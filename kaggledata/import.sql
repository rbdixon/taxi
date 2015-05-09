DROP TABLE IF EXISTS test_raw;

CREATE TABLE test_raw (
	"TRIP_ID" VARCHAR NOT NULL, 
	"CALL_TYPE" VARCHAR(1) NOT NULL, 
	"ORIGIN_CALL" VARCHAR(12), 
	"ORIGIN_STAND" VARCHAR(12), 
	"TAXI_ID" INTEGER NOT NULL, 
	"TIMESTAMP" INTEGER NOT NULL, 
	"DAY_TYPE" VARCHAR(1) NOT NULL, 
	"MISSING_DATA" BOOLEAN NOT NULL, 
	"POLYLINE" VARCHAR NOT NULL
);

COPY test_raw FROM '/Users/gt5392c/src/taxi/kaggledata/test.csv' WITH (HEADER, FORMAT csv, DELIMITER ',', NULL 'NA', QUOTE '"');

DROP TABLE IF EXISTS train_raw;
CREATE TABLE train_raw (LIKE test_raw);
COPY train_raw FROM '/Users/gt5392c/src/taxi/kaggledata/train.csv' WITH (HEADER, FORMAT csv, DELIMITER ',', NULL 'NA', QUOTE '"');

-- View of all data
DROP TABLE IF EXISTS data;
CREATE TABLE data AS
  SELECT 'TEST'::VARCHAR AS dataset, * FROM test_raw
  UNION
  SELECT 'TRAIN'::VARCHAR AS dataset, * FROM train_raw;
  
-- Extract polylines
DROP TABLE IF EXISTS traj;
CREATE TABLE traj AS
  SELECT
    *,
    ST_GeoHash(point, 9) AS gh
  FROM (
    SELECT
      *,
      ST_SetSRID(ST_Point(lon, lat), 4326) AS point
    FROM (
      SELECT
        "TRIP_ID",
        (coord_txt->>0)::real AS lon,
        (coord_txt->>1)::real AS lat,
        COUNT(*) OVER ( PARTITION BY "TRIP_ID" ROWS UNBOUNDED PRECEDING ) AS seq
      FROM (
        SELECT "TRIP_ID", json_array_elements("POLYLINE"::json) AS coord_txt FROM data
      ) extract_json
    ) extract_lat_lon
  ) extract_point
;



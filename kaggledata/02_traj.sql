-- Random view on test/train
DROP TABLE IF EXISTS traj;

CREATE TABLE traj AS
-- Random sample of train JSON
WITH train_extract_json AS (
  SELECT
  'TRAIN'::VARCHAR AS dataset,
  "TRIP_ID", 
  json_array_elements("POLYLINE"::json) AS coord_json 
  FROM train_raw
  -- SAMPLE
  WHERE id in (
    SELECT round(random() * 1710670)::integer AS id
    FROM generate_series(1, 1000*2)
    GROUP BY id -- Discard duplicates
    LIMIT 1000
  )
),

-- Extact coordinates
extract_lat_lon AS (
  SELECT
    dataset,
    "TRIP_ID",
    (coord_json->>0)::real AS lon,
    (coord_json->>1)::real AS lat,
    --COUNT(*) OVER ( PARTITION BY "TRIP_ID" ROWS UNBOUNDED PRECEDING ) AS seq
    row_number() OVER ( PARTITION BY "TRIP_ID" ROWS UNBOUNDED PRECEDING ) AS seq
  FROM train_extract_json
),

-- Convert to GeoHash
extract_gh AS (
  SELECT
  *,
  ST_GeoHash(ST_SetSRID(ST_Point(lon, lat), 4326), 9) AS gh
  FROM extract_lat_lon
)

SELECT
  "TRIP_ID",
  9::integer AS level,
  gh,
  seq
FROM extract_gh
;

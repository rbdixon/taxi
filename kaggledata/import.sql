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
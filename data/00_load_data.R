# Import data first using: psql taxi -f kaggledata/import.sql
pg = src_postgres(dbname="taxi", host="127.0.0.1")

TEST_RAW = tbl(pg, "test_raw")
TRAIN_RAW = tbl(pg, "train_raw")
GHINFO = tbl(pg, "ghinfo")
DATA = tbl(pg, "data")
TRIP_DETAILS = tbl(pg, "trip_details")

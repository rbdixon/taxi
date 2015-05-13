-- Get max seq table
DROP TABLE IF EXISTS traj_max;

CREATE TABLE traj_max AS
  SELECT 
    "TRIP_ID",
    level,
    max(seq) AS maxseq
  FROM traj
  GROUP BY "TRIP_ID", level;

DROP INDEX IF EXISTS traj_max_trip_id_lev;
CREATE INDEX traj_max_trip_id_lev ON traj_max ( "TRIP_ID", level );
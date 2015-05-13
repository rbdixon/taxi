DROP INDEX IF EXISTS traj_gh_lev;
CREATE INDEX traj_gh_lev ON traj ( gh, level );

DROP INDEX IF EXISTS traj_lev;
CREATE INDEX traj_lev ON traj ( level );

DROP INDEX IF EXISTS traj_seq_lev;
CREATE INDEX traj_seq_lev ON traj ( seq, level );

DROP INDEX IF EXISTS traj_gh_seq_lev;
CREATE INDEX traj_gh_seq_lev ON traj ( gh, seq, level );

-- Index TRIP_ID
DROP INDEX IF EXISTS traj_trip_id;
CREATE INDEX traj_trip_id ON traj ( "TRIP_ID" );

DROP INDEX IF EXISTS traj_trip_id_lev;
CREATE INDEX traj_trip_id_lev ON traj ( "TRIP_ID", level );
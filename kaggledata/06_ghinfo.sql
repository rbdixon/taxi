-- Prep a table with gh dimensions for plotting
DROP TABLE IF EXISTS ghinfo;
CREATE TABLE ghinfo AS
  SELECT
    gh,
    ST_Centroid(ST_GeomFromGeoHash(gh)) AS centroid,
    ST_GeomFromGeoHash(gh)::geography AS geo
  FROM (
    SELECT DISTINCT gh FROM traj
  ) dgh
;
  
DROP INDEX IF EXISTS ghinfo_gh;
CREATE INDEX ghinfo_gh ON ghinfo (gh);

-- Prep a table with gh dimensions for plotting
DROP TABLE IF EXISTS ghinfo;
CREATE TABLE ghinfo AS
  SELECT
    gh,
    level,
    ST_Centroid(ST_GeomFromGeoHash(gh)) AS centroid,
    ST_X(ST_Centroid(ST_GeomFromGeoHash(gh))) AS lon,
    ST_Y(ST_Centroid(ST_GeomFromGeoHash(gh))) AS lat,
    ST_GeomFromGeoHash(gh)::geography AS geo,
    ST_AsGeoJSON(ST_GeomFromGeoHash(gh)) AS geojson
  FROM (
    SELECT DISTINCT gh, level FROM traj
  ) dgh
;
  
DROP INDEX IF EXISTS ghinfo_gh_lev;
CREATE INDEX ghinfo_gh_lev ON ghinfo (gh, level);

DROP INDEX IF EXISTS ghinfo_lev;
CREATE INDEX ghinfo_lev ON ghinfo (level);

DROP TABLE IF EXISTS trip_details;

CREATE TABLE trip_details AS
WITH first AS (
  SELECT
    "TRIP_ID",
    level,
    gh AS origin_gh
  FROM traj
  WHERE seq=1
), last AS (
  SELECT
    "TRIP_ID",
    level,
    gh AS dest_gh
  FROM (
    SELECT 
      *, 
      rank() OVER (PARTITION BY "TRIP_ID", level ORDER BY seq DESC) AS rank
    FROM traj
  ) desc_seq_ranked_data
  WHERE rank=1
), numrecs AS (
  SELECT
    "TRIP_ID",
    level,
    sum(recs) AS recs
  FROM traj
  GROUP BY "TRIP_ID", level
)
SELECT
  first."TRIP_ID",
  first.level,
  first.origin_gh,
  last.dest_gh,
  recs,
  ST_Azimuth(first_ghinfo.centroid, last_ghinfo.centroid)/(2*pi())*360 AS az,
  ST_Distance_Sphere(first_ghinfo.centroid, last_ghinfo.centroid) AS dist
FROM first
JOIN last ON first."TRIP_ID"=last."TRIP_ID" AND first.level=last.level
JOIN numrecs ON first."TRIP_ID"=numrecs."TRIP_ID" AND first.level=numrecs.level
JOIN ghinfo AS first_ghinfo ON first.origin_gh=first_ghinfo.gh
JOIN ghinfo AS last_ghinfo ON last.dest_gh=last_ghinfo.gh
;

SELECT * FROM trip_details LIMIT 10;
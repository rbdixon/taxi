-- Add a recs column indicating how many observations were
-- aggregated into this geohash observation
ALTER TABLE traj ADD COLUMN recs INT;
UPDATE traj SET recs=1 WHERE recs IS NULL;

--
-- INSERT the shorted geohashes
--
CREATE OR REPLACE FUNCTION shorten_gh(lev int) RETURNS VOID AS $$
  INSERT INTO traj
  SELECT
    "TRIP_ID",
    level,
    gh,
    COUNT(*) OVER ( PARTITION BY "TRIP_ID" ROWS UNBOUNDED PRECEDING ) AS seq,
    recs
  FROM (
    SELECT
    *,
    count(*) AS recs
    FROM (
      SELECT
        "TRIP_ID",
        $1::integer AS level,
        left(gh, $1) AS gh
      FROM traj
      WHERE
        level=9
    ) subgh
    GROUP BY "TRIP_ID", level, gh
  ) subgh_distinct
$$ LANGUAGE SQL;

DELETE FROM traj WHERE level!=9;

SELECT shorten_gh(1); -- 1705017
-- Levels 2-4 don't add much additional data
SELECT shorten_gh(2); -- 1705102
SELECT shorten_gh(3); -- 1709293
SELECT shorten_gh(4); -- 1805166
SELECT shorten_gh(5); -- 3705307 -> 2.17 obs per trip, average
SELECT shorten_gh(6); -- 14587937 -> 8.55 obs per trip, average
SELECT shorten_gh(7); -- 65416757
SELECT shorten_gh(8); -- 83423824 -> 48 obs per trip, average
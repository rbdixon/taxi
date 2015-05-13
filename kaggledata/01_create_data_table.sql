-- View of all data
DROP TABLE IF EXISTS data;
CREATE TABLE data AS
SELECT 'TEST'::VARCHAR AS dataset, * FROM test_raw
UNION
SELECT 'TRAIN'::VARCHAR AS dataset, * FROM train_raw;

-- ID so we can randomly sample
ALTER TABLE data ADD COLUMN id BIGSERIAL;
CREATE INDEX data_id ON data (id);

ALTER TABLE test_raw ADD COLUMN id BIGSERIAL;
CREATE INDEX test_raw_id ON test_raw (id);

ALTER TABLE train_raw ADD COLUMN id BIGSERIAL;
CREATE INDEX train_raw_id ON train_raw (id);


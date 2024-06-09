CREATE TABLE counters
(
    id      String,
    counter UInt64
) ENGINE = SummingMergeTree()
      ORDER BY id;

CREATE MATERIALIZED VIEW counters_mv
    TO counters
AS
SELECT simpleJSONExtractString(value, 'id')  as id,
       simpleJSONExtractUInt(value, 'value') as counter
FROM source
WHERE simpleJSONExtractString(value, 'type') = 'counter';
CREATE TABLE payments
(
    id       String,
    date     Date32,
    category String,
    purpose  String,
    money    UInt64,
    "index"  UInt64
) ENGINE = ReplacingMergeTree(index)
      ORDER BY (id, date, category);

CREATE MATERIALIZED VIEW payments_mv
    TO payments
AS
SELECT simpleJSONExtractString(value, 'id')             as id,
       toDate32(simpleJSONExtractString(value, 'date')) as date,
       simpleJSONExtractString(value, 'category')       as category,
       simpleJSONExtractString(value, 'purpose')        as purpose,
       simpleJSONExtractUInt(value, 'money')            as money,
       simpleJSONExtractUInt(value, 'index')            as index
FROM source
WHERE simpleJSONExtractString(value, 'type') = 'payment';
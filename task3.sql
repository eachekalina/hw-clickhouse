CREATE TABLE payments_for_parents
(
    id       String,
    date     Date32,
    category String,
    purpose  String,
    money    UInt64,
    "index"  UInt64
) ENGINE = ReplacingMergeTree(index)
      ORDER BY (id, date, category);

CREATE MATERIALIZED VIEW payments_for_parents_mv TO payments_for_parents
AS
SELECT id, date, category, purpose, money, index
FROM payments
WHERE category NOT IN ('gaming', 'useless');
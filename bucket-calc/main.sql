WITH RECURSIVE
  bins(i, edge) AS (
    SELECT 0, 1.0
    UNION ALL
    SELECT i + 1,
           1.0 * power(power(100000.0 / 1.0, 1.0 / 20.0), i + 1)
    FROM bins
    WHERE i < 20
  )
SELECT group_concat(CAST(round(edge) AS INTEGER), ', ')
FROM bins;

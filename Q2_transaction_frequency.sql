WITH transactions_per_month AS (
  SELECT
    ssa.owner_id,
    DATE_TRUNC('month', ssa.transaction_date) AS month,
    COUNT(*) AS transactions_in_month
  FROM savings_savingsaccount ssa
  GROUP BY ssa.owner_id, DATE_TRUNC('month', ssa.transaction_date)
),
avg_transactions AS (
  SELECT
    tpm.owner_id,
    AVG(tpm.transactions_in_month) AS avg_transactions_per_month
  FROM transactions_per_month tpm
  GROUP BY tpm.owner_id
)
SELECT
  frequency_category,
  COUNT(*) AS customer_count,
  ROUND(AVG(avg_transactions_per_month)::numeric, 1) AS avg_transactions_per_month
FROM (
  SELECT
    owner_id,
    avg_transactions_per_month,
    CASE 
      WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
      WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
      ELSE 'Low Frequency'
    END AS frequency_category
  FROM avg_transactions
) AS categorized
GROUP BY frequency_category
ORDER BY
  CASE 
    WHEN frequency_category = 'High Frequency' THEN 1
    WHEN frequency_category = 'Medium Frequency' THEN 2
    WHEN frequency_category = 'Low Frequency' THEN 3
  END;

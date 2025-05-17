WITH last_tx AS (
  SELECT
    ssa.plan_id,
    ssa.owner_id,
    MAX(ssa.transaction_date) AS last_transaction_date
  FROM savings_savingsaccount ssa
  GROUP BY ssa.plan_id, ssa.owner_id
),
active_plans AS (
  SELECT
    p.id AS plan_id,
    p.owner_id,
    CASE
      WHEN p.is_regular_savings = TRUE THEN 'Savings'
      WHEN p.is_a_fund = TRUE THEN 'Investment'
      ELSE 'Other'
    END AS type
  FROM plans_plan p
  WHERE p.is_regular_savings = TRUE OR p.is_a_fund = TRUE
)
SELECT
  ap.plan_id,
  ap.owner_id,
  ap.type,
  lt.last_transaction_date,
  CURRENT_DATE - lt.last_transaction_date AS inactivity_days
FROM active_plans ap
LEFT JOIN last_tx lt ON ap.plan_id = lt.plan_id AND ap.owner_id = lt.owner_id
WHERE (lt.last_transaction_date IS NULL OR lt.last_transaction_date < CURRENT_DATE - INTERVAL '365 days')
ORDER BY inactivity_days DESC NULLS FIRST;

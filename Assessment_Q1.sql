WITH savings_plans AS (
  SELECT
    ssa.owner_id,
    COUNT(DISTINCT ssa.plan_id) AS savings_count,
    SUM(ssa.confirmed_amount) / 100.0 AS total_savings_deposits
  FROM savings_savingsaccount ssa
  JOIN plans_plan p ON ssa.plan_id = p.id
  WHERE p.is_regular_savings = TRUE
  GROUP BY ssa.owner_id
),
investment_plans AS (
  SELECT
    ssa.owner_id,
    COUNT(DISTINCT ssa.plan_id) AS investment_count,
    SUM(ssa.confirmed_amount) / 100.0 AS total_investment_deposits
  FROM savings_savingsaccount ssa
  JOIN plans_plan p ON ssa.plan_id = p.id
  WHERE p.is_a_fund = TRUE
  GROUP BY ssa.owner_id
)
SELECT
  u.id AS owner_id,
  u.name,
  sp.savings_count,
  ip.investment_count,
  (sp.total_savings_deposits + ip.total_investment_deposits) AS total_deposits
FROM users_customuser u
JOIN savings_plans sp ON u.id = sp.owner_id
JOIN investment_plans ip ON u.id = ip.owner_id
ORDER BY total_deposits DESC;

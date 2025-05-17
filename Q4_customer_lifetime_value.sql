SELECT 
    u.id AS customer_id,
    u.name,
    DATE_PART('month', AGE(CURRENT_DATE, u.date_joined)) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        ((COUNT(s.id)::numeric / NULLIF(DATE_PART('month', AGE(CURRENT_DATE, u.date_joined)), 0)) * 12 * 0.001)::numeric,
        2
    ) AS estimated_clv
FROM users_customuser u
JOIN savings_savingsaccount s ON s.owner_id = u.id
GROUP BY u.id, u.name, u.date_joined
ORDER BY estimated_clv DESC;

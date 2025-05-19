WITH base AS (
	SELECT
		s.owner_id,
        COUNT(s.transaction_reference) AS txns,
        u.date_joined
	FROM savings_savingsaccount s
    JOIN users_customuser u ON s.owner_id = u.id
    WHERE s.transaction_status = 'SUCCESS'
    GROUP BY s.owner_id, u.date_joined
),

aggs AS (
	SELECT 
		owner_id,
		txns,
		date_joined,
		TIMESTAMPDIFF(MONTH, date_joined, NOW()) AS months,
        ROUND(txns / NULLIF(TIMESTAMPDIFF(MONTH, date_joined, NOW()), 0), 1) AS avg_transactions_per_month
	FROM base
),

category AS (
    SELECT 
		owner_id,
        txns,
        avg_transactions_per_month,
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM aggs
)

SELECT
    frequency_category,
    COUNT(owner_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM category
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');

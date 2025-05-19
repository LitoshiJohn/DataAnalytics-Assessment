WITH baseuser AS (
	SELECT
		u.id as customer_id,
		CONCAT(first_name,' ',last_name) AS name,
        TIMESTAMPDIFF(MONTH, date_joined, CURRENT_DATE) as tenure_months,
        COUNT(transaction_reference) AS total_transactions,
        SUM(confirmed_amount/100) as transaction_value
	FROM users_customuser u 
    JOIN savings_savingsaccount s ON u.id = s.owner_id
    WHERE transaction_status = 'SUCCESS'
    AND confirmed_amount IS NOT NULL
    GROUP BY 1,2,3
),

clv1 AS (
	SELECT
		customer_id,
        name,
        tenure_months,
        total_transactions,
        transaction_value,
        (total_transactions/tenure_months) AS txns_per_month
	FROM baseuser
),

clv2 AS (
	SELECT
		customer_id,
        name,
        tenure_months,
        total_transactions,
        ROUND((txns_per_month * transaction_value * 12 * (0.1/100)),2) AS estimated_clv
	FROM clv1
)

	SELECT
		*
	FROM clv2
    ORDER BY estimated_clv DESC
WITH base AS (
	SELECT
		s.owner_id,
        s.plan_id,
        s.transaction_date,
        s.transaction_reference,
        p.is_regular_savings,
        p.is_a_fund
	FROM savings_savingsaccount s 
    JOIN plans_plan p ON s.owner_id = p.owner_id
	WHERE s.transaction_status = 'SUCCESS'
    AND p.is_archived = 0
    AND p.is_deleted = 0
    AND p.is_deleted_from_group = 0
),
    
aggs AS (
	SELECT
		plan_id,
        owner_id,
        CASE 
			WHEN is_regular_savings = 1 THEN 'Savings'
            WHEN is_a_fund = 1 THEN 'Investment'
        END AS type,
		MAX(transaction_date) AS last_transaction_date
	FROM base
	GROUP BY plan_id, owner_id, type
    HAVING type IS NOT NULL
),

final AS (
	SELECT 
		plan_id,
        owner_id,
        type,
        last_transaction_date,
        DATEDIFF(CURRENT_DATE, last_transaction_date) AS inactivity_days
	FROM aggs
	WHERE DATEDIFF(CURRENT_DATE, last_transaction_date) > 365
)

SELECT *
FROM final
ORDER BY inactivity_days DESC;

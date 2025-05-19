WITH identity AS (
	SELECT 
		p.owner_id,
        s.confirmed_amount
	FROM plans_plan p
	JOIN savings_savingsaccount s ON p.owner_id = s.owner_id
	WHERE s.transaction_status = 'SUCCESS'
),

username AS (
	SELECT
		id,
		CONCAT(first_name, ' ', last_name) AS name
	FROM users_customuser
),

accounts AS (
	SELECT 
		owner_id,
		COUNT(CASE WHEN is_regular_savings > 0 THEN 1 END) AS savings_count,
		COUNT(CASE WHEN is_a_fund > 0 THEN 1 END) AS investment_count
	FROM plans_plan
	GROUP BY owner_id
),

total AS (
	SELECT 
		owner_id,
		ROUND(SUM(confirmed_amount/100),2) as total_deposits
	FROM savings_savingsaccount
	WHERE confirmed_amount > 0
	GROUP BY owner_id
),

ranked_results AS (
	SELECT
		i.owner_id,
		u.name,
		a.savings_count,
		a.investment_count,
		t.total_deposits,
		ROW_NUMBER() OVER (PARTITION BY u.name ORDER BY t.total_deposits DESC) AS rn
	FROM identity i
	LEFT JOIN username u ON i.owner_id = u.id
	LEFT JOIN accounts a ON i.owner_id = a.owner_id
	LEFT JOIN total t ON i.owner_id = t.owner_id
	WHERE a.savings_count > 0 AND a.investment_count > 0
)

SELECT *
FROM ranked_results
WHERE rn = 1;
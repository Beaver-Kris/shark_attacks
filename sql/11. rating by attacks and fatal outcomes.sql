-- Ranking countries by how dangerous sharks in them are
-- where combined_risk_rank is weighted sum of two previous ranks (attacks 70%, fatal% 30%)
WITH attack_statitic AS (
	SELECT country, COUNT(*) AS all_attacks, ROUND(SUM((fatal = 1)::INTEGER)*100.00/COUNT(*),2) as percent_of_fatal_attacks 
	FROM shark_attacks
	WHERE country IS NOT NULL
	GROUP BY country 
	HAVING COUNT(*) > 10
	),
ranks as (
	SELECT country, all_attacks, DENSE_RANK() OVER(ORDER BY all_attacks DESC) AS rank_by_amount_of_attacks, 
	percent_of_fatal_attacks, DENSE_RANK() OVER(ORDER BY percent_of_fatal_attacks DESC) AS rank_by_percent_of_fatal_attacks,
	ROUND((DENSE_RANK() OVER (ORDER BY all_attacks DESC)*0.7 +
           DENSE_RANK() OVER (ORDER BY percent_of_fatal_attacks DESC)*0.3), 2) AS weighted_sum
	FROM attack_statitic)
SELECT country, all_attacks, rank_by_amount_of_attacks, percent_of_fatal_attacks, rank_by_percent_of_fatal_attacks,weighted_sum, 
	DENSE_RANK() OVER (ORDER BY weighted_sum) as combined_risk_rank
FROM ranks 
ORDER BY combined_risk_rank 

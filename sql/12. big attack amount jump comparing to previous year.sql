-- Years where amount of attacks went up or down for more than 20 percents comparing to previous year. looking at years with at least 20 attacks and only since 1950
WITH dif_percent AS (
	SELECT s.year, COUNT(*) as amount_of_attacks, 
		ROUND(ABS(COUNT(*) - LAG(COUNT(*)) OVER (ORDER BY s.year))*100.00/
		LAG(COUNT(*)) OVER (ORDER BY s.year),2) as difference_between_amount_of_attacks_in_percents
	FROM shark_attacks as s
	WHERE s.year IS NOT NULL AND s.year >= 1950
	GROUP BY s.year
	HAVING COUNT(*) >20 
)
SELECT year, amount_of_attacks, difference_between_amount_of_attacks_in_percents
FROM dif_percent
WHERE difference_between_amount_of_attacks_in_percents IS NOT NULL AND difference_between_amount_of_attacks_in_percents >= 20
ORDER BY difference_between_amount_of_attacks_in_percents DESC
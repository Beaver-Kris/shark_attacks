-- Average amount of attacks for last 3 years 
SELECT s.year, COUNT(*) as attacks_this_year, ROUND(AVG(COUNT(*)) OVER (ORDER BY s.year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AS avg_amount_of_attacks_per_last_3_years 
FROM shark_attacks as s 
WHERE s.year IS NOT NULL
GROUP BY s.year
ORDER BY s.year DESC;

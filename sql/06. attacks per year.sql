-- How many attacks per year
SELECT s.year as year, COUNT(*) as attacks_per_year
FROM shark_attacks as s 
WHERE s.year IS NOT NULL
GROUP BY s.year
ORDER BY attacks_per_year DESC;




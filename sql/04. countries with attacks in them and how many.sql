-- Countries that have attacks in them
SELECT country, COUNT(*) as attacks_per_country
FROM shark_attacks 
WHERE country IS NOT NULL
GROUP BY country
ORDER BY attacks_per_country DESC;


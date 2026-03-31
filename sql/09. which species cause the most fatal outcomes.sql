-- Which species cause the most fatal outcomes
SELECT species, ROUND(SUM((fatal = 1)::INTEGER)*100.0/COUNT(*),2) as percent_of_fatal_attacks
FROM shark_attacks
WHERE species IS NOT NULL AND fatal IS NOT NULL
GROUP BY species
HAVING COUNT(*) >= 10
ORDER BY percent_of_fatal_attacks DESC;

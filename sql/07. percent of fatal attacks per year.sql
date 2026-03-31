-- Percent of fatal attacks per year
SELECT s.year, count(s.fatal) as outcome, sum((s.fatal=1)::INTEGER) as fatal_attack, ROUND(SUM((s.fatal=1)::INTEGER) * 100.00 / COUNT(s.fatal), 2) as fatal_percent_per_year
FROM shark_attacks as s
WHERE s.year IS NOT NULL AND s.fatal IS NOT NULL
GROUP BY s.year
ORDER BY s.year DESC;


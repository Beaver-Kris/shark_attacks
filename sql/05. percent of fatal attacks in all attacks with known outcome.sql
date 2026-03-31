--Percent of fatal attacks 
SELECT ROUND(SUM((fatal = 1)::INTEGER)*1.0/COUNT(*) *100,2) AS fatal_percent
FROM shark_attacks 
WHERE fatal IS NOT NULL;


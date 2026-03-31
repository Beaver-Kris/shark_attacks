--invalid in s.type to null
UPDATE shark_attacks
SET type = NULL
WHERE type = 'invalid';

-- Fatality depending on activity and type
SELECT CASE
	WHEN s.type IS NULL THEN s.activity
	WHEN s.activity IS NULL THEN s.type
	ELSE CONCAT(s.type,', ', s.activity)
END as category, COUNT(*) as attacks, 
 SUM(CASE WHEN s.fatal = 1 THEN 1 ELSE 0 END)  as fatal_attacks, 
ROUND(SUM(CASE WHEN s.fatal = 1 THEN 1 ELSE 0 END)*100.00/COUNT(*),2) as fatal_percent,
DENSE_RANK() OVER (ORDER BY ROUND(SUM(CASE WHEN s.fatal = 1 THEN 1 ELSE 0 END)*100.00/COUNT(*),2) DESC) as fatality_rank,
DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) as amount_of_attack_rank
FROM shark_attacks as s 
WHERE s.type IS NOT NULL OR s.activity IS NOT NULL 
GROUP BY s.type, s.activity
HAVING COUNT(*) >= 5
ORDER BY fatal_percent DESC

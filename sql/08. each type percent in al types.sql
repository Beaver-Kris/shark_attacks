-- type percent in all with known type 
SELECT sa.type, COUNT(*) as type_count, ROUND(COUNT(*)*100.00/ (
	SELECT COUNT(*) 
	FROM shark_attacks as s
	WHERE s.type IS NOT NULL),2) as type_percent
FROM shark_attacks as sa
WHERE sa.type IS NOT NULL
GROUP BY sa.type
ORDER BY type_percent DESC;



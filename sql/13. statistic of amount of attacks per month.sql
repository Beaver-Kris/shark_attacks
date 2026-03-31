-- Statistic of amount of attacks per month
SELECT CASE
	when s.month= 1 then 'January'
	when s.month= 2 then 'February'
	when s.month= 3 then 'March'
	when s.month= 4 then 'April'
	when s.month= 5 then 'May'
	when s.month= 6 then 'June'
	when s.month= 7 then 'July'
	when s.month= 8 then 'August'
	when s.month= 9 then 'September'
	when s.month= 10 then 'October'
	when s.month= 11 then 'November'
	when s.month= 12 then 'December'
	else 'Unknown'
	END, 
	COUNT(*) as per_month, ROUND(COUNT(*)*100.00/(SELECT COUNT(*) FROM shark_attacks as sa WHERE sa.month IS NOT NULL),2) as percent_per_month,
	DENSE_RANK() OVER (ORDER BY COUNT(*) DESC) as the_most_amount_of_attacks_per_month_rank,
	SUM((fatal = 1)::INTEGER) as fatal_outcomes,
    ROUND(SUM((fatal = 1)::INTEGER) * 100.00 / COUNT(*), 2) as fatal_percent,
	DENSE_RANK() OVER (ORDER BY SUM((fatal = 1)::INTEGER) DESC) as the_most_amount_of_fatal_attacks_per_month_rank
FROM shark_attacks as s
WHERE s.month IS NOT NULL 
GROUP BY s.month
ORDER BY s.month
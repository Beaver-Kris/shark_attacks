-- Amount of Null per column
DO $$
DECLARE 
	col_record RECORD;
    query_text TEXT;
    result_count BIGINT;
BEGIN
    CREATE TEMP TABLE null_stats (column_names TEXT, null_count BIGINT);

	FOR col_record IN 
    	SELECT column_name 
    	FROM INFORMATION_SCHEMA.COLUMNS 
	    WHERE table_name = 'shark_attacks' AND table_schema = 'public'
	LOOP
		query_text:= format('SELECT COUNT(*) FROM shark_attacks WHERE %I IS NULL', col_record.column_name);
		EXECUTE query_text INTO result_count;
		INSERT INTO null_stats VALUES (col_record.column_name, result_count);
    END LOOP;
	
END $$;
SELECT column_names, null_count 
FROM null_stats 
ORDER BY null_count DESC;

DROP TABLE null_stats;

-- See colums and type of them 
SELECT column_name, data_type, is_nullable
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name = 'shark_attacks' AND table_schema = 'public';

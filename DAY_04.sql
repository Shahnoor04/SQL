-- DAY-4: Find the 3rd to 7th highest patient satisfaction scores from the patients table, displaying patient_id, name, service, and satisfaction. Only show these 5 records. 

SELECT patient_id, name, service, satisfaction
FROM patients
ORDER BY satisfaction DESC
LIMIT 5
OFFSET 2;

-- Other Practice Queries:
-- 1. Display the first 5 patients from the patients table.
SELECT * 
FROM patients 
Limit 5;

-- 2. Show patients 11-20 using OFFSET.
SELECT * 
FROM patients
LIMIT 10 
OFFSET 10;

-- 3. Get the 10 most recent patient admissions based on arrival_date.
SELECT *
FROM patients
ORDER BY arrival_date DESC
LIMIT 10;

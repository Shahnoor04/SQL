/* DAY-8 : Create a patient summary that shows patient_id, full name in uppercase, service in lowercase, age category (if age >= 65 then 'Senior', if age >= 18 then 'Adult', else 'Minor'), and name length.
Only show patients whose name length is greater than 10 characters.*/

SELECT patient_id, UPPER(name) AS upper_name, LOWER(service) AS lower_service, LENGTH(name) AS length_name, 
CASE 
WHEN age >= 65 THEN 'Senior' 
WHEN age >= 18 THEN 'Adult'
ELSE 'Minor' 
END AS age_category
FROM patients
HAVING length_name > 10;

-- Other Practice Queries:
-- 1. Convert all patient names to uppercase.
SELECT UPPER(name) AS uppercase_name
FROM patients;

-- 2. Find the length of each staff member's name.
SELECT name, LENGTH(name) AS length_name
FROM patients;

-- 3. Concatenate staff_id and staff_name with a hyphen separator.
SELECT CONCAT(staff_id, ' - ' ,staff_name) AS concat_staff_id_staff_name
FROM staff;

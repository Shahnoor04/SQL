--DAY-1 Challenge: List all unique hospital services available in the hospital.
SELECT DISTINCT service FROM services_weekly;

--OTHER PRACTICE QUERIES:
--1. Retrieve all columns from the patients table.
SElECT * FROM PATIENTS;

--2. Select only the patient_id, name, and age columns from the patients table.
SELECT patient_id, name, age FROM PATIENTS;

--3. Display the first 10 records from the services_weekly table.
SELECT * FROM services_weekly LIMIT 10;

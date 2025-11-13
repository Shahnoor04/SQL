/* DAY-5: Calculate the total number of patients admitted, total patients refused, and the average patient satisfaction across all services and weeks. 
Round the average satisfaction to 2 decimal places. */

SELECT COUNT(patients_admitted) AS total_patients_admitted, 
COUNT(patients_refused) AS total_patients_refused, 
AVG(patient_satisfaction) AS avg_patient_satisfaction,
ROUND(AVG(patient_satisfaction),2) AS r_avg_patient_satisfaction
FROM services_weekly;

-- Other Practice Queries:
-- 1. Count the total number of patients in the hospital.

SELECT COUNT(age) AS total_patients
FROM patients;

-- 2. Calculate the average satisfaction score of all patients.

SELECT AVG(satisfaction) AS avg_satisfaction_score
FROM patients;

-- 3. Find the minimum and maximum age of patients.

SELECT MIN(age), MAX(age) 
FROM patients;

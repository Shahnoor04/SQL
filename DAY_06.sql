/* DAY-6: For each hospital service, calculate the total number of patients admitted, total patients refused, and the admission rate (percentage of requests that were admitted). 
Order by admission rate descending. */

SELECT SUM(patients_admitted) AS total_patients_admitted, 
SUM(patients_refused) AS total_patients_refused, service,
ROUND(
SUM(patients_admitted) * 100 /(SUM(patients_request)),2
) AS admission_rate
FROM services_weekly
GROUP BY service
ORDER BY admission_rate DESC;

-- Other Practice Queries:
-- 1. Count the number of patients by each service.
 
SELECT COUNT(patient_id) AS total_patients, service
FROM patients
GROUP BY service;

-- 2. Calculate the average age of patients grouped by service.

SELECT AVG(age) AS avg_age, service
FROM patients
GROUP BY service;

-- 3. Find the total number of staff members per role.

SELECT COUNT(staff_id) AS total_staff_members, role
FROM staff
GROUP BY role;

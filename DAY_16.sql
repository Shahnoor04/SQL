/* DAY-16: Find all patients who were admitted to services that had at least one week where patients were refused AND the average patient satisfaction for that service 
was below the overall hospital average satisfaction. Show patient_id, name, service, and their personal satisfaction score. */

SELECT patient_id, name AS patient_name, service, satisfaction FROM patients WHERE service IN(
 SELECT service FROM services_weekly GROUP BY service HAVING MAX(patients_refused) > 0 AND AVG(patient_satisfaction)<(
   SELECT AVG(satisfaction) FROM patients));

-- Other Practice Queries:
-- 1. Find patients who are in services with above-average staff count.
SELECT * FROM patients WHERE service IN (
 SELECT service FROM staff GROUP BY service HAVING COUNT(staff_id)>(
 SELECT AVG(staff_total) FROM (SELECT COUNT(staff_id) AS staff_total FROM staff GROUP BY service)AS t));

-- 2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT DISTINCT staff_id, staff_name, role, service FROM staff_schedule ss WHERE exists(
 SELECT 1 FROM services_weekly sw WHERE sw.service=ss.service AND sw.week = ss.week AND patient_satisfaction <70);

-- 3. Show patients from services where total admitted patients exceed 1000.
SELECT * FROM patients WHERE service IN (
 SELECT service FROM services_weekly GROUP BY service HAVING(SUM(patients_admitted))>1000);

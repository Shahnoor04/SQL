/* DAY-15: Create a comprehensive service analysis report for week 20 showing: service name, total patients admitted that week, total patients refused, average patient satisfaction, 
count of staff assigned to service, and count of staff present that week. Order by patients admitted descending. */

SELECT 
SUM(sw.patients_admitted) AS total_patients_admitted, 
SUM(sw.patients_refused) AS total_patients_refused, 
AVG(sw.patient_satisfaction) AS avg_patient_satisfaction,
COUNT(DISTINCT ss.staff_id) AS count_staff_assigned,
SUM(CASE WHEN ss.present = true THEN 1 ELSE 0 END) AS staff_present_count, 
ss.service
FROM services_weekly sw 
INNER JOIN staff_schedule ss ON sw.week = ss.week AND sw.service = ss.service
WHERE sw.week = 20
GROUP BY ss.service
ORDER BY total_patients_admitted DESC;

-- Other Practice Queries:
-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT 
p.patient_id, p.name AS patient_name, p.age, p.service, 
s.staff_id, s.staff_name, ss.week, 
COUNT(CASE WHEN ss.present = true THEN 1 END) AS weeks_present
FROM patients p
INNER JOIN staff s ON p.service = s.service
INNER JOIN staff_schedule ss ON s.service = ss.service AND s.staff_id = ss.staff_id
WHERE ss.present = True
GROUP BY p.patient_id, p.name, p.age, p.service, s.staff_id, s.staff_name, ss.week;

-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT
 sw.week, sw.service,
 sw.available_beds, sw.patients_request, sw.patients_admitted,
 sw.patients_refused, sw.patient_satisfaction,
 COUNT(DISTINCT s.staff_id) AS staff_count,
 SUM(CASE WHEN ss.present = true THEN 1 ELSE 0 END) AS staff_present_count
FROM services_weekly sw
LEFT JOIN staff s 
 ON sw.service = s.service
LEFT JOIN staff_schedule ss
 ON s.staff_id = ss.staff_id AND s.service = ss.service AND sw.week = ss.week
GROUP BY
 sw.week, sw.service, sw.available_beds, sw.patients_request,
 sw.patients_admitted, sw.patients_refused, sw.patient_satisfaction;
 
 -- 3. Create a multi-table report showing patient admissions with staff information.
SELECT 
p.patient_id, p.name AS patitent_name, p.service, p.arrival_date, 
ss.staff_id, ss.staff_name, ss.role, sw.week, sw.month
FROM patients p
INNER JOIN services_weekly sw ON p.service = sw.service
INNER JOIN staff_schedule ss ON sw.service = ss.service AND sw.week = ss.week;

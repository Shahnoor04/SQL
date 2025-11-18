/* DAY-14: Create a staff utilisation report showing all staff members (staff_id, staff_name, role, service) and the count of weeks they were present (from staff_schedule). 
Include staff members even if they have no schedule records. Order by weeks present descending. */

SELECT 
s.staff_id,
s.staff_name,
s.role,
s.service,
COUNT(CASE WHEN ss.present = true THEN 1 END) AS weeks_present
FROM staff s 
LEFT JOIN staff_schedule ss 
ON s.staff_id = ss.staff_id
GROUP BY s.staff_id, s.staff_name, s.role, s.service
ORDER BY weeks_present DESC;


-- Other Practice Queries:
-- 1. Show all staff members and their schedule information (including those with no schedule entries).

SELECT 
s.staff_id,
s.staff_name,
s.role,
s.service,
COUNT(ss.week) AS count_weeks,
ss.present
FROM staff s LEFT JOIN staff_schedule ss 
ON s.staff_id=ss.staff_id 
GROUP BY s.staff_id,
s.staff_name,
s.role,
s.service,
ss.present;

-- 2. List all services from services_weekly and their corresponding staff (show services even if no staff assigned).

SELECT sw.service, s.staff_name
FROM services_weekly sw LEFT JOIN staff s ON sw.service=s.service;

-- 3. Display all patients and their service's weekly statistics (if available).

SELECT 
p.patient_id,
p.name AS patient_name,
p.age,
sw.week,
sw.month,
sw.service,
sw.available_beds,
sw.patient_satisfaction,
sw.patients_admitted,
sw.patients_refused,
sw.patients_request
FROM services_weekly sw LEFT JOIN patients p ON sw.service=p.service;

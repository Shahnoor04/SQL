/*DAY-21: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 1) Service-level metrics (total admissions, 
refusals, avg satisfaction), 2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). 
Then combine all three CTEs to create a final report showing service name, all calculated metrics, 
and an overall performance score (weighted average of admission rate and satisfaction). Order by performance score descending.*/

-- CTE -1
WITH service_level AS( 
SELECT service, SUM(patients_admitted) AS total_admitted, SUM(patients_refused)AS total_refused, 
ROUND(AVG(patient_satisfaction),2) AS avg_satisfaction,
ROUND( SUM(patients_admitted) *100 /NULLIF(SUM(patients_request),0) ,2) AS admission_rate
FROM services_weekly GROUP BY service),
-- CTE -2
staff_metrics AS(
SELECT service, SUM(DISTINCT staff_id) AS total_staff,
AVG(CASE WHEN present='yes' THEN 1 ELSE 0 END) AS avg_weeks_present
FROM staff_schedule GROUP BY service),

-- CTE-3
patient_demographics AS( SELECT service,
AVG(age) AS avg_age, COUNT(patient_id) AS patient_count
FROM patients GROUP BY service)

SELECT sm.total_staff, sm.avg_weeks_present, sl.total_admitted, sl.total_refused, sl.avg_satisfaction, pd.avg_age, pd.patient_count,
ROUND((0.6 * sl.admission_rate + 0.4 * sl.avg_satisfaction),2) AS performance_score
FROM service_level sl 
LEFT JOIN staff_metrics sm ON sl.service=sm.service
LEFT JOIN patient_demographics pd ON sl.service= pd.service
ORDER BY performance_score DESC;

Other Practice Queries:
-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
SELECT week, month, service, available_beds, patients_admitted, patients_refused, patient_satisfaction, event
FROM services_weekly)
SELECT * FROM service_stats;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH service_totals AS( SELECT 
	SUM(patients_admitteed) AS total_admitted,
	SUM(patients_refused) AS total_refused,
	SUM(patients_request) AS total_request
FROM services_weekly),
overall_avg AS(SELECT 
	ROUND(AVG(staff_morale) ,2) AS avg_morale, 
	ROUND(AVG(patient_satisfaction) ,2)AS avg_satisfaction
FROM services_weekly)
SELECT * FROM overall_avg;

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_utilization AS ( SELECT 
week, staff_name, role, service,
COUNT(DISTINCT staff_id) AS staff_count,  
SUM(CASE WHEN present ='yes' THEN 1 ELSE 0 END) AS staff_present
FROM staff_schedule
GROUP BY week, staff_name, role, service
) 
SELECT 
sw.week, sw.month,sw.service, sw.patients_admitted, sw.patients_refused, sw.patient_satisfaction,
su.staff_name, su.role, su.service, su.week
FROM services_weekly sw
JOIN staff_utilization su
ON sw.week = su.week
AND sw.service = su.service
ORDER BY sw.week, sw.month, sw.service;


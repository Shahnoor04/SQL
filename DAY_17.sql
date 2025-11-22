/* DAY-17: Create a report showing each service with: service name, total patients admitted, the difference between their total admissions and the average admissions across all services, 
and a rank indicator ('Above Average', 'Average', 'Below Average'). Order by total patients admitted descending. */

SELECT service, total_admitted, total_admitted - avg_admitted AS admitted_diff, CASE WHEN total_admitted > avg_admitted THEN 'Above Average'
WHEN total_admitted = avg_admitted THEN 'Average' ELSE 'Below Average' END AS rank_indicator FROM ( SELECT service,
SUM(patients_admitted) AS total_admitted, (SELECT AVG(service_totals) FROM ( SELECT SUM(patients_admitted) AS service_totals
FROM services_weekly GROUP BY service ) avg_table) AS avg_admitted FROM services_weekly GROUP BY service
) derived_table ORDER BY total_admitted DESC;

-- Other Practice Queries:
-- 1. Show each patient with their service's average satisfaction as an additional column.

SELECT DISTINCT service, patient_id, name AS patient_name,(SELECT AVG(satisfaction) FROM patients) AS avg_satisfaction FROM patients;

-- 2. Create a derived table of service statistics and query from it.

SELECT satisfaction_category, service, week FROM(SELECT week, month, available_beds, event, patient_satisfaction, service,
CASE WHEN patient_satisfaction >70 THEN 'Excellent' WHEN patient_satisfaction >50 THEN 'Good' WHEN patient_satisfaction < 50 THEN 'Bad' ELSE 'Needs Improvement' END AS satisfaction_category FROM services_weekly) AS derived_service_stats GROUP BY satisfaction_category, service, week;

-- 3. Display staff with their service's total patient count as a calculated field.

SELECT s.staff_id, s.staff_name, s.role, s.service, COALESCE(sw.total_patients, 0) AS total_patient_count
FROM staff s LEFT JOIN ( SELECT service, SUM(patients_request + patients_admitted + patients_refused) AS total_patients FROM services_weekly
GROUP BY service) sw ON s.service = sw.service;

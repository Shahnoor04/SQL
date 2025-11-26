/* DAY-20: Create a trend analysis showing for each service and week: week number, patients_admitted, running total of patients admitted (cumulative), 
3-week moving average of patient satisfaction (current week and 2 prior weeks), and the difference between current week admissions and the service average. Filter for weeks 10-20 only. */

SELECT service, week, patients_admitted,
SUM(patients_admitted) OVER( PARTITION BY service ORDER BY week 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ) AS cumulative_padmitted,
AVG(patient_satisfaction) OVER(PARTITION BY service ORDER BY week ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3week_satisfaction,
patients_admitted - AVG(patients_admitted) OVER(PARTITION BY service)AS admission_vs_service_avg
FROM services_weekly
WHERE week BETWEEN 10 AND 20
ORDER BY service, week;

-- Other Practice Queries:
-- 1. Calculate running total of patients admitted by week for each service.
SELECT week, service, patients_admitted,
SUM(patients_admitted) OVER(PARTITION BY service ORDER BY week) AS running_total_patients
FROM services_weekly
ORDER BY week, service;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT week, patient_satisfaction, service,
ROUND(AVG(patient_satisfaction) OVER (PARTITION BY service ORDER BY week ROWS BETWEEN 3 PRECEDING AND CURRENT ROW) ,2) AS mvg_avg_4week
FROM services_weekly 
ORDER BY week, service;

-- 3. Show cumulative patient refusals by week across all services.
SELECT patients_refused, week, service,
SUM(patients_refused)OVER(PARTITION BY service ORDER BY week) AS total_patients_refused
FROM services_weekly
ORDER BY service, week;

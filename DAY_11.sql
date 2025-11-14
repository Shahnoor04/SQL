/* DAY-11: Find all unique combinations of service and event type from the services_weekly table where events are not null or none, along with the count of occurrences for each combination. 
Order by count descending. */

SELECT 
 DISTINCT service, 
 event,
 COUNT(*) AS count_of_occurrences
FROM services_weekly 
WHERE 
 event IS NOT NULL AND event != 'NONE'
GROUP BY 
 service, 
 event
ORDER BY 
 count_of_occurrences DESC ;

-- Other Practice Queries:
-- 1. List all unique services in the patients table.

SELECT DISTINCT service
FROM patients;

-- 2. Find all unique staff roles in the hospital.

SELECT DISTINCT role
FROM staff;

-- 3. Get distinct months from the services_weekly table.

SELECT DISTINCT month AS unique_month
FROM services_weekly;

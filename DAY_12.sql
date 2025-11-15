/* DAY-12: Analyze the event impact by comparing weeks with events vs weeks without events. Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, 
and average staff morale. Order by average patient satisfaction descending. */

 SELECT 
 CASE 
 WHEN event IS NOT NULL AND event !='none' THEN 'with event'
 ELSE 'without event'
 END AS event_status,
 COUNT(week), 
 AVG(patient_satisfaction) AS avg_satisfaction, 
 AVG(staff_morale) AS avg_staff_morale
 FROM services_weekly
 GROUP BY event_status
 ORDER BY avg_satisfaction DESC;

-- Other Practice Queries:
-- 1. Find all weeks in services_weekly where no special event occurred.
SELECT week
FROM services_weekly 
WHERE event IS NULL
 OR event='none' ;

-- 2. Count how many records have null or empty event values.
SELECT COUNT(*) AS count_nullvalues
FROM services_weekly
WHERE event IS NULL
 OR event = 'none';
 
-- 3. List all services that had at least one week with a special event.
SELECT DISTINCT service
FROM services_weekly
WHERE event IS NOT NULL
 AND event != 'none';

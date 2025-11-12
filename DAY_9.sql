/* DAY-9: Calculate the average length of stay (in days) for each service, showing only services where the average stay is more than 7 days. 
Also show the count of patients and order by average stay descending. */

SELECT service, 
 COUNT(*) AS patient_count,
 AVG(DATEDIFF(departure_date, arrival_date)) AS avg_len_of_stay
FROM patients
GROUP BY service
HAVING avg_len_of_stay > 7 
ORDER BY avg_len_of_stay DESC; 

-- Other Practice Queries:
-- 1. Extract the year from all patient arrival dates.

SELECT year(arrival_date) AS arrival_year
FROM patients;

-- 2. Calculate the length of stay for each patient (departure_date - arrival_date).

SELECT DATEDIFF(departure_date, arrival_date) AS len_of_stay
FROM patients;

-- 3. Find all patients who arrived in a specific month.

SELECT * 
FROM patients
WHERE MONTH(arrival_date) = 4 ;

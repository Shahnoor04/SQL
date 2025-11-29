-- 1. Identify where and when the crime happened
SELECT room AS crime_location, exit_time AS crime_time 
FROM keycard_logs WHERE room = 'CEO Office'
ORDER BY exit_time;

-- 2. Analyze who accessed critical areas at the time
SELECT e.room AS evi_room, e.found_time AS evi_found_time, kl.log_id, kl.employee_id, kl.entry_time AS kl_entry_time, kl.exit_time AS kl_exit_time
FROM evidence e JOIN keycard_logs kl ON e.room = kl.room AND kl.entry_time <= e.found_time
ORDER BY e.found_time, kl.entry_time DESC;

-- 3. Cross-check alibis with actual logs
SELECT a.employee_id, a.claimed_location, a.claim_time, emp.name, kl.room AS actual_room, kl.entry_time, kl.exit_time,
CASE WHEN kl.room = claimed_location THEN 'match' ELSE 'Mismatch' END AS status
FROM alibis a JOIN employees emp ON a.employee_id=emp.employee_id LEFT JOIN keycard_logs kl ON a.employee_id=kl.employee_id;

-- 4. Investigate suspicious calls made around the time
SELECT c.call_id, c.call_time, c.duration_sec, emp.employee_id, emp.name AS emp_name 
FROM calls c JOIN employees emp ON c.caller_id= emp.employee_id 
WHERE c.call_time BETWEEN '2025-10-15 20:30:00' AND '2025-10-15 21:00:00' ;

-- 5. Match evidence with movements and claims
SELECT kl.employee_id AS emp_id,  emp.name AS emp_name, a.alibi_id, a.claimed_location AS claimed_loc,  kl.room AS actual_loc,
CASE WHEN kl.room = a.claimed_location THEN 'match' ELSE 'Mismatch' END AS loc_status,
e.evidence_id AS evi_id, a.claim_time, kl.entry_time, kl.exit_time,  e.found_time AS evi_found_time
FROM evidence e 
JOIN keycard_logs kl ON e.room = kl.room 
JOIN employees emp ON kl.employee_id= emp.employee_id 
LEFT JOIN alibis a ON kl.employee_id=a.employee_id;

-- 6. Combine all findings to identify the killer
SELECT name AS Killer FROM employees
WHERE employee_id IN (
    SELECT DISTINCT kl.employee_id FROM keycard_logs kl
    JOIN evidence e ON e.room = kl.room
    WHERE e.room = 'CEO Office' 
	AND kl.entry_time <= e.found_time      -- entered before evidence time
	AND kl.exit_time  >= '2025-10-15 21:00:00'  -- stayed through crime time);

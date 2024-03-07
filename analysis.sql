select * from employees;
-- Find all average of scores grouped by drivers.
SELECT driver_name, AVG(score) AS average_score
FROM responses
GROUP BY driver_name;

-- Find all scores by department and driver combination
SELECT e.department, r.driver_name, r.score
FROM responses r
JOIN employees e ON r.employee_id = e.id;

-- Find all scores by location and driver combination
SELECT e.location, r.driver_name, r.score
FROM responses r
JOIN employees e ON r.employee_id = e.id;

-- Find all scores by gender and driver
SELECT e.gender, r.driver_name, r.score
FROM responses r
JOIN employees e ON r.employee_id = e.id;

-- Find all scores by age group 20-30, 30-40,40-50
SELECT 
    CASE
        WHEN age BETWEEN 20 AND 30 THEN '20-30'
        WHEN age BETWEEN 31 AND 40 THEN '30-40'
        WHEN age BETWEEN 41 AND 50 THEN '40-50'
        ELSE 'Unknown'
    END AS age_group,
    r.driver_name,
    r.score
FROM responses r
JOIN employees e ON r.employee_id = e.id;

-- Find all scores by managers (ensure manager name is there)
SELECT
    m.name AS manager_name,
    r.driver_name,
    r.score
FROM
    employees e
    JOIN employees m ON e.manager_id = m.id
    JOIN responses r ON e.id = r.employee_id;

-- Additionally, to ensure anonymity - if a group (eg: combination of department for a specific driver) has less than 3 responses - skip that group.
SELECT 
    CONCAT(e.department, ' - ', r.driver_name) AS department_driver_combo,
    AVG(r.score) AS average_score
FROM responses r
JOIN employees e ON r.employee_id = e.id
GROUP BY e.department, r.driver_name
HAVING COUNT(*) >= 3;

-- Once you have created all the above reports, export them to google sheets, create a pivot table and a heatmap like below https://www.cultureamp.com/blog/heatmapping-your-engagement-results


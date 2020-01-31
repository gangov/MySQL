/*
 Exercises: Subqueries and JOINs
This document defines the exercise assignments for the MySQL course @ Software University.
For problems from 1 to 11 (inclusively) use "soft_uni" database and for the others – "geography".
 */

USE soft_uni;

/*
 1. Employee Address
Write a query that selects:
employee_id
job_title
address_id
address_text
Return the first 5 rows sorted by address_id in ascending order.
Example:

    employee_id	    job_title	                address_id	address_text
    142 	        Production Technician	    1	        108 Lakeside Court
    30	            Human Resources Manager	    2	        1341 Prospect St
…	…	…	…
 */

SELECT employee_id, job_title, employees.address_id, address_text
FROM employees
         LEFT JOIN addresses ON employees.address_id = addresses.address_id
ORDER BY employees.address_id ASC
LIMIT 5;

/*
 2. Addresses with Towns
Write a query that selects:
first_name
last_name
town
address_text
Sort the result by first_name in ascending order then by last_name. Select first 5 employees.
Example:

    first_name	last_name	town	        address_text
    A.Scott	    Wright	    Newport Hills	1400 Gate Drive
    Alan	    Brewer	    Kenmore	        8192 Seagull Court
    …	        …	        …	            …
 */

SELECT first_name, last_name, name AS 'town', address_text
FROM employees
         JOIN addresses ON employees.address_id = addresses.address_id
         JOIN towns ON addresses.town_id = towns.town_id
ORDER BY first_name ASC, last_name ASC
LIMIT 5;

/*
 3. Sales Employee
Write a query that selects:
employee_id
first_name
last_name
department_name
Sort the result by employee_id in descending order. Select only employees from the “Sales” department.
Example:

    employee_id	    first_name	    last_name	    department_name
    290	            Lynn	        Tsoflias	    Sales
    289	            Rachel	        Valdez	        Sales
    …	            …	            …           	…
 */

SELECT employee_id, first_name, last_name, name AS 'department_name'
FROM employees
         JOIN departments ON employees.department_id = departments.department_id
WHERE departments.name = 'Sales'
ORDER BY employee_id DESC;

/*
 4. Employee Departments
Write a query that selects:
employee_id
first_name
salary
department_name
Filter only employees with salary higher than 15000. Return the first 5 rows sorted by department_id in descending order.
Example:

    employee_id	    first_name	    salary	    department_name
    109	            Ken	            125500.00	Executive
    140	            Laura	        60100.00	Executive
    …	            …	            …	        …
 */

SELECT employee_id, first_name, salary, name AS 'department_name'
FROM employees
         JOIN departments ON employees.department_id = departments.department_id
WHERE salary > 15000
ORDER BY departments.department_id DESC
LIMIT 5;

/*
 5. Employees Without Project
Write a query that selects:
employee_id
first_name
Filter only employees without a project. Return the first 3 rows sorted by employee_id in descending order.
Example:

    employee_id	    first_name
    293	            George
    292	            Martin
    291	            Svetlin
 */

SELECT employees.employee_id, first_name
FROM employees
         LEFT JOIN employees_projects on employees.employee_id = employees_projects.employee_id
WHERE employees_projects.project_id IS NULL
ORDER BY employee_id DESC
LIMIT 3;

/*
 6. Employees Hired After
Write a query that selects:
first_name
last_name
hire_date
dept_name
Filter only employees hired after 1/1/1999 and from either the "Sales" or the "Finance" departments. Sort the result by
 hire_date (ascending).
Example:

    first_name	last_name	hire_date	        dept_name
    Debora     	Poe	        2001-01-19 00:00:00	Finance
    Wendy	    Kahn	    2001-01-26 00:00:00	Finance
    …	        …	        …	                …
 */

SELECT first_name, last_name, hire_date, name AS 'dept_name'
FROM employees
         INNER JOIN departments ON employees.department_id = departments.department_id
WHERE DATE(hire_date) > '1999-1-1'
  AND departments.name IN ('Sales', 'Finance')
ORDER BY hire_date ASC;

/*
 7. Employees with Project
Write a query that selects:
employee_id
first_name
project_name
Filter only employees with a project, which has started after 13.08.2002 and it is still ongoing (no end date). Return
the first 5 rows sorted by first_name then by project_name both in ascending order.
Example:

    employee_id	    first_name	    project_name
    44	            A. Scott	    Hitch Rack - 4-Bike
    170	            Alan	        LL Touring Handlebars
    …	            …	            …
 */

SELECT employees.employee_id, first_name, name AS 'project_name'
FROM employees
         INNER JOIN employees_projects ep on employees.employee_id = ep.employee_id
         INNER JOIN projects p on ep.project_id = p.project_id
WHERE DATE(p.start_date) > '2002-8-13'
  AND p.end_date IS NULL
ORDER BY first_name, project_name
LIMIT 5;

/*
 8. Employee 24
Write a query that selects:
employee_id
first_name
project_name
Filter all the projects of employees with id 24. If the project has started after 2005 inclusively the return value
 should be NULL. Sort the result by project_name alphabetically.
Example:

    employee_id	    first_name	    project_name
    24	            David	        NULL
    24	            David	        NULL
    24	            David	        NULL
    24	            David	        Road-650
 */

SELECT employees.employee_id,
       first_name,
       CASE
           WHEN DATE(p.start_date) >= '2005-01-01' THEN NULL
           ELSE name
           END AS 'project_name'
FROM employees
         LEFT JOIN employees_projects ep on employees.employee_id = ep.employee_id
         LEFT JOIN projects p on ep.project_id = p.project_id
WHERE employees.employee_id = 24
ORDER BY project_name;

/*
 9. Employee Manager
Write a query that selects:
employee_id
first_name
manager_id
manager_name
Filter all employees with a manager who has id equal to 3 or 7. Return all rows sorted by employee first_name in
ascending order.
Example:

    employee_id	    first_name	    manager_id	    manager_name
    122	            Bryan	        7	            JoLynn
    158	            Dylan	        3	            Roberto
    …	            …	            …	            …
 */

SELECT e1.employee_id, e1.first_name, e1.manager_id, e2.first_name AS 'manager_name'
FROM employees e1
         JOIN employees e2 ON e1.manager_id = e2.employee_id
WHERE e1.manager_id = 3
   OR e1.manager_id = 7
ORDER BY first_name;

/*
 10. Write a query that selects:
employee_id
employee_name
manager_name
department_name
Show the first 5 employees (only for employees who have a manager) with their managers and the departments they are in
(show the departments of the employees). Order by employee_id.
Example:

    employee_id	    employee_name	manager_name	department_name
    1	            Guy Gilbert	    Jo Brown	    Production
    2	            Kevin Brown	    David Bradley	Marketing
    …	            …	            …	            …
 */

SELECT e.employee_id,
       CONCAT(e.first_name, ' ', e.last_name)   AS 'employee',
       CONCAT(e2.first_name, ' ', e2.last_name) AS 'manager_name',
       d.name                                   AS 'department_name'
FROM employees e
         LEFT JOIN employees e2 ON e.manager_id = e2.employee_id
         LEFT JOIN departments d ON e.department_id = d.department_id
WHERE e.manager_id IS NOT NULL
ORDER BY e.employee_id
LIMIT 5;


/*
 11. Min Average Salary
Write a query that returns the value of the lowest average salary of all departments.
Example:

    min_average_salary
    10866.6666
 */

SELECT AVG(salary) AS 'min_average_salary'
FROM employees
GROUP BY department_id
ORDER BY min_average_salary ASC
LIMIT 1;

/*
 12. Highest Peaks in Bulgaria
Write a query that selects:
country_code
mountain_range
peak_name
elevation
Filter all peaks in Bulgaria with elevation over 2835. Return all rows sorted by elevation in descending order.
Example:

    country_code	mountain_range	peak_name	elevation
    BG	            Rila	        Musala	    2925
    BG	            Pirin	        Vihren	    2914
    …	            …	            …	        …
 */

USE geography;

SELECT c.country_code, m.mountain_range, p.peak_name, p.elevation
FROM countries c
         JOIN mountains_countries mc ON c.country_code = mc.country_code
         JOIN mountains m ON mc.mountain_id = m.id
         JOIN peaks p ON m.id = p.mountain_id
WHERE (c.country_code = 'BG' AND p.elevation > 2835)
ORDER BY p.elevation DESC;

/*
 13. Count Mountain Ranges
Write a query that selects:
country_code
mountain_range
Filter the count of the mountain ranges in the United States, Russia and Bulgaria. Sort result by mountain_range count
in decreasing order.
Example:

    country_code	mountain_range
    BG	            6
    RU	            1
    US	            1
 */

SELECT countries.country_code, COUNT(mountain_id) AS 'mountain_range'
FROM countries
         JOIN mountains_countries mc on countries.country_code = mc.country_code
WHERE countries.country_code IN ('BG', 'RU', 'US')
GROUP BY countries.country_code
ORDER BY mountain_range DESC;

/*
 14. Countries with Rivers
Write a query that selects:
country_name
river_name
Find the first 5 countries with or without rivers in Africa. Sort them by country_name in ascending order.
Example:

    country_name	river_name
    Algeria	        Niger
    Angola	        Congo
    Benin	        Niger
    Botswana        NULL
    Burkina Faso	Niger
 */

SELECT country_name, river_name
FROM countries
         LEFT JOIN countries_rivers cr ON cr.country_code = countries.country_code
         LEFT JOIN rivers r ON cr.river_id = r.id
WHERE continent_code = 'AF'
ORDER BY country_name
LIMIT 5;

/*
 15. Continents and Currencies
Write a query that selects:
continent_code
currency_code
currency_usage
Find all continents and their most used currency. Filter any currency that is used in only one country. Sort the result
by continent_code and currency_code.
Example:

    continent_code	currency_code	currency_usage
    AF	            XOF	            8
    AS	            AUD	            2
    AS	            ILS	            2
    EU	            EUR	            26
    NA	            XCD	            8
    OC	            USD	            8
 */

SELECT continent_code, currency_code, COUNT(currency_code) AS 'currency_usage'
FROM countries c
GROUP BY continent_code, currency_code
HAVING currency_usage > 1
   AND currency_usage = (
    SELECT count(*)
    FROM countries c2
    WHERE c2.continent_code = c.continent_code
    GROUP BY currency_code
    ORDER BY count(*) DESC
    LIMIT 1
)
ORDER BY continent_code, currency_code;

/*
 16. Countries Without Any Mountains
Find the count of all countries which don’t have a mountain.
Example:

    country_count
    231
 */

SELECT COUNT(*) AS 'country_count'
FROM countries
         LEFT JOIN mountains_countries mc on countries.country_code = mc.country_code
WHERE mountain_id IS NULL;

/*
 17. Highest Peak and Longest River by Country
For each country, find the elevation of the highest peak and the length of the longest river, sorted by the highest
peak_elevation (from highest to lowest), then by the longest river_length (from longest to smallest), then by
country_name (alphabetically). Display NULL when no data is available in some of the columns. Limit only the first 5
rows.
Example:

    country_name	highest_peak_elevation	longest_river_length
    China	        8848	                6300
    India	        8848	                3180
    Nepal	        8848	                2948
    Pakistan	    8611	                3180
    Argentina	    6962	                4880
 */

SELECT c.country_name, MAX(p.elevation) AS 'highest_peak_elevation', MAX(r.length) AS 'longest_river_length'
FROM countries c
         LEFT JOIN mountains_countries mc ON c.country_code = mc.country_code
         LEFT JOIN mountains m ON mc.mountain_id = m.id
         LEFT JOIN peaks p ON m.id = p.mountain_id
         LEFT JOIN countries_rivers cr ON c.country_code = cr.country_code
         LEFT JOIN rivers r ON cr.river_id = r.id
GROUP BY c.country_code, country_name
ORDER BY highest_peak_elevation DESC, longest_river_length DESC, c.country_name
LIMIT 5;
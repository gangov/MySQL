-- Download and get familiar with the hospital database schemas and tables. You will use it in the following exercises to write queries.
USE hospital;
/*
 1. Select Employee Information
 Write a query to select all employees and retrieve information about their id, first_name, last_name and job_title ordered by id.
 */

SELECT id, first_name, last_name, job_title
FROM employees
ORDER BY id;

/*
 2. Select Employees with Filter
 Write a query to select all employees (id, first_name, last_name, job_title, salary) whose salaries are higher than
 1000.00, ordered by id. Concatenate fields first_name and last_name into ‘full_name’.
 */

SELECT id, CONCAT(first_name, ' ', last_name) AS full_name, job_title, salary
FROM employees
WHERE salary > 1000.00
ORDER BY id;

/*
 3. Update Employees Salary
 Update all employees salaries whose job_title is “Therapist” by 10%. Retrieve information about all salaries ordered
 ascending.
 */

UPDATE employees
SET salary = salary * 1.1
WHERE job_title = 'Therapist';

SELECT salary
FROM employees
ORDER BY salary ASC;

/*
 4. Top paid employee
 Write a query to create a view that selects all information about the top paid employee from the “employees” table in
 the hospital database.
 */

SELECT id, first_name, last_name, job_title, department_id, salary
FROM employees
ORDER BY salary DESC
LIMIT 1;

/*
 5. Select Employees by Multiple Filters
 Write a query to retrieve information about employees, who are in department 4 and have salary higher or equal to 1600.
 Order the information by id.
 */

SELECT id, first_name, last_name, job_title, department_id, salary
FROM employees
WHERE salary >= 1600
  AND department_id = 4
ORDER BY salary DESC
LIMIT 2;

/*
 6. Delete from Table
 Write a query to delete all employees from the “employees” table who are in department 2 or 1. Order the information by
 id.
 */

DELETE
FROM employees
WHERE department_id = 2
   OR department_id = 1;

SELECT *
FROM employees
ORDER BY id ASC;

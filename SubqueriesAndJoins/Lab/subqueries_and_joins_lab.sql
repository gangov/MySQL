/*
 Lab: Subqueries and JOINs
This document defines the lab assignments for MySQL Course @ Software University.
You will use the soft_uni database to write queries for the following exercises.
 */

USE soft_uni;

/*
 1. Managers
Write a query to retrieve information about the managers – id, full_name, deparment_id and department_name. Select the
 first 5 departments ordered by employee_id. Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
Example:

    employee_id	    full_name	            department_id	department_name
    3               Roberto Tamburello      10              Finance
    4               Rob Walters             2               Tool Design
    6               David Bradley           5               Purchasing
    12              Terri Duffy             1               Engineering
    21              Peter Krebs             8               Production Control

 */

SELECT employee_id,
       CONCAT(first_name, ' ', last_name) AS 'full_name',
       departments.department_id,
       name                               AS 'department_name'
FROM employees
         JOIN departments
              ON employees.employee_id = departments.manager_id
ORDER BY employee_id
LIMIT 5;

/*
 2. Towns Addresses

Write a query to get information about the addresses in the database, which are in San Francisco, Sofia or Carnation.
Retrieve town_id, town_name, address_text. Order the result by town_id, then by address_id. Submit your queries using
the “MySQL prepare DB and Run Queries” strategy.

Example:

    town_id	town_name	    address_text
    9	    San Fransisco	1234 Seaside Way
    9	    San Fransisco	5725 Glaze Drive
    15	    Carnation	    1411 Ranch Drive
    …	    …	            …

 */

SELECT towns.town_id, name AS 'town_name', address_text
FROM towns
         JOIN addresses
              ON towns.town_id = addresses.town_id
WHERE (name = 'San Francisco' OR name = 'Sofia' OR name = 'Carnation')
ORDER BY town_id, address_id;

/*
3. Employees Without Managers
Write a query to get information about employee_id, first_name, last_name, department_id and salary for all employees
who don’t have a manager. Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
Example:

    employee_id	    first_name	    last_name	department_id	salary
    109	            Ken	            Sanchez	    16	            125 500
    291	            Svetlin	        Nakov	    6	            48 000
    292	            Martin	        Kulov	    6	            48 000
    293	            George	        Denchev	    6	            48 000

 */

SELECT employee_id, first_name, last_name, department_id, salary
FROM employees
WHERE manager_id IS NULL;

/*
 4. Higher Salary

Write a query to count the number of employees who receive salary higher than the average. Submit your queries using the
 “MySQL prepare DB and Run Queries” strategy.
 Example:

    count
    88
 */

SELECT COUNT(*)
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
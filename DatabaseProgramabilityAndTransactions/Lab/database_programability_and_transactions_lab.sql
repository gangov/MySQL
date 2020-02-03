/*
 You are provided with the “soft_uni” database. Use it in the following assignments.
 */

USE soft_uni;
SET GLOBAL log_bin_trust_function_creators = 1;

/*
 1. Count Employees by Town
Write a function ufn_count_employees_by_town(town_name) that accepts town_name as parameter and returns the count of
employees who live in that town. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
Example
The following example is given with employees living in Sofia.
Example:
       count
       3
 */

CREATE FUNCTION ufn_count_employees_by_town(town_name VARCHAR(20))
    RETURNS INT
BEGIN
    DECLARE employees_count INT;
    SET employees_count := (SELECT COUNT(employee_id)
                            FROM employees
                                     JOIN addresses a ON employees.address_id = a.address_id
                                     JOIN towns t ON a.town_id = t.town_id
                            WHERE t.name = town_name);
    RETURN employees_count;
END;

SELECT ufn_count_employees_by_town('Sofia') AS 'count';

/*
 2. Employees Promotion
Write a stored procedure usp_raise_salaries(department_name) to raise the salary of all employees in given department as
 parameter by 5%. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
Example
The following example is given with employees in the “Finance” department ordered by first_name, then by salary.

    first_name	salary
    Barbara	    27 720.00
    Bryan	    19 950.00
    Candy	    19 950.00
    …	        …
 */

DELIMITER $$
CREATE PROCEDURE usp_raise_salaries(department_name VARCHAR(50))
BEGIN
    UPDATE employees
        JOIN departments ON employees.department_id = departments.department_id
    SET salary = salary * 1.05
    WHERE departments.name = department_name;
END $$

/*
 3. Employees Promotion by ID
Write a stored procedure usp_raise_salary_by_id(id) that raises a given employee’s salary (by id as parameter) by 5%.
 Consider that you cannot promote an employee that doesn’t exist – if that happens, no changes to the database should be
 made. Submit your queries using the “MySQL Run Skeleton, run queries and check DB” strategy.
Example
The following example is given with employee_id  =  178.

    salary
    27720.0000
 */

DELIMITER $$
CREATE PROCEDURE usp_raise_salary_by_id(id INT)
BEGIN
    START TRANSACTION ;
    IF ((SELECT COUNT(employee_id) FROM employees WHERE employee_id LIKE id) <> 1) THEN
        ROLLBACK ;
    ELSE
        UPDATE employees SET salary = salary * 1.05 WHERE employee_id = id;
    END IF;
END $$

/*
 4. Triggered
Create a table deleted_employees(employee_id PK, first_name,last_name,middle_name,job_title,deparment_id,salary) that
will hold information about fired(deleted) employees from the employees table. Add a trigger to employees table that
inserts the corresponding information in deleted_employees. Submit your queries using the “MySQL Run Skeleton, run
queries and check DB” strategy.
 */

CREATE TABLE deleted_employees
(
    employee_id  INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name   VARCHAR(50) NOT NULL,
    last_name    VARCHAR(50) NOT NULL,
    middle_name  VARCHAR(50),
    job_title    VARCHAR(50) NOT NULL,
    department_id INT         NOT NULL,
    salary       DECIMAL(19, 4)
);

CREATE TRIGGER tr_deleted_employees
    AFTER DELETE
    ON employees
    FOR EACH ROW
BEGIN
    INSERT INTO deleted_employees(first_name, last_name, middle_name, job_title, department_id, salary)
    VALUES (OLD.first_name, OLD.last_name, OLD.middle_name, OLD.job_title, OLD.department_id, OLD.salary);
END $$
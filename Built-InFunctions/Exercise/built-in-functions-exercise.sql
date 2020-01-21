-- Part I – Queries for SoftUni Database
USE soft_uni;

/*
 1. Find Names of All Employees by First Name
Write a SQL query to find first and last names of all employees whose first name starts with “Sa” (case insensitively).
 Order the information by id. Submit your query statements as Prepare DB & run queries.

Example:
    first_name	last_name
    Sariya	    Harnpadoungsataya
    Sandra	    Reategui Alayo
    …	        …
 */

SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'Sa%'
ORDER BY employee_id;

/*
 2. Find Names of All Employees by Last Name
Write a SQL query to find first and last names of all employees whose last name contains “ei” (case insensitively).
 Order the information by id. Submit your query statements as Prepare DB & run queries.
Example:

    first_name	last_name
    Kendall 	Keil
    Christian	Kleinerman
    …	        …
 */

SELECT first_name, last_name
FROM employees
WHERE last_name LIKE '%ei%'
ORDER BY employee_id;

/*
 3. Find First Names of All Employees
Write a SQL query to find the first names of all employees in the departments with ID 3 or 10 and whose hire year is
 between 1995 and 2005 inclusively. Order the information by id. Submit your query statements as Prepare DB & run
 queries.
Example:
    first_name
    Deborah
    Wendey
    Candy
    …
 */

SELECT first_name
FROM employees
WHERE (department_id = 3
    OR department_id = 10)
  AND (hire_date >= '1995-01-01'
    AND hire_date <= '2005-12-31')
ORDER BY employee_id;

/*
 4. Find All Employees Except Engineers
Write a SQL query to find the first and last names of all employees whose job titles does not contain “engineer”.
 Order the information by id. Submit your query statements as Prepare DB & run queries.
Example:
    first_name	last_name
    Guy	        Gilbert
    Kevin	    Brown
    Rob	        Walters
    …       	…
 */

SELECT first_name, last_name
FROM employees
WHERE job_title NOT LIKE '%engineer%'
ORDER BY employee_id;

/*
 5. Find Towns with Name Length
Write a SQL query to find town names that are 5 or 6 symbols long and order them alphabetically by town name.
 Submit your query statements as Prepare DB & run queries.
Example:

    name
    Berlin
    Duluth
    Duvall
    …

 */

SELECT name
FROM towns
WHERE (LENGTH(name) = 5 OR LENGTH(name) = 6)
ORDER BY name ASC;

/*
 6.  Find Towns Starting With
Write a SQL query to find all towns that start with letters M, K, B or E (case insensitively).
 Order them alphabetically by town name. Submit your query statements as Prepare DB & run queries.
Example:
    town_id	name
    5	    Bellevue
    31	    Berlin
    30	    Bordeaux
    …	    …
 */

SELECT town_id, name
FROM towns
WHERE (name LIKE 'M%' OR name LIKE 'K%' OR name LIKE 'B%' OR name LIKE 'E%')
ORDER BY name;

/*
 7. Find Towns Not Starting With
Write a SQL query to find all towns that do not start with letters R, B or D (case insensitively).
 Order them alphabetically by name. Submit your query statements as Prepare DB & run queries.
Example:
    town_id	name
    2	    Calgary
    23	    Cambridge
    15	    Carnation
    …	    …
 */

SELECT town_id, name
FROM towns
WHERE name NOT LIKE 'B%'
  AND name NOT LIKE 'D%'
  AND name NOT LIKE 'R%'
ORDER BY name ASC;

/*
 8. Create View Employees Hired After 2000 Year
Write a SQL query to create view v_employees_hired_after_2000 with the first and the last name of all employees hired
 after 2000 year. Submit your query statements as Run skeleton, run queries & check DB.
Example:
    first_name	last_name
    Steven	    Selikoff
    Peter	    Krebs
    Stuart	    Munson
    ...     	...

 */

CREATE VIEW v_employees_hired_after_2000 AS
SELECT first_name, last_name
FROM employees
WHERE hire_date >= '2001-01-01';

SELECT *
FROM v_employees_hired_after_2000;

/*
 9. Length of Last Name
Write a SQL query to find the names of all employees whose last name is exactly 5 characters long.
Example:
    first_name	last_name
    Kevin	Brown
    Terri	Duffy
    Jo	    Brown
    Diane	Glimp
    …	    …
 */

SELECT first_name, last_name
FROM employees
WHERE LENGTH(last_name) = 5;


-- Part II – Queries for Geography Database

USE geography;

/*
 10. Countries Holding ‘A’ 3 or More Times
Find all countries that hold the letter 'A' in their name at least 3 times (case insensitively), sorted by ISO code.
 Display the country name and the ISO code. Submit your query statements as Prepare DB & run queries.
Example:

    country_name	iso_code
    Afghanistan	    AFG
    Albania     	ALB
    …	            …

 */

SELECT country_name, iso_code
FROM countries
WHERE (country_name LIKE '%a%a%a%')
ORDER BY iso_code;

/*
 11. Mix of Peak and River Names
Combine all peak names with all river names, so that the last letter of each peak name is the same as the first letter
 of its corresponding river name. Display the peak name, the river name, and the obtained mix(converted to lower case).
 Sort the results by the obtained mix alphabetically. Submit your query statements as Prepare DB & run queries.

Example:
    peak_name	    river_name	mix
    Aconcagua	    Amazon	    aconcaguamazon
    Aconcagua	    Amur	    aconcaguamur
    Banski Suhodol	Lena	    banski suhodolena
    …	…	…
 */

SELECT peak_name, river_name, LOWER(CONCAT(peak_name, SUBSTR(river_name, 2))) AS 'mix'
FROM peaks,
     rivers
WHERE (RIGHT(peak_name, 1) = LEFT(river_name, 1))
ORDER BY mix ASC;


-- Part III – Queries for Diablo Database

USE diablo;

/*
 12. Games from 2011 and 2012 Year
Find the top 50 games ordered by start date, then by name. Display only the games from the years 2011 and 2012.
 Display the start date in the format “YYYY-MM-DD”. Submit your query statements as Prepare DB & run queries.
Example:
    name	        start
    Rose Royalty	2011-01-05
    London	        2011-01-13
    Broadway	    2011-01-16
    …	            …
 */

SELECT name, DATE_FORMAT(start, '%Y-%m-%d') AS 'start'
FROM games
WHERE (start >= '2011-01-01' AND start <= '2012-12-31')
ORDER BY start, name
LIMIT 50;

/*
 13. User Email Providers
Find information about the email providers of all users. Display the user_name and the email provider. Sort the results
 by email provider alphabetically, then by username. Submit your query statements as Prepare DB & run queries.
Example:

    user_name	    Email Provider
    Pesho	        abv.bg
    monoxidecos	    astonrasuna.com
    bashsassafras	balibless.com
    …	            …
 */

SELECT user_name, SUBSTRING(email, LOCATE('@', email) + 1) AS 'Email Provider'
FROM users
ORDER BY `Email Provider` ASC, user_name;

/*
 14. Get Users with IP Address Like Pattern
Find the user_name and the ip_address for each user, sorted by user_name alphabetically. Display only the rows, where
 the ip_address matches the pattern: “___.1%.%.___”. Submit your query statements as Prepare DB & run queries.
Example:
    user_name	        ip_address
    bindbawdy	        192.157.20.222
    evolvingimportant	223.175.227.173
    inguinalself        255.111.250.207
    …	                …
 */

SELECT user_name, ip_address
FROM users
WHERE ip_address LIKE '___.1%.%.___'
ORDER BY user_name ASC;

/*
 15. Show All Games with Duration and Part of the Day
Find all games with their corresponding part of the day and duration. Parts of the day should be Morning (start time is
 >= 0 and < 12), Afternoon (start time is >= 12 and < 18), Evening (start time is >= 18 and < 24). Duration should be
 Extra Short (smaller or equal to 3), Short (between 3 and 6 including), Long (between 6 and 10 including) and Extra
 Long in any other cases or without duration. Submit your query statements as Prepare DB & run queries.
Example:

    game	            Part of the Day	    Duration
    Aithusa	            Evening	            Short
    Acid green	        Morning	            Long
    Apple	            Morning	            Short
    Broadway	        Morning	            Short
    Ancalagon	        Morning	            Short
    Allium drumstick	Morning	            Extra Long
    …	                …	                …
 */

SELECT name                                                                                            AS 'game',
       IF(HOUR(start) >= 0 AND HOUR(start) < 12, 'Morning',
          IF(HOUR(start) >= 12 AND HOUR(start) < 18, 'Afternoon', 'Evening'))                          AS 'Part of the Day',
       IF(duration <= 3, 'Extra Short', IF(duration > 3 AND duration <= 6, 'Short',
                                           IF(duration > 6 AND duration <= 10, 'Long', 'Extra Long'))) AS 'Duration'
FROM games;


-- Part IV – Date Functions Queries

USE orders;

/*
 16. Orders Table
You are given a table orders(id, product_name, order_date) filled with data. Consider that the payment for an order must
 be accomplished within 3 days after the order date. Also the delivery date is up to 1 month. Write a query to show each
 product’s name, order date, pay and deliver due dates. Submit your query statements as Prepare DB & run queries.
Original Table:

    id	product_name	order_date
    1	Butter	        2016-09-19 00:00:00
    2	Milk	        2016-09-30 00:00:00
    3	Cheese	        2016-09-04 00:00:00
    4	Bread	        2015-12-20 00:00:00
    5	Tomatoes	    2015-12-30 00:00:00
    …	…	            …

Output:
    product_name	order_date	            pay_due	                deliver_due
    Butter	        2016-09-19 00:00:00	    2016-09-22 00:00:00	    2016-10-19 00:00:00
    Milk	        2016-09-30 00:00:00	    2016-10-03 00:00:00	    2016-10-30 00:00:00
    Cheese	        2016-09-04 00:00:00	    2016-09-07 00:00:00	    2016-10-04 00:00:00
    Bread	        2015-12-20 00:00:00	    2015-12-23 00:00:00	    2016-01-20 00:00:00
    Tomatoes	    2015-12-30 00:00:00	    2016-01-02 00:00:00	    2016-01-30 00:00:00
    …	            …	                    …	                    …
 */

SELECT product_name, order_date, DATE_ADD(order_date, INTERVAL 3 DAY) AS 'pay_due', DATE_ADD(order_date, INTERVAL 1 MONTH ) AS 'deliver_due'
FROM orders;

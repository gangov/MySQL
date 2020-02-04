/*
 Part I – Queries for SoftUni Database
 */

USE soft_uni;

/*
 1. Employees with Salary Above 35000
Create stored procedure usp_get_employees_salary_above_35000 that returns all employees’ first and last names for whose
salary is above 35000. The result should be sorted by first_name then by last_name alphabetically, and id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example:

    first_name	last_name
    Amy	        Alberts
    Brian	    Welcker
    Dan	        Wilson
    …	        …
 */

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above_35000()
BEGIN
    SELECT first_name, last_name FROM employees WHERE salary > 35000 ORDER BY first_name, last_name, employee_id DESC;
END $$

CAll usp_get_employees_salary_above_35000();

/*
 2. Employees with Salary Above Number

Create stored procedure usp_get_employees_salary_above that accept a number as parameter and return all employees’ first
and last names whose salary is above or equal to the given number. The result should be sorted by first_name then by
last_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
Supplied number for that example is 48100.

    first_name	last_name
    Amy	        Alberts
    Brian	    Welcker
    Dylan	    Miller
    …	        …
 */

DELIMITER $$
CREATE PROCEDURE usp_get_employees_salary_above(quota DECIMAL(19, 4))
BEGIN
    SELECT first_name, last_name FROM employees WHERE salary >= quota ORDER BY first_name, last_name, employee_id ASC;
END $$


CALL usp_get_employees_salary_above(48100);

/*
 3. Town Names Starting With
Write a stored procedure usp_get_towns_starting_with that accept string as parameter and returns all town names starting
with that string. The result should be sorted by town_name alphabetically. Submit your query statement as Run skeleton,
run queries & check DB in Judge.

Example
Here is the list of all towns starting with “b”.

    town_name
    Bellevue
    Berlin
    Bordeaux
    Bothell
 */

DELIMITER $$
CREATE PROCEDURE usp_get_towns_starting_with(name_quota VARCHAR(50))
BEGIN
    SELECT name FROM towns WHERE name LIKE CONCAT(name_quota, '%') ORDER BY name ASC;
END $$

CALL usp_get_towns_starting_with('b');

/*
 4. Employees from Town
Write a stored procedure usp_get_employees_from_town that accepts town_name as parameter and return the employees’ first
and last name that live in the given town. The result should be sorted by first_name then by last_name alphabetically
and id ascending. Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
Here it is a list of employees living in Sofia.

    first_name	last_name
    George	    Denchev
    Martin	    Kulov
    Svetlin	    Nakov
 */

DELIMITER $$
CREATE PROCEDURE usp_get_employees_from_town(name_quota VARCHAR(50))
BEGIN
    SELECT first_name, last_name
    FROM employees
             JOIN addresses ON employees.address_id = addresses.address_id
             JOIN towns ON addresses.town_id = towns.town_id
    WHERE towns.name = name_quota
    ORDER BY first_name, last_name, employee_id;
END $$

CALL usp_get_employees_from_town('Sofia');

/*
 5. Salary Level Function
Write a function ufn_get_salary_level that receives salary of an employee and returns the level of the salary.
If salary is < 30000 return “Low”
If salary is between 30000 and 50000 (inclusive) return “Average”
If salary is > 50000 return “High”
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example

    salary	    salary_Level
    13500.00	Low
    43300.00	Average
    125500.00	High
 */

CREATE FUNCTION ufn_get_salary_level(salary_quota DECIMAL(19, 4))
    RETURNS VARCHAR(50)
BEGIN
    DECLARE result VARCHAR(50);
    SET result := (
        CASE
            WHEN salary_quota < 30000 THEN 'Low'
            WHEN salary_quota >= 30000 AND salary_quota <= 50000 THEN 'Average'
            ELSE 'High'
            END
        );
    RETURN result;
END;

SELECT ufn_get_salary_level(13500) AS 'salary_Level';

/*
 6. Employees by Salary Level

Write a stored procedure usp_get_employees_by_salary_level that receive as parameter level of salary (low, average or
high) and print the names of all employees that have given level of salary. The result should be sorted by first_name
then by last_name both in descending order.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example

Here is the list of all employees with high salary.

    first_name	last_name
    Terri	    Duffy
    Laura	    Norman
    Ken	        Sanchez
    …	        …
 */

DELIMITER $$
CREATE PROCEDURE usp_get_employees_by_salary_level(salary_level_quota VARCHAR(20))
BEGIN
    SELECT first_name, last_name
    FROM employees
    WHERE (CASE

               WHEN salary_level_quota = 'Low' THEN salary < 30000
               WHEN salary_level_quota = 'Average' THEN salary <= 50000
               WHEN salary_level_quota = 'High' THEN salary > 50000
        END)
    ORDER BY first_name DESC, last_name DESC;
END $$

CALL usp_get_employees_by_salary_level('high');

/*
 7. Define Function
Define a function ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))  that returns true or false
depending on that if the word is a comprised of the given set of letters.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example

    set_of_letters	word	result
    oistmiahf	    Sofia	1
    oistmiahf	    halves	0
    bobr	        Rob	    1
    pppp	        Guy	    0
 */

CREATE FUNCTION ufn_is_word_comprised(set_of_letters varchar(50), word varchar(50))
    RETURNS TINYINT
BEGIN
    DECLARE result TINYINT;
    SET result := (
        word REGEXP (CONCAT('^[', `set_of_letters`, ']+$'))
        );
    RETURN result;
END $$

SELECT ufn_is_word_comprised('oistmiahf', 'Sofia');

-- PART II – Queries for Bank Database

/*
 8. Find Full Name
You are given a database schema with tables:
account_holders(id (PK), first_name, last_name, ssn)
and
accounts(id (PK), account_holder_id (FK), balance).
Write a stored procedure usp_get_holders_full_name that selects the full names of all people. The result should be
sorted by full_name alphabetically and id ascending. Submit your query statement as Run skeleton, run queries & check
DB in Judge.
Example

    full_name
    Bjorn Sweden
    Jimmy Henderson
    Kim Novac
    …
 */


DELIMITER $$
CREATE PROCEDURE usp_get_holders_full_name()
BEGIN
    SELECT CONCAT(first_name, ' ', last_name) AS 'full_name' FROM account_holders ORDER BY first_name, last_name, id;
END $$

CALL usp_get_holders_full_name;

/*
 9. People with Balance Higher Than
Your task is to create a stored procedure usp_get_holders_with_balance_higher_than that accepts a number as a parameter
and returns all people who have more money in total of all their accounts than the supplied number. The result should
be sorted by account id ascending.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
Supplied number for that example is 7000.

    first_name	last_name
    Susan	    Cane
    Petko	    Petkov Junior
    Zlatina	    Pateva
    …	        …
 */

DELIMITER $$
CREATE PROCEDURE usp_get_holders_with_balance_higher_than(balance_quote DECIMAL(19, 4))
BEGIN
    SELECT a.id, ah.first_name, ah.last_name
    FROM account_holders AS ah
             JOIN accounts AS a
                  ON a.account_holder_id = ah.id
    GROUP BY a.account_holder_id
    HAVING SUM(a.balance) > 7000
    ORDER BY a.id;
END $$

CALL usp_get_holders_with_balance_higher_than(7000);

/*
 10. Future Value Function
Your task is to create a function ufn_calculate_future_value that accepts as parameters – sum, yearly interest rate and
 number of years. It should calculate and return the future value of the initial sum. Using the following formula:
FutureValue = I * ((1 + R) ** T)

I – Initial sum
R – Yearly interest rate
T – Number of years
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example

    Input	                                    Output
    Initial sum: 1000
    Yearly Interest rate: 10%
    years: 5
    ufn_calculate_future_value(1000, 0.1, 5)	1610.51
 */

SET GLOBAL log_bin_trust_function_creators = 1;


CREATE FUNCTION ufn_calculate_future_value(sum DECIMAL(19, 4), yearly_rate DOUBLE, number_of_years INT)
    RETURNS DOUBLE
BEGIN
    RETURN sum * POWER((1 + yearly_rate), number_of_years);

END $$

SELECT ufn_calculate_future_value(1000, 0.1, 5);

/*
 11. Calculating Interest
Your task is to create a stored procedure usp_calculate_future_value_for_account that uses the function from the
previous problem to give an interest to a person's account for 5 years, along with information about his/her account
id, first name, last name and current balance as it is shown in the example below. It should take the account_id and
the interest_rate as parameters. Interest rate should have precision up to 0.0001, same as the calculated balance after
5 years. Be extremely careful to achieve the desired precision!
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example:
Here is the result for account_id = 1 and interest_rate = 0.1.

    account_id	fist_name	last_name	current_balance	balance_in_5_years
    1	        Susan	    Cane	    123.1200	    198.2860
 */

DROP PROCEDURE usp_calculate_future_value_for_account;

DELIMITER $$
CREATE PROCEDURE usp_calculate_future_value_for_account(account_id INT, interest_rate DOUBLE)
BEGIN
    SELECT accounts.id,
           first_name,
           last_name,
           balance,
           FORMAT(ufn_calculate_future_value(balance, interest_rate, 5), 4)
    FROM accounts
             JOIN account_holders ON accounts.account_holder_id = account_holders.id
    WHERE account_id = account_holders.id
    GROUP BY account_holder_id;
END;
$$


CALL usp_calculate_future_value_for_account(1, 0.1);

/*
 12. Deposit Money
Add stored procedure usp_deposit_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee valid positive money_amount with precision up to fourth sign after decimal point. The procedure
should produce exact results working with the specified precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
Here is the result for account_id = 1 and money_amount = 10.

    account_id	account_holder_id	balance
    1	        1	                133.1200
 */

CREATE PROCEDURE usp_deposit_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION ;
    IF money_amount <= 0 THEN
        ROLLBACK;
    ELSE
        UPDATE accounts SET balance = balance + money_amount WHERE accounts.id = account_id;
    END IF;
END $$

CALL usp_deposit_money(1, 10);

/*
 13. Withdraw Money
Add stored procedures usp_withdraw_money(account_id, money_amount) that operate in transactions.
Make sure to guarantee withdraw is done only when balance is enough and money_amount is valid positive number. Work with
precision up to fourth sign after decimal point. The procedure should produce exact results working with the specified
precision.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
Here is the result for account_id = 1 and money_amount = 10.

    account_id	account_holder_id	balance
    1	        1	                113.1200
 */

CREATE PROCEDURE usp_withdraw_money(account_id INT, money_amount DECIMAL(19, 4))
BEGIN
    START TRANSACTION ;
    IF (money_amount <= 0) OR (SELECT balance FROM accounts WHERE id = account_id) - money_amount < 0 THEN
        ROLLBACK;
    ELSE
        UPDATE accounts SET balance = balance - money_amount WHERE accounts.id = account_id;
    END IF;
END $$

CALL usp_withdraw_money(1, 10);

/*
 14. Money Transfer
Write stored procedure usp_transfer_money(from_account_id, to_account_id, amount) that transfers money from one account
to another. Consider cases when one of the account_ids is not valid, the amount of money is negative number, outgoing
balance is enough or transferring from/to one and the same account. Make sure that the whole procedure passes without
errors and if error occurs make no change in the database.
Make sure to guarantee exact results working with precision up to fourth sign after decimal point.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
Here is the result for from_account_id = 1, to_account_id = 2 and money_amount = 10.

    account_id	account_holder_id	balance
    1	        1	                113.1200
    2	        3	                4364.2300
 */
DROP PROCEDURE usp_transfer_money;

CREATE PROCEDURE usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(20, 4))
BEGIN
    START TRANSACTION;
    CASE WHEN
                (SELECT id FROM accounts WHERE id = from_account_id) IS NULL
            OR (SELECT id FROM accounts WHERE id = to_account_id) IS NULL
            OR from_account_id = to_account_id
            OR amount < 0
            OR (SELECT balance FROM accounts WHERE id = from_account_id) < amount
        THEN ROLLBACK;
        ELSE
            UPDATE accounts
            SET balance = balance - amount
            WHERE id = from_account_id;

            UPDATE accounts
            SET balance = balance + amount
            WHERE id = to_account_id;
        END CASE;
    COMMIT;
END;
$$

CALL usp_transfer_money(1, 2, 10);

/*
 15. Log Accounts Trigger
Create another table – logs(log_id, account_id, old_sum, new_sum). Add a trigger to the accounts table that enters a new
entry into the logs table every time the sum on an account changes.
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example
The following data in logs table is inserted after updating balance of account with account_id = 1 with 10.

    log_id	account_id	old_sum	new_sum
    1	    1	        123.12	113.12
    2	    1	        145.43	155.43
 */

CREATE TABLE logs
(
    log_id     INT     NOT NULL PRIMARY KEY AUTO_INCREMENT,
    account_id INT(11) NOT NULL,
    old_sum    DECIMAL(19, 4),
    new_sum    DECIMAL(19, 4)
);

CREATE TRIGGER tr_update_table
    AFTER UPDATE
    ON accounts
    FOR EACH ROW
BEGIN
    INSERT INTO logs(account_id, old_sum, new_sum) VALUES (OLD.id, OLD.balance, NEW.balance);
END;
$$

/*
 16. Create another table – notification_emails(id, recipient, subject, body). Add a trigger to logs table to create new
email whenever new record is inserted in logs table. The following data is required to be filled for each email:
recipient – account_id
subject – “Balance change for account: {account_id}”
body - “On {date (current date)} your balance was changed from {old} to {new}.”
Submit your query statement as Run skeleton, run queries & check DB in Judge.
Example

    id	recipient	subject	                        body
    1	1	        Balance change for account: 1	On Sep 15 2016 at 11:44:06 AM your balance was changed from 133 to 143.
    …	…	        …	                            …
 */

CREATE TABLE notification_emails
(
    id        INT     NOT NULL PRIMARY KEY AUTO_INCREMENT,
    recipient INT(11) NOT NULL,
    subject   VARCHAR(200),
    body      VARCHAR(200)
);

CREATE TRIGGER tr_log_email
    AFTER INSERT
    ON logs
    FOR EACH ROW
BEGIN
    INSERT INTO notification_emails(recipient, subject, body)
    VALUES (NEW.account_id, CONCAT('Balance change for account: ', NEW.account_id),
            CONCAT('On ', DATE_FORMAT(NOW(), "%M %d %Y"), ' your balance was changed from ', NEW.old_sum, ' to ', NEW.new_sum, '.');
END;
$$


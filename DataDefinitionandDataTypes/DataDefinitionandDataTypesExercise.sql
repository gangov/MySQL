/*
 1. Create Tables
 In the newly created database Minions add table minions (id, name, age). Then add new table towns (id, name). Set id
 columns of both tables to be primary key as constraint. Submit your create table queries in Judge together for both
 tables (one after another separated by “;”) as Run queries & check DB.
 */
CREATE TABLE `minions`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL,
    `age`  INT         NULL
);

CREATE TABLE `towns`
(
    `id`   INT PRIMARY KEY AUTO_INCREMENT,
    `name` VARCHAR(20) NOT NULL
);

/*
 2. Alter minions table
 Change the structure of the Minions table to have new column town_id that would be of the same type as the id column of
 towns table. Add new constraint that makes town_id foreign key and references to id column of towns table. Submit your
 create table query in Judge as MySQL run skeleton, run queries & check DB
 */

ALTER TABLE minions
    ADD COLUMN town_id INT NOT NULL;

ALTER TABLE minions
    ADD CONSTRAINT fk_minions_town FOREIGN KEY (town_id) REFERENCES towns (id);

/*
 3. Populate both tables with sample records given in the table below:
minions								towns
id	name		age		town_id		id	name
1	Kevin		22		1			1	Sofia
2	Bob			15		3			2	Plovdiv
3	Steward		NULL 	2			3	Varna
*/

INSERT INTO `towns`(`id`, `name`)
VALUES (1, 'Sofia'),
       (2, 'Plovdiv'),
       (3, 'Varna');

INSERT INTO `minions`(`id`, `name`, `age`, `town_id`)
VALUES (1, 'Kevin', 22, 1),
       (2, 'Bob', 15, 3),
       (3, 'Steward', NULL, 2);

/*
 4. Truncate table minions
 Delete all the data from the minions table using SQL query. Submit your query in Judge as Run skeleton, run queries &
 check DB.
 */

TRUNCATE TABLE minions;


/*
 5. Drop all tables
 Delete all tables from the minions database using SQL query. Submit your query in Judge as Run skeleton, run queries &
 check DB.
 */

DROP TABLE minions;
DROP TABLE towns;

/*
6. Create table people
Using SQL query create table “people” with columns:
id – unique number for every person there will be no more than 231-1people. (Auto incremented)
name – full name of the person will be no more than 200 Unicode characters. (Not null)
picture – image with size up to 2 MB. (Allow nulls)
height –  In meters. Real number precise up to 2 digits after floating point. (Allow nulls)
weight –  In kilograms. Real number precise up to 2 digits after floating point. (Allow nulls)
gender – Possible states are m or f. (Not null)
birthdate – (Not null)
biography – detailed biography of the person it can contain max allowed Unicode characters. (Allow nulls)
Make id primary key. Populate the table with 5 records.  Submit your CREATE and INSERT statements in
Judge as Run queries & check DB.

*/

CREATE TABLE `people`
(
    `id`        INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    `name`      VARCHAR(200) NOT NULL,
    `picture`   BLOB,
    `height`    DOUBLE(5, 2),
    `weight`    DOUBLE(5, 2),
    `gender`    CHAR(1)      NOT NULL,
    `birthdate` DATE         NOT NULL,
    `biography` TEXT
);

INSERT INTO `people`(`id`, `name`, `picture`, `height`, `weight`, `gender`, `birthdate`, `biography`)
VALUES (1, 'Kaloyan Gangov',
        x'89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000001E49444154384F6350DAE843126220493550F1A80662426C349406472801006AC91F1040F796BD0000000049454E44AE426082',
        1.88, 105.40, 'm', '1990-02-03', 'Has a really large dick and fucks like a bull :)'),
       (2, 'Stoyan Petrov',
        x'89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000001E49444154384F6350DAE843126220493550F1A80662426C349406472801006AC91F1040F796BD0000000049454E44AE426082',
        1.66, 58.40, 'm', '1992-02-03', 'Nothing interesting to say about this guy'),
       (3, 'Petko Draganov',
        x'89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000001E49444154384F6350DAE843126220493550F1A80662426C349406472801006AC91F1040F796BD0000000049454E44AE426082',
        1.95, 97.40, 'm', '1995-02-03', 'Nothing interesting to say about this guy'),
       (4, 'Draganka Ivanova',
        x'89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000001E49444154384F6350DAE843126220493550F1A80662426C349406472801006AC91F1040F796BD0000000049454E44AE426082',
        1.78, 55.40, 'f', '1993-02-03', 'Nothing interesting to say about this girl'),
       (5, 'Ivelina Hristova',
        x'89504E470D0A1A0A0000000D494844520000001000000010080200000090916836000000017352474200AECE1CE90000000467414D410000B18F0BFC6105000000097048597300000EC300000EC301C76FA8640000001E49444154384F6350DAE843126220493550F1A80662426C349406472801006AC91F1040F796BD0000000049454E44AE426082',
        1.80, 54.40, 'm', '1995-02-03', 'Nothing interesting to say about this girl');


/*
7. Create Table Users
Using SQL query create table users with columns:
id – unique number for every user. There will be no more than 263-1 users. (Auto incremented)
username – unique identifier of the user will be no more than 30 characters (non Unicode). (Required)
password – password will be no longer than 26 characters (non Unicode). (Required)
profile_picture – image with size up to 900 KB.
last_login_time
is_deleted – shows if the user deleted his/her profile. Possible states are true or false.
Make id primary key. Populate the table with 5 records. Submit your CREATE and INSERT statements.
Submit your CREATE and INSERT statements as Run queries & check DB.
*/

CREATE TABLE `users`
(
    `id`              INT UNIQUE PRIMARY KEY AUTO_INCREMENT,
    `username`        VARCHAR(30) UNIQUE NOT NULL,
    `password`        VARCHAR(26)        NOT NULL,
    `profile_picture` MEDIUMBLOB,
    `last_login_time` TIME,
    `is_deleted`      TINYINT            NOT NULL
);

INSERT INTO `users`(`username`, `password`, `last_login_time`, `is_deleted`)
VALUES ('kurcho', 'admin123QWE', '2019-01-13 13:17:17', FALSE),
       ('pishcko', 'admin123QWE', '2019-01-13 13:17:17', FALSE),
       ('krio', 'admin123QWE', '2019-01-13 13:17:17', FALSE),
       ('DartVader', 'admin123QWE', '2019-01-13 13:17:17', FALSE),
       ('eipedal', 'admin123QWE', '2019-01-13 13:17:17', FALSE);


/*
8. Change primary key
Using SQL queries modify table users from the previous task. First remove current primary key then create new primary
key that would be combination of fields id and username. The initial primary key name on id is pk_users. Submit your
query in Judge as Run skeleton, run queries & check DB.
 */

ALTER TABLE `users`
    MODIFY `id` INT NOT NULL;

ALTER TABLE `users`
    DROP PRIMARY KEY;


ALTER TABLE users
    ADD CONSTRAINT pk_users PRIMARY KEY (id, username);

/*
 9. Set Default Value of a Field
 Using SQL queries modify table users. Make the default value of last_login_time field to be the current time. Submit
 your query in Judge as Run skeleton, run queries & check DB.
 */

ALTER TABLE users
    MODIFY COLUMN last_login_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP;

/*
 10.  Set Unique Field
Using SQL queries modify table users. Remove username field from the primary key so only the field id would be primary
 key. Now add unique constraint to the username field. The initial primary key name on (id, username) is pk_users.
 Submit your query in Judge as Run skeleton, run queries & check DB.
*/

ALTER TABLE users
    DROP PRIMARY KEY,
    ADD CONSTRAINT pk_users
        PRIMARY KEY (id),
    ADD CONSTRAINT unique_username
        UNIQUE (username);


/*
 11. Movies Database
Using SQL queries create Movies database with the following entities:
directors (id, director_name, notes)
genres (id, genre_name, notes)
categories (id, category_name, notes)
movies (id, title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
Set most appropriate data types for each column. Set primary key to each table. Populate each table with 5 records.
Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always
required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
 */

CREATE DATABASE movies;

USE movies;

CREATE TABLE directors
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(100) NOT NULL,
    notes         TEXT
);

CREATE TABLE genres
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(50) NOT NULL,
    notes      TEXT
);

CREATE TABLE categories
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    notes         TEXT
);

CREATE TABLE movies
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    title          VARCHAR(100) NOT NULL,
    director_id    INT          NOT NULL,
    copyright_year YEAR,
    length         INT,
    genre_id       INT          NOT NULL,
    category_id    INT          NOT NULL,
    rating         INT,
    notes          TEXT
);

INSERT INTO directors(director_name, notes)
VALUES ('Ivan Petrov', 'Dummy text'),
       ('Ivan Petrov', 'Dummy text'),
       ('Ivan Petrov', 'Dummy text'),
       ('Ivan Petrov', 'Dummy text'),
       ('Ivan Petrov', 'Dummy text');

INSERT INTO genres(genre_name, notes)
VALUES ('rape', 'Dummy text'),
       ('rape', 'Dummy text'),
       ('rape', 'Dummy text'),
       ('rape', 'Dummy text'),
       ('rape', 'Dummy text');

INSERT INTO categories(category_name, notes)
VALUES ('violent rape', 'Dummy text'),
       ('violent rape', 'Dummy text'),
       ('violent rape', 'Dummy text'),
       ('violent rape', 'Dummy text'),
       ('violent rape', 'Dummy text');

INSERT INTO movies(title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES ('sex and the softuni', 3, 2020, 180, 2, 2, 1, 'Dummy text'),
       ('sex and the softuni', 3, 2020, 180, 2, 2, 1, 'Dummy text'),
       ('sex and the softuni', 3, 2020, 180, 2, 2, 1, 'Dummy text'),
       ('sex and the softuni', 3, 2020, 180, 2, 2, 1, 'Dummy text'),
       ('sex and the softuni', 3, 2020, 180, 2, 2, 1, 'Dummy text');

/*
 12. Car Rental Database
 Using SQL queries create car_rental database with the following entities:
categories (id, category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
cars (id, plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
employees (id, first_name, last_name, title, notes)
customers (id, driver_licence_number, full_name, address, city, zip_code, notes)
rental_orders (id, employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end,
    total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
Set most appropriate data types for each column. Set primary key to each table. Populate each table with 3 records.
 Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always
 required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
 */

CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    category     VARCHAR(50)  NOT NULL,
    daily_rate   DOUBLE(5, 2) NOT NULL,
    weekly_rate  DOUBLE(5, 2) NOT NULL,
    monthly_rate DOUBLE(5, 2) NOT NULL,
    weekend_rate DOUBLE(5, 2) NOT NULL
);

CREATE TABLE cars
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    plate_number  VARCHAR(10) NOT NULL UNIQUE,
    make          VARCHAR(20) NOT NULL,
    model         VARCHAR(20) NOT NULL,
    car_year      YEAR,
    category_id   INT         NOT NULL,
    doors         INT         NOT NULL,
    picture       BLOB,
    car_condition VARCHAR(50) NOT NULL,
    available     TINYINT     NOT NULL
);

CREATE TABLE employees
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    title      VARCHAR(20),
    notes      TEXT
);

CREATE TABLE customers
(
    id                    INT PRIMARY KEY AUTO_INCREMENT,
    driver_licence_number INT          NOT NULL UNIQUE,
    full_name             VARCHAR(100) NOT NULL,
    address               VARCHAR(200),
    city                  VARCHAR(50),
    zip_code              INT          NOT NULL,
    notes                 TEXT
);

CREATE TABLE rental_orders
(
    id                INT PRIMARY KEY AUTO_INCREMENT,
    employee_id       INT          NOT NULL,
    customer_id       INT          NOT NULL,
    car_id            INT          NOT NULL,
    car_condition     VARCHAR(50)  NOT NULL,
    tank_level        INT          NOT NULL,
    kilometrage_start DOUBLE(8, 2) NOT NULL,
    kilometrage_end   DOUBLE(8, 2) NOT NULL,
    total_kilometrage DOUBLE(5, 2) NOT NULL,
    start_date        DATE         NOT NULL,
    end_date          DATE         NOT NULL,
    total_days        INT          NOT NULL,
    rate_applied      DOUBLE(5, 2) NOT NULL,
    tax_rate          DOUBLE(4, 2) NOT NULL,
    order_status      VARCHAR(50)  NOT NULL,
    notes             TEXT
);

INSERT INTO categories(category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES ('cars', 1.2, 1.3, 1.4, 1.5),
       ('buses', 1.2, 1.3, 1.4, 1.5),
       ('trucks', 1.2, 1.3, 1.4, 1.5);

INSERT INTO cars(plate_number, make, model, category_id, doors, car_condition, available)
VALUES ('PB 4778 XT', 'Mercedes', 'CLK-230', 1, 3, 'used', TRUE),
       ('PB 4758 XT', 'Mercedes', 'CLK-230', 1, 3, 'used', TRUE),
       ('PB 4738 XT', 'Mercedes', 'CLK-230', 1, 3, 'used', TRUE);

INSERT INTO employees(first_name, last_name, title)
VALUES ('Kaloyan', 'Gangov', 'CEO'),
       ('Kaloyan', 'Gangov', 'Manager'),
       ('Kaloyan', 'Gangov', 'Owner');

INSERT INTO customers(driver_licence_number, full_name, zip_code)
VALUES (14241235, 'Stoyan Petrov', 1000),
       (13541235, 'Stoyan Petrov', 1000),
       (13261235, 'Stoyan Petrov', 1000);

INSERT INTO rental_orders(EMPLOYEE_ID, CUSTOMER_ID, CAR_ID, CAR_CONDITION, TANK_LEVEL, KILOMETRAGE_START,
                          KILOMETRAGE_END, TOTAL_KILOMETRAGE, START_DATE, END_DATE, TOTAL_DAYS, RATE_APPLIED, TAX_RATE,
                          ORDER_STATUS)
VALUES (1, 2, 2, 'used', 100, 180560.25, 180650.25, 250.22, '2020-01-01', '2020-01-15', 15, 1.5, 20.00, 'submitted'),
       (1, 2, 2, 'used', 100, 180560.25, 180650.25, 250.22, '2020-01-01', '2020-01-15', 15, 1.5, 20.00, 'submitted'),
       (1, 2, 2, 'used', 100, 180560.25, 180650.25, 250.22, '2020-01-01', '2020-01-15', 15, 1.5, 20.00, 'submitted');

/*
 13. Hotel Database
Using SQL queries create Hotel database with the following entities:
employees (id, first_name, last_name, title, notes)
customers (account_number, first_name, last_name, phone_number, emergency_name, emergency_number, notes)
room_status (room_status, notes)
room_types (room_type, notes)
bed_types (bed_type, notes)
rooms (room_number, room_type, bed_type, rate, room_status, notes)
payments (id, employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days,
    amount_charged, tax_rate, tax_amount, payment_total, notes)
occupancies (id, employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes)

Set most appropriate data types for each column. Set primary key to each table. Populate each table with 3 records.
 Make sure the columns that are present in 2 tables would be of the same data type. Consider which fields are always
 required and which are optional. Submit your CREATE TABLE and INSERT statements as Run queries & check DB.
 */

CREATE DATABASE hotel;
USE hotel;

CREATE TABLE employees
(
    id         INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    title      VARCHAR(50) NOT NULL,
    notes      TEXT
);

CREATE TABLE customers
(
    account_number   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name       VARCHAR(50) NOT NULL,
    last_name        VARCHAR(50) NOT NULL,
    phone_number     VARCHAR(15) UNIQUE,
    emergency_name   VARCHAR(50) NOT NULL UNIQUE,
    emergency_number VARCHAR(50) NOT NULL UNIQUE,
    notes            TEXT
);

CREATE TABLE room_status
(
    room_status VARCHAR(50) NOT NULL,
    notes       TEXT
);

CREATE TABLE room_types
(
    room_type VARCHAR(20) NOT NULL,
    notes     TEXT
);

CREATE TABLE bed_types
(
    bed_type VARCHAR(20) NOT NULL,
    notes    TEXT
);

CREATE TABLE rooms
(
    room_number INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    room_type   VARCHAR(50)  NOT NULL,
    bed_type    VARCHAR(20)  NOT NULL,
    rate        DOUBLE(5, 2) NOT NULL,
    room_status VARCHAR(50)  NOT NULL,
    notes       TEXT
);

CREATE TABLE payments
(
    id                  INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_id         INT          NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES employees (id),
    payment_date        TIMESTAMP    NOT NULL,
    account_number      INT          NOT NULL,
    first_date_occupied TIMESTAMP    NOT NULL,
    last_date_occupied  TIMESTAMP    NOT NULL,
    total_days          INT          NOT NULL,
    amount_charged      DOUBLE(6, 2) NOT NULL,
    tax_rate            DOUBLE(4, 2) NOT NULL,
    tax_amount          DOUBLE(5, 2) NOT NULL,
    payment_total       DOUBLE(6, 2) NOT NULL,
    notes               TEXT
);

CREATE TABLE occupancies
(
    id             INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    employee_id    INT          NOT NULL,
    date_occupied  TIMESTAMP    NOT NULL,
    account_number INT          NOT NULL,
    room_number    INT          NOT NULL,
    rate_applied   DOUBLE(4, 2) NOT NULL,
    phone_charge   DOUBLE(4, 2),
    notes          TEXT
);

INSERT INTO employees (first_name, last_name, title)
VALUES ('petko', 'raychev', 'manager'),
       ('petko', 'raychev', 'manager'),
       ('petko', 'raychev', 'manager');

INSERT INTO customers (first_name, last_name, phone_number, emergency_name, emergency_number,
                       notes)
VALUES ('petko', 'raychev', 2222222222, 'petko kapitan', 333333, 'this is boring'),
       ('petko', 'raychev', 1111111111, 'petko captain', 222222, 'this is boring'),
       ('petko', 'raychev', 3333333333, 'petko komutan', 111111, 'this is boring');

INSERT INTO room_status (room_status)
VALUES ('available'),
       ('needs cleaning'),
       ('reserved');

INSERT INTO room_types (room_type)
VALUES ('suite'),
       ('single-room'),
       ('president-apartment');

INSERT INTO bed_types (bed_type)
VALUES ('single-bed'),
       ('person-and-a-half'),
       ('large-bed');

INSERT INTO rooms (room_type, bed_type, rate, room_status)
VALUES ('suite', 'large-bed', 80.00, 'available'),
       ('suite', 'large-bed', 80.00, 'available'),
       ('suite', 'large-bed', 80.00, 'available');

INSERT INTO payments (employee_id, payment_date, account_number, first_date_occupied, last_date_occupied,
                      total_days, amount_charged, tax_rate, tax_amount, payment_total)
VALUES (1, '2018-05-05 08:00:00', 1, '2018-05-05 08:00:00', '2018-05-13 11:00:00', 8, 640.00, 20.00, 128.00, 768.00),
       (1, '2018-05-05 08:00:00', 1, '2018-05-05 08:00:00', '2018-05-13 11:00:00', 8, 640.00, 20.00, 128.00, 768.00),
       (1, '2018-05-05 08:00:00', 1, '2018-05-05 08:00:00', '2018-05-13 11:00:00', 8, 640.00, 20.00, 128.00, 768.00);

INSERT INTO occupancies (employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge)
VALUES (1, '2018-05-05 08:00:00', 1, 2, 20.00, 24.20),
       (1, '2018-05-05 08:00:00', 1, 2, 20.00, 24.20),
       (1, '2018-05-05 08:00:00', 1, 2, 20.00, 24.20);


/*
 14. Create SoftUni Database
Now create bigger database called soft_uni. You will use database in the future tasks. It should hold information about
towns (id, name)
addresses (id, address_text, town_id)
departments (id, name)
employees (id, first_name, middle_name, last_name, job_title, department_id, hire_date, salary, address_id)
Id columns are auto incremented starting from 1 and increased by 1 (1, 2, 3, 4…). Make sure you use appropriate data
types for each column. Add primary and foreign keys as constraints for each table. Use only SQL queries. Consider which
fields are always required and which are optional. Submit your CREATE TABLE  statements as Run queries & check DB.
 */

CREATE DATABASE soft_uni;
USE soft_uni;

CREATE TABLE towns
(
    id   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE addresses
(
    id           INT          NOT NULL PRIMARY KEY AUTO_INCREMENT,
    address_text VARCHAR(200) NOT NULL,
    town_id      INT          NOT NULL,
    CONSTRAINT fk_addresses_town FOREIGN KEY (town_id) REFERENCES towns (id)
);

CREATE TABLE departments
(
    id   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employees
(
    id            INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    first_name    VARCHAR(20) NOT NULL,
    middle_name   VARCHAR(20) NOT NULL,
    last_name     VARCHAR(20) NOT NULL,
    job_title     VARCHAR(50) NOT NULL,
    department_id INT         NOT NULL,
    CONSTRAINT fk_employees_departments FOREIGN KEY (department_id) REFERENCES departments (id),
    hire_date     DATE        NOT NULL,
    salary        DECIMAL     NOT NULL,
    address_id    INT         NOT NULL,
    CONSTRAINT fk_employees_addresses FOREIGN KEY (address_id) REFERENCES addresses (id)
);

/*
 15. Basic Insert
 Use the SoftUni database and insert some data using SQL queries.
towns: Sofia, Plovdiv, Varna, Burgas
departments: Engineering, Sales, Marketing, Software Development, Quality Assurance
employees:
name	                    job_title	            department	            hire_date	        salary
Ivan Ivanov Ivanov	        .NET Developer	        Software Development	01/02/2013	        3500.00
Petar Petrov Petrov	        Senior Engineer	        Engineering	            02/03/2004	        4000.00
Maria Petrova Ivanova	    Intern	                Quality Assurance	    28/08/2016	        525.25
Georgi Terziev Ivanov	    CEO	                    Sales	                09/12/2007	        3000.00
Peter Pan Pan	            Intern	                Marketing	            28/08/2016	        599.88
 */

INSERT INTO towns (name)
VALUES ('Sofia'),
       ('Plovdiv'),
       ('Varna'),
       ('Burgas');

INSERT INTO departments(name)
VALUES ('Engineering'),
       ('Sales'),
       ('Marketing'),
       ('Software Development'),
       ('Quality Assurance');

INSERT INTO employees(first_name, middle_name, last_name, job_title, department_id, hire_date, salary)
VALUES ('Ivan', 'Ivanov', 'Ivanov', '.NET Developer', 4, '2013-02-01', 3500.00),
       ('Petar', 'Petrov', 'Petrov', 'Senior Engineer', 1, '2004-03-02', 4000.00),
       ('Maria', 'Petrova', 'Ivanova', 'Intern', 5, '2016-08-28', 525.25),
       ('Georgi', 'Terziev', 'Ivanov', 'CEO', 2, '2007-12-09', 3000.00),
       ('Peter', 'Pan', 'Pan', 'Intern', 3, '2016-08-28', 599.88);

/*
 16. Basic Select All Fields
 Use the soft_uni database and first select all records from the towns, then from departments and finally from employees
 table. Use SQL queries and submit them to Judge at once. Submit your query statements as Prepare DB & Run queries.
 */

SELECT *
FROM towns;
SELECT *
FROM departments;
SELECT *
FROM employees;

/*
 17. Basic Select All Fields and Order Them
 Modify queries from previous problem by sorting:
towns - alphabetically by name
departments - alphabetically by name
employees - descending by salary
Submit your query statements as Prepare DB & Run queries.
 */

SELECT *
FROM towns
ORDER BY name;
SELECT *
FROM departments
ORDER BY name;
SELECT *
FROM employees
ORDER BY salary DESC;

/*
 18. Basic Select Some Fields
 Modify queries from previous problem to show only some of the columns. For table:
towns – name
departments – name
employees – first_name, last_name, job_title, salary
Keep the ordering from the previous problem. Submit your query statements as Prepare DB & Run queries.
 */

SELECT name
FROM towns
ORDER BY name;
SELECT name
FROM departments
ORDER BY name;
SELECT first_name, last_name, job_title, salary
FROM employees
ORDER BY salary DESC;

/*
 19. Increase Employees Salary
 Use softuni database and increase the salary of all employees by 10%. Select only salary column from the employees
 table. Submit your query statements as Prepare DB & Run queries.
 */

UPDATE employees set salary = salary * 1.1;
SELECT salary FROM employees;

/*
 20. Decrease Tax Rate
 Use hotel database and decrease tax rate by 3% to all payments. Select only tax_rate column from the payments table.
 Submit your query statements as Prepare DB & Run queries.
 */

USE hotel;
UPDATE payments set tax_rate = tax_rate * 0.97;
SELECT tax_rate FROM payments;

/*
 21. Delete all records
 Use Hotel database and delete all records from the occupancies table. Use SQL query. Submit your query statements as
 Run skeleton, run queries & check DB.
 */

USE hotel;
TRUNCATE TABLE occupancies;
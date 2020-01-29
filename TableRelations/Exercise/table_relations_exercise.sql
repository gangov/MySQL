/*
 Exercises: Table Relations
This document defines the exercise assignments for the MySQL course @ Software University.
 */

CREATE DATABASE table_relations;

USE table_relations;

/*
 1. One-To-One Relationship

Create two tables as follows. Use appropriate data types.

                            persons
    person_id	first_name	salary	    passport_id
    1  	        Roberto     43300.00	102
    2	        Tom	        56100.00	103
    3	        Yana	    60200.00	101

                            passports
    passport_id	passport_number
    101	        N34FG21B
    102	        K65LO4R7
    103	        ZE657QP2

Insert the data from the example above.
Alter table persons and make person_id a primary key.
Create a foreign key between persons and passports by using the passport_id column.
Think about which passport field should be UNIQUE.
Submit your queries by using “MySQL run queries & check DB” strategy.
 */

CREATE TABLE persons
(
    person_id   INT,
    first_name  VARCHAR(50)   NOT NULL,
    salary      DECIMAL(7, 2) NOT NULL,
    passport_id INT UNIQUE    NOT NULL
);

CREATE TABLE passports
(
    passport_id     INT,
    passport_number VARCHAR(12) NOT NULL UNIQUE
);

ALTER TABLE persons
    CHANGE person_id person_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE passports
    CHANGE passport_id passport_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE persons
    ADD FOREIGN KEY fk_persons_passports (passport_id) REFERENCES passports (passport_id);


INSERT INTO passports(passport_id, passport_number)
VALUES (101, 'N34FG21B'),
       (102, 'K65LO4R7'),
       (103, 'ZE657QP2');

INSERT INTO persons(person_id, first_name, salary, passport_id)
VALUES (1, 'Roberto', 43300.00, 102),
       (2, 'Tom', 56100.00, 103),
       (3, 'Yana', 60200.00, 101);

/*
 2. One-To-Many Relationship

Create two tables as follows. Use appropriate data types.

                        manufacturers
    manufacturer_id	    name	established_on
    1  	                BMW     01/03/1916
    2	                Tesla	01/01/2003
    3	                Lada	01/05/1966


                        models
    model_id	name	    manufacturer_id
    101	        X1	        1
    102	        i6	        1
    103	        Model S	    2
    104	        Model X	    2
    105	        Model 3	    2
    106	        Nova	    3

Insert the data from the example above.
Add primary and foreign keys.
Submit your queries by using “MySQL run queries & check DB” strategy.
 */

CREATE TABLE manufacturers
(
    manufacturer_id INT         NOT NULL UNIQUE,
    name            VARCHAR(50) NOT NULL,
    established_on  DATE
);

CREATE TABLE models
(
    model_id        INT          NOT NULL UNIQUE,
    name            VARCHAR(100) NOT NULL,
    manufacturer_id INT          NOT NULL
);

ALTER TABLE manufacturers
    CHANGE manufacturer_id manufacturer_id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE models
    CHANGE model_id model_id INT NOT NULL UNIQUE PRIMARY KEY AUTO_INCREMENT;

ALTER TABLE models
    ADD CONSTRAINT fk_models_manufacturers FOREIGN KEY (manufacturer_id) REFERENCES manufacturers (manufacturer_id);

INSERT INTO manufacturers(manufacturer_id, name, established_on)
VALUES (1, 'BMW', '1916-03-01'),
       (2, 'Tesla', '2003-01-01'),
       (3, 'Lada', '1966-05-01');

INSERT INTO models(model_id, name, manufacturer_id)
VALUES (101, 'X1', 1),
       (102, 'i6', 1),
       (103, 'Model S', 2),
       (104, 'Model X', 2),
       (105, 'Model 3', 2),
       (106, 'Nova', 3);

/*
 3. Many-To-Many Relationship
Create three tables as follows. Use appropriate data types.

         exams
    exam_id	    name
    101	        Spring MVC
    102	        Neo4j
    103	        Oracle 11g

        students
    student_id	name
    1  	        Mila
    2	        Toni
    3	        Ron

        students_exams
    student_id	exam_id
    1	        101
    1	        102
    2	        101
    3	        103
    2	        102
    2	        103

Insert the data from the example above.
Add primary and foreign keys.
Have in mind that the table student_exams should have a
composite primary key.
Submit your queries by using “MySQL run queries & check DB” strategy.
 */

CREATE TABLE exams
(
    exam_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(50) NOT NULL
);

CREATE TABLE students
(
    student_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(50) NOT NULL
);

CREATE TABLE students_exams
(
    student_id INT NOT NULL,
    exam_id    INT NOT NULL,
    CONSTRAINT fk_studentid_students FOREIGN KEY (student_id) REFERENCES students (student_id),
    CONSTRAINT fk_examid_exams FOREIGN KEY (exam_id) REFERENCES exams (exam_id)
);

INSERT INTO exams(exam_id, name)
VALUES (101, 'Spring MVC'),
       (102, 'Neo4j'),
       (103, 'Oracle 11g');

INSERT INTO students(student_id, name)
VALUES (1, 'Mila'),
       (2, 'Toni'),
       (3, 'Ron');

INSERT INTO students_exams(student_id, exam_id)
VALUES (1, 101),
       (1, 102),
       (2, 101),
       (3, 103),
       (2, 102),
       (2, 103);

/*
 4. Self-Referencing

Create a single table as follows. Use appropriate data types.

            teachers
    teacher_id	    name	    manager_id
    101	            John
    102	            Maya	    106
    103	            Silvia	    106
    104	            Ted	        105
    105	            Mark	    101
    106	            Greta	    101

Insert the data from the example above.
Add primary and foreign keys.
The foreign key should be between manager_id and teacher_id.
Submit your queries by using “	MySQL run queries & check DB” strategy.
 */

CREATE TABLE teachers
(
    teacher_id INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(50) NOT NULL,
    manager_id INT         NULL
);

INSERT INTO teachers(teacher_id, name, manager_id)
VALUES (101, 'John', NULL),
       (102, 'Maya', 106),
       (103, 'Silvia', 106),
       (104, 'Ted', 105),
       (105, 'Mark', 101),
       (106, 'Greta', 101);

/*
 5. Online Store Database
Create a new database and design the following structure:
Submit your queries by using “MySQL run queries & check DB” strategy.
 */

CREATE DATABASE online_store;
USE online_store;

CREATE TABLE items
(
    item_id      INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(50),
    item_type_id INT(11)
);

CREATE TABLE item_types
(
    item_type_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name         VARCHAR(50)

);

CREATE TABLE order_items
(
    order_id INT(11) NOT NULL,
    item_id  INT(11) NOT NULL,
    PRIMARY KEY (order_id, item_id)
);

CREATE TABLE orders
(
    order_id    INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    customer_id INT(11)
);

CREATE TABLE customers
(
    customer_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50),
    birthday    DATE,
    city_id     INT(11)
);

CREATE TABLE cities
(
    city_id INT(11) NOT NULL PRIMARY KEY,
    name    VARCHAR(50)
);

ALTER TABLE items
    ADD CONSTRAINT fk_items_itemtypes FOREIGN KEY (item_type_id) REFERENCES item_types (item_type_id);

ALTER TABLE order_items
    ADD CONSTRAINT fk_orderitems_items FOREIGN KEY (item_id) REFERENCES items (item_id);

ALTER TABLE order_items
    ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_id) REFERENCES orders (order_id);

ALTER TABLE orders
    ADD CONSTRAINT fk_orders_customers FOREIGN KEY (customer_id) REFERENCES customers (customer_id);

ALTER TABLE customers
    ADD CONSTRAINT fk_customers_cities FOREIGN KEY (city_id) REFERENCES cities (city_id);

/*
 6. University Database
Create a new database and design the following structure:

Submit your queries by using “MySQL run queries & check DB” strategy.
 */

CREATE DATABASE university;
USE university;

CREATE TABLE students
(
    student_id     INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    student_number VARCHAR(12) UNIQUE,
    student_name   VARCHAR(50),
    major_id       INT(11)
);

CREATE TABLE majors
(
    major_id INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(50)
);

CREATE TABLE payments
(
    payment_id     INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    payment_date   DATE,
    payment_amount DECIMAL(8, 2),
    student_id     INT(11)
);

CREATE TABLE subjects
(
    subject_id   INT(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
    subject_name VARCHAR(50)
);

CREATE TABLE agenda
(
    student_id INT(11) NOT NULL,
    subject_id INT(11) NOT NULL,
    PRIMARY KEY (student_id, subject_id)
);

ALTER TABLE agenda
    ADD CONSTRAINT fk_agenda_subjects FOREIGN KEY (subject_id) REFERENCES subjects (subject_id),
    ADD CONSTRAINT fk_agenda_students FOREIGN KEY (student_id) REFERENCES students (student_id);

ALTER TABLE students
    ADD CONSTRAINT fk_students_majors FOREIGN KEY (major_id) REFERENCES majors (major_id);

ALTER TABLE payments
    ADD CONSTRAINT fk_payments_students FOREIGN KEY (student_id) REFERENCES students (student_id);

/*
 7. SoftUni Design
Create an E/R Diagram of the SoftUni Database. There are some special relations you should check out: employees are
 self-referenced (manager_id) and departments have One-to-One with the employees (manager_id) while the employees have
 One-to-Many (department_id). You might find it interesting how it looks on а diagram. ☺
 */

/*
  8. Geography Design

Create an E/R Diagram of the Geography Database.
 */

/*
 9. Peaks in Rila

Display all peaks for "Rila" mountain_range. Include:
mountain_range
peak_name
peak_elevation
Peaks should be sorted by peak_elevation descending.
Example:

    mountain_range	peak_name	peak_elevation
    Rila	        Musala	    2925
    …	            …	        …

  Submit your queries by using “MySQL prepare DB & run queries” strategy.
 */

USE geography;

SELECT mountain_range, peak_name, elevation AS 'peak_elevation'
FROM mountains
JOIN peaks
ON mountains.id = peaks.mountain_id
WHERE mountain_id = 17
ORDER BY peak_elevation DESC;
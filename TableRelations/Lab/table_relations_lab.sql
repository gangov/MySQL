/*
 Lab: Table Relations
This document defines the lab assignments for MySQL Course at Software University.
Get familiar with the camp database. You will use it in the following exercises.
 */

USE camp;

/*
 1. Mountains and Peaks
Write a query to create two tables – mountains and peaks and link their fields properly. Tables should have:
Mountains:
id
name
Peaks:
id
name
mountain_id
Check your solutions using the “Run Queries and Check DB” strategy.
 */

CREATE TABLE mountains
(
    id   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks
(
    id          INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50) NOT NULL,
    mountain_id INT         NOT NULL,
    CONSTRAINT fk_mountain_peak FOREIGN KEY (mountain_id) REFERENCES mountains (id)
);

/*
 2. Trip Organization
Write a query to retrieve information about SoftUni camp’s transportation organization. Get information about the
 drivers (name and id) and their vehicle type. Submit your queries using the “MySQL prepare DB and Run Queries” strategy.
Example:

    driver_id	vehicle_type	driver_name
    1	        bus	            Simo Sheytanov
    1	        van	            Simo Sheytanov
    2	        van	            Roli Dimitrova
    …	        …	            …
 */

SELECT driver_id, vehicle_type, CONCAT(first_name, ' ', last_name) AS 'driver_name'
FROM vehicles,
     campers
WHERE driver_id = campers.id;

SELECT driver_id, vehicle_type, CONCAT(first_name, ' ', last_name) AS 'driver_name'
FROM vehicles
         JOIN campers ON driver_id = campers.id;

/*
 3. SoftUni Hiking
Get information about the hiking routes – starting point and ending point, and their leaders – name and id. Submit your
 queries using the “MySQL prepare DB and Run Queries” strategy.
Example:

    route_starting_point	route_ending_point	leader_id	leader_name
    Hotel Malyovitsa	    Malyovitsa Peak	    3	        RoYaL Yonkov
    Hotel Malyovitsa	    Malyovitsa Hut	    3	        RoYaL Yonkov
    Ribni Ezera             Hut	Rila Monastery	3	        RoYaL Yonkov
    Borovets	            Musala Peak	        4	        Ivan Ivanov

 */

SELECT starting_point, end_point, leader_id, CONCAT(first_name, ' ', last_name)
FROM routes
         JOIN campers ON leader_id = campers.id;

/*
 4. Delete Mountains
Drop tables from the task 1.
Write a query to create a one-to-many relationship between a table, holding information about peaks (id, name) and
 other - about mountains (id, name, mountain_id), so that when an mountains gets removed from the database, all of his
 peaks are deleted too.
Submit your queries using the “MySQL run queries & check DB” strategy.
 */

CREATE TABLE mountains
(
    id   INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE peaks
(
    id          INT         NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(50) NOT NULL,
    mountain_id INT         NOT NULL,
    CONSTRAINT fk_mountain_peak FOREIGN KEY (mountain_id) REFERENCES mountains (id) ON DELETE CASCADE
);

/*
 5.  Project Management DB*
Write a query to create a project management db according to the following E/R Diagram:

 */

CREATE TABLE projects
(
    id              INT(11) PRIMARY KEY AUTO_INCREMENT,
    client_id       INT(11),
    project_lead_id INT(11)
);

CREATE TABLE clients
(
    id          INT(11) PRIMARY KEY AUTO_INCREMENT,
    client_name VARCHAR(100),
    project_id  INT(11)
);

CREATE TABLE employees
(
    id         INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30),
    last_name  VARCHAR(30),
    project_id INT(11)
);

ALTER TABLE projects
    ADD CONSTRAINT fk_project_client
        FOREIGN KEY (client_id) REFERENCES clients (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE projects
    ADD CONSTRAINT fk_project_lead
        FOREIGN KEY (project_lead_id) REFERENCES employees (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE clients
    ADD CONSTRAINT fk_client_project FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE employees
    ADD CONSTRAINT fk_employee_project FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE ON UPDATE CASCADE;

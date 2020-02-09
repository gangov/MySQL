/*
 MySQL Exam Football Scout Database
In a parallel reality, you have been selected to help the most famous football coaches to select the best players for
their teams. Thanks to your knowledge of databases, you have been selected to create the structure of a brand new d
atabase, tailored to the requirements of your employers, and to fill it in with a huge amount of data collected for you
by the most experienced football scouts. Once the base is ready, you will be able to respond without any problems to
any information request from the coaches on the basis of certain criteria. As with other databases, it is most
important first to become familiar with the structure you need to build, and then fill it with given data.
 */
CREATE DATABASE fsd;
USE fsd;
/*
Section 0: Database Overview
You have been given an Entity / Relationship Diagram of the Football Scout Database:

The Football Scout Database (FSD) needs to hold information about players, skill, coaches, teams, stadiums, towns,
countries.
Your task is to create a database called fsd (Football Scout Database). Then you will have to create several tables.
players – contains information about the players.
Each player has a skills data, team and coach.
coaches – contains information about the coaches.
One coach can train many players
players_coaches – a many to many mapping table between the players and the coaches.
Have composite primary key from player_id and coach_id

skill data – contains information about the current player skills.
teams – contains information about the teams.
Each team has a stadium.
stadiums – contains information about the stadiums.
Each stadium has a city.
towns - contains information about the towns.
Each town has a country
countries – contains information about current country.
 */


CREATE TABLE countries
(
    id   INT(11) PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL
);

CREATE TABLE towns
(
    id         INT(11) PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(45) NOT NULL,
    country_id INT(11)     NOT NULL,
    CONSTRAINT towns_to_country_id FOREIGN KEY (country_id) REFERENCES countries (id)
);

CREATE TABLE stadiums
(
    id       INT(11) PRIMARY KEY AUTO_INCREMENT,
    name     VARCHAR(45) NOT NULL,
    capacity INT(11)     NOT NULL,
    town_id  INT(11)     NOT NULL,
    CONSTRAINT stadium_to_town_id FOREIGN KEY (town_id) REFERENCES towns (id)
);

CREATE TABLE teams
(
    id          INT(11) PRIMARY KEY AUTO_INCREMENT,
    name        VARCHAR(45)          NOT NULL,
    established DATE                 NOT NULL,
    fan_base    BIGINT(20) DEFAULT 0 NOT NULL,
    stadium_id  INT(11)              NOT NULL,
    CONSTRAINT team_to_stadium_id FOREIGN KEY (stadium_id) REFERENCES stadiums (id)
);

CREATE TABLE skills_data
(
    id        INT(11) PRIMARY KEY AUTO_INCREMENT,
    dribbling INT(11) DEFAULT 0,
    pace      INT(11) DEFAULT 0,
    passing   INT(11) DEFAULT 0,
    shooting  INT(11) DEFAULT 0,
    speed     INT(11) DEFAULT 0,
    strength  INT(11) DEFAULT 0
);

CREATE TABLE coaches
(
    id          INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name  VARCHAR(10)              NOT NULL,
    last_name   VARCHAR(20)              NOT NULL,
    salary      DECIMAL(10, 2) DEFAULT 0 NOT NULL,
    coach_level INT(11)        DEFAULT 0 NOT NULL
);

CREATE TABLE players
(
    id             INT(11) PRIMARY KEY AUTO_INCREMENT,
    first_name     VARCHAR(10)              NOT NULL,
    last_name      VARCHAR(20)              NOT NULL,
    age            INT(11)        DEFAULT 0 NOT NULL,
    position       CHAR(1)                  NOT NULL,
    salary         DECIMAL(10, 2) DEFAULT 0 NOT NULL,
    hire_date      DATETIME,
    skills_data_id INT(11)                  NOT NULL,
    team_id        INT(11),
    CONSTRAINT skills_data_id_to_skill_datas FOREIGN KEY (skills_data_id) REFERENCES skills_data (id),
    CONSTRAINT team_id_to_teams FOREIGN KEY (team_id) REFERENCES teams (id)
);

CREATE TABLE players_coaches
(
    player_id INT(11),
    coach_id  INT(11),
    CONSTRAINT fk_played_id_to_players FOREIGN KEY (player_id) REFERENCES players (id),
    CONSTRAINT coach_id_to_coaches FOREIGN KEY (coach_id) REFERENCES coaches (id)
);

/*
 Section 2: Data Manipulation Language (DML) – 30 pts
Here we need to do several manipulations in the database, like changing data, adding data etc.
 */


/*

2. Insert
You will have to insert records of data into the coaches table, based on the players table.
For players with age over 45 (inclusive), insert data in the coaches table with the following values:
first_name – set it to first name of the player
last_name – set it to last name of the player.
salary – set it to double as player’s salary.
coach_level – set it to be equals to count of the characters in player’s first_name.
 */

INSERT INTO coaches (first_name, last_name, salary, coach_level)
SELECT players.first_name, players.last_name, players.salary * 2, LENGTH(players.first_name)
FROM players
WHERE players.age >= 45;


/*
3. Update
Update all coaches, who train one or more players and their first_name starts with ‘A’. Increase their level with 1.

 */

# CREATE VIEW find_target_coaches AS


UPDATE coaches
SET coach_level = coach_level + 1
WHERE LEFT(first_name, 1) = 'A'
  AND id IN (
    SELECT coach_id
    FROM players_coaches
);

/*
4. Delete
As you remember at the beginning of our work, we promoted several football players to coaches. Now you need to remove
all of them from the table of players in order for our database to be updated accordingly.
Delete all players from table players, which are already added in table coaches.
 */

DELETE
FROM players
WHERE age >= 45 ;

/*
 Section 3: Querying – 50 pts
And now we need to do some data extraction. Note that the example results from this section use a fresh database. It is
highly recommended that you clear the database that has been manipulated by the previous problems from the DML section
and insert again the dataset you’ve been given, to ensure maximum consistency with the examples given in this section.
 */

/*
5. Players
Extract from the Football Scout Database (fsd) database, info about all of the players.
Order the results by players - salary descending.
Required Columns
first_name
age
salary

    Example
    first_name		age	    salary
    Renault	        24	    984113.71
    Akim	        31	    982188.88
    Mollie	        24	    966079.07
    …	            …	    …
 */

SELECT first_name, age, salary
FROM players
ORDER BY salary DESC;

/*
 6. Young offense players without contract
One of the coaches wants to know more about all the young players (under age of 23) who can strengthen his team in the
offensive (played on position ‘A’). As he is not paying a transfer amount, he is looking only for those who have not
signed a contract so far (haven’t hire_date) and have strength of more than 50. Order the results ascending by salary,
then by age.

Required Columns
id (player)
full_name
age
position
hire_date

    Example:
    id	    full_name	        age	    position	hire_date
    40	    Carlen Hadny	    18	    A	        NULL
    23	    Kalvin Bewley	    19	    A	        NULL
    ..	    ..	                ..	    ..	        ..
 */


SELECT players.id, CONCAT(first_name, ' ', last_name) AS full_name, age, position, hire_date
FROM players
         JOIN skills_data AS sd ON players.skills_data_id = sd.id
WHERE age < 23
  AND position = 'A'
  AND hire_date IS NULL
  AND sd.strength > 50
ORDER BY salary ASC, age ASC;

/*
 7. Detail info for all teams
Extract from the database all of the teams and the count of the players that they have.
Order the results descending by count of players, then by fan_base descending.
Required Columns
team_name
established
fan_base
count_of_players
Example

    team_name	established	fan_base	            players_count
    Ailane	    1963-08-20	6711237100133852778 	10
    Ntags	    1981-06-05	3508984270641351110	    9
    Skyble	    1953-11-14	5381600486852672412	    8
    …	        …	        …	                    …
    Miboo	    1971-08-02	30087062078800256	    0
 */

SELECT teams.name AS 'team_name', established, fan_base, COUNT(p.id) AS 'players_count'
FROM teams
         LEFT JOIN players p ON teams.id = p.team_id
GROUP BY teams.name, established, fan_base
ORDER BY players_count DESC, fan_base DESC;

/*
 8. The fastest player by towns
Extract from the database, the fastest player (having max speed), in terms of towns where their team played.
Order players by speed descending, then by town name.
Skip players that played in team ‘Devify’

Required Columns
max_speed
town_name

Example:
    max_speed	town_name
    97	        Smolensk
    92	        Bromma
    92	        Lühua
    …	        …
    NULL	    Zavolzh’ye
 */

SELECT MAX(sd.speed) AS max_speed, t.name AS town_name
FROM towns AS t
         LEFT JOIN stadiums AS s ON s.town_id = t.id
         LEFT JOIN teams AS t2 ON t2.stadium_id = s.id
         LEFT JOIN players AS p ON p.team_id = t2.id
         LEFT JOIN skills_data AS sd ON p.skills_data_id = sd.id
WHERE t2.name != 'Devify'
GROUP BY town_name
ORDER BY max_speed DESC, town_name ASC;

/*
 9. Total salaries and players by country

And like everything else in this world, everything is ultimately about finances. Now you need to extract detailed
information on the amount of all salaries given to football players by the criteria of the country in which they played.
If there are no players in a country, display NULL.  Order the results by total count of players in descending order,
then by country name alphabetically.


Required Columns
name (country)
total_sum_of_salaries
total_count_of_players

Example:
name	        total_count_of_players	total_sum_of_salaries
Sweden	        28	                    14968947.79
Brazil	        18	                    8352732.65
China	        13	                    7042890.51
Russia	        7	                    2230759.71
…	            …	                    …
Thailand        0	                    NULL
United States   0	                    NULL
 */

SELECT c.name, COUNT(p.id) AS total_count_of_players, SUM(p.salary) AS total_sum_of_salaries
FROM countries AS c
         LEFT JOIN towns AS t ON t.country_id = c.id
         LEFT JOIN stadiums AS s ON s.town_id = t.id
         LEFT JOIN teams AS t2 ON t2.stadium_id = s.id
         LEFT JOIN players AS p ON p.team_id = t2.id
GROUP BY c.name
ORDER BY total_count_of_players DESC, c.name ASC;

/*
Section 4: Programmability – 30 pts
The time has come for you to prove that you can be a little more dynamic on the database. So, you will have to write
several procedures.
 */

/*
 10. Find all players that play on stadium
Create a user defined function with the name udf_stadium_players_count (stadium_name VARCHAR(30)) that receives a
stadium’s name and returns the number of players that play home matches there.

Example:
    Query
    SELECT udf_stadium_players_count ('Jaxworks') as `count`;
    count
    14

    Query
    SELECT udf_stadium_players_count ('Linklinks') as `count`;
    count
    0
 */

DELIMITER $$
CREATE FUNCTION udf_stadium_players_count(stadium_name VARCHAR(30))
    RETURNS INT
BEGIN
    DECLARE total INT;
    SET total := (SELECT COUNT(p.id)
                  FROM players AS p
                           JOIN teams AS t ON p.team_id = t.id
                           JOIN stadiums AS s ON s.id = t.stadium_id
                  WHERE s.name = stadium_name
                  LIMIT 1);
    RETURN total;
END;
$$

/*
 11. Find good playmaker by teams
Create a stored procedure udp_find_playmaker which accepts the following parameters:
min_dribble_points
team_name (with max length 45)
And extracts data about the players with the given skill stats (more than min_dribble_points), played for given team
(team_name) and have more than average speed for all players. Order players by speed descending. Select only the best
one.
Show all needed info for this player: full_name, age, salary, dribbling, speed, team name.
CALL udp_find_playmaker (20, ‘Skyble’);

Result:
    full_name	    age	    salary	        dribbling	speed	team_name
    Royal Deakes	19	    49162.77	    33	        92	    Skyble
 */


DELIMITER $$
CREATE PROCEDURE udp_find_playmaker(min_dribble_points INT, team_name VARCHAR(45))
BEGIN
    SELECT CONCAT(p.first_name, ' ', last_name) AS full_name,
           p.age,
           p.salary,
           sd.dribbling,
           sd.speed,
           t.name                               AS team_name
    FROM players AS p
             LEFT JOIN skills_data AS sd ON p.skills_data_id = sd.id
             LEFT JOIN teams AS t ON t.id = p.team_id
    WHERE sd.dribbling >= min_dribble_points
      AND t.name = team_name
    ORDER BY sd.speed DESC
    LIMIT 1;
END;
$$
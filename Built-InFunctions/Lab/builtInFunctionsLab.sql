-- Lab: Built-in Functions
/*
This document defines the lab exercise assignments for the MySQL course @ Software University.
Download from the course instance and get familiar with the book_library database. You will use it in the following exercises.
 */

USE book_library;

/*
 1. Find Book Titles
Write a SQL query to find books which titles start with “The”. Order the result by id. Submit your query
 statements as Prepare DB & run queries.
Example:
    title
    The Mysterious Affair at Styles
    The Big Four
    The Murder at the Vicarage
    The Mystery of the Blue Train
    The Ring
    …
 */

SELECT title
FROM books
WHERE title LIKE 'The %'
ORDER BY id;

/*
 2. Replace Titles
Write a SQL query to find books which titles start with “The” and replace the substring with 3 asterisks. Retrieve data
 about the updated titles. Order the result by id. Submit your query statements as Prepare DB & run queries.
Example :

    title
    *** Mysterious Affair at Styles
    *** Big Four
    *** Murder at the Vicarage
    *** Mystery of the Blue Train
    *** Ring
    *** Alchemist
    *** Fifth Mountain
    *** Zahir
    *** Dead Zone
    *** Hobbit
    *** Adventures of Tom Bombadil
 */

UPDATE books
SET title = REPLACE(title, 'The', '***');

SELECT title
FROM books
WHERE title LIKE '***%'
ORDER BY id;

/*
 3. Sum Cost of All Books
 Write a SQL query to sum prices of all books. Format the output to 2 digits after decimal point. Submit your query
 statements as Prepare DB & run queries.
 */

SELECT ROUND(SUM(cost), 2) AS 'TOTAL'
FROM books;


/*
 4. Days Lived
Write a SQL query to calculate the days that the authors have lived. NULL values mean that the author is still alive.
 Submit your query statements as Prepare DB & run queries.
Example:
    Full Name	                Days Lived
    Agatha Christie	            31164
    William Shakespeare	        18990
    Danielle Schuelein-Steel	(NULL)
    Joanne Rowling	            (NULL)
    Lev Tolstoy	                30021
    Paulo Souza	                (NULL)
    Stephen King	            (NULL)
    John Tolkien	            29827
    Erika Mitchell	            (NULL)
 */

SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', DATEDIFF(died, born) AS 'Days Lived'
FROM authors;

/*
 5. Harry Potter Books
Write a SQL query to retrieve titles of all the Harry Potter books. Order the information by id.
 Submit your query statements as Prepare DB & run queries.
Example:
    title
    Harry Potter and the Philosopher's Stone
    Harry Potter and the Chamber of Secrets
    Harry Potter and the Prisoner of Azkaban
    …
 */

SELECT title
FROM books
WHERE title LIKE 'Harry Potter %'
ORDER BY id;

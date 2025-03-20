--1.Question 1:
/*Task: Querry a list of all the different replacement costs of the films.
Question: What is the lowest replacement cost? */
SELECT DISTINCT replacement_cost 
FROM film
ORDER BY replacement_cost ASC
--Answer: Lowest replacement cost = 9.99

--2. Question 2:
/*Task: Write a query that provides an overview of the number of movies with replacement costs in the following cost ranges
low: 9.99 - 19.99
medium: 20.00 - 24.99
high: 25.00 - 29.99
Question: How many movies have replacement costs in the “low” group? */ 
SELECT 
CASE 
	WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
	WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'medium'
	WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'high'
END AS cost_range,
COUNT(*) AS movie_count
FROM film
GROUP BY cost_range
ORDER BY cost_range;
--Answer: 514

--3.Question 3:
/*Task: Generate a list of film_titles including title, length and category_name sorted by length in descending order. 
Filter the results to only films in the 'Drama' or 'Sports' category.
Question: What genre is the longest film and how long is it? */ 
SELECT a.title, a.length, c.name 
FROM film as a INNER JOIN film_category AS b on a.film_id = b.film_id
INNER JOIN category AS c on b.category_id = c.category_id
WHERE c.name = 'Drama' OR c.name = 'Sports'
ORDER BY a.length DESC
--Answer: Sports : 184

--4. Question 4: 
/*Task: Give an overview of the number of films (title) in each category.
Question: Which category genre is the most popular among films? */
SELECT c.name,
COUNT (a.title)
FROM film as a INNER JOIN film_category AS b on a.film_id = b.film_id
INNER JOIN category AS c on b.category_id = c.category_id
GROUP BY c.name
ORDER BY COUNT (DISTINCT a.title) DESC
--Answer: Sports - 74 titles

--5. Question 5: 
/*Task: Give an overview of the actors' names, first name and the number of films they have appeared in.
Question: Which actor has appeared in the most films? */
SELECT a.first_name, a.last_name,
COUNT (DISTINCT b.film_id) AS movies_count
FROM actor AS a INNER JOIN film_actor AS b
ON a.actor_id = b.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY COUNT (DISTINCT b.film_id) DESC
--Answer: Susan Davis - 54 films 

--6. Question 6:
/* Task: Find addresses that are not associated with any customer.
Question: How many such addresses are there? */ 
SELECT 
COUNT(*)
FROM address AS a LEFT JOIN customer AS b 
ON a.address_id = b.address_id
WHERE b.address_id IS NULL
--Answer: 4 

--7. Question 7:
/* Task: Task: Querry list of cities and corresponding revenue per city
Question: Which city has the highest revenue? */
SELECT a.city, 
SUM(d.amount) AS revenue
FROM city AS a INNER JOIN address as b ON a.city_id = b.city_id
INNER JOIN customer AS c on b.address_id = c.address_id 
INNER JOIN payment AS d on c.customer_id = d.customer_id
GROUP BY a.city 
ORDER BY SUM(d.amount) DESC
--Answer: Cape Coral: 221.55

--8. Question  8:
/* Task: Create a list that returns 2 columns of data:
Column 1: city and country information (format: “city, country”)
Column 2: revenue corresponding to column 1
Question: Which country's city has the lowest revenue? */
SELECT 
CONCAT(a.city,',', ' ', e.country) AS infor,
SUM(d.amount) AS revenue
FROM city AS a INNER JOIN address as b ON a.city_id = b.city_id
INNER JOIN customer AS c ON b.address_id = c.address_id 
INNER JOIN payment AS d ON c.customer_id = d.customer_id
INNER JOIN country AS e ON a.country_id = e.country_id
GROUP BY a.city, e.country_id
ORDER BY SUM(d.amount) ASC
--Answer: "Tallahassee, United States" = 50.85




--1. hackerank-revising-the-select-query.
/*Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.*/
SELECT NAME FROM CITY
WHERE POPULATION > 120000
AND COUNTRYCODE = 'USA';

--2. hackerank-japanese-cities-attributes. 
/*Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.*/
SELECT * FROM CITY 
WHERE COUNTRYCODE = 'JPN';

--3.hackerank-weather-observation-station-1.
/*Query a list of CITY and STATE from the STATION table.*/
SELECT CITY, STATE 
FROM STATION;

--4.hackerank-weather-observation-station-6. 
/*Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.*/
SELECT DISTINCT CITY
FROM STATION
WHERE CITY LIKE 'A%' 
   OR CITY LIKE 'E%'
   OR CITY LIKE 'I%'
   OR CITY LIKE 'O%'
   OR CITY LIKE 'U%';

--5.hackerank-weather-observation-station-7. 
/*Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.*/
SELECT DISTINCT CITY FROM STATION
WHERE CITY LIKE '%a'
   OR CITY LIKE '%e'
   OR CITY LIKE '%i'
   OR CITY LIKE '%o'
   OR CITY LIKE '%u'; 

--6. hackerank-weather-observation-station-9. 
/*Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.*/
SELECT DISTINCT CITY FROM STATION
WHERE  CITY NOT LIKE 'A%'
   AND CITY NOT LIKE 'E%'
   AND CITY NOT LIKE 'I%'
   AND CITY NOT LIKE 'O%'
   AND CITY NOT LIKE 'U%'; 

--7. hackerank-name-of-employees. 
/*Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.*/
SELECT name FROM Employee
ORDER BY name ASC; 

--8. hackerank-salary-of-employees. 
/*Write a query that prints a list of employee names (i.e.: the name attribute) for employees in E
mployee having a salary greater than  per month who have been employees for less than  months. Sort your result by ascending employee_id.*/
SELECT name FROM Employee
WHERE salary > 2000
AND months < 10
ORDER BY employee_id ASC; 

--9. leetcode-recyclable-and-low-fat-products. 
/*+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |
+-------------+---------+
product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.*/
Write a solution to find the ids of products that are both low fat and recyclable.
SELECT product_id from Products
WHERE low_fats  =  'Y' 
AND recyclable  = 'Y';

--10.leetcode-find-customer-referee. 
/*+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.
 Find the names of the customer that are not referred by the customer with id = 2.
Return the result table in any order.*/
SELECT name FROM Customer
WHERE referee_id !=2
OR referee_id is NULL;

--11.leetcode-big-countries. 
/*+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
name is the primary key (column with unique values) for this table.
Each row of this table gives information about the name of a country, the continent to which it belongs, its area, the population, and its GDP value.
 A country is big if:
it has an area of at least three million (i.e., 3000000 km2), or
it has a population of at least twenty-five million (i.e., 25000000).
Write a solution to find the name, population, and area of the big countries.
Return the result table in any order.*/
SELECT name,population,area FROM World
WHERE area >= 3000000 
  OR population >= 25000000; 

--12.leetcode-article-views. 
/*+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |
+---------------+---------+
There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.
Write a solution to find all the authors that viewed at least one of their own articles.
Return the result table sorted by id in ascending order.*/
select distinct author_id as id from Views
where author_id = viewer_id
order by author_id asc; 

--13. datalemur-tesla-unfinished-part. 
/*Tesla is investigating production bottlenecks and they need your help to extract the relevant data. 
Write a query to determine which parts have begun the assembly process but are not yet finished.
Assumptions:
parts_assembly table contains all parts currently in production, each at varying stages of the assembly process.
An unfinished part is one that lacks a finish_date.
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| part          | string  |
| finish_date   | datetime|
| assembly_step	| int     | 
+---------------+---------+ */
SELECT part, assembly_step FROM parts_assembly
where finish_date is NULL and assembly_step	>= 1;

--14.datalemur-lyft-driver-wages. 
/*Find all Lyft drivers who earn either equal to or less than 30k USD or equal to or more than 70k USD.*/
select * from lyft_drivers
where yearly_salary =< 30000 or yearly_salary >= 70000;

--15.datalemur-find-the-advertising-channel.
/*Find the advertising channel where Uber spent more than 100k USD in 2019*/
select distinct * from uber_advertising
where money_spent > 100000 and year = 2019;

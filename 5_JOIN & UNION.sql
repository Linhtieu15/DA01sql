--1.hackerrank-average-population-of-each-continent
/*Problem statment:Given two tables, City and Country whose description are given below. 
Print the name of all continents (key: Country.Continent) along with the average City population rounded down to nearest integer.
City
+-------------+----------+
| Field       | Type     |
+-------------+----------+
| ID          | int(11)  |
| Name        | char(35) |
| CountryCode | char(3)  |
| District    | char(20) |
| Population  | int(11)  |
+-------------+----------+
Country
+----------------+-------------+
| Field          | Type        |
+----------------+-------------+
| Code           | char(3)     |
| Name           | char(52)    |
| Continent      | char(50)    |
| Region         | char(26)    |
| SurfaceArea    | float(10,2) |
| IndepYear      | smallint(6) |
| Population     | int(11)     |
| LifeExpectancy | float(3,1)  |
| GNP            | float(10,2) |
| GNPOld         | float(10,2) |
| LocalName      | char(45)    |
| GovernmentForm | char(45)    |
| HeadOfState    | char(60)    |
| Capital        | int(11)     |
| Code2          | char(2)     |
+----------------+-------------+
PS #1: City.CountryCode and Country.Code is same key. 
PS #2: Continent without cities should not be included in output. */
SELECT COUNTRY.Continent, 
ROUND((AVG(CITY.Population)),0) AS AVG_POPULATION
FROM COUNTRY INNER JOIN CITY ON COUNTRY.Code = CITY.CountryCode
GROUP BY COUNTRY.Continent
ORDER BY COUNTRY.Continent;

--2.datalemur-signup-confirmation-rate.
/*Problem statement: New TikTok users sign up with their emails. 
They confirmed their signup by replying to the text confirmation to activate their accounts. 
Users may receive multiple text messages for account confirmation until they have confirmed their new account.
A senior analyst is interested to know the activation rate of specified users in the emails table. 
Write a query to find the activation rate. Round the percentage to 2 decimal places.

Definitions:
emails table contain the information of user signup details.
texts table contains the users' activation information.

emails Table:
Column Name	Type
email_id	integer
user_id	integer
signup_date	datetime

texts Table:
Column Name	Type
text_id	integer
email_id	integer
signup_action	varchar

'Confirmed' in signup_action means the user has activated their account and successfully completed the signup process.*/
SELECT 
  ROUND(CAST(COUNT(t.email_id) AS DECIMAL) / COUNT(DISTINCT e.email_id), 2) 
  AS activation_rate
FROM emails AS e
LEFT JOIN texts AS t
ON e.email_id = t.email_id
AND t.signup_action = 'Confirmed';

--3. datalemur-time-spent-snaps.


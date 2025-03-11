--1.datalemur-laptop-mobile-viewership.
/*Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.
Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. 
Output the total viewership for laptops as laptop_reviews and the total viewership for mobile devices as mobile_views.
viewership Table
Column Name	  Type
user_id	      integer
device_type	  string ('laptop', 'tablet', 'phone')
view_time	    timestamp */
SELECT 
SUM(CASE
      WHEN device_type = 'laptop' THEN 1
      ELSE 0
    END) AS laptop_views,
SUM (CASE 
      WHEN device_type = 'tablet' THEN 1
      WHEN device_type = 'phone' THEN 1
      ELSE 0
    END) AS mobile_views
FROM viewership; 

--datalemur-triangle-judgement.
/* Table: Triangle
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.
Report for every three line segments whether they can form a triangle. */ 
SELECT 
    x, y, z,
    CASE 
        WHEN x + y > z AND y + z > x AND z + x > y THEN 'Yes'
        ELSE 'No'
    END AS triangle
FROM Triangle ;

--datalemur-uncategorized-calls-percentage.
/*Write a query to calculate the percentage of calls that cannot be categorised. 
Round your answer to 1 decimal place. For example, 45.0, 48.5, 57.7.
callers Table:
Column Name	Type
policy_holder_id	integer
case_id	varchar
call_category	varchar
call_date	timestamp
call_duration_secs	integer */
SELECT 
ROUND(CAST(SUM(
          case 
          when call_category is null or call_category = 'n/a' then 1 
          else 0 
          end) as decimal)/count(*)*100
  ,1)
       as uncategorised_call_pct
from callers; 

--datalemur-find-customer-referee.
/* Table: Customer
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
In SQL, id is the primary key column for this table.
Find the names of the customer that are not referred by the customer with id = 2. */
SELECT name 
FROM Customer
WHERE referee_id !=2 OR referee_id IS NULL;

--stratascratch the-number-of-survivors.
SELECT survived, 
       sum(case when pclass = 1 then 1 else 0 end) as first_class,
       sum(case when pclass = 2 then 1 else 0 end) as second_class,
       sum(case when pclass = 3 then 1 else 0 end) as third_class
FROM titanic 
GROUP BY survived; 

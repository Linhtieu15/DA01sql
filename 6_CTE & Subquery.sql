--1: datalemur-duplicate-job-listings.
/*Assume you're given a table containing job postings from various companies on the LinkedIn platform. 
Write a query to retrieve the count of companies that have posted duplicate job listings.
Definition:
Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
job_listings Table:
Column Name	Type
job_id	integer
company_id	integer
title	string
description	string */ 
SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
    SELECT company_id, title, description, COUNT(*) AS count
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(*) > 1
) AS duplicates;

--2. datalemur-highest-grossing.
/* Assume you're given a table containing data on Amazon customers and their spending on products in different category
write a query to identify the top two highest-grossing products within each category in the year 2022.
The output should include the category, product, and total spend.
product_spend Table:
Column Name	Type
category	string
product	string
user_id	integer
spend	decimal
transaction_date	timestamp*/ 
WITH product_totals AS (
    SELECT category, product, SUM(spend) AS total_spend
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product
),

ranked_products AS (
    SELECT pt1.category, pt1.product, pt1.total_spend,
     (SELECT COUNT(*) FROM product_totals pt2
        WHERE pt2.category = pt1.category
       AND pt2.total_spend > pt1.total_spend
      ) AS num_higher_products
    FROM product_totals pt1 )

SELECT category, product, total_spend
FROM ranked_products
WHERE num_higher_products < 2
ORDER BY category ASC, total_spend DESC;

--3. datalemur-frequent-callers.
/*UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support for their health care needs 
– whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.
Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the case_id column.
callers Table:
Column Name	Type
policy_holder_id	integer
case_id	varchar
call_category	varchar
call_date	timestamp
call_duration_secs	integer */
SELECT COUNT( distinct a.policy_holder_id)
FROM callers a
WHERE (SELECT
  COUNT(case_id) as count_call
  FROM callers  b
  WHERE a.policy_holder_id = b.policy_holder_id
  GROUP BY policy_holder_id) >= 3

--4.datalemur-page-with-no-likes.
/*Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").
Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

pages Table:
Column Name	Type
page_id	integer
page_name	varchar 

page_likes Table:
Column Name	Type
user_id	integer
page_id	integer
liked_date	datetime  */
SELECT page_id 
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)

--5.datalemur-user-retention.



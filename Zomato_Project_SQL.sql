9

-- Basic Analysis

-- How many total restaurants are in the dataset?

SELECT COUNT(*) AS total_restarents
FROM `zomato-data-`

-- How many unique restaurant names are there?

SELECT DISTINCT name
FROM `zomato-data-`


-- How many restaurants accept online orders?

SELECT COUNT(*) AS online_orders
FROM `zomato-data-`
WHERE online_order = 'Yes'

-- How many restaurants allow table booking?

SELECT  COUNT(*)
FROM `zomato-data-`
WHERE book_table = 'Yes'


-- What are the different types of restaurant listings in the dataset?

SELECT DISTINCT `listed_in(type)`
FROM `zomato-data-`


-- Ratings and Reviews Analysis
-- What is the average rating of restaurants?

SELECT AVG(rate)
FROM `zomato-data-`

-- What are the top 10 highest-rated restaurants?

SELECT MAX(rate)
FROM `zomato-data-`

-- How many restaurants fall under different rating categories (e.g., 4.5+, 4.0-4.5, 3.5-4.0, etc.)?

SELECT rate ,COUNT(*) AS resterants
FROM `zomato-data-`
GROUP BY 1

-- Which restaurant has received the highest number of votes?
SELECT *
FROM `zomato-data-`
WHERE votes = (SELECT MAX(votes)
				FROM `zomato-data-`)
                
-- Is there any correlation between the number of votes and the rating of a restaurant?

SELECT rate , votes
FROM `zomato-data-`

SELECT rate , AVG(votes) AS avarage_votes
FROM `zomato-data-`
GROUP BY 1
ORDER BY 2 DESC


-- Cost Analysis
-- What is the average cost for two people across all restaurants?


-- What are the top 5 most expensive restaurants based on approximate cost?

SELECT *
FROM `zomato-data-`
ORDER BY `approx_cost(for two people)` DESC
LIMIT 5


-- What are the most affordable restaurants (least cost for two)?

SELECT *
FROM `zomato-data-`
ORDER BY`approx_cost(for two people)` 
LIMIT 2


-- Is there any relationship between restaurant cost and rating?

SELECT `approx_cost(for two people)` , rate
FROM `zomato-data-`

SELECT rate , AVG(`approx_cost(for two people)`) 
FROM `zomato-data-`
GROUP BY 1


-- How many restaurants fall within different cost ranges (e.g., <500, 500-1000, 1000-2000, etc.)?

SELECT `approx_cost(for two people)`,COUNT(*) AS different_cost_range
FROM `zomato-data-`
GROUP BY `approx_cost(for two people)`
order by `approx_cost(for two people)`

-- Category-Based Analysis
-- How many restaurants are there in each listed_in(type) category?

SELECT `listed_in(type)` , COUNT(*) AS no_of_resterants
FROM`zomato-data-`
GROUP BY `listed_in(type)`

-- Which type of restaurant has the highest average rating?


-- SELECT`listed_in(type)` , AVG(rate) AS avg_rate
-- FROM `zomato-data-`
-- WHERE `listed_in(type)` = (SELECT MAX(AVG(rate)) 
-- 							FROM `zomato-data-`)

-- WITH CTC AS (
-- SELECT  `listed_in(type)` , AVG(rate) AS avg_rate
-- FROM `zomato-data-`)
-- SELECT `listed_in(type)` , MAX(avg_rate)
-- FROM CTC


SELECT `listed_in(type)`,AVG(rate) AS avg_rate
FROM `zomato-data-`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1

-- Which type of restaurant is the most expensive on average?

SELECT `listed_in(type)`,AVG(`approx_cost(for two people)`) AS avg_cost
FROM `zomato-data-`
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1


-- How many restaurants provide both online ordering and table booking?

SELECT  COUNT(*) AS online_and_offiline_restrants
FROM `zomato-data-`
WHERE online_order = 'YES' AND book_table = 'Yes'


-- What percentage of restaurants offer online ordering in each listed_in(type) category?

SELECT `listed_in(type)` , (count(online_order = 'Yes') / count(online_order) * 100) as percentage
from `zomato-data-`


WITH CCT AS(
SELECT `listed_in(type)` , COUNT(*) AS COUNT_OF_ONLINE_ORDER_YES
FROM `zomato-data-`
WHERE online_order = 'Yes'
group by 1)

WITH TTT(
SELECT `listed_in(type)` , COUNT(*) AS COUNT_OF_ALL_ONLINE
FROM `zomato-data-`
WHERE online_order = 'Yes' OR online_order = 'No'
group by 1)

select c.`approx_cost(for two people)` , 
(c.COUNT_OF_ONLINE_ORDER_YES/t.COUNT_OF_ALL_ONLINE)*100
from CCT as c
join TTT c on c.`listed_in(type)` = t.`listed_in(type)`
group by `listed_in(type)`


SELECT 
    listed_in(type), 
    SUM(CASE WHEN online_order = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS online_order_percentage
FROM zomato
GROUP BY listed_in(type);

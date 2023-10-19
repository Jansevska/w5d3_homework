-- Question 1
SELECT *
FROM address a
WHERE district = 'Texas';


select c.first_name, c.last_name, a.district 
from customer c
join address a 
on c.address_id = a.address_id 
WHERE district = 'Texas'
ORDER BY customer_id;

-- Answer:
--first_name|last_name|district|
------------+---------+--------+
--Jennifer  |Davis    |Texas   |
--Kim       |Cruz     |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |


-- Question 2
SELECT c.first_name, c.last_name, p.amount 
FROM payment p 
JOIN customer c 
ON p.customer_id = c.customer_id 
WHERE amount >= 7.00;

-- Answer:
--first_name|last_name  |amount|
------------+-----------+------+
--Peter     |Menard     |  7.99|
--Peter     |Menard     |  7.99|
--Peter     |Menard     |  7.99|
--Douglas   |Graf       |  8.99|
--Ryan      |Salisbury  |  8.99|
--Ryan      |Salisbury  |  8.99|
--Ryan      |Salisbury  |  7.99|
--Roger     |Quintanilla|  8.99|
--Joe       |Gilliland  |  8.99|
-- ...

-- Question 3
SELECT *
FROM customer c 
WHERE customer_id in(
SELECT customer_id
FROM payment p 
GROUP BY customer_id 
HAVING sum(amount) >= 175
ORDER BY customer_id
);

-- Answer:
--customer_id|store_id|first_name|last_name|email                            |address_id|activebool|
-------------+--------+----------+---------+---------------------------------+----------+----------+
--        137|       2|Rhonda    |Kennedy  |rhonda.kennedy@sakilacustomer.org|       141|true      |
--        144|       1|Clara     |Shaw     |clara.shaw@sakilacustomer.org    |       148|true      |
--        148|       1|Eleanor   |Hunt     |eleanor.hunt@sakilacustomer.org  |       152|true      |
--        178|       2|Marion    |Snyder   |marion.snyder@sakilacustomer.org |       182|true      |
--        459|       1|Tommy     |Collazo  |tommy.collazo@sakilacustomer.org |       464|true      |
--        526|       2|Karl      |Seal     |karl.seal@sakilacustomer.org     |       532|true      |


-- Question 4

SELECT c.first_name, c.last_name, a.district, c2.city, c3.country 
FROM customer c 
JOIN address a 
ON c.address_id = a.address_id 
JOIN city c2  
ON a.city_id  = c2.city_id 
JOIN country c3 
ON c2.country_id  = c3.country_id 
WHERE country = 'Argentina';

-- Answer:
--first_name|last_name|district    |city                |country  |
------------+---------+------------+--------------------+---------+
--Willie    |Markham  |Buenos Aires|Almirante Brown     |Argentina|
--Jordan    |Archuleta|Buenos Aires|Avellaneda          |Argentina|
--Jason     |Morrissey|Buenos Aires|Baha Blanca         |Argentina|
--Kimberly  |Lee      |Crdoba      |Crdoba              |Argentina|
--Micheal   |Forman   |Buenos Aires|Escobar             |Argentina|
--Darryl    |Ashcraft |Buenos Aires|Ezeiza              |Argentina|
--Julia     |Flores   |Buenos Aires|La Plata            |Argentina|
--Florence  |Woods    |Buenos Aires|Merlo               |Argentina|
--Perry     |Swafford |Buenos Aires|Quilmes             |Argentina|
--Lydia     |Burke    |Tucumn      |San Miguel de Tucumn|Argentina|
--Eric      |Robert   |Santa F     |Santa F             |Argentina|
--Leonard   |Schofield|Buenos Aires|Tandil              |Argentina|
--Willie    |Howell   |Buenos Aires|Vicente Lpez        |Argentina|



-- Question 5
--SELECT c.category_id, c."name", sum(category_id) AS num_movies_in_cat
--FROM category c
--GROUP BY c.category_id ;

SELECT c.category_id, c."name", count(fc.category_id) AS num_movies_in_cat
FROM category c
JOIN film_category fc 
ON c.category_id = fc.category_id 
GROUP BY c.category_id
ORDER BY num_movies_in_cat DESC ;

-- Answer:
--category_id|name       |num_movies_in_cat|
-------------+-----------+-----------------+
--         15|Sports     |               74|
--          9|Foreign    |               73|
--          8|Family     |               69|
--          6|Documentary|               68|
--          2|Animation  |               66|
--          1|Action     |               64|
--         13|New        |               63|
--          7|Drama      |               62|
--         14|Sci-Fi     |               61|
--         10|Games      |               61|
--          3|Children   |               60|
--          5|Comedy     |               58|
--          4|Classics   |               57|
--         16|Travel     |               57|
--         11|Horror     |               56|
--         12|Music      |               51|


-- Question 6

SELECT f.film_id, f.title, count(fa.actor_id) AS num_actors 
FROM film f
JOIN film_actor fa 
ON f.film_id = fa.film_id 
GROUP BY f.film_id
ORDER BY num_actors DESC ;

-- Answer:
--film_id|title                      |num_actors|
---------+---------------------------+----------+
--    508|Lambs Cincinatti           |        15|


    
-- Question 7

SELECT a.actor_id, a.first_name, a.last_name, count(fa.actor_id) AS num_films
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
GROUP BY a.actor_id 
ORDER BY num_films ASC;

-- Answer:
--actor_id|first_name |last_name   |num_films|
----------+-----------+------------+---------+
--     148|Emily      |Dee         |       14|
   

-- Question 8

SELECT c.country_id, c.country , count(c2.city_id) AS num_cities
FROM country c 
JOIN city c2 
ON c.country_id = c2.country_id 
GROUP BY c.country_id 
ORDER BY num_cities DESC ; 

-- Answer:
--country_id|country                              |num_cities|
------------+-------------------------------------+----------+
--        44|India                                |        60|
--        23|China                                |        53|
--       103|United States                        |        35|


-- Question 9

SELECT a.actor_id , a.first_name , a.last_name , count(fa.film_id)
FROM actor a 
JOIN film_actor fa 
ON a.actor_id = fa.actor_id 
GROUP  BY a.actor_id 
HAVING count(*) BETWEEN 20 AND 25; 

-- Answer:
--actor_id|first_name |last_name  |count|
----------+-----------+-----------+-----+
--       8|Matthew    |Johansson  |   20|
--     116|Dan        |Streep     |   24|
--      87|Spencer    |Peck       |   21|
--      51|Gary       |Phoenix    |   25|
--      70|Michelle   |Mcconaughey|   23|
--     162|Oprah      |Kilmer     |   25|
--     132|Adam       |Hopper     |   22|
--     170|Mena       |Hopper     |   24|
--      69|Kenneth    |Paltrow    |   21|
--     180|Jeff       |Silverstone|   25|
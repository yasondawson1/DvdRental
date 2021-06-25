--Yason Dawson -- Data Engineering Felloship IYKRA
--Study case: Dvdrental

--1. A customer wants to know the films about “astronauts”. How many recommendations could you give for him?
SELECT COUNT(film_id) FROM film
WHERE description LIKE '%astronaut%';

--2. I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?
SELECT COUNT (film_id) FROM film 
WHERE rating = 'R' AND replacement_cost BETWEEN 5 AND 15;

--3. We have two staff members with staff IDs 1 and 2. We want to give a bonus to the staff member that handled the most payments. 
--   How many payments did each staff member handle? And how much was the total amount processed by each staff member?
SELECT COUNT (payment_id) AS count_payment, sum(amount) AS total_payment, staff_id FROM payment p 
GROUP BY staff_id;

--4. Corporate headquarters is auditing the store! They want to know the average replacement cost of movies by rating!
SELECT avg(replacement_cost), rating FROM film f 
GROUP BY rating;

--5. We want to send coupons to the 5 customers who have spent the most amount of money. Get the customer name, email and their spent amount!
SELECT concat(c.first_name,' ', c.last_name) AS customer_name, c.email, SUM(p.amount) AS total
FROM customer c JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY total DESC
LIMIT 5;
      
--6. We want to audit our stock of films in all of our stores. How many copies of each movie in each store, do we have?
SELECT f.title, COUNT (i.inventory_id) AS copies, i.store_id
FROM inventory i JOIN film f
ON i.film_id = f.film_id 
GROUP BY i.store_id, f.title;

--7. We want to know what customers are eligible for our platinum credit card. 
---The requirements are that the customer has at least a total of 40 transaction payments. 
---Get the customer name, email who are eligible for the credit card! 
SELECT concat(c.first_name,' ', c.last_name) AS customer_name, c.email, COUNT (p.payment_id) AS count_payment
FROM customer c JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
HAVING COUNT (p.payment_id) >= 40
ORDER BY count_payment DESC;

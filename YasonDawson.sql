--Yason Dawson -- Data Engineering Felloship IYKRA
--Practice Case SQL
--Study case: Dvdrental

--1. How many movies about 'astronauts'
select count(film_id) from film
where description like'%stronaut%';

--2. How many movies with rating R and replacement cost rangin between $5 - $15?
select count(film_id) from film f
where rating = 'R' and replacement_cost between 5 and 15;

--3. How many payment and its total handled by each staff?
select count(payment_id) as count_payment, sum(amount) as total_payment, staff_id from payment p 
group by staff_id;

--4. How much is the average replacement cost by its rating?
select avg(replacement_cost), rating from film f 
group by rating;

--5. Customer name, email and their spent amount of 5 customers who spent most amount of money.
select concat(c.first_name,' ', c.last_name) as customer_name, c.email, SUM(p.amount) AS total
from customer c join payment p
on c.customer_id = p.customer_id
group by c.customer_id
order by total desc
limit 5;
      
--6. How many copies of each movies in each store?
select  f.title, count(i.inventory_id) as copies, i.store_id
from inventory i join film f
on i.film_id = f.film_id 
group by i.store_id, f.title;

--7. Name and email of customers who have at least 40 payments.
select concat(c.first_name,' ', c.last_name) as customer_name, c.email, count(p.payment_id) AS count_payment
from customer c join payment p
on c.customer_id = p.customer_id
group by c.customer_id
having count(p.payment_id) >= 40
order by count_payment desc;
-- 1.List all customers who live in Texas

SELECT first_name, last_name
FROM customer 
FULL join address
ON customer.address_id = address.address_id 
WHERE district = 'Texas';

-- 2.Get all payments above $6.99 with the customer's FULL name

SELECT first_name, last_name
FROM customer
FULL join payment 
ON customer.customer_id = payment.customer_id 
WHERE amount > 6.99;

-- 3.Show all customers names who have made payments over $175
SELECT first_name,last_name
FROM customer 
WHERE customer_id in(
	SELECT customer_id 
	FROM payment
	GROUP BY customer_id 
	HAVING sum(amount) > 175
);

-- 4.List all customers that live in Nepal
SELECT first_name,last_name
FROM customer
INNER JOIN address 
ON customer.address_id = address.address_id 
INNER JOIN city 
ON address.city_id = city.city_id 
FULL join country 
ON country.country_id = city.country_id 
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT first_name,last_name, COUNT(payment.staff_id)
FROM staff 
INNER JOIN payment 
ON staff.staff_id = payment.staff_id 
GROUP BY first_name,last_name 
HAVING COUNT(payment.staff_id)> 7300
ORDER BY COUNT(payment.staff_id) desc;

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(rating)
FROM film 
GROUP BY rating 
ORDER BY COUNT(rating) asc;

-- 7.Show all customers who have made a single payment above $6.99
SELECT first_name,last_name, amount
FROM customer 
INNER JOIN payment 
ON customer.customer_id = payment.customer_id 
WHERE amount in(
	SELECT amount
	FROM payment 
	WHERE amount > 6.99
	GROUP BY amount
);

-- 8. How many free rentals did our stores give away?
SELECT COUNT(payment_id)
FROM payment 
WHERE amount < 0.01;
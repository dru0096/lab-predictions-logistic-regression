USE sakila;

/* Create a query or queries to extract the information you think may be relevant for building the prediction model. 
It should include some film features and some rental features. Use the data from 2005.
    Film:

    film_id
    title
    language_id
    length
    rating

    Rental: 
    r.inventory_id
    r.rental_id
    r.rental_date
    
    Category:
    name
    category_id
    
    Film-Category
    film_id
    category_id
    
    Actor:
    actor_id
    first_name
    last_name
    
    Film_Actor:
    
    actor_id
    film_id

	Language:
    After exploring data it appears all films are in english so language will not be so relevant for our model.*/

SELECT     
    f.film_id,
    f.title,
    f.length,
    f.rating,
    r.rental_id,
    year(r.rental_date) as Rental_year,
    month(r.rental_date) as Rental_month,
    c.name,
    fa.actor_id,
    concat(a.first_name,' ', a.last_name)
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
JOIN sakila.film_actor as fa
ON f.film_id = fa.film_id
JOIN sakila.actor as a
ON fa.actor_id = a.actor_id;

--
/* Create a query to get the list of films and a boolean indicating if it was rented last month (August 2005). 
This would be our target variable. */

/* July 2005 */
SELECT     
    f.film_id,
    f.title,
    f.length,
    f.rating,
    r.rental_id,
    year(r.rental_date) as Rental_year,
    month(r.rental_date) as Rental_month,
    c.name,
    fa.actor_id,
    concat(a.first_name,' ', a.last_name)
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
JOIN sakila.film_actor as fa
ON f.film_id = fa.film_id
JOIN sakila.actor as a
ON fa.actor_id = a.actor_id
WHERE month(r.rental_date) = 7;


/* August 2005 */

SELECT     
    f.film_id,
    f.title,
    f.length,
    f.rating,
    r.rental_id,
    year(r.rental_date) as Rental_year,
    month(r.rental_date) as Rental_month,
    c.name,
    fa.actor_id,
    concat(a.first_name,' ', a.last_name)
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
JOIN sakila.film_actor as fa
ON f.film_id = fa.film_id
JOIN sakila.actor as a
ON fa.actor_id = a.actor_id
WHERE month(r.rental_date) = 8;

/* Unique films */
SELECT title from sakila.film
;



/* After new instructions */

SELECT     
    f.film_id,
    f.title,
    f.length,
    f.rating,
    r.rental_id,
    year(r.rental_date) as Rental_year,
    month(r.rental_date) as Rental_month,
    c.name,
    fa.actor_id,
    concat(a.first_name,' ', a.last_name)
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
JOIN sakila.film_actor as fa
ON f.film_id = fa.film_id
JOIN sakila.actor as a
ON fa.actor_id = a.actor_id
WHERE month(r.rental_date) = 8;

/* Unique films. For movies rented in July count the number of rentals in July. 
Do the same for mov ies rented in August and comprare both numbers. */


SELECT 
f.film_id,
f.length,
f.rating,
count(r.rental_id) as Num_film_rentals,
month(r.rental_date) as Rental_month,
c.name
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
WHERE month(r.rental_date) = 7
GROUP BY f.film_id;

SELECT 
f.film_id,
f.length,
f.rating,
count(r.rental_id) as Num_film_rentals,
month(r.rental_date) as Rental_month,
c.name
FROM sakila.film as f
JOIN sakila.inventory as i
ON f.film_id = i.film_id
JOIN sakila.rental as r
ON i.inventory_id = r.inventory_id
LEFT JOIN sakila.film_category as fc
ON f.film_id = fc.film_id
LEFT JOIN sakila.category as c
ON fc.category_id = c.category_id
WHERE month(r.rental_date) = 8
GROUP BY f.film_id;

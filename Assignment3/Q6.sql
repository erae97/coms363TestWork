-- Q6
SELECT 
    CONCAT(customer.last_name,
            ', ',
            customer.first_name) AS customer,
    address.phone
FROM
    rental,
    customer,
    address,
    inventory,
    film
WHERE
    rental.customer_id = customer.customer_id
        AND customer.address_id = address.address_id
        AND rental.inventory_id = inventory.inventory_id
        AND inventory.film_id = film.film_id
        AND rental.return_date IS NULL
        AND rental_date + INTERVAL film.rental_duration DAY < CURRENT_DATE();
        

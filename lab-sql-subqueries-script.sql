	-- 1.
select * from inventory
where film_id = (
	select film_id from film
	where title = 'HUNCHBACK IMPOSSIBLE'
	);

	-- 2.
select title, length from film
where length > (select avg(length) from film)
order by length;

	-- 3.
select first_name, last_name from actor
where actor_id in (
	select actor_id from film_actor
	where film_id =(
		select film_id from film
		where title = 'ALONE TRIP'
		)
	);

	-- 4.
select title from film
where film_id in (
	select film_id from film_category
	where category_id = (    
		select category_id from category
		where name = 'Family'
		)
	);

	-- 5.
select first_name, last_name, email from customer
where address_id in (
	select address_id from address
	where city_id in (
		select city_id from city
		where country_id = (
			select country_id from country
			where country = 'Canada'
			)
		)
	);

select first_name, last_name, email from customer
join address using(address_id)
join city using(city_id)
join country using(country_id)
where country = 'Canada';

	-- 6.
select title from film
where film_id in (    
	select film_id from film_actor
	where actor_id = (
		select actor_id from film_actor
		group by actor_id
		order by count(*) desc
        limit 1
		)
	);

	-- 7.
select title from film
where film_id in (
	select film_id from inventory
	where inventory_id in (
		select inventory_id from rental
		where customer_id = (
			select customer_id from payment
			group by customer_id
			order by sum(amount) desc
			limit 1
			)
		)
	);

	-- 8.
select customer_id client_id, sum(amount) total_amount_spent from payment
group by customer_id
having sum(amount) > (
	select avg(sa) from (
		select customer_id, sum(amount) sa from payment
		group by customer_id
		) ta
    )
order by customer_id;
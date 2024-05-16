{{ config(materialized='table') }}


select customer_id, name, email, min(created_at) as first_order_at, count(*) as  number_of_orders
 from `analytics-engineers-club.coffee_shop.customers` as c
inner join `analytics-engineers-club.coffee_shop.orders` as o
on c.id = o.customer_id
group by o.customer_id, name, email
order by min(created_at)

 

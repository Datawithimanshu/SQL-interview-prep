use company;
select * from customers;
select * from orders;

-- JOINS

-- show all order with customer name and city.
Select o.order_id, c.customer_name, c.city, o.product_name, o.quantity, o.unit_price
from orders o
inner join customers c 
on o.customer_id = c.customer_id;

-- Find customer who never placed an order.
 select o.customer_id, c.customer_name, c.email, c.city
 from orders o
 left join customers c
 on c.customer_id = o.customer_id
 where order_id is null;
 
-- List all electronic order with customer name and membership tier.
select c.customer_name, c.membership_tier, o.product_name, o.quantity, o.unit_price
from orders o
inner join customers c
on o.customer_id = c.customer_id
where o.category ='electronics';

-- Show all Delivered orders from London customers
select c.customer_name, o.product_name, o.order_date, o.status, c.city
from orders o
inner join customers c
on c.customer_id = o.customer_id
where c.city = 'London'
and o.status = 'Delivered';

-- Total amount spent by each customer (quantity × unit_price)
select c.customer_name, c.membership_tier,
sum(o.quantity*o.unit_price) as total_amount
from orders o
inner join customers c
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name, c.membership_tier
order by total_amount desc;

-- total order and revenue per category
select o.category,
count(o.order_id) as total_order,
sum(o.quantity*o.unit_price) as total_revenue
from orders o
inner join customers c
on c.customer_id = o.customer_id
group by o.category
order by total_revenue desc;

-- customer who spent more than 1000 in total
select c.customer_name, c.city,
sum(o.quantity*o.unit_price) as total_spent
from orders o 
inner join customers c
on o.customer_id = c.customer_id
group by c.customer_id, c.customer_name, c.city
having total_spent>1000
order by total_spent desc;

 -- Count of orders per membership tier with total revenue

select membership_tier,
count(o.order_id) as total_order,
sum(o.quantity * o.unit_price) as total_revenue,
avg(o.quantity*o.unit_price) as avg_revenue
from orders o
inner join customers c
on o.customer_id = c.customer_id
group by membership_tier
order by total_revenue desc;

-- Find all Cancelled orders with customer contact details
select c.customer_name, c.email, c.city, o.order_id, o.product_name, o.order_date
from orders o
inner join customers c
on c.customer_id = o.customer_id
where o.status = 'Cancelled';

-- Monthly revenue trend
select date_format(o.order_date, '%Y-%M')  as month,
count(o.order_id) as total_order,
sum(o.quantity * o.unit_price) as monthlt_revenue
from orders o 
inner join customers c 
on c.customer_id = o.customer_id
group by month
order by month;

-- Rank customers by total spending using Window Function

select c.customer_name, c.membership_tier,
sum(o.quantity * o.unit_price) as total_spent,
rank() over(order by sum(o.quantity * o.unit_price) desc) as spending_spent
from orders o
inner join customers c 
on c.customer_id = o.customer_id
group by c.customer_name, c.membership_tier;

  -- Rank customers by spending WITHIN each membership tier
select c.customer_name, c.membership_tier,
sum(o.quantity*o.unit_price) as total_spent,
rank() over(partition by c.membership_tier order by sum(o.quantity*o.unit_price)desc) as tier_rank
from orders o 
inner join customers c 
on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name, c.membership_tier;

-- For each customer show their first and latest order date (CTE + JOIN)
with customer_order as (
select customer_id,
max(order_date) as latest_order,
min(order_date) as first_order,
count(order_id) as total_order,
sum(quantity*unit_price) as lifetime_revenue
from orders
group by customer_id
)
select c.customer_name, c.membership_tier, c.city, 
co.latest_order, co.first_order, co.total_order, co.lifetime_revenue
from customers c
inner join customer_order co
on c.customer_id = co.customer_id
order by co.lifetime_revenue desc;

-- Full customer report — spending label, rank, order count (CASE + Window + JOIN)
select c.customer_name, c.membership_tier, c.city,
count(order_id) as total_order,
sum(o.quantity*o.unit_price) as total_spend,
rank() over(order by sum(o.quantity*o.unit_price) desc) as spending_rank,
case
when sum(o.quantity*o.unit_price) >=2000 then 'high_spend'
when sum(o.quantity*o.unit_price) >=500 then 'mid_spend'
else 'low_spend'
end as spending_label
from orders o
inner join customers c 
on c.customer_id = o.customer_id
group by c.customer_name, c.membership_tier, c.city
order by spending_rank;

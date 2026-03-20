# List the top 5 most ordered pizza types along with their quantities.
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;

# Determine the distribution of orders by hour of the day.
select
hour(time) as hour, count(order_id) as order_count
from orders 
group by hour(time);

# Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

# Chapter 4: Operational Insights
# Calculate the percentage contribution of each pizza type to total revenue.
# Market Share Analysis
SELECT 
    pizza_types.category,
    ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT 
                    ROUND(SUM(order_details.quantity * pizzas.price),
                                2) AS total_sales
                FROM
                    order_details
                        JOIN
                    pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100,
            2) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC;

# Analyze the cumulative revenue generated over time.
# Time-Series Analysis
select date,
sum(revenue) over (order by date) as CUM_revenue
from (
select 
orders.date,
sum(order_details.quantity * pizzas.price) AS revenue
from order_details
join pizzas on order_details.pizza_id = pizzas.pizza_id
join orders on orders.order_id = order_details.order_id
group by orders.date
) as sales;

# Determine the top 3 most ordered pizza types based on revenue for each pizza category.
# Nested Logic
select name, revenue from (
select category,
name,
revenue,
Rank() over (partition by category order by revenue desc) AS rn
from (
Select
pizza_types.category,
pizza_types.name,
SUM((order_details.quantity)*pizzas.price) AS revenue
from pizza_types
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category, pizza_types.name
) AS a
) As b
where rn <=3;

# Chapter 5 - category-wise analysis
# Find the total quantity of each pizza category ordered.
select
pizza_types.category,
sum(order_details.quantity) AS quantity
from
pizza_types
join
pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
join
order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.category
order by quantity desc;

# Find the category-wise distribution of pizzas.
select category, count(name) AS name_count
From 
pizza_types
group by category;

# Group the orders by date and calculate the average number of pizzas ordered per day.
select
round(Avg(quantity),0) AS avg_pizzas_ordered_per_day
from
(select orders.date, sum(order_details.quantity) AS quantity
from orders
join order_details on orders.order_id = order_details.order_id
group by orders.date) AS order_quantity;
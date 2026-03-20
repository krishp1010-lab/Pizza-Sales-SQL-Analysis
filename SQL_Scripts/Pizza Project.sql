-- 1. Drop and Create Database
DROP DATABASE IF EXISTS pizza_hut;
CREATE DATABASE pizza_hut;
USE pizza_hut;

-- 2. Create pizza_types (Matches pizza_types.csv)
CREATE TABLE pizza_types (
    pizza_type_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    ingredients TEXT
);

-- 3. Create pizzas (Matches pizzas.csv)
CREATE TABLE pizzas (
    pizza_id VARCHAR(50) PRIMARY KEY,
    pizza_type_id VARCHAR(50),
    size VARCHAR(10),
    price DECIMAL(10,2)
);

-- 4. Create orders (Matches orders.csv headers 'date' and 'time' exactly)
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    date DATE,
    time TIME
);

-- 5. Create order_details (Matches order_details.csv)
CREATE TABLE order_details (
    order_details_id INT PRIMARY KEY,
    order_id INT,
    pizza_id VARCHAR(50),
    quantity INT
);

-- IMPORTANT: Disable safety checks for the import
SET FOREIGN_KEY_CHECKS = 0;

-- Enable safety checks
SET FOREIGN_KEY_CHECKS = 1;

-- Add the Foreign Key links
ALTER TABLE pizzas ADD CONSTRAINT fk_type 
FOREIGN KEY (pizza_type_id) REFERENCES pizza_types(pizza_type_id);

ALTER TABLE order_details ADD CONSTRAINT fk_order 
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_details ADD CONSTRAINT fk_pizza 
FOREIGN KEY (pizza_id) REFERENCES pizzas(pizza_id);

# Chapter 2 Data Exploration
# Retrieve the total number of orders placed.
select count(order_id) AS total_orders
from orders #21350

#Calculate the total revenue generated from pizza sales.
Select round(sum(order_details.quantity*pizzas.price),2) AS Total_revenue
from
order_details join pizzas on pizzas.pizza_id = order_details.pizza_id 
#Total Revenue = $817860.05

# Identify the highest-priced pizza
select pizza_types.name, pizzas.price
from pizza_types 
join pizzas on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by pizzas.price DESC
Limit 1;
# The Greek Pizza price(35.95$)

# Identify the most common pizza size ordered.
select pizzas.size,
count(order_details.order_details_id) AS order_count
from pizzas
join 
order_details on pizzas.pizza_id = order_details.pizza_id
group by pizzas.size
order by order_count desc;

CREATE DATABASE Pizza_Database;
USE Pizza_Database;

-- Create Pizza Table
CREATE TABLE pizzas (
pizza_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
pizza_type VARCHAR(50),
pizza_price DECIMAL(6,2) 
);

-- Insert data to Pizza table
INSERT INTO pizzas (pizza_type, pizza_price) VALUES ('Pepperoni & Cheese', 7.99);
INSERT INTO pizzas (pizza_type, pizza_price) VALUES ('Vegetarian', 9.99); 
INSERT INTO pizzas (pizza_type, pizza_price) VALUES ('Meat Lovers', 14.99);
INSERT INTO pizzas (pizza_type, pizza_price) VALUES ('Hawaiian', 12.99);

-- Check result-set
SELECT * FROM pizzas;

-- Create Customers table 
CREATE TABLE customers (
customer_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
customer_name VARCHAR(50),
phone_number VARCHAR(15)
);

-- Insert customers to the table
INSERT INTO customers(customer_name, phone_number) VALUES ('Trevor Page', '226-555-4982');
INSERT INTO customers (customer_name, phone_number) VALUES ('John Doe', '555-555-9498');

-- Check result-set
SELECT * FROM customers;

-- Create orders table
CREATE TABLE orders (
order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
order_date DATETIME(0) NOT NULL,
customer_id INT NOT NULL,
FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);

-- Insert orders to the table
INSERT INTO orders (order_date, customer_id) VALUES ('2014-09-10 9:47:00', 1);
INSERT INTO orders (order_date, customer_id) VALUES ('2014-09-10 13:20:00', 2);
INSERT INTO orders (order_date, customer_id) VALUES ('2014-09-10 9:47:00', 1);
INSERT INTO orders (order_date, customer_id) VALUES ('2015-01-01 9:47:00', 1);
INSERT INTO orders (order_date, customer_id) VALUES ('2015-01-01 6:47:00', 1);
INSERT INTO orders (order_date, customer_id) VALUES ('2015-01-01 6:47:00', 1);



-- Check result-set
SELECT * FROM orders;



-- create table for order details
CREATE TABLE order_line(
order_id INT NOT NULL,
pizza_id INT NOT NULL,
quantity INT NOT NULL,
FOREIGN KEY(order_id) REFERENCES orders(order_id),
FOREIGN KEY(pizza_id) REFERENCES pizzas(pizza_id)
);

-- Insert orders to the table
INSERT INTO order_line (order_id, pizza_id, quantity) VALUES (1, 1, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (1, 3, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (2, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (2, 3, 2);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (3, 3, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (3, 4, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (4, 4, 2);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (4, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (4, 3, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (4, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (5, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (5, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (6, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (6, 2, 1);
INSERT INTO order_line (order_id, pizza_id, quantity)VALUES (6, 2, 1);
-- Check result-set
SELECT * FROM order_line;

-- Q4: Now the restaurant would like to know which customers are spending the most money at their establishment. 
-- Write a SQL query which will tell them how much money each individual customer has spent at their restaurant.
SELECT customers.customer_name, SUM(order_line.quantity * pizzas.pizza_price) AS Total FROM order_line
JOIN pizzas ON  order_line.pizza_id =pizzas.pizza_id
JOIN orders ON order_line.order_id = orders.order_id
JOIN customers ON orders.customer_id = customers.customer_id
GROUP BY customers.customer_id;

-- Q5: Modify the query from Q4 to separate the orders not just by customer, 
-- but also by date so they can see how much each customer is ordering orders on which date.
SELECT customer_name AS `NAME`, DATE(orders.order_date) AS `DATE`, SUM(order_line.quantity * pizzas.pizza_price) AS TOTAL FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id
LEFT JOIN order_line ON orders.order_id = order_line.order_id
LEFT JOIN pizzas ON  order_line.pizza_id =pizzas.pizza_id
GROUP BY `NAME`, `DATE`;

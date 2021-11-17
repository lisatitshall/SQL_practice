-- creating database and setting the database as active
CREATE DATABASE IF NOT EXISTS gameshopdb;
USE gameshopdb;

-- creating table to store game genre
CREATE TABLE genre(
  genre_id INT NOT NULL AUTO_INCREMENT,			
  genre_name VARCHAR(30) UNIQUE NOT NULL,
  PRIMARY KEY (genre_id)
);

-- creating customers table
CREATE TABLE customers(
  customer_id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(40) NOT NULL,
  email VARCHAR(60) NOT NULL,
  house_number VARCHAR(10) NOT NULL,
  postcode VARCHAR(8) NOT NULL,
  PRIMARY KEY (customer_id)
);

-- creating products table to store game information
CREATE TABLE products(
  product_id INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(60) NOT NULL,
  release_date DATE,
  price DECIMAL(6,2) NOT NULL,
  stock INT NOT NULL,
  platform VARCHAR(30),
  genre_id INT NOT NULL,
  PRIMARY KEY (product_id),
  FOREIGN KEY (genre_id) REFERENCES genre(genre_id)
);

-- creating orders table to store customer orders
CREATE TABLE orders(
  order_id INT NOT NULL AUTO_INCREMENT,
  customer_id INT NOT NULL,
  product_id INT NOT NULL,
  date_placed DATETIME NOT NULL,
  order_status VARCHAR(30) DEFAULT 'placed',
  PRIMARY KEY (order_id),
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- inserting genres into genre table
INSERT INTO genre(genre_name)
VALUES('action'),
('adventure'),
('puzzle'),
('racing'),
('role-playing'),
('sports'),
('strategy')
;

-- inserting customers into customer table
INSERT INTO customers(name, email, house_number, postcode)
VALUES('Matt Richards', 'mr@gmail.com', '473', 'WC1 8GH'),
('Ben Price', 'benprice@hotmail.com', '10', 'B12 4HN'),
('Lucy Reynolds', 'lucy172@gmail.com', '26a', 'WR2 1KL'),
('Lottie Smith', 'lottiesmith@gmail.co.uk', '13', 'OX12 5TH'),
('Jason Williams', 'jwilliams@hotmail.co.uk', '13', 'N1 7AM')
;

-- inserting products into product table
INSERT INTO products(title, price, stock, platform, genre_id, release_date)
VALUES('Jak and Daxter', 25.99, 2, 'PS2', 2, '2001-10-31'),
('Super Mario Galaxy', 38.99, 100, 'Wii', 2, '2008-06-02'),
('Mario Kart 9', 45.99, 15, 'Nintendo Switch', 4, '2014-08-19'),
('Call of Duty: Black Ops', 49.99, 100, 'PS4', 1, '2013-11-21'),
('Kingdom Hearts', 30.99, 1, 'PS2', 5, '2008-04-01'),
('Fifa 21', 55.99, 50, 'PS5', 6, '2020-10-20')
;

-- inserting orders into order table
INSERT INTO orders(customer_id, product_id, date_placed, order_status)
VALUES(1, 2, '2020-08-14 16:20:35.20342', 'placed'),
(1, 3, '2018-06-12 12:10:45.32542', 'placed'),
(3, 2, '2008-09-01 09:30:21.40892', 'placed'),
(4, 5, '2020-10-10 10:01:01.34021', 'placed'),
(5, 6, '2020-08-14 14:39:10.59280', 'placed')
;

-- Practicing queries 

-- select list of game titles
SELECT title FROM products; 

--list of names from the customers table									
SELECT name FROM customers; 

-- list of distinct platforms from the products table					 
SELECT DISTINCT platform FROM products; 		
				
-- list of all products where price is more than 50	
SELECT * FROM products WHERE price > 50; 

-- list of title/price of PS2 games				
SELECT title, price FROM products WHERE platform = 'PS2'; 

-- list of games where there's less than 10 in stock				
SELECT * FROM products WHERE stock <= 10;  	

-- list of all games except PS2 games 						
SELECT * FROM products WHERE platform != 'PS2';

-- ** list of products released in 2020 and 2021 **		
SELECT * FROM products WHERE release_date BETWEEN '2020-01-01' AND '2021-12-31';

-- list of customers in Worcester
SELECT * FROM customers WHERE postcode LIKE 'WR%';

-- list of playstation games					
SELECT title, price, release_date FROM products WHERE platform IN ('PS2', 'PS4', 'PS5');

-- ordering products by price 
SELECT * FROM products ORDER BY price ASC; 

-- list of 3 most expensive games							
SELECT * FROM products ORDER BY price DESC LIMIT 3; 

-- list of 5 most recently released games
SELECT title, price FROM products ORDER BY release_date DESC LIMIT 5; 	

-- shows all orders placed by customer one			
SELECT * FROM orders WHERE customer_id = 1; 

-- orders of product 2 sorted by descending order date						
SELECT * FROM orders WHERE product_id = 2 ORDER BY date_placed DESC; 	

-- shows a list of products and the value we have in stock
SELECT title, price * stock AS stock_value FROM products;

-- shows the three products where we have most stock value				
SELECT title, price * stock AS stock_value FROM products ORDER BY stock_value DESC LIMIT 3; 	


-- testing aggregrate functions 

-- shows how many orders we've received
SELECT COUNT(order_id) FROM orders; 

-- shows how many products we've got				
SELECT COUNT(title) FROM products;

-- shows how many games we have in stock						
SELECT SUM(stock) FROM products;

-- shows cheapest product						
SELECT MIN(price) FROM products;	

-- shows how many copies of the most common title we have in stock					
SELECT MAX(stock) FROM products;				

-- shows a list of customers and how many orders they've made				
SELECT customer_id, COUNT(product_id) AS number_of_orders FROM orders GROUP BY customer_id; 

-- shows total stock value
SELECT SUM(price * stock) AS stock_value FROM products

--shows how many products in each genre we have				
SELECT genre_id, COUNT(genre_id) FROM products GROUP BY genre_id;				

-- testing nested queries

-- lists full details of most expensive product					
SELECT * 											 
FROM products 
WHERE price = (
SELECT MAX(price) 
FROM products
);

-- lists title of product we have most of in stock
SELECT title										
FROM products
WHERE stock = (
SELECT MAX(stock) 
FROM products
);

-- saves a view of all Worcester customers
CREATE VIEW worcester_customers									
AS
SELECT * 
FROM customers 
WHERE postcode LIKE 'WR%'
;	

-- selects email addresses of Worcester customers
SELECT email FROM worcester_customers;
	
-- join examples

-- joins product and genre tables to show genre name instead of id
SELECT p.title, g.genre_name, p.platform, p.release_date					
FROM products p
JOIN genre g ON p.genre_id=g.genre_id;

-- same again but the right join means there's a row for genres which don't have a product associated with them 			
SELECT p.title, g.genre_name, p.platform, p.release_date	
FROM products p
RIGHT OUTER JOIN genre g ON p.genre_id=g.genre_id;

-- joins orders and customers table to show customer name instead of id
FROM orders o
SELECT c.name, o.product_id, o.date_placed, o.order_status					
JOIN customers c ON o.customer_id=c.customer_id;

-- same again but this time will be a null row for customers who haven't placed an order yet
SELECT c.name, o.product_id, o.date_placed, o.order_status
FROM orders o
RIGHT OUTER JOIN customers c ON o.customer_id=c.customer_id;

-- same as above but using left outer join
SELECT c.name, o.product_id, o.date_placed, o.order_status									
FROM customers c
LEFT OUTER JOIN orders o ON o.customer_id=c.customer_id;



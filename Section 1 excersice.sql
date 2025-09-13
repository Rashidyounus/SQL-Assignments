CREATE TABLE color (
    id int primary key,          
    name varchar(50) NOT NULL,   
    extra_fee decimal (10,2) DEFAULT 0 )


	INSERT INTO color (id, name, extra_fee) 
VALUES 
(1, 'Red', 0.00),
(2, 'Black', 2.50),
(3, 'Blue', 1.00);


INSERT INTO color (id, name, extra_fee) VALUES (4,'Green',0.00)
 

	create table customer(
	
	id int primary key,
	first_name varchar (50) not null,
	last_name varchar(50)  not null,
	favorite_color_id int ,

	CONSTRAINT fk_customer_color 
	   FOREIGN KEY (favorite_color_id)
        REFERENCES color (id)
	);


	INSERT INTO customer (id, first_name, last_name, favorite_color_id) 
VALUES
(1, 'Ali', 'Khan', 2),  
(2, 'Sara', 'Malik', 1), 
(3, 'John', 'Smith', 3); 


INSERT INTO customer (id, first_name, last_name, favorite_color_id) VALUES
(4, 'Ayesha', 'Noor', 4);

	CREATE TABLE category (
    id INT PRIMARY KEY,                 
    name VARCHAR(100) NOT NULL,         
    parent_id INT NULL,                

    CONSTRAINT fk_category_parent
        FOREIGN KEY (parent_id) 
        REFERENCES category(id)         
);



-- Main categories
INSERT INTO category (id, name, parent_id) 
VALUES
(1, 'Clothing', NULL),
(2, 'Shoes', NULL);

-- Subcategories
INSERT INTO category (id, name, parent_id) 
VALUES
(3, 'T-Shirts', 1),
(4, 'Running Shoes', 2);



CREATE TABLE clothing (
    id INT PRIMARY KEY,                  
    name VARCHAR(100) NOT NULL,          
    size VARCHAR(10) CHECK (size IN ('S','M','L','XL','2XL','3XL')),  
    price DECIMAL(10,2) NOT NULL,        
    color_id INT NOT NULL,               
    category_id INT NOT NULL,            

    CONSTRAINT fk_clothing_color
        FOREIGN KEY (color_id) REFERENCES color(id),

    CONSTRAINT fk_clothing_category
        FOREIGN KEY (category_id) REFERENCES category(id)

);

INSERT INTO clothing (id, name, size, price, color_id, category_id) 
VALUES
(1, 'Sports T-Shirt', 'M', 15.99, 1, 3),   -- Red T-Shirt
(2, 'Running Shoes', 'L', 49.99, 2, 4),   -- Black Running Shoes
(3, 'Hoodie', 'XL', 29.99, 3, 1);         -- Blue Hoodie (Clothing main category)




CREATE TABLE clothing_order (
    id INT PRIMARY KEY,                   
    customer_id INT NOT NULL,             
    clothing_id INT NOT NULL,             
    items INT NOT NULL CHECK (items > 0), 
    order_date DATE NOT NULL,             

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customer(id),

    CONSTRAINT fk_order_clothing
        FOREIGN KEY (clothing_id) REFERENCES clothing(id)
);


INSERT INTO clothing_order (id, customer_id, clothing_id, items, order_date) 
VALUES
(1, 1, 1, 2, '2025-09-01'),  -- Ali Khan bought 2 Red Sports T-Shirts
(2, 2, 2, 1, '2025-09-03'),  -- Sara Malik bought 1 Black Running Shoes
(3, 3, 3, 1, '2025-09-05');  -- John Smith bought 1 Blue Hoodie


--Exercise 1:
--List All Clothing Items

select * from clothing
--Exercise:

--Display the name of clothing items (name the column clothes),
--their color (name the column color), 
--and the last name and first name of the customer(s)
--who bought this apparel in their favorite color. 
--Sort rows according to color, in ascending order.


select clo.name as Clothes_name , c.name as color_name , cus.first_name, cus.last_name from clothing_order co
inner join clothing clo on co.clothing_id = clo.id
inner join color c on co.clothing_id = co.id
inner join customer cus on co.customer_id = cus.id
where clo.color_id =cus.favorite_color_id
order by c.name Asc;

--Exercise 2: Get All Non-Buying Customers

select * from customer
select* from clothing
select * from clothing_order 

SELECT 
    cu.id,
    cu.first_name,
    cu.last_name
FROM customer cu
LEFT JOIN clothing_order o 
    ON cu.id = o.customer_id
WHERE o.id IS NULL;


--Exercise:
--Select the last name and first name of customers and the name of their favorite color for customers with no purchases.


SELECT 
    cu.last_name,
    cu.first_name,
    co.name AS favorite_color
FROM customer cu
JOIN color co 
    ON cu.favorite_color_id = co.id
LEFT JOIN clothing_order o 
    ON cu.id = o.customer_id
WHERE o.id IS NULL;



--Exercise 3: Select All Main Categories and Their Subcategories

select * from category
--Exercise:
--Select the name of the main categories (which have a NULL in the parent_id column)
--and the name of their direct subcategory (if one exists). 
--Name the first column category and the second column subcategory.

SELECT 
    main.name AS category,
    sub.name AS subcategory
FROM category main
LEFT JOIN category sub
    ON sub.parent_id = main.id
WHERE main.parent_id IS NULL
ORDER BY main.name, sub.name;

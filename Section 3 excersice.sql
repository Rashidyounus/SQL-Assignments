CREATE TABLE channels (
    id INT PRIMARY KEY,
    channel_name VARCHAR(100) NOT NULL
);
INSERT INTO channels (id, channel_name) VALUES
(1, 'Google Ads'),
(2, 'Facebook'),
(3, 'Instagram'),
(4, 'Referral'),
(5, 'Direct'),
(6, 'YouTube'),
(7, 'LinkedIn'),
(8, 'Twitter'),
(9, 'Email Marketing'),
(10, 'Affiliate');


CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    city VARCHAR(100),
    region VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),
    phone VARCHAR(30),
    registration_date DATE NOT NULL,
    channel_id INT,
    first_order_id INT,
    first_order_date DATE,
    last_order_id INT,
    last_order_date DATE,
    CONSTRAINT fk_channel FOREIGN KEY (channel_id) REFERENCES channels(id)
);

INSERT INTO customers 
(customer_id, email, full_name, address, city, region, postal_code, country, phone, registration_date, channel_id, first_order_id, first_order_date, last_order_id, last_order_date)
VALUES
(1, 'john.smith@example.com', 'John Smith', '12 Main St', 'New York', 'NY', '10001', 'USA', '+1-212-555-1234', '2024-01-10', 1, 101, '2024-02-01', 103, '2024-04-15'),

(2, 'emily.johnson@example.com', 'Emily Johnson', '45 Park Ave', 'London', NULL, 'W1A 1AA', 'UK', '+44-20-7946-5678', '2024-02-05', 2, 102, '2024-02-20', 104, '2024-05-01'),

(3, 'michael.brown@example.com', 'Michael Brown', '88 Hill Rd', 'Toronto', 'ON', 'M4B 1B4', 'Canada', '+1-416-555-7890', '2024-03-12', 3, 105, '2024-03-25', 105, '2024-03-25'),

(4, 'sophia.davis@example.com', 'Sophia Davis', '33 Queen St', 'Sydney', 'NSW', '2000', 'Australia', '+61-2-9876-5432', '2024-04-18', 4, 106, '2024-04-22', 108, '2024-07-01'),

(5, 'daniel.miller@example.com', 'Daniel Miller', '22 Market St', 'Berlin', NULL, '10115', 'Germany', '+49-30-1234-5678', '2024-05-01', 5, NULL, NULL, NULL, NULL),

(6, 'olivia.wilson@example.com', 'Olivia Wilson', '9 River Rd', 'Paris', NULL, '75001', 'France', '+33-1-5555-4433', '2024-05-10', 6, 107, '2024-05-15', 110, '2024-08-02'),

(7, 'james.moore@example.com', 'James Moore', '77 King St', 'Madrid', NULL, '28001', 'Spain', '+34-91-234-5678', '2024-06-03', 7, NULL, NULL, NULL, NULL),

(8, 'ava.taylor@example.com', 'Ava Taylor', '14 Harbour Rd', 'Dublin', NULL, 'D02 X285', 'Ireland', '+353-1-234-5678', '2024-06-12', 8, 109, '2024-06-20', 112, '2024-08-25'),

(9, 'william.anderson@example.com', 'William Anderson', '5 Riverbank', 'Amsterdam', NULL, '1012 WX', 'Netherlands', '+31-20-555-3322', '2024-07-01', 9, 111, '2024-07-05', 111, '2024-07-05'),

(10, 'isabella.thomas@example.com', 'Isabella Thomas', '10 High St', 'Rome', 'Lazio', '00184', 'Italy', '+39-06-6677-8899', '2024-07-18', 10, 113, '2024-07-22', 113, '2024-07-22');



CREATE TABLE categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description VARCHAR(255)
);


INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Beverages', 'Soft drinks, coffees, teas, beers'),
(2, 'Snacks', 'Sweet and savory snacks'),
(3, 'Dairy Products', 'Cheese, milk, yogurt'),
(4, 'Bakery', 'Bread, cakes, pastries'),
(5, 'Frozen Foods', 'Frozen vegetables, pizzas'),
(6, 'Fruits', 'Fresh fruits'),
(7, 'Vegetables', 'Fresh vegetables'),
(8, 'Meat & Poultry', 'Chicken, beef, lamb'),
(9, 'Seafood', 'Fish and prawns'),
(10, 'Confectionery', 'Candies, chocolates');





CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category_id INT,
    unit_price DECIMAL(10,2) NOT NULL,
    discontinued BIT NOT NULL DEFAULT 0,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

INSERT INTO products (product_id, product_name, category_id, unit_price, discontinued) VALUES
(1, 'Green Tea', 1, 5.00, 0),
(2, 'Cola Drink', 1, 2.50, 0),
(3, 'Potato Chips', 2, 3.00, 0),
(4, 'Cheddar Cheese', 3, 8.50, 0),
(5, 'Yogurt Cup', 3, 1.50, 0),
(6, 'Chocolate Cake', 4, 12.00, 0),
(7, 'Frozen Pizza', 5, 15.00, 0),
(8, 'Apple', 6, 2.00, 0),
(9, 'Tomato', 7, 1.20, 0),
(10, 'Chicken Breast', 8, 7.50, 0);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    total_amount DECIMAL(12,2) NOT NULL,
    ship_name VARCHAR(100),
    ship_address VARCHAR(200),
    ship_city VARCHAR(100),
    ship_region VARCHAR(100),
    ship_postalcode VARCHAR(20),
    ship_country VARCHAR(100),
    shipped_date DATE,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO orders (
    order_id, customer_id, order_date, total_amount, 
    ship_name, ship_address, ship_city, ship_region, 
    ship_postalcode, ship_country, shipped_date
)
VALUES
(101, 1, '2024-02-01', 120.00, 'John Smith', '12 Main St', 'New York', 'NY', '10001', 'USA', '2024-02-03'),
(103, 1, '2024-04-15', 150.00, 'John Smith', '12 Main St', 'New York', 'NY', '10001', 'USA', '2024-04-18'),

(102, 2, '2024-02-20', 85.00, 'Emily Johnson', '45 Park Ave', 'London', NULL, 'W1A 1AA', 'UK', '2024-02-22'),
(104, 2, '2024-05-01', 65.00, 'Emily Johnson', '45 Park Ave', 'London', NULL, 'W1A 1AA', 'UK', '2024-05-03'),

(105, 3, '2024-03-25', 95.00, 'Michael Brown', '88 Hill Rd', 'Toronto', 'ON', 'M4B 1B4', 'Canada', '2024-03-28'),

(106, 4, '2024-04-22', 140.00, 'Sophia Davis', '33 Queen St', 'Sydney', 'NSW', '2000', 'Australia', '2024-04-25'),
(108, 4, '2024-07-01', 200.00, 'Sophia Davis', '33 Queen St', 'Sydney', 'NSW', '2000', 'Australia', '2024-07-05'),

(107, 6, '2024-05-15', 110.00, 'Olivia Wilson', '9 River Rd', 'Paris', NULL, '75001', 'France', '2024-05-18'),
(110, 6, '2024-08-02', 180.00, 'Olivia Wilson', '9 River Rd', 'Paris', NULL, '75001', 'France', '2024-08-05'),

(109, 8, '2024-06-20', 130.00, 'Ava Taylor', '14 Harbour Rd', 'Dublin', NULL, 'D02 X285', 'Ireland', '2024-06-22'),
(112, 8, '2024-08-25', 95.00, 'Ava Taylor', '14 Harbour Rd', 'Dublin', NULL, 'D02 X285', 'Ireland', '2024-08-28'),

(111, 9, '2024-07-05', 150.00, 'William Anderson', '5 Riverbank', 'Amsterdam', NULL, '1012 WX', 'Netherlands', '2024-07-08'),

(113, 10, '2024-07-22', 175.00, 'Isabella Thomas', '10 High St', 'Rome', 'Lazio', '00184', 'Italy', '2024-07-25');


CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    discount DECIMAL(4,2) DEFAULT 0,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

drop table order_items
select * from products
INSERT INTO order_items (order_id, product_id, unit_price, quantity, discount)
VALUES
-- Order 101 (John Smith, total 120.00)
(101, 1, 5.00, 10, 0.00),     -- Green Tea
(101, 2, 2.50, 20, 0.05),    -- Cola Drink (5% off)
(101, 3, 3.00, 10, 0.00),    -- Potato Chips

-- Order 102 (Emily Johnson, total 85.00)
(102, 3, 3.00, 10, 0.10),    -- Potato Chips (10% off)
(102, 5, 1.50, 15, 0.00),    -- Yogurt
(102, 2, 2.50, 5, 0.00),     -- Cola

-- Order 103 (John Smith, total 150.00)
(103, 4, 8.50, 10, 0.00),    -- Cheddar Cheese
(103, 6, 12.00, 5, 0.05),    -- Chocolate Cake (5% off)
(103, 7, 15.00, 2, 0.00),    -- Frozen Pizza

-- Order 104 (Emily Johnson, total 65.00)
(104, 6, 12.00, 3, 0.00),    -- Chocolate Cake
(104, 8, 2.00, 5, 0.00),     -- Apple
(104, 9, 1.20, 10, 0.00),    -- Tomato

-- Order 105 (Michael Brown, total 95.00)
(105, 7, 15.00, 3, 0.10),    -- Frozen Pizza (10% off)
(105, 5, 1.50, 10, 0.00),    -- Yogurt
(105, 2, 2.50, 10, 0.00),    -- Cola

-- Order 106 (Sophia Davis, total 140.00)
(106, 8, 2.00, 20, 0.00),    -- Apple
(106, 10, 7.50, 10, 0.05),   -- Chicken Breast (5% off)
(106, 6, 12.00, 3, 0.00),    -- Chocolate Cake

-- Order 107 (Olivia Wilson, total 110.00)
(107, 1, 5.00, 10, 0.00),    -- Green Tea
(107, 3, 3.00, 10, 0.00),    -- Chips
(107, 9, 1.20, 15, 0.00),    -- Tomato

-- Order 108 (Sophia Davis, total 200.00)
(108, 7, 15.00, 5, 0.00),    -- Frozen Pizza
(108, 10, 7.50, 10, 0.10),   -- Chicken Breast (10% off)
(108, 4, 8.50, 10, 0.00),    -- Cheese
(108, 6, 12.00, 5, 0.00),    -- Cake

-- Order 109 (Ava Taylor, total 130.00)
(109, 5, 1.50, 20, 0.00),    -- Yogurt
(109, 8, 2.00, 15, 0.00),    -- Apple
(109, 2, 2.50, 20, 0.05),    -- Cola (5% off)

-- Order 110 (Olivia Wilson, total 180.00)
(110, 10, 7.50, 15, 0.00),   -- Chicken
(110, 4, 8.50, 10, 0.10),    -- Cheese (10% off)
(110, 1, 5.00, 10, 0.00),    -- Green Tea

-- Order 111 (William Anderson, total 150.00)
(111, 7, 15.00, 5, 0.00),    -- Frozen Pizza
(111, 6, 12.00, 5, 0.05),    -- Cake (5% off)
(111, 9, 1.20, 20, 0.00),    -- Tomato

-- Order 112 (Ava Taylor, total 95.00)
(112, 8, 2.00, 10, 0.00),    -- Apple
(112, 3, 3.00, 10, 0.00),    -- Chips
(112, 5, 1.50, 15, 0.00),    -- Yogurt

-- Order 113 (Isabella Thomas, total 175.00)
(113, 4, 8.50, 10, 0.00),    -- Cheese
(113, 6, 12.00, 5, 0.00),    -- Cake
(113, 10, 7.50, 10, 0.05);   -- Chicken (5% off)


select * from order_items




WITH RankedOrders AS (
    SELECT 
        order_id,
        total_amount,
        order_date,
        DENSE_RANK() OVER (
            ORDER BY total_amount DESC, order_date ASC
        ) AS rank
    FROM orders
)
SELECT rank, order_id, total_amount
FROM RankedOrders
WHERE rank <= 3
ORDER BY rank, order_date;




SELECT
    order_id,
    customer_id,
    total_amount,
    LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS previous_value,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
    ) AS delta
FROM orders
ORDER BY customer_id, order_date;




SELECT
    c.customer_id,
    c.full_name,
    o.order_id,
    o.order_date,
    o.total_amount,
    SUM(o.total_amount) OVER (
        PARTITION BY c.customer_id
        ORDER BY o.order_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS running_total
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;


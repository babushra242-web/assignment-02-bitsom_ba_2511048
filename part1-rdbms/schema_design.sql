-- ============================================================
-- Part 1 - RDBMS: Normalized Schema (3NF)
-- Source: orders_flat.csv
-- Description: Decomposed denormalized flat file into 4 tables
--              in 3NF to eliminate all anomalies.
-- Tables: customers, sales_reps, products, orders, order_items
-- ============================================================


-- ------------------------------------------------------------
-- TABLE: customers
-- Stores one row per customer.
-- Eliminates delete anomaly: customers exist independently of orders.
-- ------------------------------------------------------------

CREATE TABLE customers (
    customer_id   VARCHAR(10)  NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_email VARCHAR(150) NOT NULL,
    customer_city VARCHAR(100) NOT NULL,
    PRIMARY KEY (customer_id)
);

INSERT INTO customers (customer_id, customer_name, customer_email, customer_city) VALUES
('C001', 'Rohan Mehta',  'rohan@gmail.com',  'Mumbai'),
('C002', 'Priya Sharma', 'priya@gmail.com',  'Delhi'),
('C003', 'Amit Verma',   'amit@gmail.com',   'Bangalore'),
('C004', 'Sneha Iyer',   'sneha@gmail.com',  'Chennai'),
('C005', 'Vikram Singh', 'vikram@gmail.com', 'Mumbai'),
('C006', 'Neha Gupta',   'neha@gmail.com',   'Delhi'),
('C007', 'Arjun Nair',   'arjun@gmail.com',  'Bangalore'),
('C008', 'Kavya Rao',    'kavya@gmail.com',  'Hyderabad');


-- ------------------------------------------------------------
-- TABLE: sales_reps
-- Stores sales representative details independently of any order.
-- Fixes UPDATE anomaly: office_address is stored exactly once per rep.
-- ------------------------------------------------------------

CREATE TABLE sales_reps (
    sales_rep_id   VARCHAR(10)  NOT NULL,
    sales_rep_name VARCHAR(100) NOT NULL,
    sales_rep_email VARCHAR(150) NOT NULL,
    office_address VARCHAR(255) NOT NULL,
    PRIMARY KEY (sales_rep_id)
);

INSERT INTO sales_reps (sales_rep_id, sales_rep_name, sales_rep_email, office_address) VALUES
('SR01', 'Deepak Joshi', 'deepak@corp.com', 'Mumbai HQ, Nariman Point, Mumbai - 400021'),
('SR02', 'Anita Desai',  'anita@corp.com',  'Delhi Office, Connaught Place, New Delhi - 110001'),
('SR03', 'Ravi Kumar',   'ravi@corp.com',   'South Zone, MG Road, Bangalore - 560001');


-- ------------------------------------------------------------
-- TABLE: products
-- Stores product details independently of any order.
-- Eliminates insert anomaly: products can be added without orders.
-- ------------------------------------------------------------

CREATE TABLE products (
    product_id   VARCHAR(10)  NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    category     VARCHAR(100) NOT NULL,
    unit_price   DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (product_id)
);

INSERT INTO products (product_id, product_name, category, unit_price) VALUES
('P001', 'Laptop',        'Electronics', 55000.00),
('P002', 'Mouse',         'Electronics',   800.00),
('P003', 'Desk Chair',    'Furniture',    8500.00),
('P004', 'Notebook',      'Stationery',    120.00),
('P005', 'Headphones',    'Electronics',  3200.00),
('P006', 'Standing Desk', 'Furniture',   22000.00),
('P007', 'Pen Set',       'Stationery',    250.00),
('P008', 'Webcam',        'Electronics',  2100.00);


-- ------------------------------------------------------------
-- TABLE: orders
-- Stores one row per order, referencing customer and sales rep by FK.
-- order_date kept here as it is a fact about the order itself.
-- ------------------------------------------------------------

CREATE TABLE orders (
    order_id     VARCHAR(10) NOT NULL,
    customer_id  VARCHAR(10) NOT NULL,
    sales_rep_id VARCHAR(10) NOT NULL,
    order_date   DATE        NOT NULL,
    PRIMARY KEY (order_id),
    FOREIGN KEY (customer_id)  REFERENCES customers (customer_id),
    FOREIGN KEY (sales_rep_id) REFERENCES sales_reps (sales_rep_id)
);

INSERT INTO orders (order_id, customer_id, sales_rep_id, order_date) VALUES
('ORD1000', 'C002', 'SR03', '2023-05-21'),
('ORD1001', 'C004', 'SR03', '2023-02-22'),
('ORD1002', 'C002', 'SR02', '2023-01-17'),
('ORD1003', 'C002', 'SR01', '2023-09-16'),
('ORD1004', 'C001', 'SR01', '2023-11-29'),
('ORD1005', 'C007', 'SR02', '2023-10-29'),
('ORD1006', 'C001', 'SR01', '2023-12-24'),
('ORD1007', 'C006', 'SR01', '2023-04-21'),
('ORD1008', 'C002', 'SR02', '2023-02-19'),
('ORD1009', 'C006', 'SR02', '2023-01-23'),
('ORD1010', 'C002', 'SR01', '2023-10-10'),
('ORD1011', 'C006', 'SR01', '2023-12-27'),
('ORD1012', 'C001', 'SR01', '2023-05-29'),
('ORD1013', 'C004', 'SR01', '2023-07-14'),
('ORD1014', 'C008', 'SR02', '2023-03-25'),
('ORD1015', 'C006', 'SR03', '2023-05-17'),
('ORD1016', 'C003', 'SR03', '2023-05-06'),
('ORD1017', 'C008', 'SR02', '2023-11-24'),
('ORD1018', 'C004', 'SR02', '2023-01-29'),
('ORD1185', 'C003', 'SR03', '2023-06-15');


-- ------------------------------------------------------------
-- TABLE: order_items
-- Stores line items linking orders to products.
-- unit_price_at_sale is captured here to preserve historical pricing
-- even if the product's current price changes later.
-- Composite PK on (order_id, product_id) ensures no duplicate line items.
-- ------------------------------------------------------------

CREATE TABLE order_items (
    order_id          VARCHAR(10)    NOT NULL,
    product_id        VARCHAR(10)    NOT NULL,
    quantity          INT            NOT NULL,
    unit_price_at_sale DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id)   REFERENCES orders   (order_id),
    FOREIGN KEY (product_id) REFERENCES products (product_id)
);

INSERT INTO order_items (order_id, product_id, quantity, unit_price_at_sale) VALUES
('ORD1000', 'P001', 2, 55000.00),
('ORD1001', 'P002', 5,   800.00),
('ORD1002', 'P005', 1,  3200.00),
('ORD1003', 'P002', 5,   800.00),
('ORD1004', 'P005', 5,  3200.00),
('ORD1005', 'P002', 3,   800.00),
('ORD1006', 'P007', 4,   250.00),
('ORD1007', 'P003', 3,  8500.00),
('ORD1008', 'P001', 3, 55000.00),
('ORD1009', 'P005', 4,  3200.00),
('ORD1010', 'P004', 3,   120.00),
('ORD1185', 'P008', 1,  2100.00);

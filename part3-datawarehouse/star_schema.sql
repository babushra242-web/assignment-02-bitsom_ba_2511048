-- ============================================================
-- Part 3 — Data Warehouse: Star Schema Design
-- ============================================================

-- Drop tables if they exist (for clean re-run)
DROP TABLE IF EXISTS fact_sales;
DROP TABLE IF EXISTS dim_date;
DROP TABLE IF EXISTS dim_store;
DROP TABLE IF EXISTS dim_product;

-- ------------------------------------------------------------
-- Dimension Tables
-- ------------------------------------------------------------

CREATE TABLE dim_date (
    date_id INT PRIMARY KEY,
    full_date DATE NOT NULL,
    day INT NOT NULL,
    month INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE dim_store (
    store_id INT PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL
);

CREATE TABLE dim_product (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL
);

-- ------------------------------------------------------------
-- Fact Table
-- ------------------------------------------------------------

CREATE TABLE fact_sales (
    transaction_id VARCHAR(20) PRIMARY KEY,
    date_id INT NOT NULL,
    store_id INT NOT NULL,
    product_id INT NOT NULL,
    customer_id VARCHAR(20) NOT NULL,
    units_sold INT NOT NULL,
    total_sales DECIMAL(12,2) NOT NULL,
    FOREIGN KEY (date_id) REFERENCES dim_date(date_id),
    FOREIGN KEY (store_id) REFERENCES dim_store(store_id),
    FOREIGN KEY (product_id) REFERENCES dim_product(product_id)
);

-- ------------------------------------------------------------
-- Insert Sample Dimension Data (cleaned and standardized)
-- ------------------------------------------------------------

INSERT INTO dim_date VALUES
(1, '2023-08-29', 29, 8, 2023),
(2, '2023-12-12', 12, 12, 2023),
(3, '2023-02-05', 5, 2, 2023),
(4, '2023-01-15', 15, 1, 2023),
(5, '2023-10-26', 26, 10, 2023),
(6, '2023-06-04', 4, 6, 2023),
(7, '2023-05-21', 21, 5, 2023),
(8, '2023-11-18', 18, 11, 2023),
(9, '2023-07-22', 22, 7, 2023),
(10, '2023-09-27', 27, 9, 2023);

INSERT INTO dim_store VALUES
(1, 'Chennai Anna', 'Chennai'),
(2, 'Delhi South', 'Delhi'),
(3, 'Bangalore MG', 'Bangalore'),
(4, 'Pune FC Road', 'Pune'),
(5, 'Mumbai Central', 'Mumbai');

INSERT INTO dim_product VALUES
(101, 'Speaker', 'Electronics', 49262.78),
(102, 'Tablet', 'Electronics', 23226.12),
(103, 'Phone', 'Electronics', 48703.39),
(104, 'Smartwatch', 'Electronics', 58851.01),
(105, 'Atta 10kg', 'Groceries', 52464.00),
(106, 'Jeans', 'Clothing', 2317.47),
(107, 'Jacket', 'Clothing', 30187.24),
(108, 'Laptop', 'Electronics', 42343.15),
(109, 'Milk 1L', 'Groceries', 43374.39),
(110, 'Rice 5kg', 'Groceries', 52195.05);

-- ------------------------------------------------------------
-- Insert Sample Fact Data (10 rows, cleaned)
-- ------------------------------------------------------------

INSERT INTO fact_sales VALUES
('TXN5000', 1, 1, 101, 'CUST045', 3, 147788.34),
('TXN5001', 2, 1, 102, 'CUST021', 11, 255487.32),
('TXN5002', 3, 1, 103, 'CUST019', 20, 974067.80),
('TXN5004', 4, 1, 104, 'CUST004', 10, 588510.10),
('TXN5007', 5, 4, 106, 'CUST041', 16, 37079.52),
('TXN5010', 6, 1, 107, 'CUST031', 15, 452808.60),
('TXN5012', 7, 3, 108, 'CUST044', 13, 550460.95),
('TXN5013', 8, 5, 109, 'CUST015', 10, 433743.90),
('TXN5019', 9, 1, 105, 'CUST008', 3, 157392.00),
('TXN5039', 10, 3, 110, 'CUST033', 13, 678535.65);

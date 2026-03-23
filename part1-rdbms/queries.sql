-- ============================================================
-- Part 1 — SQL Queries
-- ============================================================

-- Q1: List all customers from Mumbai along with their total order value
SELECT 
    customer_id,
    customer_name,
    SUM(unit_price * quantity) AS total_order_value
FROM orders_flat
WHERE customer_city = 'Mumbai'
GROUP BY customer_id, customer_name;

-- Q2: Find the top 3 products by total quantity sold
WITH product_sales AS (
    SELECT 
        product_id,
        product_name,
        SUM(quantity) AS total_quantity
    FROM orders_flat
    GROUP BY product_id, product_name
)
SELECT *
FROM product_sales
ORDER BY total_quantity DESC
FETCH FIRST 3 ROWS ONLY;

-- Q3: List all sales representatives and the number of unique customers they have handled
SELECT 
    sales_rep_id,
    sales_rep_name,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM orders_flat
GROUP BY sales_rep_id, sales_rep_name;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT 
    order_id,
    customer_id,
    customer_name,
    (unit_price * quantity) AS order_value
FROM orders_flat
WHERE (unit_price * quantity) > 10000
ORDER BY order_value DESC;

-- Q4: Find all orders where the total value exceeds 10,000, sorted by value descending
SELECT o.OrderID, SUM(p.Price * od.Quantity) AS OrderValue
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.OrderID
HAVING SUM(p.Price * od.Quantity) > 10000
ORDER BY OrderValue DESC;



-- Q5: Identify any products that have never been ordered
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN orders_flat o ON p.product_id = o.product_id
WHERE o.product_id IS NULL;

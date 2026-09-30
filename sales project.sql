use  sales; 
CREATE TABLE sales_d(
    order_date TEXT,
    invoice_no INT(11),
    customer_id INT(11),
    customer TEXT,
    product_id INT(11),
    product TEXT,
    category TEXT,
    segment TEXT,
    quantity INT(11),
    unit_cost INT(11),
    unit_price DOUBLE,
    revenue DOUBLE,
    cost INT(11),
    margin DOUBLE,
    ship_date TEXT,
    MyUnknownColumn TEXT,
    `MyUnknownColumn_[0]` TEXT,
    `MyUnknownColumn_[1]` TEXT,
    `MyUnknownColumn_[2]` TEXT,
    `MyUnknownColumn_[3]` TEXT,
    `MyUnknownColumn_[4]` TEXT,
    `MyUnknownColumn_[5]` TEXT,
    `MyUnknownColumn_[6]` TEXT
);



SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE "C:/Users/STORMSOFTS/Desktop/shravani/messy.csv"
INTO TABLE sales_d
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SHOW TABLES;
DESCRIBE sales_d;
SELECT *
FROM sales_d
LIMIT 5;
SELECT COUNT(*) AS total_rows
FROM sales_d;
SELECT SUM(dup_count - 1) AS total_extra_duplicate_rows
FROM (
    SELECT invoice_no, customer_id, product_id, order_date, COUNT(*) AS dup_count
    FROM sales_d
    GROUP BY invoice_no, customer_id, product_id, order_date
    HAVING COUNT(*) > 1
) AS subquery;
####duplicate remove############
DELETE FROM sales_d
WHERE (invoice_no, customer_id, product_id, order_date) IN (
    SELECT invoice_no, customer_id, product_id, order_date FROM (
        SELECT invoice_no, customer_id, product_id, order_date
        FROM sales_d
        GROUP BY invoice_no, customer_id, product_id, order_date
        HAVING COUNT(*) > 1
    ) AS temp
);
select * from sales_d;
-- NULLs check karne:
SELECT 
    SUM(CASE WHEN invoice_no IS NULL THEN 1 ELSE 0 END) AS null_invoices,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customers,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS null_products,
    SUM(CASE WHEN quantity IS NULL OR quantity <= 0 THEN 1 ELSE 0 END) AS invalid_qty
FROM sales_d;

-- Missing customer naav 'Unknown' thevane:
UPDATE sales_d
SET customer = 'Unknown Customer'
WHERE customer IS NULL OR TRIM(customer) = '';
#########revenue##################
SELECT invoice_no, product_id, revenue, (quantity * unit_price) AS calc_revenue
FROM sales_d
WHERE ABS(revenue - (quantity * unit_price)) > 0.05;
SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN customer IS NULL OR TRIM(customer) = '' THEN 1 ELSE 0 END) AS missing_customer,
    SUM(CASE WHEN category IS NULL OR TRIM(category) = '' THEN 1 ELSE 0 END) AS missing_category,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS missing_qty,
    SUM(CASE WHEN revenue IS NULL THEN 1 ELSE 0 END) AS missing_revenue
FROM sales_d;
-- Customer column madhye 'Unknown Customer' fill karne
UPDATE sales_d
SET customer = 'Unknown Customer'
WHERE customer IS NULL OR TRIM(customer) = '';

-- Category column madhye 'Others' fill karne
UPDATE sales_d
SET category = 'Others'
WHERE category IS NULL OR TRIM(category) = '';
-- Revenue missing aslyas (Quantity * Unit Price)
UPDATE sales_d
SET revenue = quantity * unit_price
WHERE (revenue IS NULL OR revenue = 0) 
  AND (quantity IS NOT NULL AND unit_price IS NOT NULL);

-- Cost missing aslyas (Quantity * Unit Cost)
UPDATE sales_d
SET cost = quantity * unit_cost
WHERE (cost IS NULL OR cost = 0) 
  AND (quantity IS NOT NULL AND unit_cost IS NOT NULL);

-- Margin missing aslyas (Revenue - Cost)
UPDATE sales_d
SET margin = revenue - cost
WHERE (margin IS NULL OR margin = 0) 
  AND (revenue IS NOT NULL AND cost IS NOT NULL);
  UPDATE sales_d t1
JOIN sales_d t2 
  ON t1.customer_id = t2.customer_id
SET t1.customer = t2.customer
WHERE (t1.customer IS NULL OR TRIM(t1.customer) = '')
  AND (t2.customer IS NOT NULL AND TRIM(t2.customer) != '');
  select *from sales_d t1;

  -- Safe updates off kara
SELECT 
    COUNT(*) AS total_rows,
    COUNT(DISTINCT invoice_no) AS total_orders,
    COUNT(DISTINCT customer_id) AS total_customers,
    COUNT(DISTINCT product_id) AS total_products,
    SUM(CASE WHEN ship_date < order_date THEN 1 ELSE 0 END) AS invalid_ship_dates,
    SUM(CASE WHEN quantity <= 0 THEN 1 ELSE 0 END) AS invalid_quantities
FROM sales_d;

-- 1. Monthly Revenue Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(SUM(margin), 2) AS total_profit
FROM sales_d
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY month;

-- 2. Top 5 Best Selling Products
SELECT 
    product,
    category,
    SUM(quantity) AS units_sold,
    ROUND(SUM(revenue), 2) AS total_revenue
FROM sales_d
GROUP BY product, category
ORDER BY total_revenue DESC
LIMIT 5;

-- 3. Segment-wise Profit Margin %
SELECT 
    segment,
    ROUND(SUM(revenue), 2) AS revenue,
    ROUND(SUM(margin), 2) AS profit,
    ROUND((SUM(margin) / SUM(revenue)) * 100, 2) AS margin_percentage
FROM sales_d
GROUP BY segment
ORDER BY margin_percentage DESC;



/*
This query retrieves Store Performance by Stores
*/
SELECT
s.store_name,
SUM(rs.total_price) AS total_revenue,
COUNT(rs.sale_id) AS total_transactions,
AVG(rs.total_price) AS avg_transaction_value
FROM
Stores s
JOIN
RetailSales rs
ON
s.store_id = rs.store_id
GROUP BY
s.store_name
ORDER BY
total_revenue DESC;

/*
This query retrieves Store Seasonal Sales Trends 
*/
WITH MonthlyStoreSales AS (
SELECT
s.store_name,
EXTRACT(MONTH FROM rs.sale_date) AS month,
SUM(rs.total_price) AS monthly_revenue,
COUNT(rs.sale_id) AS sales_count,
SUM(rs.quantity) AS total_units_sold
FROM
RetailSales rs
JOIN
Stores s
ON
rs.store_id = s.store_id
GROUP BY
s.store_name, month
)
SELECT
store_name,
month,
monthly_revenue,
sales_count,
total_units_sold
FROM
MonthlyStoreSales
ORDER BY
store_name, month;

/*
This query retrieves top 10 Best-Selling Products
*/
SELECT
p.product_name,
SUM(rs.quantity) AS total_units_sold,
SUM(rs.total_price) AS total_revenue
FROM
Products p
JOIN
RetailSales rs
ON
p.product_id = rs.product_id
GROUP BY
p.product_name
ORDER BY
total_units_sold DESC
LIMIT
10;
/*
This query retrieves Top 10 Loyalty Customer
*/
SELECT
    c.FirstName,
    c.LastName,
    COUNT(rs.sale_id) AS total_purchases
FROM
    Customers c
JOIN
    RetailSales rs
ON
    c.customer_id = rs.customer_id
GROUP BY
    c.FirstName,
    c.LastName
ORDER BY
    total_purchases DESC
LIMIT
    10;

/*
This query retrieves Product Inventory Levels
*/
SELECT
    s.store_name,
    p.product_name,
    si.Quantity AS current_inventory
FROM
    StoreInventory si
JOIN
    Stores s ON si.store_id = s.store_id
JOIN
    Products p ON si.product_id = p.product_id
WHERE
    si.Quantity < 10  -- Use the less than symbol here
ORDER BY
    si.Quantity;

/*
This query retrieves Product Discount Sales Performance
*/
WITH discount_sales AS (
    SELECT
        rs.product_id,
        SUM(rs.quantity) AS total_quantity,
        SUM(rs.total_price) AS total_revenue
    FROM
        RetailSales rs
    JOIN
        Discounts d ON d.product_id = rs.product_id
    WHERE
        rs.sale_date BETWEEN d.start_date AND d.end_date
    GROUP BY
        rs.product_id
)
SELECT
    p.product_name,
    ds.total_quantity AS discounted_units_sold,
    ds.total_revenue AS discounted_revenue,
    (SELECT SUM(rs.total_price) FROM RetailSales rs WHERE rs.product_id = p.product_id) AS total_revenue
FROM
    Products p
JOIN
    discount_sales ds ON p.product_id = ds.product_id
ORDER BY
    ds.total_revenue DESC;

/*
This query retrieves Employee Vacation Days
*/
SELECT 
    CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
    s.store_name,
    COALESCE(SUM(ev.vacation_end - ev.vacation_start), 0) AS total_vacation_days
FROM 
    Employees e
JOIN 
    Stores s
ON 
    e.store_id = s.store_id
LEFT JOIN 
    EmployeeVacation ev
ON 
    e.employee_id = ev.employee_id
GROUP BY 
    e.first_name, e.last_name, s.store_name
ORDER BY 
    total_vacation_days DESC;

/*
This query retrieves Vendor Performance
*/
SELECT
    v.vendor_name,
    COUNT(vd.delivery_id) AS total_deliveries,
    AVG(vd.quantity_received) AS avg_quantity_per_delivery
FROM
    vendor v  
JOIN
    VendorDelivery vd ON v.vendor_id = vd.vendor_id
GROUP BY
    v.vendor_name
ORDER BY
    total_deliveries DESC;

/*
This query retrieves Customer Feedback for each store
*/
SELECT 
    s.store_name,
    cf.feedback_text,
    cf.feedback_date,
    CONCAT(c.FirstName, ' ', c.LastName) AS customer_name
FROM 
    CustomerFeedback cf
JOIN 
    Stores s
ON 
    cf.store_id = s.store_id
JOIN 
    Customers c
ON 
    cf.customer_id = c.customer_id
ORDER BY 
    s.store_name, cf.feedback_date DESC;

/*
This query retrieves Employees performance
*/
WITH EmployeeSales AS (
    SELECT 
        e.employee_id,
        CONCAT(e.first_name, ' ', e.last_name) AS employee_name,
        s.store_name,
        SUM(rs.total_price) AS total_sales,
        COUNT(rs.sale_id) AS total_transactions
    FROM 
        RetailSales rs
    JOIN 
        Employees e
    ON 
        rs.store_id = e.store_id
    JOIN 
        Stores s
    ON 
        rs.store_id = s.store_id
    GROUP BY 
        e.employee_id, 
        e.first_name, 
        e.last_name, 
        s.store_name
)
SELECT 
    es.employee_name,
    es.store_name,
    es.total_sales,
    es.total_transactions
FROM 
    EmployeeSales es
ORDER BY 
    es.total_sales DESC;



-- REPORT 1: Products below their reorder level
SELECT
    product_name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity < reorder_level
ORDER BY stock_quantity ASC;


-- REPORT 2: Inventory valuation by category
SELECT
    category,
    SUM(stock_quantity) AS total_units,
    ROUND(SUM(stock_quantity * unit_price), 2) AS inventory_value
FROM products
GROUP BY category
ORDER BY inventory_value DESC;


-- REPORT 3: Products with supplier details
SELECT
    p.product_name,
    s.supplier_name,
    s.city,
    p.stock_quantity,
    p.unit_price
FROM products p
JOIN suppliers s
    ON p.supplier_id = s.supplier_id
ORDER BY p.product_name;


-- REPORT 4: Purchase order summary by supplier
SELECT
    s.supplier_name,
    COUNT(po.order_id) AS total_orders,
    SUM(po.quantity) AS total_units_ordered,
    SUM(po.quantity * po.unit_cost) AS total_order_value
FROM suppliers s
JOIN purchase_orders po
    ON s.supplier_id = po.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_order_value DESC;


-- REPORT 5: Pending purchase orders
SELECT
    po.order_id,
    s.supplier_name,
    p.product_name,
    po.quantity,
    po.unit_cost,
    po.quantity * po.unit_cost AS order_value,
    po.order_date
FROM purchase_orders po
JOIN suppliers s
    ON po.supplier_id = s.supplier_id
JOIN products p
    ON po.product_id = p.product_id
WHERE po.status = 'Pending'
ORDER BY po.order_date;


-- REPORT 6: Stock movement summary
SELECT
    p.product_name,
    SUM(CASE
        WHEN sm.movement_type = 'IN' THEN sm.quantity
        ELSE 0
    END) AS total_stock_in,
    SUM(CASE
        WHEN sm.movement_type = 'OUT' THEN sm.quantity
        ELSE 0
    END) AS total_stock_out
FROM products p
LEFT JOIN stock_movements sm
    ON p.product_id = sm.product_id
GROUP BY p.product_id, p.product_name
ORDER BY p.product_name;


-- REPORT 7: Supplier-wise product count
SELECT
    s.supplier_name,
    COUNT(p.product_id) AS total_products
FROM suppliers s
LEFT JOIN products p
    ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_products DESC;


-- REPORT 8: Create a reusable low-stock view
CREATE VIEW low_stock_products AS
SELECT
    product_id,
    product_name,
    stock_quantity,
    reorder_level
FROM products
WHERE stock_quantity < reorder_level;


-- Display the view
SELECT * FROM low_stock_products;


-- REPORT 9: Create an index for product category searches
CREATE INDEX idx_products_category
ON products(category);


-- REPORT 10: Examine the query execution plan
EXPLAIN ANALYZE
SELECT *
FROM products
WHERE category = 'Accessories';
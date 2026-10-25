-- INVENTORY & SUPPLIER MANAGEMENT SYSTEM
-- Database: inventory_management

-- 1. Create suppliers table
CREATE TABLE suppliers (
    supplier_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    city VARCHAR(50)
);

-- 2. Create products table
CREATE TABLE products (
    product_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    supplier_id INT REFERENCES suppliers(supplier_id),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    stock_quantity INT NOT NULL DEFAULT 0 CHECK (stock_quantity >= 0),
    reorder_level INT NOT NULL DEFAULT 10 CHECK (reorder_level >= 0)
);

-- 3. Create purchase orders table
CREATE TABLE purchase_orders (
    order_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    supplier_id INT NOT NULL REFERENCES suppliers(supplier_id),
    product_id INT NOT NULL REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_cost NUMERIC(10,2) NOT NULL CHECK (unit_cost >= 0),
    order_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL
        CHECK (status IN ('Pending', 'Received', 'Cancelled'))
);

-- 4. Create stock movements table
CREATE TABLE stock_movements (
    movement_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    product_id INT NOT NULL REFERENCES products(product_id),
    movement_type VARCHAR(10) NOT NULL
        CHECK (movement_type IN ('IN', 'OUT')),
    quantity INT NOT NULL CHECK (quantity > 0),
    movement_date DATE NOT NULL,
    remarks VARCHAR(200)
);

-- 5. Insert suppliers
INSERT INTO suppliers
(supplier_name, contact_person, phone, email, city)
VALUES
('TechSource India', 'Amit Shah', '9876543210',
 'amit@techsource.com', 'Pune'),
('Global Electronics', 'Priya Mehta', '9876543211',
 'priya@globalelectronics.com', 'Mumbai'),
('Smart Supplies', 'Rahul Patil', '9876543212',
 'rahul@smartsupplies.com', 'Nashik'),
('Prime Components', 'Neha Joshi', '9876543213',
 'neha@primecomponents.com', 'Pune'),
('Digital World', 'Karan Rao', '9876543214',
 'karan@digitalworld.com', 'Bangalore');

-- 6. Insert products
INSERT INTO products
(product_name, category, supplier_id, unit_price,
 stock_quantity, reorder_level)
VALUES
('Wireless Mouse', 'Accessories', 1, 599.00, 8, 10),
('Mechanical Keyboard', 'Accessories', 1, 2499.00, 25, 10),
('USB Cable', 'Accessories', 2, 199.00, 5, 15),
('Monitor 24-inch', 'Displays', 2, 8999.00, 12, 5),
('Laptop Stand', 'Accessories', 3, 999.00, 7, 10),
('SSD 1TB', 'Storage', 4, 5499.00, 18, 8),
('Webcam HD', 'Electronics', 5, 1799.00, 4, 8),
('Headphones', 'Electronics', 3, 1499.00, 20, 10),
('USB Hub', 'Accessories', 4, 799.00, 9, 10),
('External Hard Drive', 'Storage', 5, 3999.00, 6, 8);

-- 7. Insert purchase orders
INSERT INTO purchase_orders
(supplier_id, product_id, quantity, unit_cost, order_date, status)
VALUES
(1, 1, 20, 400.00, '2026-10-01', 'Received'),
(1, 2, 15, 1800.00, '2026-10-03', 'Received'),
(2, 3, 50, 120.00, '2026-10-05', 'Pending'),
(2, 4, 10, 7000.00, '2026-10-07', 'Received'),
(3, 5, 20, 650.00, '2026-10-10', 'Pending'),
(4, 6, 12, 4200.00, '2026-10-12', 'Received'),
(5, 7, 15, 1200.00, '2026-10-15', 'Pending'),
(3, 8, 25, 1000.00, '2026-10-18', 'Received');

-- 8. Insert stock movements
INSERT INTO stock_movements
(product_id, movement_type, quantity, movement_date, remarks)
VALUES
(1, 'IN', 20, '2026-10-01', 'Supplier delivery'),
(1, 'OUT', 12, '2026-10-02', 'Customer sales'),
(2, 'IN', 15, '2026-10-03', 'Supplier delivery'),
(3, 'IN', 30, '2026-10-05', 'Stock received'),
(3, 'OUT', 25, '2026-10-08', 'Customer sales'),
(4, 'IN', 10, '2026-10-07', 'Supplier delivery'),
(5, 'OUT', 3, '2026-10-11', 'Customer sales'),
(6, 'IN', 12, '2026-10-12', 'Supplier delivery'),
(7, 'OUT', 4, '2026-10-16', 'Customer sales'),
(8, 'IN', 25, '2026-10-18', 'Supplier delivery');

-- 9. Verify the data
SELECT * FROM suppliers;
SELECT * FROM products;
SELECT * FROM purchase_orders;
SELECT * FROM stock_movements;







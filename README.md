# Inventory & Supplier Management System (PostgreSQL)

## Project Overview
This project uses PostgreSQL to manage supplier information, product inventory, purchase orders, and stock movements. It demonstrates relational database design, SQL queries, data validation, and operational reporting.

## Technologies Used
- PostgreSQL 18
- SQL
- pgAdmin 4

## Database Tables
- **Suppliers:** Stores supplier contact details and locations.
- **Products:** Stores product details, categories, prices, available stock, and reorder levels.
- **Purchase Orders:** Tracks supplier orders, quantities, costs, dates, and order statuses.
- **Stock Movements:** Records stock-in and stock-out activities.

## Key Features
- Relational database design using primary and foreign keys.
- Data validation using `NOT NULL`, `UNIQUE`, and `CHECK` constraints.
- SQL joins and aggregate functions for reporting.
- Identification of products below their reorder levels.
- Inventory valuation by product category.
- Supplier-wise purchase order summaries.
- A reusable view for identifying low-stock products.
- Index creation and query execution-plan analysis.

## Sample Data
The project contains:
- 5 suppliers
- 10 products
- 8 purchase orders
- 10 stock movement records

## How to Run
1. Install PostgreSQL and open pgAdmin 4.
2. Create a database named `inventory_management`.
3. Open the Query Tool for that database.
4. Execute `01_create_tables_and_insert_data.sql` to create the tables and insert sample data.
5. Execute `02_inventory_reports.sql` to generate reports.

**Note:** Run the setup script only once on a fresh database. If you have already created the tables and inserted the data, run only the reporting script.

## Project Scope
This is a personal portfolio project built with sample data to demonstrate SQL development and database reporting skills. It does not currently implement automatic stock updates or a complete production inventory workflow.

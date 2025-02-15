# E-Commerce Database Project  

This project contains an SQL database designed for an **e-commerce system**. It includes multiple tables to store customer details, orders, products, events, and more.  

## 📌 Project Overview  
This database was created using **SQL Server Management Studio (SSMS)** and structured with **foreign keys** to maintain data integrity. The dataset was imported from an external source, filtered, and integrated into the database.  

### 🔄 **Handling Missing Data**  
To ensure data integrity and avoid errors:  
✔ All **NULL** values in text fields were replaced with `'unknown'`.  
✔ All **NULL** values in integer fields were replaced with `0`.  
✔ Data was verified to ensure consistency before insertion.  

## 📂 Database Schema  
The following tables are included:  
- **Customers**: Stores customer information (customer_id, name, email, etc.).  
- **Products**: Contains product details (product_id, name, price, category_id).  
- **Orders**: Stores customer orders (order_id, customer_id, total_amount, date).  
- **Events**: Logs user activities (event_id, user_id, event_type, timestamp).  
- **Other Tables**: Discounts, Payments, Reviews, Shipping, etc.  

## 🚀 How to Use  
1. Download **`e_commerce_schema.sql`** and **`data_import.sql`**.  
2. Open **SQL Server Management Studio (SSMS)**.  
3. Run **`e_commerce_schema.sql`** to create tables.  
4. Run **`data_import.sql`** to insert sample data.  

## 🔗 Dataset Source  
This project uses the **E-Commerce Behavior Data** from Kaggle.  
📥 **Download the dataset here:** [Kaggle E-Commerce Dataset](https://www.kaggle.com/datasets/mkechinov/ecommerce-behavior-data-from-multi-category-store)  

## 🔧 Technologies Used  
- **SQL Server Management Studio (SSMS)**  
- **SQL Queries (DDL & DML)**  
- **Data Import & Cleaning**  

## 📜 Key Features  
✔ Well-structured database with **foreign key constraints**.  
✔ Preloaded sample data for easy testing.  
✔ **NULL values handled** for smooth data processing.  
✔ Optimized queries for data retrieval.  

## 👨💻 Author  
**Bello John** – Data Engineering Enthusiast  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/bello-john-493b15155)  

---


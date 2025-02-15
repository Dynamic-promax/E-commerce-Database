-- Create the database
CREATE DATABASE E_Commerce;
GO

-- Use the DB
USE E_Commerce;

-- Customers Table
CREATE TABLE Customers (
	customer_id INT IDENTITY(1,1)
PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
	address TEXT
);
-- Products Table
CREATE TABLE Products (
	product_id INT IDENTITY(1,1)
PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	brand VARCHAR(255),
	description TEXT,
	price DECIMAL(10,2) NOT NULL,
	quantity_in_stock INT NOT NULL
);
-- Orders Table
CREATE TABLE Orders (
	order_id INT IDENTITY(1,1)
PRIMARY KEY,
	customer_id INT NOT NULL,
	order_date DATETIME DEFAULT GETDATE(),
	total_amount DECIMAL(10,2) NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Order Items Table (Join Table for orders & Product)
CREATE TABLE Order_Items (
	order_item_id INT IDENTITY (1,1) 
PRIMARY KEY,
	order_id INT NOT NULL,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	unit_price DECIMAL(10,2) NOT NULL,

	--Defining foreign keys correctly

	FOREIGN KEY (order_id) 
REFERENCES Orders(order_id),
	FOREIGN KEY (product_id)
REFERENCES Products(product_id)
);
-- Categories Table

CREATE TABLE Categories (
	category_id BIGINT IDENTITY (1,1)
PRIMARY KEY,
	category_code VARCHAR(50) UNIQUE NOT NULL,
	category_name VARCHAR(50) NOT NULL
);

--Shipping Table
CREATE TABLE Shipping (
	shipping_id INT IDENTITY(1,1)
PRIMARY KEY,
	order_id INT NOT NULL,
	shipping_address TEXT NOT NULL,
	shipping_date DATETIME DEFAULT GETDATE (),
	FOREIGN KEY (order_id)
REFERENCES Orders(order_id)
);

--User Sessions Table
CREATE TABLE UserSessions (
	user_id INT NOT NULL,
	user_session VARCHAR(255) NOT NULL,
PRIMARY KEY (user_id, user_session)
);
-- Events Table (For tracking views and purchases)

CREATE TABLE Events (
	event_id INT IDENTITY(1,1)
PRIMARY KEY,
	user_id INT NOT NULL,
	product_id INT NOT NULL,
	event_type NVARCHAR(50) CHECK (event_type IN ('view', 'purchase', 'cart')),
	event_time DATETIME,
	FOREIGN KEY (user_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);
-- DISCOUNT TABLE (FOR PRODUCT AND PROMOTION)

CREATE TABLE Discounts (
	discount_id INT IDENTITY(1,1)
PRIMARY KEY,
	product_id INT NOT NULL,
	discount_percentage DECIMAL(5,2) CHECK (discount_percentage BETWEEN 0 AND 100),
	start_date DATETIME NOT NULL,
	FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);
-- Reviews Table (For custome feedback)
CREATE TABLE Reviews (
	review_id INT IDENTITY(1,1)
PRIMARY KEY,
	customer_id INT NOT NULL,
	product_id INT NOT NULL,
	rating INT CHECK (rating BETWEEN 1 AND 5),
	review_text TEXT,
	review_date DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
	FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);
--Payments Table (For storing transanctions)
CREATE TABLE Payments (
	payment_id INT IDENTITY(1,1)
PRIMARY KEY,
	order_id INT NOT NULL,
	payment_method VARCHAR(50) CHECK (payment_method IN ('Credit Card', 'Paypal', 'Bank Tranfer', 'Crypto')),
	payment_status VARCHAR(50) CHECK (payment_status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
	payment_date DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
--Add Indexes for Performance Optimization
USE E_Commerce
CREATE INDEX idx_customer_email ON Customers(email);
CREATE INDEX idx_product_brand ON Products(brand);
CREATE INDEX idx_product_name ON Products(name);
CREATE INDEX idx_order_customer ON Orders(customer_id)
CREATE INDEX idx_order_items_order ON Order_Items(order_id);
CREATE INDEX idx_review_product ON Reviews(product_id);
CREATE INDEX idx_event_user ON Events(user_id);
CREATE INDEX idx_event_product ON Events(product_id)

--UPDATING THE E-COMMERCE TABLE
SELECT * FROM [E-Commerce] WHERE category_code IS NULL OR brand IS NULL
GO
UPDATE [E-Commerce] SET category_code = 'unknown' WHERE category_code IS NULL;
UPDATE [E-Commerce] SET brand = 'unknown' WHERE brand IS NULL;
GO
SELECT * FROM [E-Commerce] WHERE category_code IS NULL OR brand IS NULL


--IMPORTING DATA INTO CREATED DATA BASE (E_Commerce)
GO
--Importing data into customer_id, since its refrencing user_id in Events table (NB: Since email cant be null and its unique, user_session was used since email wasnt given in the dataset used)
INSERT INTO Customers(name, email)
SELECT DISTINCT 'Unknown', user_session  FROM [E-Commerce] WHERE user_id IS NOT NULL
GO
--Importing data into product_id, since its refrencing product_id in Events table
INSERT INTO Products(name, brand, price, quantity_in_stock)
SELECT DISTINCT 'Unknown', brand, price, '2'  FROM [E-Commerce]
GO
USE E_Commerce
--Improting data into Events Table
INSERT INTO dbo.Events (event_type, user_id, product_id)
SELECT e.event_type, c.customer_id, p.product_id FROM dbo.[E-Commerce] e
LEFT JOIN dbo.Products p ON e.brand = p.brand
LEFT JOIN dbo.Customers c ON e.user_session = c.email
WHERE p.product_id IS NOT NULL AND c.customer_id IS NOT NULL
GO
--Importing data into Categories Table
INSERT INTO Categories(category_code, category_name)
SELECT DISTINCT category_code, 'UNKNOWN' FROM [E-Commerce]
--Importing data into UserSessions
INSERT INTO UserSessions(user_id,user_session)
SELECT DISTINCT user_id, user_session FROM [E-Commerce]
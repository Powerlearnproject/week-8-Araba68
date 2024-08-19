-- CREATE database Agribusiness;
-- USE Agribusiness;

-- Create the Farmers table
-- CREATE TABLE Farmers (
--     farmer_id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     contact_info VARCHAR(255),
--     location VARCHAR(255),
--     farm_size DECIMAL(10, 2) -- Assuming farm_size is in hectares or similar unit
-- );

-- Create the Buyers table
-- CREATE TABLE Buyers (
--     buyer_id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     contact_info VARCHAR(255),
--     organization VARCHAR(255),
--     location VARCHAR(255)
-- );

-- Create the Products table
-- CREATE TABLE Products (
--     product_id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(255) NOT NULL,
--     category VARCHAR(255),
--     unit VARCHAR(50) -- e.g., kg, liters
-- );

-- Create the Transactions table
-- CREATE TABLE Transactions (
--     transaction_id INT AUTO_INCREMENT PRIMARY KEY,
--     farmer_id INT,
--     buyer_id INT,
--     product_id INT,
--     quantity DECIMAL(10, 2),
--     price DECIMAL(10, 2),
--     transaction_date DATE,
--     FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id),
--     FOREIGN KEY (buyer_id) REFERENCES Buyers(buyer_id),
--     FOREIGN KEY (product_id) REFERENCES Products(product_id)
-- );

-- Create the Logistics table
-- CREATE TABLE Logistics (
--     logistics_id INT AUTO_INCREMENT PRIMARY KEY,
--     transaction_id INT,
--     status VARCHAR(50),
--     delivery_date DATE,
--     transport_mode VARCHAR(50),
--     FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id)
-- );

-- Create the SustainablePractices table
-- CREATE TABLE SustainablePractices (
--     practice_id INT AUTO_INCREMENT PRIMARY KEY,
--     description TEXT,
--     category VARCHAR(255),
--     recommended BOOLEAN
-- );


-- Create the FarmerPractices table (many-to-many relationship between Farmers and SustainablePractices)
-- CREATE TABLE FarmerPractices (
--     farmer_practice_id INT AUTO_INCREMENT PRIMARY KEY,
--     farmer_id INT,
--     practice_id INT,
--     adopted_date DATE,
--     FOREIGN KEY (farmer_id) REFERENCES Farmers(farmer_id),
--     FOREIGN KEY (practice_id) REFERENCES SustainablePractices(practice_id)
-- );

-- Insert sample data into Farmers table
-- INSERT INTO Farmers (name, contact_info, location, farm_size)
-- VALUES
-- ('Hellen Kairu', 'kairu96@gmail.com', 'Rural Area A', 50.00),
-- ('Muringe Jane', 'janemuringe@gmail.com', 'Rural Area B', 35.00),
-- ('Alice Johnson', 'alicejohnson54@gmail.com', 'Rural Area C', 40.00);

-- Insert sample data into Buyers table
-- INSERT INTO Buyers (name, contact_info, organization, location)
-- VALUES
-- ('Acme Corp', 'acme.corp@example.com', 'Acme Corporation', 'Urban Area A'),
-- ('GreenGrocers', 'greengrocers@example.com', 'Green Grocers', 'Urban Area B'),
-- ('FoodMart', 'foodmart@example.com', 'FoodMart Retailers', 'Urban Area C');

-- Insert sample data into Products table
-- INSERT INTO Products (name, category, unit)
-- VALUES
-- ('Tomatoes', 'Vegetables', 'kg'),
-- ('Apples', 'Fruits', 'kg'),
-- ('Milk', 'Dairy', 'liters');

-- Insert sample data into Transactions table
-- INSERT INTO Transactions (farmer_id, buyer_id, product_id, quantity, price, transaction_date)
-- VALUES
-- (1, 1, 1, 100.00, 500.00, '2024-08-01'),
-- (2, 2, 2, 150.00, 450.00, '2024-08-05'),
-- (3, 3, 3, 200.00, 400.00, '2024-08-10');

--  Insert sample data into Logistics table
-- INSERT INTO Logistics (transaction_id, status, delivery_date, transport_mode)
-- VALUES
-- (1, 'Delivered', '2024-08-02', 'Truck'),
-- (2, 'Shipped', '2024-08-06', 'Van'),
-- (3, 'Pending', NULL, 'Truck');

--  Insert sample data into SustainablePractices table
-- INSERT INTO SustainablePractices (description, category, recommended)
-- VALUES
-- ('Drip irrigation to conserve water', 'Water Conservation', TRUE),
-- ('Organic composting for soil health', 'Soil Management', TRUE),
-- ('Crop rotation to maintain soil fertility', 'Soil Management', TRUE);

--  Insert sample data into FarmerPractices table
-- INSERT INTO FarmerPractices (farmer_id, practice_id, adopted_date)
-- VALUES
-- (1, 1, '2024-06-01'),
-- (2, 2, '2024-07-15'),
-- (3, 3, '2024-08-01');

-- Retrieve All Transactions for a Specific Farmer
-- SELECT t.transaction_id, b.name AS buyer_name, p.name AS product_name, t.quantity, t.price, t.transaction_date
-- FROM Transactions t
-- JOIN Buyers b ON t.buyer_id = b.buyer_id
-- JOIN Products p ON t.product_id = p.product_id
-- WHERE t.farmer_id = 2;  -- Replace 1 with the desired farmer_id

--  Get Total Sales and Average Price for a Specific Product
-- SELECT p.name AS product_name, 
--        SUM(t.quantity) AS total_quantity_sold, 
--        SUM(t.price) AS total_sales,
--        AVG(t.price) AS average_price
-- FROM Transactions t
-- JOIN Products p ON t.product_id = p.product_id
-- WHERE p.product_id = 3  -- Replace 1 with the desired product_id
-- GROUP BY p.name;

-- List All Farmers and Their Adopted Sustainable Practices
-- SELECT f.name AS farmer_name, sp.description AS practice_description, fp.adopted_date
-- FROM FarmerPractices fp
-- JOIN Farmers f ON fp.farmer_id = f.farmer_id
-- JOIN SustainablePractices sp ON fp.practice_id = sp.practice_id;

-- Find Buyers and Their Purchased Products in a Given Time Range
-- SELECT b.name AS buyer_name, p.name AS product_name, SUM(t.quantity) AS total_quantity
-- FROM Transactions t
-- JOIN Buyers b ON t.buyer_id = b.buyer_id
-- JOIN Products p ON t.product_id = p.product_id
-- WHERE t.transaction_date BETWEEN '2024-08-01' AND '2024-08-31'  -- Replace with desired date range
-- GROUP BY b.name, p.name;

-- Retrieve Current Status of Logistics for All Transactions
-- SELECT t.transaction_id, l.status, l.delivery_date, l.transport_mode
-- FROM Logistics l
-- JOIN Transactions t ON l.transaction_id = t.transaction_id;


--  Get Farmers with the Largest Farm Sizes
-- SELECT name, farm_size
-- FROM Farmers
-- ORDER BY farm_size DESC
-- LIMIT 5;  -- Adjust the limit as needed

-- Find the Most Recent Transactions for Each Farmer
-- SELECT t.farmer_id, f.name AS farmer_name, t.transaction_id, t.transaction_date, p.name AS product_name, t.quantity, t.price
-- FROM Transactions t
-- JOIN Farmers f ON t.farmer_id = f.farmer_id
-- JOIN Products p ON t.product_id = p.product_id
-- WHERE t.transaction_date = (
--     SELECT MAX(transaction_date)
--     FROM Transactions t2
--     WHERE t2.farmer_id = t.farmer_id
-- );
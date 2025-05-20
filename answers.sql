-- Question 1: Achieving 1NF (First Normal Form) 🛠
-- The original table violates 1NF due to multivalued field in 'Products'.
-- We break it down so that each row contains only one product.

-- Normalized to 1NF:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(100)
);

INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product) VALUES
(101, 'John Doe', 'Laptop'),
(101, 'John Doe', 'Mouse'),
(102, 'Jane Smith', 'Tablet'),
(102, 'Jane Smith', 'Keyboard'),
(102, 'Jane Smith', 'Mouse'),
(103, 'Emily Clark', 'Phone');

-- Question 2: Achieving 2NF (Second Normal Form) 
-- The table has partial dependency: CustomerName depends only on OrderID.
-- Split into two tables: Orders and OrderProducts.

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE OrderProducts (
    OrderID INT,
    Product VARCHAR(100),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

INSERT INTO OrderProducts (OrderID, Product) VALUES
(101, 'Laptop'),
(101, 'Mouse'),
(102, 'Tablet'),
(102, 'Keyboard'),
(102, 'Mouse'),
(103, 'Phone');

-- Question 3: Achieving 3NF (Third Normal Form) 
-- Assume we want to eliminate any potential transitive dependency in the future,
-- such as storing ProductName and ProductCategory together.
-- We separate Products into a new table.

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(100)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Example data population
INSERT INTO Products (ProductID, ProductName, Category) VALUES
(1, 'Laptop', 'Electronics'),
(2, 'Mouse', 'Electronics'),
(3, 'Tablet', 'Electronics'),
(4, 'Keyboard', 'Electronics'),
(5, 'Phone', 'Electronics');

INSERT INTO OrderDetails (OrderID, ProductID) VALUES
(101, 1),
(101, 2),
(102, 3),
(102, 4),
(102, 2),
(103, 5);

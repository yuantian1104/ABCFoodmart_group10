--Stores Table:
CREATE TABLE Stores (
    StoreID SERIAL PRIMARY KEY,
    StoreName VARCHAR(400) NOT NULL,
    StreetAddress VARCHAR(100) NOT NULL,
    City VARCHAR(80) NOT NULL,
    State VARCHAR(80) NOT NULL,
    Zipcode VARCHAR(10) NOT NULL,
    Rent NUMERIC(10,2)
);
--Employees Table:
CREATE TABLE Employees (
    EmployeeID SERIAL PRIMARY KEY,
    StoreID INT NOT NULL,
    Position VARCHAR(200) NOT NULL,
    Salary NUMERIC(10, 2),
    HireDate DATE,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID) ON DELETE CASCADE
);
--StoreManager Table:
CREATE TABLE StoreManager (
    ManagedStoreID INT,
    ManagerID INT,
    PRIMARY KEY (ManagedStoreID, ManagerID),
    FOREIGN KEY (ManagedStoreID) REFERENCES Stores(StoreID) ON DELETE CASCADE,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
--EmployeeSchedule Table:
CREATE TABLE EmployeeSchedule (
    ScheduleID SERIAL PRIMARY KEY,     
    EmployeeID INT NOT NULL,
    DayOfWeek VARCHAR(10) NOT NULL,
    ShiftStart TIME,
    ShiftEnd TIME,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
--EmployeeVacation Table:
CREATE TABLE EmployeeVacation (
    VacationID SERIAL NOT NULL,
    EmployeeID INT  NOT NULL,
    VacationStart DATE,
    VacationEnd DATE,
    PRIMARY KEY (VacationID, EmployeeID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);
--Categories Table: 
CREATE TABLE Categories (
   CategoryID SERIAL,
   CategoryName VARCHAR(100) NOT NULL,
   Description TEXT,
   PRIMARY KEY (CategoryID)
);
--Products Table:
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price NUMERIC(10, 2) NOT NULL,
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
--StoreInventory Table:
CREATE TABLE StoreInventory (
   StoreInventoryID SERIAL PRIMARY KEY,
   ProductID INT,
   StoreID INT,
   Quantity INT NOT NULL,
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE,
   FOREIGN KEY (StoreID) REFERENCES Stores(StoreID) ON DELETE CASCADE
);
--Expiration Table:
CREATE TABLE Expiration (
   BatchID SERIAL PRIMARY KEY,
   ProductID INT,
   ExpirationDate DATE,
   FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
); 
--Vendors Table:
CREATE TABLE Vendors (
    VendorID SERIAL PRIMARY KEY,
    VendorName VARCHAR(400) NOT NULL,
    ContactPhone VARCHAR(15),
    ContactEmail VARCHAR(100)
);
--VendorDelivery Table:
CREATE TABLE VendorDelivery (
    DeliveryID SERIAL PRIMARY KEY,
    VendorID INT NOT NULL,
    ProductID INT NOT NULL,
    QuantityReceived INT NOT NULL,
    DeliveryDate DATE,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--Customers Table:
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    ContactEmail VARCHAR(100),
    ContactPhone VARCHAR(15)
);
--RetailSales Table:
CREATE TABLE RetailSales (
    SaleID SERIAL PRIMARY KEY,
    ProductID INT NOT NULL,
    QuantitySold INT NOT NULL,
    SaleDate DATE,
    TotalPrice NUMERIC(10, 2) NOT NULL,
    StoreID INT,
    CustomerID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);
--WholesaleTransactions Table:
CREATE TABLE WholesaleTransactions (
    PurchaseID SERIAL PRIMARY KEY,
    VendorID INT NOT NULL,
    ProductID INT NOT NULL,
    QuantityPurchased INT NOT NULL,
    PurchaseDate DATE,
    PurchasePrice NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
--Discounts Table:
CREATE TABLE Discounts (
    DiscountID SERIAL PRIMARY KEY,
    PromotionPrice NUMERIC(10, 2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    ProductID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE
);
--CustomerFeedback Table:
CREATE TABLE CustomerFeedback (
    FeedbackID SERIAL PRIMARY KEY,
    CustomerID INT,
    FeedbackText TEXT NOT NULL,
    FeedbackDate DATE,
    StoreID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (StoreID) REFERENCES Stores(StoreID)
);

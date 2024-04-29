CREATE TABLE Stores (
    store_id SERIAL PRIMARY KEY,
    store_name VARCHAR(400) NOT NULL,
    store_street VARCHAR(100) NOT NULL,
    store_city VARCHAR(80) NOT NULL,
    store_state VARCHAR(80) NOT NULL,
    store_zipcode VARCHAR(10) NOT NULL,
    store_expense NUMERIC(10,2)
);

CREATE TABLE Employees (
    employee_id SERIAL PRIMARY KEY,
    store_id INT NOT NULL,
    Position VARCHAR(200) NOT NULL,
    salary NUMERIC(10, 2),
    date_of_hire DATE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE
);

CREATE TABLE StoreManager (
    manage_store_id INT,
    manager_id INT,
    PRIMARY KEY (manage_store_id, manager_id),
    FOREIGN KEY (manage_store_id) REFERENCES Stores(store_id) ON DELETE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE EmployeeSchedule (
    schedule_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    day_of_week VARCHAR(10) NOT NULL,
    shift_start TIME,
    shift_end TIME,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE EmployeeVacation (
    vacation_id SERIAL PRIMARY KEY,
    employee_id INT NOT NULL,
    vacation_start DATE,
    vacation_end DATE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id) ON DELETE CASCADE
);

CREATE TABLE Categories (
   category_id SERIAL PRIMARY KEY,
   category VARCHAR(100) NOT NULL,
   product_description TEXT
);

CREATE TABLE Products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE StoreInventory (
   store_inventory_id SERIAL PRIMARY KEY,
   product_id INT,
   store_id INT,
   Quantity INT NOT NULL,
   FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
   FOREIGN KEY (store_id) REFERENCES Stores(store_id) ON DELETE CASCADE
);

CREATE TABLE Expiration (
   batch_id SERIAL PRIMARY KEY,
   product_id INT,
   expiration_date DATE,
   FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE Vendor (
    vendor_id SERIAL PRIMARY KEY,
    vendor_name VARCHAR(400) NOT NULL,
    Contact_phone VARCHAR(15),
    vendor_email VARCHAR(100)
);

CREATE TABLE VendorDelivery (
    delivery_id SERIAL PRIMARY KEY,
    vendor_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_received INT NOT NULL,
    delivery_date DATE,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    customer_email VARCHAR(100),
    Contact_phone VARCHAR(15)
);

CREATE TABLE RetailSales (
    sale_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    sale_date DATE,
    total_price NUMERIC(10, 2) NOT NULL,
    store_id INT,
    customer_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

CREATE TABLE WholesaleTransactions (
    purchase_id SERIAL PRIMARY KEY,
    vendor_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity_received INT NOT NULL,
    delivery_date DATE,
    price NUMERIC(10, 2) NOT NULL,
    FOREIGN KEY (vendor_id) REFERENCES Vendor(vendor_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Discounts (
    discount_id SERIAL PRIMARY KEY,
    promotion_price NUMERIC(10, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE
);

CREATE TABLE CustomerFeedback (
    feedback_id SERIAL PRIMARY KEY,
    customer_id INT,
    feedback_text TEXT NOT NULL,
    feedback_date DATE,
    store_id INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);
    


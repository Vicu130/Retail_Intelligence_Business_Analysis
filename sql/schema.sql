CREATE DATABASE if NOT EXISTS retail_db;
Use retail_db;

Create table if not exists products(
    product_id INT PRIMARY KEY,
    product VARCHAR(100),
    category VARCHAR(100),
    subcategory VARCHAR(100),
    cost DECIMAL(10,2),
    price DECIMAL(10,2)
);

Create table if not exists customers(
    customer_id INT PRIMARY KEY,
    gender CHAR(1),
    age INT,
    city VARCHAR(100),
    signup_date DATE
);

Create table if not exists stores(
    store_id INT PRIMARY KEY,
    city VARCHAR(100),
    district VARCHAR(100),
    region VARCHAR(100)
);

Create table if not exists inventory(
    PRIMARY KEY(store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    store_id INT,
    product_id INT,
    stock_units INT,
    date DATE,
    reorder_level INT,
    stock_value DECIMAL(10,2)
);

Create table if not exists campaigns(
    campaign_id INT PRIMARY KEY,
    campaign_name VARCHAR(100),
    campaign_type VARCHAR(100),
    start_date DATE,
    end_date DATE,
    discount_rate DECIMAL(10,2)
);

Create table if not exists sales(
    sale_id INT PRIMARY KEY,
    date DATE,
    customer_id INT,
    product_id INT,
    store_id INT,
    campaign_id INT,
    quantity INT,
    discount DECIMAL(10,2),
    unit_price DECIMAL(10,2),
    revenue DECIMAL(10,2),
    cost_total DECIMAL(10,2),
    profit DECIMAL(10,2),
    FOREIGN KEY(customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY(product_id) REFERENCES products(product_id),
    FOREIGN KEY(store_id) REFERENCES stores(store_id),
    FOREIGN KEY(campaign_id) REFERENCES campaigns(campaign_id)
);

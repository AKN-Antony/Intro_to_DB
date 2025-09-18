#!/usr/bin/env python3

try:
    import mysql.connector
    from mysql.connector import Error
except ImportError:
    print("Error: mysql-connector-python module is not installed.")
    print("You can install it using: pip install mysql-connector-python")
    exit(1)

DB_NAME = "alx_book_store"

# Update credentials as needed
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "your_password_here"  # <-- Replace with your actual password
}


def create_database():
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute(f"CREATE DATABASE IF NOT EXISTS {DB_NAME}")
            print(f"Database '{DB_NAME}' created successfully.")
    except Error as e:
        print(f"Error while creating database: {e}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


def create_tables_and_insert_data():
    try:
        connection = mysql.connector.connect(database=DB_NAME, **DB_CONFIG)
        if connection.is_connected():
            cursor = connection.cursor()

            # Create Authors table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Authors (
                    author_id INT AUTO_INCREMENT PRIMARY KEY,
                    author_name VARCHAR(215) NOT NULL
                )
            """)

            # Create Books table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Books (
                    book_id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(130) NOT NULL,
                    author_id INT,
                    price DOUBLE,
                    publication_date DATE,
                    FOREIGN KEY (author_id) REFERENCES Authors(author_id)
                )
            """)

            # Create Customers table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Customers (
                    customer_id INT AUTO_INCREMENT PRIMARY KEY,
                    customer_name VARCHAR(215) NOT NULL,
                    email VARCHAR(215) NOT NULL,
                    address TEXT
                )
            """)

            # Create Orders table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Orders (
                    order_id INT AUTO_INCREMENT PRIMARY KEY,
                    customer_id INT,
                    order_date DATE,
                    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
                )
            """)

            # Create Order_Details table
            cursor.execute("""
                CREATE TABLE IF NOT EXISTS Order_Details (
                    orderdetailid INT AUTO_INCREMENT PRIMARY KEY,
                    order_id INT,
                    book_id INT,
                    quantity DOUBLE,
                    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                    FOREIGN KEY (book_id) REFERENCES Books(book_id)
                )
            """)

            print("Tables created successfully.")

            # Insert customer data
            cursor.executemany("""
                INSERT INTO Customers (customer_id, customer_name, email, address)
                VALUES (%s, %s, %s, %s)
            """, [
                (2, 'Blessing Malik', 'bmalik@sandtech.com', '124 Happiness  Ave.'),
                (3, 'Obed Ehoneah', 'eobed@sandtech.com', '125 Happiness  Ave.'),
                (4, 'Nehemial Kamolu', 'nkamolu@sandtech.com', '126 Happiness  Ave.')
            ])

            connection.commit()
            print("Customer data inserted successfully.")

    except Error as e:
        print(f"Error while creating tables or inserting data: {e}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


if __name__ == "__main__":
    create_database()
    create_tables_and_insert_data()

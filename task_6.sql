#!/usr/bin/env python3

import os
import mysql.connector
from mysql.connector import Error

DB_NAME = "alx_book_store"
DB_CONFIG = {
    "host": "localhost",
    "user": "root",
    "password": "your_password_here",  # <-- Replace with your actual MySQL password
    "database": DB_NAME
}

CUSTOMER_IDS_TO_CHECK = [2, 3, 4]
SQL_FILE = "task_6.sql"

    INSERT INTO Customers (customer_id, customer_name, email, address)
VALUES 
    (2, 'Blessing Malik', 'bmalik@sandtech.com', '124 Happiness  Ave.'),
    (3, 'Obed Ehoneah', 'eobed@sandtech.com', '125 Happiness  Ave.'),
    (4, 'Nehemial Kamolu', 'nkamolu@sandtech.com', '126 Happiness  Ave.');



def check_sql_file(file_path):
    print(f"Checking SQL file: {file_path}")
    if not os.path.exists(file_path):
        print("❌ task_6.sql does not exist.")
    elif os.path.getsize(file_path) == 0:
        print("❌ task_6.sql is empty.")
    else:
        print("✅ task_6.sql exists and is not empty.")


def check_customer_insertion(customer_ids):
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()
        for customer_id in customer_ids:
            cursor.execute("SELECT * FROM Customers WHERE customer_id = %s", (customer_id,))
            result = cursor.fetchone()
            if result:
                print(f"✅ Customer with customer_id = {customer_id} exists in the database.")
            else:
                print(f"❌ Customer with customer_id = {customer_id} NOT found in the database.")
    except Error as e:
        print(f"Error while checking customers: {e}")
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()


if __name__ == "__main__":
    check_sql_file(SQL_FILE)
    check_customer_insertion(CUSTOMER_IDS_TO_CHECK)

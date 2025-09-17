#!/usr/bin/env python3

try:
    import mysql.connector
    from mysql.connector import Error
except ImportError as e:
    print("Error: mysql-connector-python module is not installed.")
    print("You can install it using: pip install mysql-connector-python")
    exit(1)

def create_database():
    try:
        # Connect to MySQL server (adjust credentials as needed)
        connection = mysql.connector.connect(
            host='localhost',
            user='root',
            password='your_password_here'  # <-- Replace this with your actual MySQL password
        )

        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute("CREATE DATABASE IF NOT EXISTS alx_book_store")
            print("Database 'alx_book_store' created successfully!")

    except Error as e:
        print(f"Error while connecting to MySQL: {e}")

    finally:
        # Ensure cleanup of DB resources
        if 'cursor' in locals():
            cursor.close()
        if 'connection' in locals() and connection.is_connected():
            connection.close()

if __name__ == "__main__":
    create_database()

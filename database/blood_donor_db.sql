-- Blood Donor Management System - simple database
-- run this file in MySQL once

CREATE DATABASE IF NOT EXISTS blood_donor_db;
USE blood_donor_db;

DROP TABLE IF EXISTS requests;
DROP TABLE IF EXISTS blood_requests;
DROP TABLE IF EXISTS donation_history;
DROP TABLE IF EXISTS donors;
DROP TABLE IF EXISTS admins;

CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL
);

CREATE TABLE donors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    phone VARCHAR(20),
    blood_group VARCHAR(5),
    city VARCHAR(100),
    available VARCHAR(3) DEFAULT 'YES',
    verified INT DEFAULT 0
);

CREATE TABLE requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    patient VARCHAR(100),
    blood_group VARCHAR(5),
    hospital VARCHAR(100),
    city VARCHAR(100),
    status VARCHAR(20) DEFAULT 'PENDING'
);

-- admin login
INSERT INTO admins (username, password) VALUES ('admin', 'admin123');

-- some sample donors
INSERT INTO donors (name, email, password, phone, blood_group, city, available, verified) VALUES
('Rahul Sharma', 'rahul@gmail.com', '123456', '9876543210', 'O+', 'Chennai', 'YES', 1),
('Priya Patel', 'priya@gmail.com', '123456', '9876543211', 'A+', 'Bangalore', 'YES', 1),
('Arjun Reddy', 'arjun@gmail.com', '123456', '9876543212', 'B+', 'Hyderabad', 'NO', 0),
('Sneha Menon', 'sneha@gmail.com', '123456', '9876543213', 'AB+', 'Mumbai', 'YES', 1);

-- some sample requests
INSERT INTO requests (patient, blood_group, hospital, city, status) VALUES
('Ramesh Kumar', 'O+', 'Apollo Hospital', 'Chennai', 'PENDING'),
('Anita Das', 'A+', 'City Hospital', 'Bangalore', 'APPROVED'),
('Vijay Singh', 'B+', 'Care Hospital', 'Hyderabad', 'PENDING');

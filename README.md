# Blood Donor Management System

This is a small Java web project for a college assignment. It is made with JSP,
Servlets, JDBC and MySQL. It runs on Apache Tomcat.

## What it does

- A donor can register and login.
- In the donor dashboard the donor can change if he/she is available to donate.
- The admin can login and see all donors and all blood requests.
- The admin can verify or delete a donor.

## What you need

1. Java JDK 17 or above
2. MySQL 8
3. Apache Tomcat 10 or 11

## How to run

1. Open MySQL and run the file `database/blood_donor_db.sql`.
   It will create the database and add some sample data.

2. Check the MySQL password in `src/main/java/com/bdms/DB.java` and change it
   if your root password is different.

3. Build the project. Open cmd in the project folder and run:

   build.bat

4. Copy `target\blood-donor-system.war` to the `webapps` folder of Tomcat.

5. Start Tomcat with `bin\startup.bat` and open:

   http://localhost:8080/blood-donor-system/

## Logins (sample data)

- Donor: rahul@gmail.com / 123456
- Admin: admin / admin123

## Note

The passwords are saved in plain text because this is only a small college
project. For a real website they must be encrypted.

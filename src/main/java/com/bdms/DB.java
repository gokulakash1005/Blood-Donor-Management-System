package com.bdms;

import java.sql.Connection;
import java.sql.DriverManager;

// this class only gives us a database connection
public class DB {

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");

        // change the password here if your MySQL password is different
        String url = "jdbc:mysql://localhost:3306/blood_donor_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
        String user = "root";
        String pass = "Asdfg@49";

        return DriverManager.getConnection(url, user, pass);
    }
}

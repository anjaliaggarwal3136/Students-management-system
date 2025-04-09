package com.example;

import java.sql.*;

public class DBConnection {
    public static Connection connect() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/studentsystem_db", "root", "Suraj@2002"
            );
        } catch (Exception e) {
            System.out.println("DB Connection Error: " + e.getMessage());
        }
        return conn;
    }
}
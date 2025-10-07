package com.expense.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String URL = "jdbc:mysql://localhost:3306/expensetracker?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";        // change if needed
    private static final String PASS = "1249"; // change to your password

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // safe to call
        } catch (ClassNotFoundException e) {
            // driver missing from WEB-INF/lib
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASS);
    }
}

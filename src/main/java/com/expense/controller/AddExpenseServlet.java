package com.expense.controller;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.expense.util.DBConnection;

public class AddExpenseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String date = request.getParameter("date");
        String category = request.getParameter("category");
        String amountStr = request.getParameter("amount");
        String description = request.getParameter("description");

        double amount = Double.parseDouble(amountStr);

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO expenses (date, category, amount, description) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, category);
            ps.setDouble(3, amount);
            ps.setString(4, description);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new ServletException("DB error in AddExpenseServlet", e);
        }

        request.setAttribute("message", "Expense added successfully!");
        request.getRequestDispatcher("addExpense.jsp").forward(request, response);
    }
}




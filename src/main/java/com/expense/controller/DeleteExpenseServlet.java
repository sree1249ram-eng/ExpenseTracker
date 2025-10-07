package com.expense.controller;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.expense.util.DBConnection;

public class DeleteExpenseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM expenses WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ps.executeUpdate();
        } catch (Exception e) {
            throw new ServletException("Error deleting expense", e);
        }

        response.sendRedirect("viewExpenses");
    }
}



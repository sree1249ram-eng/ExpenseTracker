package com.expense.controller;

import java.io.*;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.expense.util.DBConnection;

public class EditExpenseServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM expenses WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, Integer.parseInt(id));
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                request.setAttribute("id", rs.getInt("id"));
                request.setAttribute("date", rs.getString("date"));
                request.setAttribute("category", rs.getString("category"));
                request.setAttribute("amount", rs.getDouble("amount"));
                request.setAttribute("description", rs.getString("description"));
            }
        } catch (Exception e) {
            throw new ServletException("Error loading expense for edit", e);
        }

        request.getRequestDispatcher("editExpense.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String date = request.getParameter("date");
        String category = request.getParameter("category");
        String amount = request.getParameter("amount");
        String description = request.getParameter("description");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE expenses SET date=?, category=?, amount=?, description=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, date);
            ps.setString(2, category);
            ps.setDouble(3, Double.parseDouble(amount));
            ps.setString(4, description);
            ps.setInt(5, Integer.parseInt(id));

            ps.executeUpdate();
        } catch (Exception e) {
            throw new ServletException("Error updating expense", e);
        }

        response.sendRedirect("viewExpenses");
    }
}

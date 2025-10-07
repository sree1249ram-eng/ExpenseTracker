package com.expense.controller;

import com.expense.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ViewExpensesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Read parameters
        String sortOrderParam = request.getParameter("sortOrder"); // standardized name
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        // Validate sort order: only ASC or DESC allowed; default = DESC (newest first)
        String sortOrder = "DESC";
        if ("ASC".equalsIgnoreCase(sortOrderParam)) sortOrder = "ASC";
        else if ("DESC".equalsIgnoreCase(sortOrderParam)) sortOrder = "DESC";

        int month = 0;
        int year = 0;
        try {
            if (monthParam != null && !monthParam.trim().isEmpty()) month = Integer.parseInt(monthParam);
            if (yearParam != null && !yearParam.trim().isEmpty()) year = Integer.parseInt(yearParam);
        } catch (NumberFormatException ignored) {
            month = 0;
            year = 0;
        }

        List<String[]> expenses = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        String sql = "SELECT id, date, category, amount, description FROM expenses " +
                     "WHERE (MONTH(date) = ? OR ? = 0) AND (YEAR(date) = ? OR ? = 0) " +
                     "ORDER BY date " + sortOrder;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (conn == null) {
                throw new ServletException("DB connection is null - check DBConnection settings.");
            }

            ps.setInt(1, month);
            ps.setInt(2, month);
            ps.setInt(3, year);
            ps.setInt(4, year);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String[] e = new String[5];
                    e[0] = String.valueOf(rs.getInt("id"));
                    Date d = rs.getDate("date");
                    e[1] = (d != null) ? d.toString() : "";
                    e[2] = rs.getString("category");
                    BigDecimal amt = rs.getBigDecimal("amount");
                    e[3] = (amt != null) ? amt.toPlainString() : "0.00";
                    e[4] = rs.getString("description");
                    expenses.add(e);

                    if (amt != null) total = total.add(amt);
                }
            }
        } catch (SQLException e) {
            throw new ServletException("Error fetching expenses", e);
        }

        // pass attributes to JSP
        request.setAttribute("expenses", expenses);
        request.setAttribute("total", String.format("%.2f", total.doubleValue()));
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("selectedMonth", month);
        request.setAttribute("selectedYear", year);

        request.getRequestDispatcher("/viewExpenses.jsp").forward(request, response);
    }
}


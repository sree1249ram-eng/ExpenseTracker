<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>View Expenses</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        /* Soft gentle gradient background chosen for readability */
        body {
            background: linear-gradient(135deg, #f3f8ff 0%, #eefaf3 100%);
            min-height: 100vh;
        }
        .card-custom {
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(14, 30, 37, 0.08);
        }
        .controls .form-control, .controls .btn {
            min-height: 44px;
        }
        .total-centered {
            text-align: center;
            font-weight: 700;
            font-size: 1.15rem;
            margin-top: 18px;
        }
    </style>
</head>
<body>
<div class="container py-5">

    <div class="text-center mb-4">
        <h1 class="fw-bold">Expense Tracker</h1>
        <p class="text-muted">Sort & filter your expenses, then edit or delete rows as needed</p>
    </div>

    <!-- Controls: Sort (keeps month/year) -->
    <div class="card card-custom mb-3 p-3 controls">
        <form method="get" action="viewExpenses" class="row g-2 align-items-center">
            <% 
                List<String[]> expenses = (List<String[]>) request.getAttribute("expenses");
                String sortOrder = (String) request.getAttribute("sortOrder");
                if (sortOrder == null) sortOrder = "DESC";
                Integer selectedMonth = (Integer) request.getAttribute("selectedMonth");
                if (selectedMonth == null) selectedMonth = 0;
                Integer selectedYear = (Integer) request.getAttribute("selectedYear");
                if (selectedYear == null) selectedYear = 0;
            %>

            <!-- preserve month/year when sorting -->
            <input type="hidden" name="month" value="<%= selectedMonth %>"/>
            <input type="hidden" name="year" value="<%= selectedYear %>"/>

            <div class="col-auto">
                <label class="form-label mb-0">Sort by date</label>
                <select class="form-select" name="sortOrder" aria-label="sort">
                    <option value="DESC" <%= "DESC".equals(sortOrder) ? "selected" : "" %>>Newest first</option>
                    <option value="ASC" <%= "ASC".equals(sortOrder) ? "selected" : "" %>>Oldest first</option>
                </select>
            </div>

            <div class="col-auto">
                <label class="form-label mb-0 invisible">.</label>
                <button type="submit" class="btn btn-primary">Apply Sort</button>
            </div>

            <div class="col-auto ms-auto">
                <a href="addExpense.jsp" class="btn btn-success">➕ Add Expense</a>
            </div>
        </form>
    </div>

    <!-- Controls: Month/Year filter (keeps sortOrder) -->
    <div class="card card-custom mb-4 p-3 controls">
        <form method="get" action="viewExpenses" class="row g-2 align-items-center">
            <!-- preserve sort when filtering -->
            <input type="hidden" name="sortOrder" value="<%= sortOrder %>"/>

            <div class="col-sm-3">
                <label class="form-label mb-0">Month (1-12)</label>
                <input class="form-control" type="number" name="month" min="1" max="12"
                       value="<%= (selectedMonth != 0) ? selectedMonth : "" %>" placeholder="MM"/>
            </div>

            <div class="col-sm-3">
                <label class="form-label mb-0">Year</label>
                <input class="form-control" type="number" name="year" min="2000" max="2100"
                       value="<%= (selectedYear != 0) ? selectedYear : "" %>" placeholder="YYYY"/>
            </div>

            <div class="col-sm-3 d-flex align-items-end">
                <button type="submit" class="btn btn-primary w-100">Show Monthly Expense</button>
            </div>

            <div class="col-sm-3 d-flex align-items-end">
                <a href="viewExpenses" class="btn btn-outline-secondary w-100">Reset</a>
            </div>
        </form>
    </div>

    <!-- Table card -->
    <div class="card card-custom p-0">
        <div class="table-responsive">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr>
                    <th style="width:120px">Date</th>
                    <th>Category</th>
                    <th style="width:140px">Amount (₹)</th>
                    <th>Description</th>
                    <th style="width:150px">Actions</th>
                </tr>
                </thead>
                <tbody>
                <%
                    if (expenses != null && !expenses.isEmpty()) {
                        for (String[] e : expenses) {
                %>
                <tr>
                    <td><%= e[1] %></td>
                    <td><%= e[2] %></td>
                    <td>₹ <%= e[3] %></td>
                    <td><%= e[4] %></td>
                    <td>
                        <a class="btn btn-sm btn-warning" href="editExpense?id=<%= e[0] %>">Edit</a>
                        <a class="btn btn-sm btn-danger" href="deleteExpense?id=<%= e[0] %>"
                           onclick="return confirm('Delete this expense?');">Delete</a>
                    </td>
                </tr>
                <%      }
                    } else { %>
                <tr>
                    <td colspan="5" class="text-center p-4 text-muted">No expenses found.</td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Total centered -->
    <div class="total-centered">
        Total: ₹ <%= request.getAttribute("total") != null ? request.getAttribute("total") : "0.00" %>
    </div>

    <div class="text-center mt-4">
        <a href="index.jsp" class="btn btn-link">⬅ Back to Home</a>
    </div>
</div>
</body>
</html>




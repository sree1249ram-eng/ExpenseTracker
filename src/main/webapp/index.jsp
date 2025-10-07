<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Expense Tracker - Home</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body { background: linear-gradient(135deg,#f3f8ff 0%, #eefaf3 100%); min-height:100vh; }
        .card-custom { border-radius:12px; box-shadow: 0 6px 18px rgba(14,30,37,0.08); }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="card card-custom p-4 text-center">
        <h1 class="mb-3">💰 Expense Tracker</h1>
        <p class="text-muted mb-4">Quick add and review your expenses</p>
        <div class="d-grid gap-2 col-6 mx-auto">
            <a href="addExpense.jsp" class="btn btn-success btn-lg">➕ Add Expense</a>
            <a href="viewExpenses" class="btn btn-primary btn-lg">📊 View Expenses</a>
        </div>
    </div>
</div>
</body>
</html>

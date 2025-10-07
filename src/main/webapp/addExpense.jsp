<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>Add Expense</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <style>
        body { background: linear-gradient(135deg,#f3f8ff 0%, #eefaf3 100%); min-height:100vh; }
        .card-custom { border-radius:12px; box-shadow: 0 6px 18px rgba(14,30,37,0.08); }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="card card-custom p-4 mx-auto" style="max-width:720px;">
        <h2 class="mb-3">➕ Add Expense</h2>

        <form action="addExpense" method="post">
            <div class="mb-3">
                <label class="form-label">Date</label>
                <input type="date" name="date" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Category</label>
                <input type="text" name="category" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Amount</label>
                <input type="number" step="0.01" name="amount" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">Description</label>
                <textarea name="description" class="form-control"></textarea>
            </div>

            <div class="d-flex gap-2">
                <button type="submit" class="btn btn-success">Add Expense</button>
                <a href="viewExpenses" class="btn btn-secondary">View All</a>
                <a href="index.jsp" class="btn btn-link ms-auto">Home</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>

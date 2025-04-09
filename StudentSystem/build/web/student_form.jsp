<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Form</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
    <h2>Student Registration</h2>
    <form action="StudentServlet" method="post">
        <label for="uid">UID:</label>
        <input type="text" name="uid" required>

        <label for="name">Name:</label>
        <input type="text" name="name" required>

        <label for="className">Class:</label>
        <input type="text" name="className" required>

        <label for="section">Section:</label>
        <input type="text" name="section" required>

        <label for="mobile">Mobile:</label>
        <input type="text" name="mobile" required>

        <button type="submit">Add Student</button>
    </form>

    <form action="StudentServlet" method="get" style="margin-top: 10px;">
        <button type="submit">View All Registered Students</button>
    </form>

    <p style="color: green;"><%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %></p>
</div>
</body>
</html>

<%@ page import="java.sql.*, java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registered Students</title>
    <style>
        body {
            font-family: Arial;
            background: linear-gradient(to right, #83a4d4, #b6fbff);
            padding: 40px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        th, td {
            padding: 15px;
            border: 1px solid #eee;
            text-align: center;
        }
        th {
            background-color: #2193b0;
            color: white;
        }
        a.btn {
            text-decoration: none;
            padding: 5px 10px;
            border-radius: 5px;
            color: white;
            background-color: #2193b0;
        }
        a.btn.delete {
            background-color: #e74c3c;
        }
    </style>
</head>
<body>
<h2>All Registered Students</h2>
<table>
    <tr>
        <th>UID</th>
        <th>Name</th>
        <th>Class</th>
        <th>Section</th>
        <th>Mobile</th>
        <th>Actions</th>
    </tr>

    <%
        try {
            Connection conn = com.example.DBConnection.connect();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM students");
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("uid") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("class") %></td>
        <td><%= rs.getString("section") %></td>
        <td><%= rs.getString("mobile") %></td>
        <td>
            <a class="btn" href="edit_student.jsp?uid=<%= rs.getString("uid") %>">Edit</a>
            <form action="StudentServlet" method="post" style="display:inline;">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="uid" value="<%= rs.getString("uid") %>">
                <button type="submit" class="btn delete" onclick="return confirm('Delete this student?')">Delete</button>
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        }
    %>
</table>
<br>
<a href="student_form.jsp">Back to Form</a>
</body>
</html>

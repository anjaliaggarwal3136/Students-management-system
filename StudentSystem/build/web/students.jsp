<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registered Students</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #43cea2, #185a9d);
            color: #fff;
            padding: 40px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #ffffff;
            color: #000;
            margin-top: 20px;
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border-bottom: 1px solid #ccc;
        }

        th {
            background-color: #2193b0;
            color: #fff;
        }

        h2 {
            text-align: center;
        }

        a.button {
            background-color: #2193b0;
            padding: 10px 15px;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }

        form {
            display: inline;
        }
    </style>
</head>
<body>
    <h2>All Registered Students</h2>
    <a class="button" href="student_form.jsp">Back to Form</a>
    <br/><br/>

    <%
        java.util.ArrayList<String[]> students = (java.util.ArrayList<String[]>) request.getAttribute("students");
        if (students != null && students.size() > 0) {
    %>
        <table>
            <tr>
                <th>UID</th>
                <th>Name</th>
                <th>Class</th>
                <th>Section</th>
                <th>Mobile</th>
                <th>Actions</th>
            </tr>
            <% for (String[] student : students) { %>
                <tr>
                    <td><%= student[0] %></td>
                    <td><%= student[1] %></td>
                    <td><%= student[2] %></td>
                    <td><%= student[3] %></td>
                    <td><%= student[4] %></td>
                    <td>
                        <form action="StudentServlet" method="post" style="display:inline;">
                            <input type="hidden" name="uid" value="<%= student[0] %>">
                            <input type="hidden" name="action" value="delete">
                            <button type="submit">Delete</button>
                        </form>

                        <form action="student_form.jsp" method="get" style="display:inline;">
                            <input type="hidden" name="uid" value="<%= student[0] %>">
                            <input type="hidden" name="name" value="<%= student[1] %>">
                            <input type="hidden" name="className" value="<%= student[2] %>">
                            <input type="hidden" name="section" value="<%= student[3] %>">
                            <input type="hidden" name="mobile" value="<%= student[4] %>">
                            <button type="submit">Edit</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </table>
    <% } else { %>
        <p>No students registered yet.</p>
    <% } %>
</body>
</html>

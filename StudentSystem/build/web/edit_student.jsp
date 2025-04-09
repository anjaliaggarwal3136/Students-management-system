<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String uid = request.getParameter("uid");
    String name = "", className = "", section = "", mobile = "";

    try {
        Connection conn = com.example.DBConnection.connect();
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM students WHERE uid = ?");
        ps.setString(1, uid);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            className = rs.getString("class");
            section = rs.getString("section");
            mobile = rs.getString("mobile");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
<html>
<head>
    <title>Edit Student</title>
</head>
<body>
<h2>Edit Student</h2>
<form action="StudentServlet" method="post">
    <input type="hidden" name="action" value="update">
    <label>UID:</label>
    <input type="text" name="uid" value="<%= uid %>" readonly><br><br>
    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required><br><br>
    <label>Class:</label>
    <input type="text" name="className" value="<%= className %>" required><br><br>
    <label>Section:</label>
    <input type="text" name="section" value="<%= section %>" required><br><br>
    <label>Mobile:</label>
    <input type="text" name="mobile" value="<%= mobile %>" required><br><br>
    <button type="submit">Update</button>
</form>
</body>
</html>

package com.example;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class StudentServlet extends HttpServlet {

    // Handle GET - Show all registered students
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.connect()) {
            ArrayList<String[]> studentList = new ArrayList<>();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM students");

            while (rs.next()) {
                String[] row = {
                        rs.getString("uid"),
                        rs.getString("name"),
                        rs.getString("class"),
                        rs.getString("section"),
                        rs.getString("mobile")
                };
                studentList.add(row);
            }

            request.setAttribute("students", studentList);
            RequestDispatcher rd = request.getRequestDispatcher("students.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("student_form.jsp").forward(request, response);
        }
    }

    // Handle POST - Add, Update, Delete
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String uid = request.getParameter("uid");
        String name = request.getParameter("name");
        String className = request.getParameter("className");
        String section = request.getParameter("section");
        String mobile = request.getParameter("mobile");

        // Input validation
        if (name != null && !name.matches("[a-zA-Z ]+")) {
            request.setAttribute("message", "Name must contain only alphabets!");
            request.getRequestDispatcher("student_form.jsp").forward(request, response);
            return;
        }

        if (section != null && !section.matches("[ABCabc]")) {
            request.setAttribute("message", "Section must be A, B, or C!");
            request.getRequestDispatcher("student_form.jsp").forward(request, response);
            return;
        }

        if (mobile != null && !mobile.matches("\\d{10}")) {
            request.setAttribute("message", "Mobile number must be 10 digits!");
            request.getRequestDispatcher("student_form.jsp").forward(request, response);
            return;
        }

        try (Connection conn = DBConnection.connect()) {

            if ("delete".equals(action)) {
                PreparedStatement ps = conn.prepareStatement("DELETE FROM students WHERE uid = ?");
                ps.setString(1, uid);
                ps.executeUpdate();
                request.setAttribute("message", "Student deleted successfully!");

            } else if ("update".equals(action)) {
                PreparedStatement ps = conn.prepareStatement(
                        "UPDATE students SET name=?, class=?, section=?, mobile=? WHERE uid=?");
                ps.setString(1, name);
                ps.setString(2, className);
                ps.setString(3, section);
                ps.setString(4, mobile);
                ps.setString(5, uid);
                ps.executeUpdate();
                request.setAttribute("message", "Student updated successfully!");

            } else { // Add student (default)
                // Check for duplicate UID
                PreparedStatement checkStmt = conn.prepareStatement("SELECT * FROM students WHERE uid = ?");
                checkStmt.setString(1, uid);
                ResultSet rsCheck = checkStmt.executeQuery();
                if (rsCheck.next()) {
                    request.setAttribute("message", "Student already exists!");
                } else {
                    PreparedStatement ps = conn.prepareStatement(
                            "INSERT INTO students (uid, name, class, section, mobile) VALUES (?, ?, ?, ?, ?)");
                    ps.setString(1, uid);
                    ps.setString(2, name);
                    ps.setString(3, className);
                    ps.setString(4, section);
                    ps.setString(5, mobile);
                    ps.executeUpdate();
                    request.setAttribute("message", "Student added successfully!");
                }
            }

            // Forward back to form
            RequestDispatcher rd = request.getRequestDispatcher("student_form.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            request.getRequestDispatcher("student_form.jsp").forward(request, response);
        }
    }
}

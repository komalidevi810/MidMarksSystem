<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mid Marks</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: url('bg.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        .container {
            width: 400px;
            margin: 100px auto;
            padding: 30px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(8px);
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0,0,0,0.3);
            color: #fff;
        }

        .title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #fff;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 18px;
        }

        table, td, th {
            border: 1px solid #ddd;
            padding: 10px;
        }

        th {
            background-color: rgba(255, 255, 255, 0.2);
            color: #fff;
        }

        td {
            background-color: rgba(255, 255, 255, 0.1);
            color: #fff;
        }

    </style>
</head>
<body>
    <div class="container">
        <div class="title">Mid Marks</div>
        <table>
            <tr>
                <th>S_No</th>
                <th>Subject Code</th>
                <th>Marks</th>
            </tr>
<%@page import="java.sql.*"%>
<%
String driver = "com.mysql.cj.jdbc.Driver";
String connectionUrl = "jdbc:mysql://localhost:3306/examresults?useSSL=false";
String userid = "root";
String password = "@A881028k";

Connection connection = null;
PreparedStatement statement = null;
ResultSet resultSet = null;

String pinNumber = request.getParameter("PinNumber");
String year = request.getParameter("Year");
String semester = request.getParameter("Semester");
String mid = request.getParameter("Mid");

try {
    Class.forName(driver);
    connection = DriverManager.getConnection(connectionUrl, userid, password);

    String sql = "SELECT Subject, Marks FROM Marks WHERE PinNumber = ? AND Year = ? AND Semester = ? AND Mid = ? ORDER BY Year ASC, Semester ASC, Mid ASC";
    statement = connection.prepareStatement(sql);
    statement.setString(1, pinNumber);
    statement.setString(2, year);
    statement.setString(3, semester);
    statement.setString(4, mid);

    resultSet = statement.executeQuery();

    int i = 1;
    while (resultSet.next()) {
%>
            <tr>
                <td><%= i++ %></td>
                <td><%= resultSet.getString("Subject") %></td>
                <td><%= resultSet.getInt("Marks") %></td>
            </tr>
<%
    }
} catch (Exception e) {
    out.println("<p style='color:red; text-align:center;'>Error occurred: " + e.getMessage() + "</p>");
    e.printStackTrace();
} finally {
    try { if (resultSet != null) resultSet.close(); } catch (Exception e) {}
    try { if (statement != null) statement.close(); } catch (Exception e) {}
    try { if (connection != null) connection.close(); } catch (Exception e) {}
}
%>
        </table>
    </div>
</body>
</html>

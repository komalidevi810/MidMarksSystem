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
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mid Marks</title>
    <style>
        table, td {
            padding: 10px;
            margin: 50px auto;
            font-size: 20px;
            background-color: #ECC9EE;
        }
        b, u {
            font-size: 24px;
            padding-left: 300px;
            color: #643A6B;
        }
    </style>
</head>
<body style="background-color:#D4ADFC;">
    <b><u>Mid Marks</u></b>
    <table border="5" bordercolor="#A9907E" style="color:#8B1874;">
        <tr style="color:#1D267D;">
            <td><i>S_No</i></td>
            <td><i>Subject Code</i></td>
            <td><i>Marks</i></td>
        </tr>
<%
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
</body>
</html>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="auth.jsp"%>


<% // Credits to ZingChart for the chart template
%>

<!DOCTYPE html>
<html>
<head>
    <title>Sales Report of Ramon Emporium</title>
    <script type="text/javascript" src="https://cdn.zingchart.com/zingchart.min.js"></script>
</head>
<body>
    <script>
        <%
            // Make connection
            String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
            String uid = "SA";
            String pw = "YourStrong@Passw0rd";
            Connection con = DriverManager.getConnection(url, uid, pw);

            // --- Create two Java Arrays
            ArrayList<String> date = new ArrayList<>();
            ArrayList<Double> totalSales = new ArrayList<>();

            String sql = "SELECT CONVERT(date,orderDate), sum(totalAmount) FROM ordersummary GROUP BY CONVERT(date, orderDate) ";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rst = pstmt.executeQuery();
            while(rst.next()) {
                date.add(rst.getDate(1) + "");
                totalSales.add(rst.getDouble(2));
            }
        %>

       // --- add a comma after each value in the array and convert to javascript string representing an array
        var date = [<%= join(date, ",") %>];
        var totalSales = [<%= join(totalSales, ",") %>];

        window.onload = function() {
            zingchart.render({
                id: "myChart",
                width: "100%",
                height: 400,
                data: {
                "type": "bar",
                "title": {
                    "text": "Sales per Day"
                },
                "scale-x": {
                    "labels": date
                },
                "plot": {
                    "line-width": 1
                },
                "series": [{
                    "values": totalSales
                }]
                }
            });
        };
    </script>

    <h1> Sales Report of Ramon Emporium</h1>
    <div id="myChart"></div>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <font face="Century Gothic" size="5">
    Return to previous page by clicking this <a href="admin.jsp">link</a></h2>
    </font>


</body>
</html>

<%!
    // --- String Join Function converts from Java array to javascript string.
    public String join(ArrayList<?> arr, String del)
    {

        StringBuilder output = new StringBuilder();

        for (int i = 0; i < arr.size(); i++)
        {

            if (i > 0) output.append(del);

              // --- Quote strings, only, for JS syntax
              if (arr.get(i) instanceof String) output.append("\"");
              output.append(arr.get(i));
              if (arr.get(i) instanceof String) output.append("\"");
        }

        return output.toString();
    }
%>

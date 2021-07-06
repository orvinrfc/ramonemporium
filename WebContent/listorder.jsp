<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
<title>The Ramon Emporium - Order List</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp" %>
<h3>Order List</h3>

<font face="Century Gothic" size=3>
	<table class="table" border="1">
		<tbody>
			<tr>
				<th>Order ID</th>
				<th>Order Date</th>
				<th>Customer ID</th>
				<th>Customer Name</th>
				<th>Total $ Amount</th>
			</tr>



<%
//Note: Forces loading of SQL Server driver
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

try {	// Load driver class
	Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
}
catch (java.lang.ClassNotFoundException e) {
	out.println("ClassNotFoundException: " +e);
}

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);  // Prints $5.00

// Make connection
Connection con = DriverManager.getConnection(url, uid, pw);

// Write query to retrieve all order summary records
Statement stmt = con.createStatement();
ResultSet rst = stmt.executeQuery("SELECT orderId, orderDate, customer.customerId, firstName, lastName, totalAmount FROM ordersummary JOIN customer ON ordersummary.customerId = customer.customerId");

// For each order in the ResultSet
while(rst.next()) {
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
	// Print out the order summary information
	%>
		<tr>
			<td class="col-md-1"><b><%=rst.getInt("orderId")%></b></td>
			<td><%=rst.getDate("orderDate") + " " + rst.getTime("orderDate")%></td>
			<td><%=rst.getInt("customerId")%></td>
			<td><%=rst.getString("firstName") + " " + rst.getString("lastName")%></td>
			<td><%=currFormat.format(rst.getDouble("totalAmount"))%></td>
		</tr>
	<%
	// Write a query to retrieve the products in the order
	Statement stmt2 = con.createStatement();
	ResultSet rst2 = stmt2.executeQuery("SELECT productId, quantity, price FROM orderproduct WHERE orderId = " + rst.getInt("orderId"));
	%>
	<tr align="right">
		<td colspan="5">
			<table class="table" border="1">
				<tbody>
					<tr>
						<th>Product ID</th>
						<th>Quantity</th>
						<th>Price</th>
					</tr>
	<%
					while(rst2.next()) {
	%>
					<tr>
						<td><%=rst2.getInt("productId")%></td>
						<td><%=rst2.getInt("quantity")%></td>
						<td><%=currFormat.format(rst2.getDouble("price"))%></td>
					</tr>
	<%
	}
	%>
				</tbody>
			</table>
		</td>
	</tr>
	<%
}
// Close connection
con.close();
%>

	</tbody>
</table>
</font>

</body>
</html>

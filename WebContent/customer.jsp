<!DOCTYPE html>
<html>
<head>
<title>The Ramon Emporium - Customer Account Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="auth.jsp"%>
<%@ page import="java.text.NumberFormat" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<%
	String userName = (String) session.getAttribute("authenticatedUser");
%>

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


// Retrieves customer ID from username
String sql1 = "SELECT customerId FROM customer WHERE userId = ?";
PreparedStatement pstmt1 = con.prepareStatement(sql1);
pstmt1.setString(1,userName);
ResultSet rst1 = pstmt1.executeQuery();

int custId =0;
while(rst1.next()){
custId = rst1.getInt("customerId");
}

%>
<%
// TODO: Print Customer information

String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid FROM customer WHERE customerId = ? ";

PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,custId );
ResultSet rst = pstmt.executeQuery();

// Prints customer information in formatted table

%>
<h3 align = "center" >Customer Information</h3>
<font face="Century Gothic" size="3">
<table class="table" border = "1">
	<tr align = "right">
		<%
		while(rst.next()){
		%>
		<tr>
			<th>Customer Id</th>
			<td><%=custId%></td>

		</tr>
		<tr>

			<th>First Name</th>
			<td><%=rst.getString("firstName")%></td>

		</tr>
		<tr>
			<th>Last Name</th>
			<td><%=rst.getString("lastName")%></td>
		</tr>
		<tr>
			<th>Email</th>
			<td><%=rst.getString("email")%></td>
		</tr>
		<tr>
			<th>Phone Number</th>
			<td><%=rst.getString("phonenum")%></td>
		</tr>
		<tr>
			<th>Address</th>
			<td><%=rst.getString("address")%></td>
		</tr>
		<tr>
			<th>City</th>
			<td><%=rst.getString("city")%></td>
		</tr>
		<tr>
			<th>State</th>
			<td><%=rst.getString("state")%></td>

		</tr>
		<tr>
			<th>Postal Code</th>
			<td><%=rst.getString("postalCode")%></td>
		</tr>
		<tr>
			<th>Country</th>
			<td><%=rst.getString("country")%></td>
		</tr>
		<tr>
			<th >User ID</th>
			<td><%=rst.getString("userId")%></td>
		</tr>
		<%
		}
		%>
	</tr>
</table>
</font>

<h3 align="center">Change User Information</h3>

<hr>
<div class="text-center">
	<form method="changeInfo" action="changeUserInfo.jsp">
		<input type="hidden" name="custId" value=<%=custId%>>
		<p align="left">
			<h4>Change First Name:</h4>
			<input type="text" name="changeFirstName" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change Last Name:</h4>
			<input type="text" name="changeLastName" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change Email:</h4>
			<input type="text" name="changeEmail" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change Phone Number:</h4>
			<input type="text" name="changePhoneNumber" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change Address:</h4>
			<input type="text" name="changeAddress" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change City:</h4>
			<input type="text" name="changeCity" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change State:</h4>
			<input type="text" name="changeState" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change Postal Code:</h4>
			<input type="text" name="changePostalCode" size="50">
			<hr>
		</p>
		<p align="left">
			<h4>Change Country:</h4>
			<input type="text" name="changeCountry" size="50">
		</p>
		<input type="submit" value="Submit"><input type="reset" value="Reset">
	</form>
</div>

</body>
</html>

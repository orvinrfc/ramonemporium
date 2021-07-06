<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<!DOCTYPE html>
<html>
<head>
	<title>The Ramon Emporium - Products</title>
	<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
	<%@ include file="header.jsp" %>
	<% boolean auth = session.getAttribute("authenticatedUser") == null ? false : true; %>
	<%
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";
	try {	// Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	}
	catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " +e);
	}
	Connection con = DriverManager.getConnection(url, uid, pw);
	NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
	String bestProductsSQL = "SELECT productId, SUM(quantity) FROM orderproduct GROUP BY productId ORDER BY SUM(quantity) DESC";
	PreparedStatement bestProduct = con.prepareStatement(bestProductsSQL);

	ResultSet findBestProducts = bestProduct.executeQuery();
	%>
	<%if (findBestProducts.isBeforeFirst()) {	%>

		<h3>Our Best Products:</h3>
		<font face="Century Gothic" size="3">
			<table class="table" border="1">
				<tbody>
					<tr>
						<th class="col-md-1"></th>
						<th>Product Name</th>
						<th>Product Image</th>
						<th>Category</th>
						<th>Price</th>
					</tr>

		<%

		findBestProducts.next();
		for(int i = 0; i < 3; i++) {
			if (!findBestProducts.next()) {
				break;
			}
			int goodProductId = findBestProducts.getInt("productId");
			String goodProductInfo = "SELECT productId, productName, categoryName, productPrice, productImageURL FROM product JOIN category ON product.categoryId = category.categoryId WHERE productId = ?";
			PreparedStatement goodProductStatement = con.prepareStatement(goodProductInfo);
			goodProductStatement.setInt(1,goodProductId);
			ResultSet findGoodProduct = goodProductStatement.executeQuery();
			findGoodProduct.next();
			String pName = findGoodProduct.getString("productName");
			String pNameUrl = "";
			if(pName.contains(" ")) {
				pNameUrl = pName.replaceAll(" ","%20");
			}else {
				pNameUrl = pName;
			}
			String addcartBest = "addcart.jsp?id=" + findGoodProduct.getInt("productId") + "&name=" + pNameUrl + "&price=" + findGoodProduct.getDouble("productPrice");
			String productBest = "product.jsp?id=" + findGoodProduct.getInt("productId");
			String imagePathBest = findGoodProduct.getString("productImageURL");
			%>
			<tr>
				<td class="col-md-1"><a href=<%=addcartBest%>>Add To Cart</a></td>
				<td><a href=<%=productBest%>><%=findGoodProduct.getString("productName")%></a></td>
				<td><img src="<%=imagePathBest%>" onerror="this.onerror=null;this.remove();" alt = "Product Image" style="margin-left:auto; margin-right:auto; display:block; border:2px solid black;width:50px;height:50px;"></td>
				<td><%=findGoodProduct.getString("categoryName")%></td>
				<td><%=currFormat.format(findGoodProduct.getDouble("productPrice"))%></td>
			</tr>
			<%
			findBestProducts.next();
		}
		%>
				</tbody>
			</table>
		</font>
		<hr>
<%}%>


<h3>Browse Products By Category And Search By Product Name:</h3>


<form method="get" action="listprod.jsp">
	<p align="left">
		<select size="1" name="categoryName">
			<option>All</option>
			<option>Religious</option>
			<option>Hero/Villain</option>
			<option>Fantasy</option>
			<option>Sci-Fi</option>
			<option>Pop Culture</option>
		</select>
		<input type="text" name="productName" size="50">
		<input type="submit" value="Submit"><input type="reset" value="Reset">
	</p>
</form>

<% // Get product name to search for
String name = request.getParameter("productName");
if(name == null) {
	name = "";
}
String category = request.getParameter("categoryName");
if(category == null) {
	category = "All";
}

String sql = "";
PreparedStatement pstmt = null;
if(category.equals("All")) {
	sql = "SELECT productId, productName, categoryName, productPrice, productImageURL FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ? ORDER BY productName ASC";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,"%"+name+"%");
}else {
	sql = "SELECT productId, productName, categoryName, productPrice, productImageURL FROM product JOIN category ON product.categoryId = category.categoryId WHERE productName LIKE ? AND categoryName LIKE ? ORDER BY productName ASC";
	pstmt = con.prepareStatement(sql);
	pstmt.setString(1,"%"+name+"%");
	pstmt.setString(2,"%"+category+"%");
}

// Print out the ResultSet
ResultSet rst = pstmt.executeQuery();

if(name.equals("") && category.equals("All")) {
	%>
	<h4>All Products</h4>
	<%
} else if(name.equals("") && !category.equals("All")) {
	%>
	<h4>Products in category: <%=category%></h4>
	<%
} else if(!name.equals("") && category.equals("All")) {
	%>
	<h4>Products containing '<%=name%>'</h4>
	<%
}else if(!name.equals("") && !category.equals("All")) {
	%>
	<h4>Products containing '<%=name%> in category: <%=category%>'</h4>
	<%
}
%>
<font face="Century Gothic" size="3">
	<table class="table" border="1">
		<tbody>
			<tr>
				<th class="col-md-1"></th>
				<th>Product Name</th>
				<th>Product Image</th>
				<th>Category</th>
				<th>Price</th>
				<% if (auth) { %>
					<th>Admin</th>
				<% } %>
			</tr>
<%

// For each product create a link of the form
// addcart.jsp?id=productId&name=productName&price=productPrice
while(rst.next()) {
	String pName = rst.getString("productName");
	String pNameUrl = "";
	if(pName.contains(" ")) {
		pNameUrl = pName.replaceAll(" ","%20");
	}else {
		pNameUrl = pName;
	}
	String addcartVal = "addcart.jsp?id=" + rst.getInt("productId") + "&name=" + pNameUrl + "&price=" + rst.getDouble("productPrice");
	String productVal = "product.jsp?id=" + rst.getInt("productId");
	String deleteVal = "deleteprod.jsp?id=" + rst.getInt("productId");
	String editVal = "editprod.jsp?id=" + rst.getInt("productId");
	String imagePath = rst.getString("productImageURL");
	%>
		<tr>
			<td class="col-md-1"><a href=<%=addcartVal%>>Add To Cart</a></td>
			<td><a href=<%=productVal%>><%=rst.getString("productName")%></a></td>
			<td><img src="<%=imagePath%>" onerror="this.onerror=null;this.remove();" alt = "Product Image" style="margin-left:auto; margin-right:auto; display:block; border:2px solid black;width:50px;height:50px;"></td>
			<td><%=rst.getString("categoryName")%></td>
			<td><%=currFormat.format(rst.getDouble("productPrice"))%></td>
			<% if (auth) { %>
				<td>
					<a href=<%=editVal%>>EDIT</a>
					||
					<a href=<%=deleteVal%>>DELETE</a>
				</td>
			<% } %>

		</tr>
	<%
}
// Close connection
con.close();

// Useful code for formatting currency values:
// NumberFormat currFormat = NumberFormat.getCurrencyInstance();
// out.println(currFormat.format(5.0);	// Prints $5.00
%>

		</tbody>
	</table>
</font>

</body>
</html>

<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.io.File" %>
<%@ page import="java.lang.Integer" %>
<%@ page import="java.sql.Date" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>The Ramon Emporium - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>

<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";
String userName = (String) session.getAttribute("authenticatedUser");
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

NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
// Get product name to search for
// TODO: Retrieve and display info for the product

String productId = request.getParameter("id");
int pId = Integer.parseInt(productId);
String sql = "SELECT productId, productName, productDesc, productPrice, productImageURL FROM product WHERE productId LIKE ?";
PreparedStatement pstmt = pstmt = con.prepareStatement(sql);
pstmt.setInt(1,pId);

// Print out the ResultSet
ResultSet rst = pstmt.executeQuery();
rst.next();

%>
<font face="Century Gothic" size="5" style="max-width:300px;">
	<table class="table" border="1">
		<tbody>
			<tr>
				<th><%=rst.getString("productName")%></th>
				<th><%=rst.getInt("productId")%></th>
				<th><%=currFormat.format(rst.getDouble("productPrice"))%></th>
            </tr>
        </tbody>
    </table>
</font>

<h3 align="center"><%=rst.getString("productName")%></h3>
<%

// TODO: If there is a productImageURL, display using IMG tag
String imagePath = rst.getString("productImageURL");
if(imagePath != null) {
%>
    <img src="<%=imagePath%>" onerror="this.onerror=null;this.remove();" alt = "Product Image" style="margin-left:auto; margin-right:auto; display:block; border:5px solid black; max-width:500px;">
<%
}
%>
<br>
<h1 align="center"><%=rst.getString("productDesc")%></h1>
<%

// TODO: Add links to Add to Cart and Continue Shopping
String pName = rst.getString("productName");
	String pNameUrl = "";
	if(pName.contains(" ")) {
		pNameUrl = pName.replaceAll(" ","%20");
	}else {
		pNameUrl = pName;
	}
String addcartVal = "addcart.jsp?id=" + rst.getInt("productId") + "&name=" + pNameUrl + "&price=" + rst.getDouble("productPrice");

//Shows review prompt
long ms = System.currentTimeMillis();
%>
<h4><a href=<%=addcartVal%>>Add To Cart</a></h4>
<h4><a href="listprod.jsp">Continue Shopping</a></h4>

<hr>

<h3>Leave a Product Review:</h3>
<form  method = "get" action = reviewSubmitted.jsp >
	<p align = "left">
		<input type="radio" id="1 Star" name="reviewRating" value=1>
	  	<label for="reviewRating">1 Star</label>
  		<input type="radio" id="1 Star" name="reviewRating" value=2>
		<label for="reviewRating">2 Star</label>
		<input type="radio" id="1 Star" name="reviewRating" value=3>
		<label for="reviewRating">3 Star</label>
		<input type="radio" id="1 Star" name="reviewRating" value=4>
		<label for="reviewRating">4 Star</label>
		<input type="radio" id="1 Star" name="reviewRating" value=5>
		<label for="reviewRating">5 Star</label><br>
		<label for="reviewComment">Comment:</label>
        <textarea id = "reviewComment" rows = "3" cols = "80" name="reviewComment" size="1000"></textarea>
        </p>
		<input type="hidden" id="custId" name="custId" value=<%=custId %>>
		<input type="hidden" id="reviewDate" name="reviewDate" value=<%=new java.sql.Date(ms) %>>
		<input type="hidden" id="productId" name="productId" value=<%=productId %>>
		<input type="submit" value="Submit"><input type="reset" value="Reset">
	</p>
</form>

<h3>Product Reviews:</h3>
<table class = "table" border= "1">
<tbody>
	<tr>
		<th>Customer Name:</th>
		<th>Rating:</th>
		<th>Review Date:</th>
		<th>Comment:</th>
	</tr>
<%
// Queries the review data for item
PreparedStatement pstmt2 = con.prepareStatement("SELECT reviewRating, reviewDate, reviewComment, customerId FROM review WHERE productId =? ");
pstmt2.setString(1,productId);
ResultSet rstReview = pstmt2.executeQuery();

// Gets customer name for review
PreparedStatement pstmtCN = con.prepareStatement("SELECT customerId, firstName, lastName  FROM customer WHERE customerId = ? ");

while(rstReview.next()){
	pstmtCN.setInt(1,rstReview.getInt("customerId"));
	ResultSet nameRst = pstmtCN.executeQuery();
	String fullName="";
	while(nameRst.next()){
		fullName =  nameRst.getString("firstName") + " " + nameRst.getString("lastName");
	}
%>
<tr>
<td><%=fullName%></td>
<td><%=rstReview.getInt("reviewRating")%> Stars</td>
<td><%=rstReview.getDate("reviewDate")%></td>
<td><%=rstReview.getString("reviewComment")%></td>
</tr>


<%
}
con.close();
%>
</tbody>
</table>
</body>
</html>

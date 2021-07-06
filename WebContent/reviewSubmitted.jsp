<%@ page import="java.util.HashMap" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.io.File" %>
<%@ page import="java.lang.Integer" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>The Ramon Emporium - Product Information</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="header.jsp" %>
<h2> Thank you for Reviewing the Product! We appreciate your feedback.</h2>
<%
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";

Connection con = DriverManager.getConnection(url, uid, pw);

// gets parameters from request
String productId= request.getParameter("productId");
String reviewRating = request.getParameter("reviewRating");
String reviewDate= request.getParameter("reviewDate");
int customerId= Integer.parseInt(request.getParameter("custId"));
String reviewComment= request.getParameter("reviewComment");


//pstmt for adding customer review
PreparedStatement pstmt = con.prepareStatement("INSERT INTO review (reviewRating, reviewDate, customerId, productId,reviewComment) VALUES (?,?,?,?,?)");
pstmt.setString(1,reviewRating);
pstmt.setString(2,reviewDate);
pstmt.setInt(3,customerId);
pstmt.setString(4,productId);
pstmt.setString(5,reviewComment);

// makes sure customer has not left a review already for product
PreparedStatement pstmtt = con.prepareStatement("SELECT customerId FROM review WHERE customerId = ? AND productId = ?");
pstmtt.setInt(1,customerId);
pstmtt.setString(2,productId);
ResultSet rstt= pstmtt.executeQuery();
String reviewedAlready ="";
while(rstt.next()){
    reviewedAlready = rstt.getString("customerId");
}
out.print(reviewedAlready);

//If product isnt already reviewed, add review. Otherwise prompt customer and not add review.
if(reviewedAlready.isEmpty()){
pstmt.executeUpdate();
}else{
%> 
<h2><a> You have already reviewed this product! Try out our other products to add more reviews!</a></h2> 
     <%
}
String prodList = "product.jsp?id=" +productId;
%>
<h2><a href=<%=prodList %> >Return to Product Page</a></h2>

</body>
</html>

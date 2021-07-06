<html>
<head>
<title>The Ramon Emporium - Edit Product</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>
    <%@ include file="auth.jsp" %>
    <%@ include file="jdbc.jsp" %>


<h1>Edit Product information:</h1>

<%
int prodId = Integer.parseInt(request.getParameter("id"));

getConnection();
String sql = "SELECT productId, productName, productPrice, productDesc, categoryId FROM product where productId = ?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setInt(1,prodId);
ResultSet rst = pstmt.executeQuery();

%>

<% if (!rst.isBeforeFirst()) { %>

  <form method="get" action="updateprod.jsp">
  <table>

    <tr><td>Product Name:</td><td><input type="text" name="productName" size="20"></td></tr>
    <tr><td>Product Price:</td><td><input type="number" step="0.01" name="productPrice" size="20"></td></tr>
    <tr><td>Product Description:</td><td><input type="text" name="productDesc" size="40"></td></tr>
    <tr><td>Category ID:</td><td><input type="text" name="categoryId" size="20"></td></tr>
    <tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
<% } else {%>
  <% rst.next();%>
  <% String updateVal = "updateprod.jsp?id=" + rst.getInt("productId"); %>
  <form method="post" action=<%=updateVal%>>
  <table>
    <tr><td>Product Name:</td><td><input type="text" name="productName" size="20" autocomplete="off" value="<%=rst.getString(2)%>"></td></tr>
    <tr><td>Product Price:</td><td><input type="number" step="0.01" name="productPrice" size="20" autocomplete="off" value="<%=rst.getDouble(3)%>"></td></tr>
    <tr><td>Product Description:</td><td><input type="text" name="productDesc" size="40" autocomplete="off" value="<%=rst.getString(4)%>"></td></tr>
    <tr><td>Category ID:</td><td><input type="text" name="categoryId" size="20" autocomplete="off" value="<%=rst.getInt(5)%>"></td></tr>
    <tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
<% } %>

</table>
</form>

</body>
</html>

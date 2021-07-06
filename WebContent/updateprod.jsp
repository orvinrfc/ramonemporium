<!DOCTYPE html>
<html>
<head>
<title>The Ramon Emporium - Update Product</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <%@ include file="header.jsp" %>
  <%@ include file="auth.jsp" %>
  <%@ include file="jdbc.jsp" %>


  <%
  int prodId = Integer.parseInt(request.getParameter("id"));
  String productName = request.getParameter("productName");
  Double productPrice = Double.parseDouble(request.getParameter("productPrice"));
  String productDesc = request.getParameter("productDesc");
  int productCategoryId = Integer.parseInt(request.getParameter("categoryId"));

  if (productName.length() > 0 && productPrice > 0 && (productCategoryId >= 1 && productCategoryId <= 5)) {
    String productUpdateSQL = ("UPDATE product SET productName = ?, productPrice = ?, productDesc = ?, categoryId = ? WHERE productId = ?");

    getConnection();
    PreparedStatement ps = con.prepareStatement(productUpdateSQL);
    ps.setString(1,productName);
    ps.setDouble(2,productPrice);
    ps.setString(3,productDesc);
    ps.setInt(4,productCategoryId);
    ps.setInt(5,prodId);

    ps.executeUpdate();
    closeConnection();

    out.println("<b>Product Updated.</b>");
  }
  else {
    out.println("<b>Error Occured. Try again.</b>");
  }

  %>

</body>

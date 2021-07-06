<html>
<head>
<title>The Ramon Emporium - Add Product</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>

<h1>Enter new Product information:</h1>

<form method="get" action="addprod.jsp">
<table>
<tr><td>Product Name:</td><td><input type="text" name="productName" size="20"></td></tr>
<tr><td>Product Price:</td><td><input type="number" step="0.01" name="productPrice" size="20"></td></tr>
<tr><td>Product Description:</td><td><input type="text" name="productDesc" size="40"></td></tr>
<tr><td>Category ID:</td><td><input type="text" name="categoryId" size="20"></td></tr>
<tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
</table>
</form>

</body>
</html>

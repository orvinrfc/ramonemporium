<html>
<head>
<title>The Ramon Emporium - Cart Checkout</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ include file="header.jsp" %>

<h3>Enter your customer ID, password to complete the transaction:</h3>

<div>
  <form method="get" action="order.jsp">
    <table>
      <tr><td>Customer ID:</td><td><input type="text" name="customerId" size="20"></td></tr>
      <tr><td>Password:</td><td><input type="password" name="password" size="20"></td></tr>
      <tr><td><input type="submit" value="Submit"></td><td><input type="reset" value="Reset"></td></tr>
    </table>
  </form>
</div>

</body>
</html>

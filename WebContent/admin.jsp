<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
<title>The Ramon Emporim - Administrator Page</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<%@ include file="header.jsp" %>

<h3>Admin Actions</h3>
  <a class="btn btn-warning" href="loaddata.jsp" onclick="return confirm('Are you sure you want to reset the database?')">Restore Database To Initial State</a>


<h3>Administrator Sales Report by Day <a href = "graph.jsp"> (Graph Version) </a></h3>
<font face="Century Gothic" size="5">
  <table class="table" border="1">
    <tbody>
      <tr>
        <th>Order Date</th>
        <th>Total Order Amount</th>
      </tr>

<%
getConnection();
NumberFormat currFormat = NumberFormat.getCurrencyInstance(Locale.CANADA);
String sql = "SELECT CONVERT(date,orderDate), sum(totalAmount) FROM ordersummary GROUP BY CONVERT(date, orderDate) ";
PreparedStatement pstmt = con.prepareStatement(sql);
ResultSet rst = pstmt.executeQuery();
while(rst.next()) {
%>
      <tr>
        <td><%=rst.getDate(1)%></td>
        <td><%=currFormat.format(rst.getDouble(2))%></td>
      </tr>
<%
}
closeConnection();
%>
    </tbody>
  </table>
</font>

<hr>

<h3>List of all Customers</h3>

<font face="Century Gothic" size="3">
<table class="table" border="1">
  <tbody>
    <tr>
      <th>Customer ID</th>
      <th>First Name</th>
      <th>Last Name</th>
      <th>Email</th>
      <th>Phone Number</th>
      <th>Address</th>
      <th>City</th>
      <th>State</th>
      <th>Postal Code</th>
      <th>Country</th>
      <th>User ID</th>
    </tr>

    <%
    getConnection();
    String customersql = "SELECT * FROM Customer";
    pstmt = con.prepareStatement(customersql);
    rst = pstmt.executeQuery();
    while(rst.next()) {
      %>
      <tr>
        <td><%=rst.getInt(1)%></td> <%-- customerId --%>
        <td><%=rst.getString(2)%></td> <%-- firstName --%>
        <td><%=rst.getString(3)%></td> <%-- lastName --%>
        <td><%=rst.getString(4)%></td> <%-- email --%>
        <td><%=rst.getString(5)%></td> <%-- phonenum --%>
        <td><%=rst.getString(6)%></td> <%-- address --%>
        <td><%=rst.getString(7)%></td> <%-- city --%>
        <td><%=rst.getString(8)%></td> <%-- state --%>
        <td><%=rst.getString(9)%></td> <%-- postalCode --%>
        <td><%=rst.getString(10)%></td> <%-- country --%>
        <td><%=rst.getString(11)%></td> <%-- userid --%>
      </tr>

      <%
    }
    %>
  </tbody>
</table>
</font>

<hr>

<h3>Warehouse Inventory</h3>

<%
String wareSql = "SELECT warehouseId, warehousename FROM warehouse";
PreparedStatement warePstmt = con.prepareStatement(wareSql);
ResultSet wareRst = warePstmt.executeQuery();

while(wareRst.next()) {
  %>
  <h4><%=wareRst.getString("warehousename")%></h4>
  <%
  String wareProdSql = "SELECT P.productName, PI.productId, PI.quantity, PI.price FROM product AS P JOIN productinventory AS PI ON P.productId = PI.productId WHERE warehouseId = ?";
  PreparedStatement wareProdPstmt = con.prepareStatement(wareProdSql);
  wareProdPstmt.setInt(1,wareRst.getInt("warehouseId"));
  ResultSet wareProdRst = wareProdPstmt.executeQuery();
  %>
  <font face="Century Gothic" size="3">
    <table class="table" border="1">
      <tr>
        <th>Product Name</th>
        <th>Product ID</th>
        <th># In Stock</th>
        <th>Price</th>
      </tr>
  <%
  while(wareProdRst.next()) {
    if(wareProdRst.getInt("quantity") > 0) {
      %>
      <tr>
        <td><%=wareProdRst.getString("productName")%></td>
        <td><%=wareProdRst.getInt("productId")%></td>
        <td><%=wareProdRst.getInt("quantity")%></td>
        <td><%=currFormat.format(wareProdRst.getDouble("price"))%></td>
      </tr>
      <%
    }
  }
  %>
    </table>
  </font>
  <%
}
%>

<%
closeConnection();
%>
</body>
</html>

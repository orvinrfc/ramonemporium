<%@ include file="auth.jsp" %>
<%@ include file="jdbc.jsp" %>
<%
  int productId = Integer.parseInt(request.getParameter("id"));

  if (authenticated) {
    String productInventoryDeleteSQL = ("DELETE FROM productinventory WHERE productId = ?");
    String orderProductDeleteSQL = ("DELETE FROM orderproduct WHERE productId = ?");
    String productDeleteSQL = ("DELETE FROM product WHERE productId = ?");

    getConnection();
    PreparedStatement ps = con.prepareStatement(productInventoryDeleteSQL);
    ps.setInt(1,productId);
    ps.executeUpdate();

    ps = con.prepareStatement(orderProductDeleteSQL);
    ps.setInt(1,productId);
    ps.executeUpdate();

    ps = con.prepareStatement(productDeleteSQL);
    ps.setInt(1,productId);
    ps.executeUpdate();

    closeConnection();
  }
  else {
    out.println("<b>Error. Not logged in.</b>");
  }
%>
<h2><a href="listprod.jsp">Continue Shopping</a></h2>

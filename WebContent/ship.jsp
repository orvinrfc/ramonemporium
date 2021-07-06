<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<html>
<head>
<title>The Ramon Emporium - Shipment Overview</title>
<link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
        
<%@ include file="header.jsp" %>

<h1 align="center">Shipment Order Overview</h1>
<br>
<%
	// TODO: Get order id
	int orderId = Integer.parseInt(request.getParameter("orderId"));

	// Make connection
	String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
	String uid = "SA";
	String pw = "YourStrong@Passw0rd";

	try {
		Connection con = DriverManager.getConnection(url, uid, pw);  

		// TODO: Check if valid order id
		String validOrderIdSQL = ("SELECT count(*) FROM orderproduct WHERE orderId = ?");
		PreparedStatement ps = con.prepareStatement(validOrderIdSQL);
		ps.setInt(1,orderId);
		ResultSet rsOrderId = ps.executeQuery();
		
	
		if(rsOrderId.next()) {
			// if orderId is not valid back to main page, otherwise proceed
			int count = rsOrderId.getInt(1); //get how many orders are with the given orderId
			if (count == 0) {
				out.println("<h1> This order id is not valid.");
			} else {
				// TODO: Start a transaction (turn-off auto-commit)
				con.setAutoCommit(false);

				// TODO: Retrieve all items in order with given id
				String retrieveAllItemsSQL = ("SELECT * FROM orderproduct WHERE orderId = ?");
				PreparedStatement ps2 = con.prepareStatement(retrieveAllItemsSQL);
				ps2.setInt(1,orderId);
				ResultSet rsAllItems = ps2.executeQuery();

				// TODO: Create a new shipment record.
				//Step 1: get the date from the orderSummary table and convert it to sqlDate
				String orderSummaryDateSQL = ("SELECT * FROM ordersummary WHERE orderId =" + orderId );
				Statement st = con.createStatement();
				ResultSet rsOrderSummary = st.executeQuery(orderSummaryDateSQL);
				Date date = new Date();
				while(rsOrderSummary.next()){
					date = rsOrderSummary.getDate(2);
				}
				SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
				java.sql.Date sqlDate = new java.sql.Date(new Date(formatter.format(date)).getTime());

				//new shipment record
				String shipmentRecordSQL = ("INSERT INTO shipment(shipmentDate, shipmentDesc, warehouseId) VALUES(?,?,1)");
				PreparedStatement ps6 = con.prepareStatement(shipmentRecordSQL);
				
				String shipmentDescHelper = "<b>Shipment successfully processed.</b>";

				// TODO: For each item verify sufficient quantity available in warehouse 1.
				//loop over all items in the orderproduct to check the quantity
%>
<font face="Century Gothic" size="5">
	<table class="table" border="1">
		<tbody>
			<tr>
				<th>Ordered Product</th>
				<th>Quantity</th>
				<th>Previous Inventory</th>
				<th>New Inventory</th>
			</tr>
<%
				while (rsAllItems.next()) {
					int quantityOrder = rsAllItems.getInt("quantity"); //quantity of each item
					int productId = rsAllItems.getInt("productId"); //productId of each item

					String verifyQuantitySQL = ("SELECT * from productinventory WHERE productId = ? AND warehouseId = 1");
					PreparedStatement ps3 = con.prepareStatement(verifyQuantitySQL);
					ps3.setInt(1,productId);
					ResultSet rsVerifyQuantity = ps3.executeQuery();

					int quantityInInventory = 0;
					//get the number of product with productId in the productinventory
					while (rsVerifyQuantity.next()) {
						quantityInInventory = rsVerifyQuantity.getInt("quantity");
					}
					// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
					if(quantityOrder > quantityInInventory) {
						shipmentDescHelper = "<b>Shipment incomplete. Insufficient inventory for product id " + productId + "</b>.";
						con.rollback();
						break;
					} else {
						%>
							<tr>
								<td><%=productId%></td>
								<td><%=quantityOrder%></td>
								<td><%=quantityInInventory%></td>
								<td><%=quantityInInventory-quantityOrder%></td>
							</tr>	
						<%
						String updateSQL = "UPDATE productInventory SET quantity = quantity - ? WHERE productId = ?";
						PreparedStatement ps5 = con.prepareStatement(updateSQL);
						ps5.setInt(1,quantityOrder);
						ps5.setInt(2,productId);
						int row = ps5.executeUpdate();
					}
					
				}
				//set the shipment date
				ps6.setDate(1,sqlDate);
				//set the shipment description
				ps6.setString(2,shipmentDescHelper);
				int rowShipmentAdded = ps6.executeUpdate();
%>
		</tbody>
	</table>
</font>
<br>
<h2><%=shipmentDescHelper%></h2>
<%
				con.commit();
			}
		
		// TODO: Auto-commit should be turned back on
		con.setAutoCommit(true);
		}
	}catch (SQLException ex) {
		out.println(ex);
	}

%>                       				

</body>
</html>

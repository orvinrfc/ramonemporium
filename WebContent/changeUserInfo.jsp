<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	session = request.getSession(true);
	try {
		changeUserInfo(out,request,session);
	}
	catch(IOException e) {	
		System.err.println(e);
	}
	response.sendRedirect("customer.jsp");
%>


<%!
	void changeUserInfo(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException {
		String customerIdString = request.getParameter("custId");
		int customerId = Integer.parseInt(customerIdString);
		String firstName = request.getParameter("changeFirstName");
		String lastName = request.getParameter("changeLastName");
		String email = request.getParameter("changeEmail");
		String phoneNumber = request.getParameter("changePhoneNumber");
		String address = request.getParameter("changeAddress");
		String city = request.getParameter("changeCity");
		String state = request.getParameter("changeState");
		String postalCode = request.getParameter("changePostalCode");
		String country = request.getParameter("changeCountry");
		try {
			getConnection();

			if(firstName != null && !firstName.equals("")) {
				String sql = "UPDATE customer SET firstName = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,firstName);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(lastName != null && !lastName.equals("")) {
				String sql = "UPDATE customer SET lastName = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,lastName);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(email != null && !email.equals("")) {
				String sql = "UPDATE customer SET email = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,email);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(phoneNumber != null && !phoneNumber.equals("")) {
				String sql = "UPDATE customer SET phonenum = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,phoneNumber);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(address != null && !address.equals("")) {
				String sql = "UPDATE customer SET address = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,address);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(city != null && !city.equals("")) {
				String sql = "UPDATE customer SET city = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,city);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(state != null && !state.equals("")) {
				String sql = "UPDATE customer SET state = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,state);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(postalCode != null && !postalCode.equals("")) {
				String sql = "UPDATE customer SET postalCode = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,postalCode);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
			if(country != null && !country.equals("")) {
				String sql = "UPDATE customer SET country = ? WHERE customerId = ?";
				PreparedStatement pstmt = con.prepareStatement(sql);
				pstmt.setString(1,country);
				pstmt.setInt(2,customerId);
				pstmt.executeUpdate();
			}
		}
		catch (SQLException ex) {
			out.println(ex);
		}
		finally {
			closeConnection();
		}
	}
%>

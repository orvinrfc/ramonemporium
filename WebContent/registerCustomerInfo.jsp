<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String newUserLogin = null;
	session = request.getSession(true);
	try {
		newUserLogin = registerNewCustomer(out,request,session);
	}
	catch(IOException e) {	
        System.err.println(e);
    }

	if(newUserLogin != null)
		response.sendRedirect(newUserLogin);		// Successful login
	else
		response.sendRedirect("registerCustomer.jsp");		// Failed login - redirect back to login page with a message
%>


<%!
	String registerNewCustomer(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException {
		String username = request.getParameter("setUserId");
        String password = request.getParameter("setPassword");
        String firstName = request.getParameter("setFirstName");
        String lastName = request.getParameter("setLastName");
        String email = request.getParameter("setEmail");
        String phoneNumber = request.getParameter("setPhoneNumber");
        String address = request.getParameter("setAddress");
        String city = request.getParameter("setCity");
        String state = request.getParameter("setState");
        String postalCode = request.getParameter("setPostalCode");
        String country = request.getParameter("setCountry");
        
        String retStr = null;
		if(username == null || password == null || firstName == null || lastName == null || email == null || phoneNumber == null || address == null || city == null || state == null || postalCode == null || country == null) {
            return null;
        }
		if((username.length() == 0) || (password.length() == 0) || (firstName.length() == 0) || (lastName.length() == 0) || (email.length() == 0) || (phoneNumber.length() == 0) || (address.length() == 0) || (city.length() == 0) || (state.length() == 0) || (postalCode.length() == 0) || (country.length() == 0)) {  
            return null;
        }

        boolean uniqueId = true;
		try {
			getConnection();

			
			String checkUserSql = "SELECT userid FROM customer";
			PreparedStatement checkUserPstmt = con.prepareStatement(checkUserSql);
            ResultSet checkUserRst = checkUserPstmt.executeQuery();

            while(uniqueId) {
                while(checkUserRst.next()) {
                    if(checkUserRst.getString("userid").equals(username)) {
                        uniqueId = false;
                    }
                }
                String addCustomerSql = "INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement addCustomerPstmt = con.prepareStatement(addCustomerSql);
                addCustomerPstmt.setString(1,firstName);
                addCustomerPstmt.setString(2,lastName);
                addCustomerPstmt.setString(3,email);
                addCustomerPstmt.setString(4,phoneNumber);
                addCustomerPstmt.setString(5,address);
                addCustomerPstmt.setString(6,city);
                addCustomerPstmt.setString(7,state);
                addCustomerPstmt.setString(8,postalCode);
                addCustomerPstmt.setString(9,country);
                addCustomerPstmt.setString(10,username);
                addCustomerPstmt.setString(11,password);
                addCustomerPstmt.executeUpdate();

                retStr = "validateLogin.jsp?username=" + username + "&password=" + password;
                uniqueId = false;
            }
			
		}
		catch (SQLException ex) {
			out.println(ex);
		}
		finally {
			closeConnection();
		}
		return retStr;
	}
%>
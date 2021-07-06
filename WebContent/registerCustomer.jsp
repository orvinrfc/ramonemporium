<!DOCTYPE html>
<html>
<head>
    <title>The Ramon Emporium - Customer Registration</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@ page import="java.text.NumberFormat" %>
    <%@ include file="jdbc.jsp" %>
    <%@ include file="header.jsp" %>

    <h3 align="center">Welcome to the Ramon Emporium! Please enter the required information below.</h3>

    <hr>

    <form method="registerCustomer" action="registerCustomerInfo.jsp">
        <div align="center">
            <h4>User ID:</h4>
            <input type="text" name="setUserId" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Password:</h4>
            <input type="text" name="setPassword" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>First Name:</h4>
            <input type="text" name="setFirstName" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Last Name:</h4>
            <input type="text" name="setLastName" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Email:</h4>
            <input type="text" name="setEmail" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Phone Number:</h4>
            <input type="text" name="setPhoneNumber" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Address:</h4>
            <input type="text" name="setAddress" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>City:</h4>
            <input type="text" name="setCity" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>State:</h4>
            <input type="text" name="setState" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Postal Code:</h4>
            <input type="text" name="setPostalCode" size="50">
            <hr>
        </div>
        <div align="center">
            <h4>Country:</h4>
            <input type="text" name="setCountry" size="50">
            <hr>
        </div>
        <div align="center">
            <input type="submit" value="Submit Customer Info"><input type="reset" value="Reset Fields">
        </div>

</body>

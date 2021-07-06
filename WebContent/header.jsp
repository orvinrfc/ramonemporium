<header>
  <%
  String userId = (String) session.getAttribute("authenticatedUser");
  if (userId != null) {
      %>
      <div class="text-left">
        <ul>
          <li><a href="listprod.jsp">Products</a></li>
          <li><a href="customer.jsp">User Info</a></li>
        </ul>
      </div>

      <div>
        <h1 align="center">
            <font face="cursive" color="#3399FF">
                <a href="index.jsp">The Ramon Emporium</a>
            </font>
        </h1>
      </div>

      <div class="text-right">
        <ul>
          <li>Logged in as: <% out.println(userId); %></li>
          <li><a href="logout.jsp">Log out</a></li>
        </ul>
      </div>
      <%
  } else {
      %>
      <div class="text-left">
        <ul>
          <li><a href="listprod.jsp">Products</a></li>
        </ul>
      </div>

      <div>
        <h1 align="center">
            <font face="cursive" color="#3399FF">
                <a href="index.jsp">The Ramon Emporium</a>
            </font>
        </h1>
      </div>

      <div class="text-right">
        <ul>
          <li><a href="login.jsp">Login</a></li>
        </ul>
      </div>
      <%
  }
  %>
</header>
<hr>


<style>
header {
  display:flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  padding: 0px 5px;
}
header div {
  width:33.3%;
}

ul {
  padding: 0;
  margin: 0;
}

li {
  list-style: none;
  margin: none;
}
</style>

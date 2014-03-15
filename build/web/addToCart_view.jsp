<%@page import="java.util.ArrayList"%>
<%@page import="user.user"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC</title>
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
</head>
<body>
        <jsp:useBean id="cart" scope="session" class="cart.cart"/>
        <%
            if (session.getAttribute("user") == null) {// THen new user, show join now
%>
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%        } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%            }
        %>
        <div class="container">
            <h4>Products In your Cart</h4>
            <%
                user User = new user();
                session.getAttribute("user");
                //out.println(session.getAttribute("user"));
                User = (user) session.getAttribute("user");
                if (session.getAttribute("user") == null) {
            %>
            <button class="showForm btn btn-warning btn-lg center-block">Login to make Purchase</button>
            <%                } else {
            %>
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <h3 class="panel-title">Items in your Cart</h3>
                  </div>
                  <div class="panel-body">
                   <div class="table-responsive">
                    <table class="table table-bordered">
                        <tr>
                            <th>S No.</th>
                            <th>Name of Product</th>
                            <th>Price</th>
                            <th style="text-align:center;">Quantity</th>
                            <th>Total Price</th>
                        </tr>
                    <%
                            //out.println("<br/>Total value price of the cart " + cart.getTotalPriceOfCart());
                            ArrayList<String> productNames = new ArrayList();
                            ArrayList<Double> productPrices = new ArrayList();
                            ArrayList<Integer> Qty = new ArrayList();
                            ArrayList<Integer> ids = new ArrayList();

                            productNames = cart.getProductNames();
                            productPrices = cart.getPrices();
                            Qty = cart.getQty();
                            ids = cart.getId();
                    %>

                        <%
                            for (int i = 0; i < productNames.size(); i++) {
                        %>
                         <tr>
                            <td>
                                <%=(i+1) %>
                            </td>
                        <td>
                            <%=productNames.get(i)%>
                        </td>
                        <td>
                            <i class="fa fa-rupee"></i> <%=productPrices.get(i)%>
                        </td>
                        <td style="text-align:center;">
                            <%=Qty.get(i)%>
                        </td>
                        <td>
                            <i class="fa fa-rupee"></i> <%= Qty.get(i) * productPrices.get(i)%>
                        </td>
                        <%
                            }
                            productNames.clear();
                            productPrices.clear();

                        %>
                            </tr>
                            </table>
                            <h3 class="text-center">Total Amount to be Paid: 
                                <i class="fa fa-rupee"></i> <%= Math.ceil(cart.getTotalPriceOfCart()) %></h3>
                            <div class="pull-right">
                                <a class="btn btn-success btn-embossed" href="buyItems.jsp">Proceed to Checkout</a>
                                <a class="btn btn-default btn-embossed" href="viewProducts_.jsp">Continue Shopping</a>
                        </div>
                    </div>
                    <%
                            }
                    %>
                </div>
             </div>
          </div>
    </body>
</html>

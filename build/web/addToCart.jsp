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
        <jsp:useBean id="cart" scope="session" class="cart.cart"></jsp:useBean>
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
         <h3>Products In your Cart</h3>
           <%
            user User = new user();
            session.getAttribute("user");
            //out.println(session.getAttribute("user"));
            User = (user) session.getAttribute("user");
            if (session.getAttribute("user") == null) {
           %>
            <button class="showForm btn btn-warning btn-embossed btn-lg center-block">Login to make Purchase</button>
            <%                } else {
                //out.println("login by " + User.getUserEmail());
            %>
            <div class="panel panel-default">
             <div class="panel-heading">
               <h3 class="panel-title">Recently Added Items in your Cart</h3>
             </div>
             <div class="panel-body">
               <div class="table-responsive">
                <table class="table">
                  <tr>
                    <th>Product Id</th>
                    <th>Name of Product</th>
                    <th>Price</th>
                  </tr>
                  <tr>
                  <%
                    String sid = request.getParameter("id");
                    int id;
                    if (request.getParameter("id") == null) {
                        response.sendRedirect("viewProduct_.jsp");
                    } else {
                        id = Integer.parseInt(sid);
                        boolean b = cart.addProduct(id);
                        if (b == true) {
                            out.println("<td>"+ id +"</td>"+ "<td>" + cart.getProductName(id) + "</td>" + "<td>" +"Rs. "+ cart.getProductPrice(id)+"</td>");
                        } else {
                            out.println("No Product Added");
                        }
                        //out.println("<td>" + cart.getTotalPriceOfCart()+"</td>");
                        ArrayList<String> productNames = new ArrayList();
                        ArrayList<Double> productPrices = new ArrayList();
                        ArrayList<Integer> Qty = new ArrayList();
                        ArrayList<Integer> ids = new ArrayList();
                        productNames = cart.getProductNames();
                        productPrices = cart.getPrices();
                        Qty = cart.getQty();
                        ids = cart.getId();
                  %>
                </tr>
            </table>
           </div>
          </div>
       </div>
      <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">All Items in your Cart</h3>
          </div>
           <div class="panel-body">
             <div class="table-responsive">
               <table class="table table-hover table-bordered">
                  <tr>
                    <th>Serial No.</th>
                    <th>Name of Product</th>
                    <th>Price</th>
                    <th style="text-align:center;">Quantity</th>
                    <th>Total Price</th>
                  </tr>
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
                    <tr>
                        <td class="invisible text-hide"></td>
                        <td class="invisible text-hide"></td>
                    </tr>
                    <tr style="background-color:#f8f8fa;">
                        <td class="invisible text-hide"></td>
                        <td class="invisible text-hide"></td>
                        <td colspan="2" style="font-size: 125%;text-align: right;">
                            <strong>Total to be Paid:</strong>
                        </td>
                        <td style="font-size: 125%;">
                            <i class="fa fa-rupee"></i><strong> <%= Math.ceil(cart.getTotalPriceOfCart()) %></strong>
                        </td>
                    </tr>
                </table>
                <div class="pull-right">
                    <a class="btn btn-success btn-embossed" href="buyItems.jsp">Proceed to Checkout</a>
                    <a class="btn btn-default btn-embossed" href="viewProducts_.jsp"><i class="fa fa-reply"></i> Continue Shopping</a>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
  </div>
 </div>
</body>
</html>

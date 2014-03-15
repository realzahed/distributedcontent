<%@page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC</title>
    <jsp:useBean class="product.product" id="product" scope="session"></jsp:useBean>
    <%@page import="java.sql.*, database.*" %>
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
</head>
<body>
    <div style="box-shadow: 0px 2px 10px #eee;">
        <div class="container">
            <h4 class="text-right">Major Project <small>DCAC</small></h4>
        </div>
    </div>
    <div class="container" style="margin-top: 2%;">
      <div class="row" style="border: 1px solid #efefef;"> 
            <%
                if (request.getParameter("oid") != null) {
                    String OrderId = request.getParameter("oid");
                    String fetchInfoSQL = "SELECT * FROM  `order` WHERE  `order_id` =  '" + OrderId + "' ; ";
                    Connection c = new DB_Conn().getConnection();
                    Statement st = c.createStatement();
                    ResultSet rs1 = st.executeQuery(fetchInfoSQL);
                    while (rs1.next()) {
                        String name,
                                email, address, mobileNum, status;
                        Date ordered_on_date;
                        Time ordered_on_time;
                        name = rs1.getString("shippers_name");
                        email = rs1.getString("shippers_email");
                        address = rs1.getString("address");
                        mobileNum = rs1.getString("mobile_number");
                        ordered_on_date = rs1.getDate("ordered_On");
                        ordered_on_time = rs1.getTime("ordered_On");
                        status = rs1.getString("status");
            %>
            <div class="col-md-6">
                <p class="label label-primary">Billing Address</p>
                <form class="form-horizontal" role="form">
                    <div class="form-group" style="margin-bottom: 0px;text-transform: capitalize;">
                      <label class="col-sm-12"><%= name %></label>
                    </div>
                    <div class="form-group" style="margin-bottom: 0px;">
                      <label class="col-sm-12"><%= email %></label>
                    </div>
                    <div class="form-group" style="margin-bottom: 0px;">
                      <label class="col-sm-7"><%= address %></label>
                    </div>
                    <div class="form-group" style="margin-bottom: 0px;">
                      <label class="col-sm-12"><%= mobileNum %></label>
                    </div>
                    <div class="form-group" style="margin-bottom: 0px;">
                      <label class="col-sm-12">Order Date: <%= ordered_on_date %></label>
                    </div>
                </form>
                </div>
                <div class="col-sm-offset-2 col-md-4">
                    <p class="label label-info">Sold By</p>
                      <form class="form-horizontal" role="form">
                        <div class="form-group" style="margin-bottom: 0px;">
                          <label class="col-sm-12">Mammoth Media (Hyderabad) Ltd</label>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px;">
                          <label class="col-sm-12">County Hill Complex, Building No. H</label>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px;">
                          <label class="col-sm-12">Nampally, Road No. 12, By-Pass Road</label>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px;">
                          <label class="col-sm-12">Hyderabad - 500001</label>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px;">
                          <label class="col-sm-12">Andhra Pradesh, India</label>
                        </div>
                        <div class="form-group" style="margin-bottom: 0px;">
                          <label class="col-sm-12"><a href="mailto:support@dcac.com">support@dcac.com</a> </label>
                        </div>
                    </form>
                </div>
          </div>
           <%
                }
           %>
           <div class="row" style="margin-top: 1%;">
            <div class="panel panel-default">
             <div class="panel-heading">Order Summary</div>
              <div class="panel-body">
               <div class="table-responsive">
                <table class="table table-condensed">
                  <tr>
                    <th>Order ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                  </tr>   
                    <%
                        String sql = "SELECT  `order_id` ,  `product_name` ,  `product_price` ,  `product_quantity` ,  `sold_on` "
                                + " FROM  `order` o "
                                + " INNER JOIN  `sales` s "
                                + " USING (  `order_id` ) "
                                + " WHERE o.`order_id` = " + OrderId + " "
                                + " ORDER BY `order_id` DESC ";
                        PreparedStatement psmt =
                                c.prepareStatement(sql);
                        ResultSet rs = psmt.executeQuery();
                        int oldOrder = 0;
                        int newOrder;
                        String product_name;
                        double product_price;
                        int product_quantity;
                        Date sold_on_date;
                        Time sold_on_time;
                        double totalPrice = 0;
                        double totalValue = 0;
                        while (rs.next()) {
                            newOrder = rs.getInt("order_id");
                            product_name = rs.getString("product_name");
                            product_price = rs.getDouble("product_price");
                            product_quantity = rs.getInt("product_quantity");
                            sold_on_time = rs.getTime("sold_on");
                            sold_on_date = rs.getDate("sold_on");
                            String orderDateArr[] = sold_on_date.toString().split("-");
                            totalValue = product_quantity * product_price;
                            totalPrice += totalValue;
                            String billNo = "";
                            for (int i = orderDateArr.length - 1; i >= 1; i--) {
                                billNo += orderDateArr[i];
                            }
                            billNo += newOrder;
                            if (oldOrder == newOrder) {
                            // Dont Draw border Type II order Div
%>
            <!-- Type II Order -->
           <tr>
             <td></td>
             <td style="text-align: left;"><%= product_name %></td>
             <td><i class="fa fa-rupee"></i> <%= product_price %></td>
             <td><%= product_quantity %></td>
             <td><i class="fa fa-rupee"></i> <%= totalValue %> </td>
           </tr>     
           <%
            } else {
                // Draw New Order Type I order Div
           %>
            <!-- Type I Order -->
             <tr>
                <td><%= billNo %></td>
                <td><%= product_name %></td>
                <td><i class="fa fa-rupee"></i> <%= product_price %></td>
                <td><%= product_quantity %></td>
                <td><i class="fa fa-rupee"></i> <%= totalValue %></td>
            </tr>
                    <%
                            }
                            oldOrder = newOrder;
                        }
                        totalPrice = Math.ceil(totalPrice);
                    %>
             <tr>
                <th class="invisible" colspan="2"></th>
                <th colspan="2">Total</th>
                <th><i class="fa fa-rupee"></i> <%= totalPrice %></th>
            </tr>
           </table>
         </div>
                </div>
            </div>
      </div>
     </div>
        <%
        } else {
        %>
    <div class="container">
        <div class="well">
           <h3>No Product Invoice to Print</h3>
        </div>
    </div>
    <%            }
    %>
    </body>
</html>

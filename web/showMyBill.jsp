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
    <style type="text/css">
        #leftside {
            cursor: pointer;
            position: fixed;
            width: 260px;
        }
    </style>
</head>
<body>     
        <%
        if (session.getAttribute("user") == null ){// THen new user, show join now
            %>

        <%
        }else {
            %>
            <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%
        }
        %>    
            <%
            if (request.getParameter("oid") != null){
                
               String OrderId = request.getParameter("oid");
               String fetchInfoSQL = "SELECT * FROM  `order` WHERE  `order_id` =  '"+OrderId+"' ; ";
               Connection c = new DB_Conn().getConnection();
               Statement st = c.createStatement() ;
               ResultSet rs1 = st.executeQuery(fetchInfoSQL);
               while (rs1.next()){
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
        <div class="container">
          <div class="row">
            <div class="col-md-3">
                <div id="leftside" class="sidebar affix-top hidden-xs hidden-sm"  role="complementary">
                    <ul class="nav sidenav">
                        <li class="active"><a href="userinfo.jsp"><i class="fa fa-arrow-circle-left"></i> Back</a></li>
                        
                    </ul>
                </div>
            </div>
            <div class="col-md-9">
                <div class="well">
                    <h3 style="text-align: center;">Order Summary</h3>
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Name:</label>
                          <div class="col-sm-10">
                            <p class="form-control-static"><%= name %>
                                <br class="visible-sm visible-xs"/><span style="text-transform:capitalize;font-size: 110%;" class="label label-primary pull-right">
                                <% if (status.equals("delivered"))
                                      {
                                          %>
                                          Status: <i class="fa fa-truck fa-lg"></i> Delivered
                                  <%
                                         } else if (status.equals("pending")) 
                                         {
                                  %>
                                    Status: <span class="text-muted"> <i class="fa fa-exclamation-triangle fa-lg"></i> <%= status %></span>
                                    <%
                                         } else if(status.equals("approved")) {
                                             %>
                                             Status: <span class="text-info"> <i class="fa fa-check-circle fa-lg"></i> <%= status %></span>
                                             <%
                                         } else {
                                             %>
                                             Status: <%= status%>
                                    <%                            } 
                                  %>
                            </span></p>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Email:</label>
                          <div class="col-sm-10">
                            <p class="form-control-static"><%= email %>
                                <br class="visible-sm visible-xs"/><span style="text-transform:capitalize;text-decoration: none;"label label-info class="col-sm-offset-6 text-info">
                               <% if (status.equals("delivered"))
                                    {
                                        %>
                                        <a target="_blank" style="text-transform:capitalize;text-decoration: none;" class="btn btn-facebook btn-xs pull-right" href="showMyBill_Print.jsp?oid=<%= OrderId %>">Print Invoice</a>
                                <%
                                       }
                                %>
                            </span></p>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Address:</label>
                          <div class="col-sm-10">
                            <p class="form-control-static"><%= address %></p>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Phone:</label>
                          <div class="col-sm-10">
                            <p class="form-control-static"><%= mobileNum %></p>
                          </div>
                        </div>
                        <div class="form-group">
                          <label class="col-sm-2 control-label">Order Date:</label>
                          <div class="col-sm-10">
                            <p class="form-control-static"><%= ordered_on_date +" <b>Time:</b> "+ordered_on_time %></p>
                          </div>
                        </div>                 
                </div><!--/.alert-->
           <%
               }
           %>
            <div class="table-responsive">
               <table class="table table-striped table-bordered table-hover">
                <tr>
                    <th>Order ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                </tr>   
                <%
            String sql = "SELECT  `order_id` ,  `product_name` ,  `product_price` ,  `product_quantity` ,  `sold_on` "
                        +" FROM  `order` o "
                        +" INNER JOIN  `sales` s "
                        +" USING (  `order_id` ) "
                        +" WHERE o.`order_id` = "+OrderId+" "
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
            while (rs.next()){
                newOrder = rs.getInt("order_id");
                product_name = rs.getString("product_name");
                product_price = rs.getDouble("product_price");
                product_quantity = rs.getInt("product_quantity");
                sold_on_time = rs.getTime("sold_on");
                sold_on_date = rs.getDate("sold_on");
                String orderDateArr [] = sold_on_date.toString().split("-");
                totalValue = product_quantity*product_price;
                totalPrice += totalValue;
                String billNo = "";
                for (int i= orderDateArr.length-1; i>= 1; i--){
                    billNo += orderDateArr[i];
                }
                billNo+= newOrder;
                if (oldOrder == newOrder){
                    // Dont Draw border Type II order Div
                    %>
            <!-- Type II Order -->
            <tr>
              <td></td>
              <td style="text-align: left;"><a href="product.jsp?id="></a><%= product_name %></td>
              <td><i class="fa fa-rupee"></i> <%= product_price %></td>
              <td><%= product_quantity %></td>
              <td><i class="fa fa-rupee"></i> <%= totalValue %> </td>
            </tr>     
            <%
            }else {
            // Draw New Order Type I order Div
            %>
            <!-- Type I Order -->
             <tr>
                <td><a class="blue" href="showMyBill.jsp?oid=<%= newOrder %>"><%= billNo %></a></td>
                <td><%= product_name %><a class="pull-right" href="showMyBill.jsp?oid=<%= newOrder %>"></a></td>
                <td><i class="fa fa-rupee"></i> <%= product_price %></td>
                <td><%= product_quantity %></td>
                <td><i class="fa fa-rupee"></i> <%= totalValue %></td>
            </tr>
            <%
            }
            oldOrder = newOrder;
            }
            totalPrice =  Math.ceil(totalPrice);
            %>
            <tr class="success">
                <th class="invisible" colspan="2"></th>
                <th colspan="2">Total</th>
                <th><%= totalPrice %></th>
            </tr>
           </table>
         </div>
        </div><!--/.col-md-9-->
       </div><!--/.row-->                            
     </div>                      
            <%
          } else {
          %>
          <div class="container">
              <div class="well">
                  <h4>No Product Invoice to Display</h4>
              </div>
          </div>
         <%
          }                       
        %>
    </body>
</html>

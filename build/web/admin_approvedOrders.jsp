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
        <%
        if (session.getAttribute("user") == null ){// THen new user, show join now
            %>
            <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%
        }else {
            %>
            <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%
        }
        if (session.getAttribute("admin")== null){
            response.sendRedirect("admin_.jsp");
        }
        %>
  <div class="container">
    <div class="row">
     <div class="col-md-3">
            <div id="sidebar-nav" class="list-group">
                <a href="admin_Performance.jsp" class="list-group-item"><i class="fa fa-dashboard fa-lg fa-fw"></i> Dashboard</a>
                <a href="admin_addProduct.jsp" class="list-group-item"><i class="fa fa-plus-square fa-lg fa-fw"></i> Add Product</a>
                <a href="admin_manageProduct.jsp"class="list-group-item"><i class="fa fa-paperclip fa-lg fa-fw"></i> Manage Product</a>
                <a href="admin_pendingOrders.jsp" class="list-group-item"><i class="fa fa-clock-o fa-lg fa-fw"></i> Pending Orders</a>
                <a href="admin_approvedOrders.jsp" style="background-color: #318ce7;" class="list-group-item active"><i class="fa fa-check-square-o fa-lg fa-fw"></i> Approved Orders</a>
                <a href="admin_deliveredOrders.jsp" class="list-group-item"><i class="fa fa-truck fa-lg fa-fw"></i> Delivered Orders</a>
                <a href="admin_settings.jsp" class="list-group-item"><i class="fa fa-cog fa-lg fa-fw"></i> Settings</a>
            </div>
        </div>
        <div class="col-md-9">
          <div class="lead">
           <jsp:include page="includesPage/gChartings/gCharts_pieChartItemsViewedByCategory.jsp"></jsp:include>
          </div>
             <form class="form-horizontal" method="post" action="changeProductStatus">
                 <h3 class="text-center">Approved Orders <small> Orders to be Delivered</small></h3>
                 <div class="form-group">
                     <input type="submit" class="btn btn-primary" style="background-color: #318CE7;border-color: #318CE7;" value="Change Product Status">
                    <div class="col-sm-6">
                      <select class="form-control" name="ChangeStatus">
                        <option value="delivered">Deliver Order(s)</option>
                        <option value="cancel">Cancel</option>
                      </select>
                    </div>
                  </div>
                  <div  style ="text-align: left;">
                    <h5 style ="text-align: center;">Order(s) To Be Delivered</h5>  
                     <div class="table-responsive">
                       <table class="table table-bordered" style="width: 100%;">
                        <colgroup>
                            <col width="0%"  />
                            <col width="10%" />
                            <col width="30%" />
                            <col width="10%" />
                            <col width="0%"  />
                            <col width="20%" />
                            <col width="0%"  />
                            <col width="40%" />
                        </colgroup>
                        <tr>
                            <th>Select</th>
                            <th>Order ID</th>
                            <th>Product Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Date Ordered</th>
                            <th>Contact</th>
                            <th>Address</th>
                        </tr>   
                    <%
                      String sql = "\n"
                              + "SELECT `order_id` , `product_name` , \n"
                              + " `product_price` , `product_quantity` , \n"
                              + " `sold_on` , `mobile_number` , \n"
                              + " `address` , `shippers_name` \n"
                              + "FROM `order` o\n"
                              + "INNER JOIN `sales` s\n"
                              + "USING ( `order_id` )"
                              + " WHERE `status` = 'approved' \n"
                              + "ORDER BY `order_id` ";
                      Connection c = new database.DB_Conn().getConnection();
                      PreparedStatement psmt =
                              c.prepareStatement(sql);
                      ResultSet rs = psmt.executeQuery();
                      int oldOrder = 0;
                      int newOrder;
                      String product_name,
                      name, address, mobile_no;
                      double product_price;
                      int product_quantity;
                      Date sold_on_date;
                      Time sold_on_time;
                      while (rs.next()) {
                          newOrder = rs.getInt("order_id");
                          product_name = rs.getString("product_name");
                          product_price = rs.getDouble("product_price");
                          product_quantity = rs.getInt("product_quantity");
                          sold_on_time = rs.getTime("sold_on");
                          sold_on_date = rs.getDate("sold_on");
                          String orderDateArr[] = sold_on_date.toString().split("-");
                          name = rs.getString("shippers_name");
                          address = rs.getString("address");
                          mobile_no = rs.getString("mobile_number");
                                  String billNo = "";
                                  for (int i= orderDateArr.length-1; i>= 1; i--){
                                      billNo += orderDateArr[i];
                                  }
                                  billNo+= newOrder;
                          if (oldOrder == newOrder) {
                              // Dont Draw border Type II order Div
                  %>
                    <tr>
                      <td></td>
                      <td></td>
                      <td style="text-align: left;"><a href="product.jsp?id="></a><%= product_name %></td>
                      <td><i class="fa fa-rupee"></i><%= product_price %></td>
                      <td><%= product_quantity %></td>
                      <td><%= sold_on_date%></td>
                      <td></td>
                      <td></td>
                    </tr>               
                        <%
                        } else {
                            // Draw New Order Type I order Div
                        %>
                      <tr>
                            <td><input type="checkbox" class="order" name="order" value="<%= newOrder%>"/></td>
                            <td><a class="blue" href="showMyBill.jsp?oid=<%= newOrder %>"><%= billNo %></a></td>
                            <td><%= product_name %></td>
                            <td><i class="fa fa-rupee"></i><%= product_price %></td>
                            <td><%= product_quantity %></td>
                            <td><%= sold_on_date%></td>
                            <td><%= mobile_no%></td>
                            <td><strong><%= name%>,</strong><br/> <%= address%></td>
                        </tr>
                        <%
                                }
                                oldOrder = newOrder;
                            }

                        %>
                    </table>
                </div>
             </div>
           </form>
         </div>
       </div>
    </div>
 </body>
</html>

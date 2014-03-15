<%@page import="cart.cart"%>
<%@page import="user.user"%>
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
    <link rel="stylesheet" href="assets/css/animate.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script>
    <style type="text/css">
    #MyOrders a{color:#000}.user-info-block{font-size:18px}.profile{color:#40826d;background-color:#e8e8e8;border:1px solid transparent;-webkit-border-top-left-radius:10px;-webkit-border-top-right-radius:10px;-moz-border-radius-topleft:10px;-moz-border-radius-topright:10px;border-top-left-radius:10px;border-top-right-radius:10px}.profile img{display:block;border:10px solid rgba(255,255,255,.3);margin:0 auto;margin-top:10px;margin-bottom:10px}.profile p{text-align:center;color:#000;font-weight:700;font-size:18px}.list-group-item{background-color:#fff;border-radius:0!important;border:1px solid #DDD}.list-group-item a{text-decoration:none}.list-group-item:hover{border-left:3px solid #18bc9c;background-color:#F8F7F5;text-decoration:none}
    </style>
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
        user User;
        String printName = null;
        if ((session.getAttribute("user") == null)) {
            response.sendRedirect("index.jsp");
        } else {
            User = (user) session.getAttribute("user");
            String email = User.getUserEmail();
            String userName = User.getUsername();
            int uid = User.getUserId();
            if (userName == null){
                printName = email;
            }
            else {
                printName = userName;
            }
        %>
<div class="container animated fadeInUpBig">
  <div class="row"> 
   <div class="col-md-3">
      <article>
        <div class="profile">
          <img src="assets/img/multi/default.png" alt="<%= userName %>" class="img-circle">
            <p><%= printName %></p>
        </div>
        <ul class="list-group">
            <li class="list-group-item active"><a id="jump0" href="#UserProfile"><i class="fa fa-user fa-fw fa-lg"></i> Profile</a></li>
            <li class="list-group-item"><a id="jump1" href="#MyOrders"><i class="fa fa-calendar fa-fw fa-lg"></i> Orders</a></li>
            <li class="list-group-item"><a id="jump2" href="#Account"><i class="fa fa-pencil-square-o fa-fw fa-lg"></i> Account Settings</a></li>
            <li class="list-group-item"><a id="jump3" href="#Settings"><i class="fa fa-cog fa-fw fa-lg"></i> Change Password</a></li>
            <li class="list-group-item"><a id="jump3" href="#Settings"><i class="fa fa-save fa-fw fa-lg"></i> Settings</a></li>
        </ul>
      </article>
       
   <!--  <div class="user-info-block text-info">
       <div class="sidebar affix-top" role="complementary">
        <ul class="nav sidenav">
            <li class="list-group active"><a href="#"><em><strong>Jump To:</strong></em></a></li>
            <li><a id="jump0" href="#UserProfile"><i class="fa fa-user fa-fw fa-lg"></i> User Profile</a></li>
            <li><a id="jump1" href="#MyOrders"><i class="fa fa-calendar fa-fw fa-lg"></i> Order History</a></li>
            <li><a id="jump2" href="#Account"><i class="fa fa-pencil-square-o fa-fw fa-lg"></i> Account Details</a></li>
            <li><a id="jump3" href="#Settings"><i class="fa fa-cog fa-fw fa-lg"></i> Settings</a></li>
        </ul>
       </div>
     </div>-->
   </div>
   <div class="col-md-9">
    <div id="UserProfile">
        <div class="well" style="background-color: #7b5aae;color: #ffffff;">
            <h3 class="lead text-center">Welcome, <%= printName %></h3>
            <form class="form-horizontal" role="form">
                <h4 style="margin-left:10px;font-weight: bold;color: #f9f8fb;">User Profile<a href="#Account" id="account1" class="pull-right btn btn-warning btn-xs" style="margin-left:10px;font-weight: normal;color: #f9f8fb;">Edit Profile</a></h4>
                
                <div class="form-group">
                  <label class="col-sm-2 control-label">Name</label>
                  <div class="col-sm-10">
                    <%
                        if (userName==null) {
                    %>
                    <p class="form-control-static">Name Not Available</p>
                    <%        } else {
                    %>
                    <p class="form-control-static"><%= userName %></p>
                    <% }
                    %> 
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">Phone No</label>
                  <div class="col-sm-10">
                        <%
                            if (User.getMobileNum() == null) {
                         %>
                         <p class="form-control-static">Phone Number Not Available</p>
                         <%
                            } else {
                         %>
                         <p class="form-control-static"><%= User.getMobileNum() %>
                         <% }
                         %> 
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">Address</label>
                  <div class="col-sm-10">
                         <%
                            if (User.getAddress() == null) {
                         %>
                         <p class="form-control-static">Address Not Available</p>
                         <%
                            } else {
                         %>
                         <p class="form-control-static"><%= User.getAddress()%></p>
                         <% }
                         %> 
                  </div>
                </div>
                <div class="form-group">
                  <label class="col-sm-2 control-label">City</label>
                  <div class="col-sm-10">
                    <p class="form-control-static">Hyderabad</p>
                  </div>
                </div>
            </form>          
        </div>
    </div>
    <div id="MyOrders">
     <div id="grad" style="text-align: left;padding-top: 5px;">
         <h4 style="text-align: center;">Order History</h4>  <hr/>
         <div class="table-responsive">
            <table class="table table-bordered">
                <tr>
                    <th>Order ID</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th style="text-align: center;">Quantity</th>
                    <th class="hidden-xs">Date Ordered</th>
                    <th class="hidden-xs">Time</th>
                </tr>   
            <%
            String sql = "SELECT  `order_id` ,  `product_name` ,  `product_price` ,  `product_quantity` ,  `sold_on` "
                        +" FROM  `order` o "
                        +" INNER JOIN  `sales` s "
                        +" USING (  `order_id` ) "
                        +" WHERE o.`user_id` = "+uid+" "
                        + " ORDER BY `order_id` DESC ";
            Connection c = new DB_Conn().getConnection();
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
            while (rs.next()){
                newOrder = rs.getInt("order_id");
                product_name = rs.getString("product_name");
                product_price = rs.getDouble("product_price");
                product_quantity = rs.getInt("product_quantity");
                sold_on_time = rs.getTime("sold_on");
                sold_on_date = rs.getDate("sold_on");
                String orderDateArr [] = sold_on_date.toString().split("-");
                String billNo = "";
                for (int i= orderDateArr.length-1; i>= 1; i--){
                    billNo += orderDateArr[i];
                }
                billNo+= newOrder;
                if (oldOrder == newOrder){
                    // Dont Draw border Type II order Div
            %>
        <tr>
          <td></td>
          <td style="text-align: left;"><a href="product.jsp?id="></a><%= product_name %></td>
          <td><i class="fa fa-rupee"></i><%= product_price %></td>
          <td style="text-align: center;"><%= product_quantity %></td>
          <td class="hidden-xs"></td>
          <td class="hidden-xs"></td>
        </tr>     
        <%
         }else {
         // Draw New Order Type I order Div
        %>
           <!-- Type I Order -->
            <tr>
                <td><a class="blue" href="showMyBill.jsp?oid=<%= newOrder %>"><%= billNo %></a></td>
                <td><%= product_name %><a class="pull-right" href="showMyBill.jsp?oid=<%= newOrder %>">
                    <span class="button button-tiny button-flat button-wrap">View All</span></a></td>
                <td><i class="fa fa-rupee"></i><%= product_price %></td>
                <td style="text-align: center;"><%= product_quantity %></td>
                <td class="hidden-xs"><%= sold_on_date %></td>
                <td class="hidden-xs"><%= sold_on_time %></td>
            </tr>
            <%
            }
             oldOrder = newOrder;
            }
            %>         
          </table>
         </div>
        </div>
       </div>
       <div id="Account" style="margin-top: 2em;"><hr/>
        <h4 style ="text-align: center;">Account Details</h4>  <hr/>
         <div class="well" style="background-color:#f7f7f7;">
         <%
            if (User.getUsername() == null) {
         %>
         <form  class="form-horizontal" role="form" method="post" action="addUserDetalsServlet">
           <div class="form-group">
             <label for="name" class="col-sm-2 control-label">Full Name <span class="text-danger">*</span></label>
              <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="username" value="<%= User.getUsername()%>" placeholder="Enter Name" required>
              </div>
           </div>
           <div class="form-group">
            <label for="genderlabel" class="col-sm-2 control-label">Gender <span class="text-danger">*</span></label>
             <div class="col-sm-10">
               <select class="form-control" name="gender" id="genderlabel" required="yes">
                   <option selected="yes">Select an Option</option>
                   <option value="male">Male</option>
                    <option value="female">Female</option>
                </select>
              </div>
           </div>
             <div class="form-group">
                <label for="contactno" class="col-sm-2 control-label">Phone</label>
                <div class="col-sm-10">
                 <div class="input-group">
                   <span class="input-group-addon">+91</span>
                   <input type="text" class="form-control mobile" name="mobileNum" id="contactno" maxlength="10" placeholder="Phone Number">
                 </div>
                </div>
             </div>
             <div class="form-group">
                <label for="addressinput" class="col-sm-2 control-label">Address <span class="text-danger">*</span></label>
                <div class="col-sm-10">
                    <textarea class="form-control address"  rows="3" placeholder="Enter Full Shipping Address" name="address" required></textarea>
                </div>
            </div>
            <div class="form-group">
                <label for="disabledInput1" class="col-sm-2 control-label">City</label>
                 <div class="col-sm-10">
                     <input class="form-control" id="disabledInput1" type="text" placeholder="Hyderabad (Service available only in Hyderabad)" disabled>
                 </div>
            </div>
            <div class="form-group">
                <label for="disabledInput2" class="col-sm-2 control-label">State</label>
                 <div class="col-sm-10">
                    <input class="form-control" id="disabledInput2" type="text" placeholder="Andhra Pradesh (Service available only in AP)" disabled>
                 </div>
            </div>
            <div class="form-group">
                <div class="col-sm-offset-5 col-sm-10">
                  <input type="submit" class="btn btn-accent" value="Add Details"/>
                </div>
            </div>
        </form>
                <%
                }else {
                           %>
          <form class="form-horizontal" method="post" action="addUserDetalsServlet">
               <div class="form-group">
                <label for="name" class="col-sm-2 control-label">Full Name <span class="text-danger">*</span></label>
                <div class="col-sm-10">
                <input type="text" class="form-control" id="name" name="username" value="<%= User.getUsername()%>" placeholder="Enter Name" required>
                </div>
               </div>
               <div class="form-group">
               <label for="genderlabel" class="col-sm-2 control-label">Gender <span class="text-danger">*</span></label>
               <div class="col-sm-10">
               <select class="form-control" name="gender" id="genderlabel" required="yes">
                    <%
                        if (User.getGender().equals("male")) {
                    %>
                    <option value="male" selected>Male</option>
                    <option value="female">Female</option>
                    <%        } else {
                    %>
                    <option value="male">Male</option>
                    <option value="female" selected >Female</option>
                    <%                            }
                    %>
               </select>
               </div>
               </div>
                <div class="form-group">
                    <label for="contactno" class="col-sm-2 control-label">Phone</label>
                    <div class="col-sm-10">
                     <div class="input-group">
                       <span class="input-group-addon">+91</span>
                       <input type="text" class="form-control mobile" name="mobileNum" id="contactno" value="<%= User.getMobileNum()%>" maxlength="10" placeholder="Phone Number">
                     </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="addressinput" class="col-sm-2 control-label">Address <span class="text-danger">*</span></label>
                    <div class="col-sm-10">
                        <textarea class="form-control address"  rows="3" placeholder="Enter Full Shipping Address" name="address" required><%= User.getAddress()%></textarea>
                    </div>
                </div>
                <div class="form-group">
                    <label for="disabledInput1" class="col-sm-2 control-label">City</label>
                     <div class="col-sm-10">
                         <input class="form-control" id="disabledInput1" type="text" placeholder="Hyderabad (Service available only in Hyderabad)" disabled>
                     </div>
                </div>
                <div class="form-group">
                    <label for="disabledInput2" class="col-sm-2 control-label">State</label>
                     <div class="col-sm-10">
                        <input class="form-control" id="disabledInput2" type="text" placeholder="Andhra Pradesh (Service available only in AP)" disabled>
                     </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-5 col-sm-10">
                      <input type="submit" class="btn btn-accent" value="Change Details"/>
                    </div>
                </div>
            </form>
            <% 
                }
            %>
        </div>
    </div><hr/>
    <div id="Settings" style="margin-top:2em;">
        <h4 style ="text-align: center;">Change Password</h4>  <hr/>
        <div class="alert" style="background-color: #f2f3f4;"> 
        <form class="form-horizontal" method="post" action="changeMyPass">
            <div class="form-group">
                <label for="Inputemail" class="col-sm-2 control-label">Name</label>
                <div class="col-sm-10">
                    <input type="email" name="email" class="form-control" value="<%= printName %>" disabled/>
                    <small class="help-block">Go to <a href="#Account" id="account1" style="color: #0066cc;text-decoration: none;">Account Details</a> to change your name</small>
                </div>
            </div>
            <div class="form-group">
                <label for="Inputemail" class="col-sm-2 control-label">Username</label>
                <div class="col-sm-10">
                    <input type="email" name="email" class="form-control" value="<%= User.getUserEmail() %>" disabled/>
                    <small class="help-block">You cannot change your Username</small>
                </div>
            </div>
            <div class="form-group">
                <label for="Inputpwd" class="col-sm-2 control-label">New Password</label>
             <div class="col-sm-10">
                <input type="password" class="form-control" name="pass" />
                <small class="help-block">Choose something that&apos;s easy to remember but hard to guess. 6 characters min. You can also use special characters for added security</small>
             </div>
            </div>
            <div class="form-group">
                <label for="InputConfirmpwd" class="col-sm-2 control-label">Confirm Password</label>
             <div class="col-sm-10">
                 <input type="password" class="form-control"/>
                <small class="help-block">Repeat the same Passpord as above</small>
             </div>
            </div>
            <div class="form-group">
             <div class="col-sm-offset-5 col-sm-10">
               <input type="submit" class="btn button-primary" value="Change Password"/>
             </div>
            </div>
         </form>
      </div>
    </div>
    
    </div>
   </div>
 </div>
        <%
        //This is else closing of the top if checking of User Logged In...
        }        
%>
<div id="footer">        
    <jsp:include page="includesPage/_footer.jsp"></jsp:include>
</div>
<script type="text/javascript">
$('#account1').click(function(){
    $("html, body").animate({scrollTop: $("#Account").offset().top}, 500);
    return false;
});
$('#jump0').click(function(){
    $("html, body").animate({scrollTop: $("#UserProfile").offset().top}, 500);
    return false;
});
$('#jump1').click(function(){
    $("html, body").animate({scrollTop: $("#MyOrders").offset().top}, 500);
    return false;
});
$('#jump2').click(function(){
    $("html, body").animate({scrollTop: $("#Account").offset().top}, 500);
    return false;
});
$('#jump3').click(function(){
    $("html, body").animate({scrollTop: $("#Settings").offset().top}, 500);
    return false;
});
</script>
</body>
</html>

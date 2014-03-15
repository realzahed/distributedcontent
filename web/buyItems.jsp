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
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
    <style type="text/css">
        .shippingAddress {
            cursor: pointer;
        } 
        .fk-co-addr-seperator {
            width: 40px;
        }
        .fk-float-right, .flrt {
            float: right;
        }
        .co_select_or_label {
            width: 7%;
            font-size: 16px;
        }
        .fk-float-left, .fllt {
            float: left;
        }
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
        %>
        <%
          user User;
          String email=null;
           if ((session.getAttribute("user")==null)){
               //response.sendRedirect("index.jsp");
           }else {
               User = (user)session.getAttribute("user");
               email = User.getUserEmail();
        %>
        <div class="container">
            <div class="well">
                <div class="row">
                    <div class="col-md-8 col-md-push-7">
                    <h4>Enter Shipping Address</h4>
                    <form class="form-horizontal" method="post" action="buyItems" role="form">
                        <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">Name <span class="text-danger">*</span> </label>
                         <div class="col-sm-4">
                             <input type="text" class="form-control name" id="inputName" name="name" placeholder="Full Name" required>
                         </div>
                        </div>
                        <div class="form-group">
                            <label for="inputMobile" class="col-sm-2 control-label">Phone <span class="text-danger">*</span> </label>
                        <div class="col-sm-4">
                            <div class="input-group">
                                <span class="input-group-addon">+91</span>
                                <input type="text" class="form-control mobile" name="mobile" id="inputMobile" maxlength="10" placeholder="Phone Number">
                            </div>
                        </div>
                        </div>
                        <div class="form-group">
                        <label for="inputAddress" class="col-sm-2 control-label">Address <span class="text-danger">*</span> </label>
                         <div class="col-sm-4">
                            <textarea class="form-control address" id="inputAddress" name="address" required rows="3" placeholder="Enter Full Shipping Address" ></textarea> 
                        </div>
                        </div>
                        <div class="form-group">
                        <label for="disabledInput1" class="col-sm-2 control-label">City</label>
                         <div class="col-sm-4">
                            <input class="form-control" id="disabledInput1" type="text" placeholder="Hyderabad (Service available only in Hyderabad)" disabled>
                        </div>
                        </div>
                        <div class="form-group">
                        <label for="disabledInput2" class="col-sm-2 control-label">State</label>
                         <div class="col-sm-4">
                            <input class="form-control" id="disabledInput2" type="text" placeholder="Andhra Pradesh (Service available only in AP)" disabled>
                        </div>
                        </div>
                          <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                              <button type="submit" class="btn button-primary" value="Add Details">Place Order & Continue</button>
                            </div>
                           </div>
                          <span class="col-sm-offset-1 col-sm-10 help-block">Fields marked as  <span class="text-danger">*</span> are required.</span>
                    </form>
                </div>
               <div class="flrt fk-co-addr-seperator col-sm-1 col-md-pull-6 hidden-xs">
                    <div id="co_select_or_label" class="fllt co_select_or_label">
                        <b>OR</b>
                    </div>
                    <div class="flrt" style="width:60%;min-height:370px;border-left:1px solid #333333;margin-top: 30px;"></div>
               </div>
                     <%
               if (User.getAddress() != null && User.getMobileNum() != null && User.getUserEmail() != null && User.getUsername() != null){
                   %>
                  <div class="col-md-3 col-md-pull-7 shippingAddress" id="useInfo">
                      <div class="panel panel-info">
                        <div class="panel-heading">
                            <h3 class="panel-title"><i class="fa fa-map-marker fa-lg"></i> Saved Shipping Address</h3>
                          </div>
                          <div class="panel-body">
                            <form class="form-horizontal" role="form">
                            <div class="form-group">
                              <label class="col-sm-4 control-label">Name:</label>
                              <div class="col-sm-8">
                                  <p class="form-control-static text-info" id="userName"><%= User.getUsername() %></p>
                              </div>
                            </div>
                              <div class="form-group">
                                <label class="col-sm-4 control-label">Phone:</label>
                              <div class="col-sm-8">
                                <p class="form-control-static text-info" id ="mobile"><%= User.getMobileNum() %></p>
                              </div>
                              </div>
                               <div class="form-group">
                                <label class="col-sm-4 control-label">Address:</label>
                              <div class="col-sm-8">
                                <address class="form-control-static text-info" id ="useAddress"><%= User.getAddress() %></address> 
                              </div>
                               </div>
                              <div class="form-group">
                                <label class="col-sm-4 control-label">City:</label>
                              <div class="col-sm-8">
                                <p class="form-control-static text-muted" id ="useAddress">Hyderabad</p> 
                              </div>
                               </div>
                              <div class="form-group">
                                <label class="col-sm-4 control-label">State:</label>
                              <div class="col-sm-8">
                                <p class="form-control-static text-muted" id ="useAddress">Andhra Pradesh</p> 
                              </div>
                               </div>
                            </form>
                           </div>
                         <div class="panel-footer text-center">
                            <span class="btn btn-info btn-block btn-sm">Select Address <i class="fa fa-arrow-circle-o-right fa-fw fa-lg"></i></span>
                         </div>
                      </div>
                   <script type="text/javascript">
                       $(document).ready(function (){
                           $('#useInfo').click(function (){
                           var userName = $('#userName').text();
                           var mobile = $('#mobile').text();
                           var address = $('#useAddress').text();
                           
                            //alert (userName +" "+mobile+" "+address);
                               $('.name').attr('value', userName);
                               $('.address').attr('value', address);
                               $('.mobile').attr('value', mobile);
                           });
                       });
                   </script>
                    <%
                    }else {
                    %>
                   <a href="userinfo.jsp#Account">
                    <div class="alert alert-info col-md-3 col-md-pull-7 text-center" style="margin-top: 100px;">
                        <h2>Add your details for quick Checkout</h2>
                        <button type="button" class="btn btn-outline">Take Me There <i class="fa fa-arrow-circle-o-right fa-fw fa-lg"></i></button>
                    </div>
                   </a>
                            <%
                           }
                      }
                     %>
            </div>
          </div>
        </div>
      </div>
  </body>
</html>

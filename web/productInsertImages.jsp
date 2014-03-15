<!DOCTYPE HTML>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC</title>
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script>
    <script src="js/myScript.js"></script>
    <style type="text/css">
        #targetPrev {
            padding:5px;
            border:1px solid #CCC;
            background:#EEE;
        }
    </style>
    <script type = "text/javascript">

        function readURL(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                $('#targetPrev').hide();
                reader.onload = function (e) {
                    $('#targetPrev')
                    .attr('src', e.target.result)
                    .width(150);
                    $('#targetPrev').fadeIn(3000);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</head>
<body>
        <%@ page language="java" import="javazoom.upload.*,java.util.*" %>
        <%
            String path = application.getRealPath("uploads");
        %>
        <jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
            <jsp:setProperty name="upBean" property="folderstore" value="<%= path%>" />
        </jsp:useBean>
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
<div class="container">
  <div class="row">
            <div class="col-md-3">
             <div  id="sidebar-nav" class="list-group">
                 <a href="admin_Performance.jsp" class="list-group-item"><i class="fa fa-dashboard fa-lg fa-fw"></i> Dashboard</a>
                 <a href="admin_addProduct.jsp" class="list-group-item list-group-item-warning"><i class="fa fa-plus-square fa-lg fa-fw"></i> Add Product</a>
                 <a href="admin_manageProduct.jsp" class="list-group-item"><i class="fa fa-paperclip fa-lg fa-fw"></i> Manage Product</a>
                 <a href="admin_pendingOrders.jsp" class="list-group-item"><i class="fa fa-clock-o fa-lg fa-fw"></i> Pending Orders</a>
                 <a href="admin_approvedOrders.jsp" class="list-group-item"><i class="fa fa-check-square-o fa-lg fa-fw"></i> Approved Orders</a>
                 <a href="admin_deliveredOrders.jsp" class="list-group-item"><i class="fa fa-truck fa-lg fa-fw"></i> Delivered Orders</a>
                 <a href="admin_settings.jsp" class="list-group-item"><i class="fa fa-cog fa-lg fa-fw"></i> Settings</a>
             </div>
         </div>
         <div class="col-md-9">
           <div class="well">
             <h3>Steps for adding a product</h3>
               <p class="lead">Enter the following Information in the following steps to add a Product.</p>      
                  <div class="row form-group">
                    <div class="col-xs-12">
                       <ul class="nav nav-pills nav-justified thumbnail">
                           <li><a href="admin_addProduct_1.jsp">
                             <h4 class="list-group-item-heading" >Step 1</h4>
                             <p class="list-group-item-text">Product Company</p>
                           </a></li>
                           <li><a href="admin_addProduct_2.jsp">
                               <h4 class="list-group-item-heading">Step 2</h4>
                               <p class="list-group-item-text">Product Category</p>
                            </a></li>
                            <li><a href="admin_addProduct_3.jsp">
                                <h4 class="list-group-item-heading">Step 3</h4>
                                <p class="list-group-item-text">Product Name</p>
                            </a></li>
                            <li><a href="admin_addProduct_4.jsp">
                                 <h4 class="list-group-item-heading">Step 4</h4>
                                 <p class="list-group-item-text">Product Price</p>
                            </a></li>
                         </ul>
                      </div>
                   </div>
                </div><!--/.steps_well-->
                <div class="panel panel-warning">
                 <div class="panel-heading">
                   <h3 class="panel-title">
                        <%
                            if ((session.getAttribute("productName") == null)) {
                                // if email session is set, Dont show the message redirect to index
                                out.println("There is no product detected to insert an image for it...");
                            }else {
                        %>
                    </h3>
                     <h3 class="panel-title"><% out.print("Add Product Image for: " + session.getAttribute("productName"));%></h3> 
                  </div>
                  <div class="panel-body">
                      <p class="lead">
                        <%
                            out.print("Product Selected: " + session.getAttribute("productName"));
                        %>
                      </p>
                     <form class="form-horizontal" method="post" action="uploadImage.jsp" name="upform" enctype="multipart/form-data">
                      <img class="push_1" id="targetPrev" alt="your image" />
                        <table width="60%" cellspacing="1" cellpadding="1" align="center" class="style1">
                            <tr>
                                <td align="left"><b>Select Image to Upload:</b> <span class="label label-info" style="font-size: 100%;"> (JPEG/JPG or PNG ONLY)</span></td>
                            </tr>
                            <tr>
                                <td align="left">
                                    <input type="file" onchange="readURL(this);"  name="uploadfile" size="50">
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <input type="hidden" name="todo" value="upload">
                                    <input id="greenBtn" class="btn btn-success btn-embossed" type="submit" name="Submit" value="Upload">
                                    <br/>
                                </td>
                            </tr>
                        </table>
                        <%
                            if (request.getAttribute("fileName") != null) {
                        %>
                        <div class="well">
                            <h4>Result : <%= request.getAttribute("result")%>
                                <a href="admin_manageProduct.jsp?pid=<%= (String)session.getAttribute("productId") %>" style="float: right;" class="btn btn-default" id="buy" >Edit Product</a>
                            </h4>
                        <span class="label label-default">File Name:</span> <%= request.getAttribute("fileName")%><br />
                        <span class="label label-default">File Type:</span> <%= request.getAttribute("fileType")%><br />
                        <span class="label label-default">File Size:</span> <%= request.getAttribute("fileSize")%> bytes<br />
                        <%
                            String result = (String) request.getAttribute("result");
                            if (result.equals("File Uploaded Successfully")) {
                        %>
                        <span class="label label-default">File Location:</span> <%= path%>
                        <%
                                }
                            }
                          }
                        %>
                  </div>
               </form>
             </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

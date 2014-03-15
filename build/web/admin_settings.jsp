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
            if (session.getAttribute("user") == null) {// THen new user, show join now
%>
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%        } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%            }
            if (session.getAttribute("admin") == null) {
                response.sendRedirect("admin_.jsp");
            }
        %>
 <jsp:useBean class="admin.administrator" scope="session" id="admins"></jsp:useBean>
<div class="container">
    <div class="row">
         <div class="col-md-3">
            <div  id="sidebar-nav" class="list-group">
                <a href="admin_Performance.jsp" class="list-group-item"><i class="fa fa-dashboard fa-lg fa-fw"></i> Dashboard</a>
                <a href="admin_addProduct.jsp" class="list-group-item"><i class="fa fa-plus-square fa-lg fa-fw"></i> Add Product</a>
                <a href="admin_manageProduct.jsp" class="list-group-item"><i class="fa fa-paperclip fa-lg fa-fw"></i> Manage Product</a>
                <a href="admin_pendingOrders.jsp" class="list-group-item"><i class="fa fa-clock-o fa-lg fa-fw"></i> Pending Orders</a>
                <a href="admin_approvedOrders.jsp" class="list-group-item"><i class="fa fa-check-square-o fa-lg fa-fw"></i> Approved Orders</a>
                <a href="admin_deliveredOrders.jsp" class="list-group-item"><i class="fa fa-truck fa-lg fa-fw"></i> Delivered Orders</a>
                <a href="admin_settings.jsp" style="background-color: #ECF0F1;color: #000" class="list-group-item"><i class="fa fa-cog fa-lg fa-fw"></i> Settings</a>
            </div>
        </div>
        <div class="col-md-9">
            <div class="jumbotron">
                <h3 class="text-center">Administrator Settings </h3>
            </div>
            <%
                ArrayList<String> administrators = new ArrayList<String>();
                administrators.clear();
                administrators = admins.getListsOfAdmin();
            %>
                <div id="addAdmin" class="panel panel-default">
                    <div class="panel-heading">
                        <h4>Add an Administrator</h4>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" method="post" action="addAnAdministrator">
                         <div class="form-group">
                           <label class="col-sm-2 control-label">Select Email</label>
                            <div class="col-sm-10">
                                <select class="form-control" name="email">
                                    <%
                                        for (int i = 0; i < administrators.size(); i++) {
                                    %>
                                    <option value="<%= administrators.get(i).toString()%>"><%= administrators.get(i).toString()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Password</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="pass" placeholder="Assign Password" />
                            </div>
                        </div>
                         <div class="form-group">
                            <label class="col-sm-2 control-label">Confirm Password</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="passAgain" placeholder="Confirm Password" />
                            </div>
                        </div>
                        <div class="form-group text-center">
                            <input id="greenBtn" class="btn btn-accent" type="submit" value="Add Administrator"/>
                        </div>
                    </form>
                </div>
              </div>     
                <%
                    Connection c = new DB_Conn().getConnection();
                    Statement st = c.createStatement();
                    String sqlFetchCompany = "SELECT * FROM  `product-company` ";
                    String sqlFetchCategory = "SELECT * FROM  `category` ";
                    String sqlFetchSubCategory = "SELECT * FROM  `sub-category` ORDER BY `category_name` ";
                    ResultSet rs;
                %>
              <div id="manageCo" class="panel panel-default">
                <div class="panel-heading">
                    <h4 style="color: #333;">Manage Companies of Products in Catalog</h4>
                </div>
                      <form method="post" action="removeCompany">
                       <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                              <tr>
                                  <th style="text-align: center;">Select All <input type="checkbox" id="ckbCheckAll" /></th>
                                  <th>Company Name</th>
                              </tr>
                        <%

                            rs = st.executeQuery(sqlFetchCompany);
                            while (rs.next())  {
                            String companyId = rs.getString("company-id");
                            String company = rs.getString("company-name");
                        %>
                        <tr>
                           <td style="text-align: center;"><input style="display:inline;" type ="checkbox" class="checkBoxClass" name="company" value="<%= companyId %>" /></td>
                           <td><a><%= company %></a> </td>
                        </tr>
                        <%
                            }
                        %>
                     </table>
                    </div>
                     <div class="form-group text-center">
                     <input class="btn btn-bsu" type="submit" value="Delete Companies" id="buy"/>
                   </div>
                  </div>
                 </form>
                 </div>

               <div id="manageCa" class="panel panel-default">
                <div class="panel-heading">
                    <h4>Manage Categories of Products in Catalog</h4>
                </div>
                  <form method="post" action="removeCategory">
                    <div class="panel-body">
                        <table class="table table-striped">
                          <tr>
                              <th style="text-align: center;">Select All <input type="checkbox" id="ckbCheckAll1" /></th>
                              <th>Category Name</th>
                          </tr>
                        <%
                        rs = st.executeQuery(sqlFetchCategory);
                        while (rs.next())  {
                        String categoryId = rs.getString("category_id");
                        String categoryName = rs.getString("category_name");
                        %>
                      <tr>
                        <td style="text-align: center;"><input type ="checkbox" class="checkBoxClass1" name="category" value="<%= categoryId %>" /></td>
                        <td><a><%= categoryName %></a></td>
                      </tr>                         
                        <%
                            }
                        %>
                      </table>
                     <div class="form-group text-center">
                       <input class="btn btn-bsu" type="submit" value="Delete Categories"/>
                     </div>
                    </div>
                  </form>
                </div>

                <div id="manageSc" class="panel panel-default">
                <div class="panel-heading">
                    <h4>Manage Sub-Categories <i class="fa fa-chevron-right"></i> Category for Products in Catalog</h4>
                </div>
                 <form method="post" action="removeSubCategory">
                   <div class="panel-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                              <tr>
                                  <th style="text-align: center;">Select All <input type="checkbox" id="ckbCheckAll2" /></th>
                                  <th>Sub-Category Name</th>
                              </tr>
                    <%
                    
                        rs = st.executeQuery(sqlFetchSubCategory);
                        while (rs.next())  {
                            /*subcategory_id	sub-category_name category_name*/
                            String subCatId = rs.getString("subcategory_id");
                            String category_name = rs.getString("category_name");
                            String subCatName = rs.getString("sub-category_name");
                            %>
                          <tr>
                            <td style="text-align: center;"><input type ="checkbox" class="checkBoxClass2" name="subCategory" value="<%= subCatId %>" /></td>
                            <td><a><%= subCatName %></a> <i class="fa fa-chevron-circle-right"></i> <a><%= category_name %></a></td>
                          </tr> 
                    <%
                        }
                    %>
                    </table>
                    </div>
                   <div class="form-group text-center">
                      <input class="btn btn-bsu" type="submit" value="Delete Sub-Categories"/>
                   </div>
                 </div>
                </form>
              </div>
            </div>
        </div> 
    </div>
   <div id="scrolltoTop">
    <a href="#">Top <i class="fa fa-chevron-up"></i></a>
   </div>
<script type="text/javascript">
$('#scrolltoTop').click(function(){
        $("html, body").animate({ scrollTop: 0 }, 600);
        return false;
        });
</script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#ckbCheckAll").click(function () {
                $(".checkBoxClass").prop('checked', $(this).prop('checked'));
            });
            $("#ckbCheckAll1").click(function () {
                $(".checkBoxClass1").prop('checked', $(this).prop('checked'));
            });
            $("#ckbCheckAll2").click(function () {
                $(".checkBoxClass2").prop('checked', $(this).prop('checked'));
            });
        });
    </script>
  </body>
</html> 
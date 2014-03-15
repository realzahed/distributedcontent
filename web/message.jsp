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

        if ((request.getAttribute("message") == null) || (request.getAttribute("messageDetails") == null)){
        // if email session is set, Dont show the message redirect to index
            //response.sendRedirect("/index.jsp");
        }
%>
        <div class="container">
            <div class="well">
                <h3 class="text-center text-danger"><% out.print(request.getAttribute("message"));%></h3>
                <h4 class="text-center text-info">
                    <%                                                                
                        out.print(request.getAttribute("messageDetail"));
                    %>
                </h4>
            </div>
        </div>
    </body>
</html>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC Contact</title>
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
    <style>
        body {background: url(assets/img/bg-contact.gif) top no-repeat;background-position: 20% 80%;background-size: cover;}
        #map {width: 100%;height: 200px;margin-top: 100px;}
        #social a{font-size: 18px;text-decoration: none;}
        #social ul li a {margin-top: 3px;text-decoration: none;border-radius: 0px;}
        #social ul li a {color: #fff;}
        #social ul li a:hover {color: #f7f7f2;}
        @media(min-width:767px) {
          .content-section {color: #fff;padding-top: 50px;}
          .download-section {padding: 100px 0;}
          #map {height: 400px;margin-top: 250px;}}
    </style>
</head>
<body>
    <a href="#content" class="sr-only">Skip to main content</a>
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
    <section id="contact" class="container-fluid content-section text-center">
        <div class="row">
            <div class="text-center" id="social">
                <h2>Contact Distributed Content Access On Cloud Team</h2>
                <p>Feel free to email us to provide some feedback on our web-application, give us suggestions for adding new features, or to just say hello!</p>
                <a href="feedback@dcac.com">feedback@dcac.com</a>
                <ul class="list-inline banner-social-buttons">
                    <li><a href="https://twitter.com/dcac" style="background-color:#55ACEE;border-color: #55ACEE;" class="btn btn-danger"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a></li>
                    <li><a href="https://facebook.com/dcac" class="btn btn-facebook"><i class="fa fa-facebook-square fa-fw"></i> <span class="network-name">Facebook</span></a>
                    </li>
                    <li><a href="https://plus.google.com/dcac/posts" class="btn btn-danger"><i class="fa fa-google-plus fa-fw"></i> <span class="network-name">Google+</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <div id="map"></div>
    <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRngKslUGJTlibkQ3FkfTxj3Xss1UlZDA&sensor=false"></script>
    <!-- Custom Theme JavaScript -->
    <script type="text/javascript">
        var myOptions = {
            zoom: 18,
            center: new google.maps.LatLng(17.3840725, 78.4652117),
            mapTypeId: google.maps.MapTypeId.ROADMAP,
            disableDefaultUI: true,
            styles: [{"featureType":"water","elementType":"geometry","stylers":[{"color":"#333739"}]},{"featureType":"landscape","elementType":"geometry","stylers":[{"color":"#2ecc71"}]},{"featureType":"poi","stylers":[{"color":"#2ecc71"},{"lightness":-7}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2ecc71"},{"lightness":-28}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#2ecc71"},{"visibility":"on"},{"lightness":-15}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#2ecc71"},{"lightness":-18}]},{"elementType":"labels.text.fill","stylers":[{"color":"#ffffff"}]},{"elementType":"labels.text.stroke","stylers":[{"visibility":"off"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2ecc71"},{"lightness":-34}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"visibility":"on"},{"color":"#333739"},{"weight":0.8}]},{"featureType":"poi.park","stylers":[{"color":"#2ecc71"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#333739"},{"weight":0.3},{"lightness":10}]}]
        };
        var map = new google.maps.Map(document.getElementById('map'), myOptions);
    </script>
</body>
</html>

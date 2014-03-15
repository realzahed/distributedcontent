<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="DCAC - Major Project">
    <meta name="author" content="Zahed Shareef">
    <title>DCAC FAQ</title>        
    <!-- Default Stylesheets -->
    <link rel="icon" href="assets/img/icons/logo.ico"/>
    <link rel="stylesheet" href="assets/css/stylemain.css"/>
    <link rel="stylesheet" href="assets/css/font-awesome.min.css"/>
    <script src="js/jquery-1.7.2.min.js"></script> 
    <style>
    .ac-container{
      margin: 10px auto 30px auto;
      text-align: left;
      }
    .ac-container label{
      padding: 5px 20px;
      position: relative;
      z-index: 20;
      display: block;
      cursor: pointer;
      color: #777;
      text-shadow: 1px 1px 1px rgba(255,255,255,0.8);
      line-height: 33px;
      font-size: 19px;
      background: #eeedf1;
      box-shadow: 0px 0px 0px 1px rgba(155,155,155,0.3);
    }
    .ac-container label:hover{
      background: #fff;
    }
    .ac-container input:checked + label,
    .ac-container input:checked + label:hover{
      background: #e1e6e9;
      color: #3c4a54;
      text-shadow: 0px 1px 1px rgba(255,255,255, 0.6);
      box-shadow: 0px 0px 0px 1px rgba(155,155,155,0.3), 0px 2px 2px rgba(0,0,0,0.1);
    }
    .ac-container label:hover:after,
    .ac-container input:checked + label:hover:after{
      content: '';
      position: absolute;
      width: 24px;
      height: 24px;
      right: 13px;
      top: 7px;
      background: transparent url(assets/img/icons/arrow-down.png) no-repeat center center;	
    }
    .ac-container input:checked + label:hover:after{
      background-image: url(assets/img/icons/arrow-up.png);
    }
    .ac-container input{
      display: none;
    }
    .ac-container article{
      background: rgba(255, 255, 255, 0.5);
      margin-top: -1px;
      overflow: hidden;
      height: 0px;
      position: relative;
      z-index: 10;
      -webkit-transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
      -moz-transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
      -o-transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
      -ms-transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
      transition: height 0.3s ease-in-out, box-shadow 0.6s linear;
    }
    .ac-container article p{
        font-style: italic;
        color: #777;
        line-height: 23px;
        font-size: 14px;
        padding: 20px;
        text-shadow: 1px 1px 1px rgba(255,255,255,0.8);
    }
    .ac-container input:checked ~ article{
        -webkit-transition: height 0.5s ease-in-out, box-shadow 0.1s linear;
        -moz-transition: height 0.5s ease-in-out, box-shadow 0.1s linear;
        -o-transition: height 0.5s ease-in-out, box-shadow 0.1s linear;
        -ms-transition: height 0.5s ease-in-out, box-shadow 0.1s linear;
        transition: height 0.5s ease-in-out, box-shadow 0.1s linear;
        box-shadow: 0px 0px 0px 1px rgba(155,155,155,0.3);
    }
    .ac-container input:checked ~ article.ac-small{
        height: 140px;
    }
    .ac-container input:checked ~ article.ac-medium{
        height: 180px;
    }
    .ac-container input:checked ~ article.ac-large{
        height: 230px;
    }
    #contact {
        color: #ffffff;
        width: 100%;
        height: 10px;
        margin-top: 10px;
    }
    @media(min-width:767px) {
        .content-section {
            padding-top: 50px;
        }
        .download-section {
            padding: 100px 0;
        }
        #contact {
            color: #ffffff;
            height: 400px;
            margin-top: 250px;
        }
    }
    #social ul li a {
        text-decoration: none;
        border-radius: 0px;
    }
    #social ul li a:hover {
        color: #000;
    }
    </style>
 </head>
 <body style="background-color: #873260;">
        <%
            if (session.getAttribute("user") == null) {// THen new user, show join now
%>
        <jsp:include page="includesPage/_joinNow.jsp"></jsp:include>
        <%        } else {
        %>
        <jsp:include page="includesPage/_logout.jsp"></jsp:include>
        <%            }
        %>
      <section id="contact" class="container-fluid content-section text-center hidden-xs">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2" id="social">
                <h2>F.A.Q. Distributed Content Access On Cloud</h2>
                <p>Feel free to email us to provide some feedback on our web-application, give us suggestions for adding new features, or to just say hello!</p>
                <a href="feedback@dcac.com">feedback@dcac.com</a>
                <ul class="list-inline banner-social-buttons">
                    <li><a href="https://twitter.com/dcac" style="background-color:#87318c;border-color: #632466;" class="btn btn-danger"><i class="fa fa-twitter fa-fw"></i> <span class="network-name">Twitter</span></a></li>
                    <li><a href="https://facebook.com/dcac" class="btn btn-facebook"><i class="fa fa-facebook-square fa-fw"></i> <span class="network-name">Facebook</span></a>
                    </li>
                    <li><a href="https://plus.google.com/dcac/posts" class="btn btn-danger"><i class="fa fa-google-plus fa-fw"></i> <span class="network-name">Google+</span></a>
                    </li>
                </ul>
            </div>
        </div>
    </section>
    <div class="text-center visible-xs text-warning">
       <h2>F.A.Q. Distributed Content Access On Cloud</h2>
    </div>
    <section class="ac-container" style="background-color: #fff;">
        <div>
            <input id="ac-1" name="accordion-1" type="checkbox" />
            <label for="ac-1">Account</label>
            <article class="ac-small">
                <div class="list-group">
                    <a href="#" class="list-group-item">
                      <h4 class="list-group-item-heading">List group item heading</h4>
                      <p class="list-group-item-text">...</p>
                    </a>
                  </div>
            </article>
        </div>
        <div>
            <input id="ac-2" name="accordion-1" type="checkbox" />
            <label for="ac-2">Orders</label>
            <article class="ac-medium">
                <p>Some content... </p>
            </article>
        </div>
        <div>
            <input id="ac-3" name="accordion-1" type="checkbox" />
            <label for="ac-3">Shopping</label>
            <article class="ac-medium">
                <p>Some content... </p>
            </article>
        </div>
        <div>
            <input id="ac-4" name="accordion-1" type="checkbox" />
            <label for="ac-4">Order Status</label>
            <article class="ac-medium">
                <p>Some content... </p>
            </article>
        </div>
        <div>
            <input id="ac-5" name="accordion-1" type="checkbox" />
            <label for="ac-5">Media Formats and Copyright</label>
            <article class="ac-medium">
                <p>Some content... </p>
            </article>
        </div>
        <div>
            <input id="ac-6" name="accordion-1" type="checkbox" />
            <label for="ac-6">Troubleshooting FAQ</label>
            <article class="ac-medium">
                <p>Some content... </p>
            </article>
        </div>
    </section>
    <jsp:include page="includesPage/_footer.jsp"></jsp:include>
</body>
</html>

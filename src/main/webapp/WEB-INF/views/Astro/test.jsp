<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
String astroTitle = (String) request.getAttribute("astroTitle");
String locdate = (String) request.getAttribute("locdate");
String astroEvent = (String) request.getAttribute("astroEvent");
String astroTime = (String) request.getAttribute("astroTime");
%>
<%@include file="../import/heads.jsp"%>    
        <title>The Big Picture - Start Bootstrap Template</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">

<style>
                *{
                        font-family: 'Gowun Dodum', sans-serif;
                        color: white;
                }
            right{
                float: right;
            }
        </style>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>

<br>
<!-- Page Content-->
<section>
        <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5">
                        <div class="col-lg-6">
                                <h1 class="mt-5 weather" >The Big Picture</h1>
                                <p class="weather">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deserunt voluptates rerum eveniet sapiente repellat esse, doloremque quod recusandae deleniti nostrum assumenda vel beatae sed aut modi nesciunt porro quisquam voluptatem.</p>
                        </div>
                </div>
        </div>
</section>
<div>

        <div>
                <p><%=CmmUtil.nvl(astroTitle) %></p>
        </div><br>
        <div>
                <p><%=CmmUtil.nvl(locdate)%></p>
        </div><br>
        <div>
                <p><%=CmmUtil.nvl(astroEvent) %></p>
        </div>


</div>




<script src="https://code.jquery.com/jquery-latest.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" type=""></script>
<!-- Core theme JS-->
<script src="static/js/scripts.js"></script>
</body>
</html>

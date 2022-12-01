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
        <title>우주현상 조회</title>

<style>

            right{
                float: right;
            }
        </style>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>

<br>
<!-- Page Content-->
<div class="container" >
        <div class="row justify-content-center">
                <div class="col-lg-9">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header"><h3 class="text-center font-weight-light my-4"><strong><%=locdate%></strong></h3></div>
                                <div class="text-center" style="margin-top: 10px";><h3><%=astroTitle%></h3></div>
                                <hr>
                                <div class="card-body" style="padding: 30px">
                                        <div class="text-center">
                                                <%=astroEvent%>
                                        </div>
                                        <button class="btn btn--block card__btn" style="margin-top: 10px; float:right;" onclick=location.href="/Astro/selectDate">뒤로</button>
                                </div>
                        </div>
                </div>
        </div>
<div>

</div>


<%@include file="../import/footer.jsp"%>
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
                                <h1 class="mt-5 weather" >천문 현상 조회</h1>

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
<!--
<div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
                <main>
                        <div class="container">
                                <div class="row justify-content-center">
                                        <div class="col-lg-7">
                                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                                        <div class="card-header"><h3 class="text-center font-weight-light my-4">Create Account</h3></div>
                                                        <div class="card-body">
                                                                <form name="f" method="post" action="/Userinfoinsert" target= "ifrPrc" onsubmit="return doSubmit(this);" >
                                                                        <div class="row mb-3">
                                                                                <div class="col-md-6">
                                                                                        <div class="form-floating mb-3 mb-md-0">
                                                                                                <input class="form-control" id="user_id" name="user_id" type="text" required oninput="idCheck()" />
                                                                                                <span class="id_ok">사용 가능한 아이디입니다.</span>
                                                                                                <span class="id_already">중복된 아이디입니다</span>
                                                                                                <!-- <span class="id_length">8자 이상 입력해주세요</span>
                                                                                                <label for="user_id">아이디</label>

                                                                                        </div>
                                                                                </div>

                                                                                <div class="col-md-6">
                                                                                        <div class="form-floating mb-3 mb-md-0">
                                                                                                <input class="form-control" id="password" name="password" type="password"  />
                                                                                                <label for="password">비밀번호</label>
                                                                                        </div>
                                                                                </div>
                                                                                <div class="col-md-6">
                                                                                        <div class="form-floating mb-3 mb-md-0">
                                                                                                <input class="form-control" id="user_name" name="user_name" type="text"  />
                                                                                                <label for="user_name">이름</label>

                                                                                        </div>
                                                                                </div>

                                                                                <div class = "col-md-10">
                                                                                        <div class="form-floating mb-3">
                                                                                                <input class="form-control" id="emailText" name="emailText" type="email"  />
                                                                                                <label for="emailText">이메일</label>

                                                                                        </div>
                                                                                </div>
                                                                                <div class = "col-md-10">
                                                                                        <div class="form-floating mb-3">
                                                                                                <button type="button" name="emailCheck" id="emailCheck" onclick="emailSend()">인증메일 전송</button>

                                                                                        </div>
                                                                                </div>


                                                                        </div>
                                                                </form>
                                                        </div>

                                                </div>
                                        </div>
                                </div>
                        </div>
                </main>
        </div>
</div>
-->


<script src="https://code.jquery.com/jquery-latest.js"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" type=""></script>
<!-- Core theme JS-->
<script src="static/js/scripts.js"></script>
</body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@include file="import/heads.jsp"%>
           <title>로그인</title>
        <link rel="stylesheet" href="/css/login.css">
        <style>
            *{
                font-family: 'Gowun Dodum', sans-serif;
            }
        </style>

        <script type="text/javascript">
            function doSubmit(f) {
                if (f.user_id.value == "") {
                    alert("아이디를 입력하시기 바랍니다.");
                    f.user_id.focus();
                    return false;
                }
                if (f.password.value == "") {
                    alert("비밀번호를 입력하시기 바랍니다.");
                    f.password.focus();
                    return false;
                }
            }
        </script>


    </head>
    <body>
    <%@include file="import/Navigation.jsp"%>
    <!-- Page Content-->
    <section>
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5">
                <div class="col-lg-6">
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                </div>
            </div>
        </div>
    </section>
    <div class="login-form">
        <div class="card-header" style="background-color: #eeeff1">
            <h3 class="text-center font-weight-light my-4">로그인</h3>

        </div>

        <form name="l" action="/Login" method="post" onsubmit="return doSubmit(this);">
            <input type="text" name="user_id" class="text-field" placeholder="아이디"><br>
            <input type="password" name="password" class="text-field" placeholder="비밀번호"><br>
            <input type="submit" value="로그인" class="submit-btn">

        </form>

        <div class="links">
            <a href="/FindPwdi">비밀번호를 잊어버리셨나요?</a>
        </div>

        <div class="links">
            <a href="/register">회원가입</a>
        </div>

    </div>


<%@include file="import/footer.jsp"%>

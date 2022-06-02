<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@include file="import/heads.jsp"%>
           <title>The Big Picture - Start Bootstrap Template</title>
        

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
    <body class="bg-primary">
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
        <div id="layoutAuthentication" >
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                    <div class="card-body">
                                        <form name="l" action="/Login" method="post" onsubmit="return doSubmit(this);">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="user_id" name="user_id" type="text" placeholder="user_id" />
                                                <label for="user_id">아이디</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="password" name="password" type="password" placeholder="Password" />
                                                <label for="password">비밀번호</label>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <a class="small" href="/FindPwd">Forgot Password?</a>
                                                <input type="submit" value="로그인">
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="/register">회원가입</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>


    </body>
</html>

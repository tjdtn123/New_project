<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% //String user_id = request.getParameter("user_id");
   //session.setAttribute("PwdSession", user_id);
    String session_id = session.getAttribute("user_id").toString();%>
<%@include file="import/heads.jsp"%>
<title>비밀번호 변경</title>



    <script type="text/javascript">
        function doSubmit(f) {
            if (f.password.value !== f.pwd_check.value) {
                alert("비밀번호가 일치하지 않습니다");
                f.password.focus();
                return false;
            }
        }
    </script>
</head>
<body class="bg-primary">
<%@include file="import/Navigation.jsp"%>
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
                                <form name="l" action="/ChangePwd" method="post" onsubmit="return doSubmit(this);">
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="password" name="password" type="text" placeholder="password" />
                                        <label for="password">새 비밀번호</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="pwd_check" name="pwd_check" type="pwd_check" placeholder="pwd_check" />
                                        <label for="pwd_check">새 비밀번호 확인</label>
                                    </div>
                                    <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                        <a class="small" href="/FindPwd">Forgot Password?</a>
                                        <input type="submit" value="확인">
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

</body>
</html>

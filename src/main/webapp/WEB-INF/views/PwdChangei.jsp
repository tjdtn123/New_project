<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="import/heads.jsp"%>
<%
        UserInfoDTO rDTO = (UserInfoDTO)request.getAttribute("uDTO");



%>


<title>비밀번호 변경</title>
<link rel="stylesheet" href="/css/login.css">
<link rel="stylesheet" href="/css/nomal.css">

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
<body>
<%@include file="import/Navigation.jsp"%>

            <div class="container" style="margin-top: 200px;">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header"><h3 class="text-center font-weight-light my-4"><strong>비밀번호 변경</strong></h3></div>
                            <div class="card-body">
                                <form name="l" action="/ChangePwdi" method="post" onsubmit="return doSubmit(this);">
                                    <input hidden name="user_id" value="<%=CmmUtil.nvl(rDTO.getUser_id())%>">
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="password" name="password" type="password" placeholder="password" />
                                        <label for="password">새 비밀번호</label>
                                    </div>
                                    <div class="form-floating mb-3">
                                        <input class="form-control" id="pwd_check" name="pwd_check" type="password" placeholder="pwd_check" />
                                        <label for="pwd_check">새 비밀번호 확인</label>
                                    </div>
                                    <div class="mt-4 mb-0 text-end">
                                        <input type="submit"  class="submit-btn-100" value="확인">
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

<%@include file="import/footer.jsp"%>
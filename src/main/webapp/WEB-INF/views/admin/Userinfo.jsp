<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    UserInfoDTO rDTO = (UserInfoDTO) request.getAttribute("Userinfo");

%>
<%@include file="../import/heads.jsp"%>

    <title>마이페이지</title>
<style>
    .garo {
        display: inline-block;
    }
</style>
<script>
    function doEdit(user_id) {

            location.href = "/admin/EditUserinfo?user_id=" + user_id;

    }
</script>
</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-7">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header"><h3 class="text-center font-weight-light my-4">회원정보</h3></div>
                                <div class="card-body">
                                        <div class=" ">
                                            <div class="garo">
                                                <div>아이디</div>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getUser_id())%></div>
                                            </div>
                                        </div>
                                        <div class="">
                                            <div class="garo">
                                                <div>비밀번호</div>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getPassword())%></div>
                                            </div>
                                        </div>
                                        <div class="">
                                            <div class="garo">
                                                <div>이름</div>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getUser_name())%></div>
                                            </div>
                                        </div>
                                        <div class="">
                                            <div class="garo">
                                                <div>이메일</div>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getEmail())%></div>
                                            </div>
                                        </div>
                                    <div>
                                        <div colspan="4">
                                            <a href="javascript:doEdit('<%=CmmUtil.nvl(rDTO.getUser_id())%>');">[수정]</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>


</body>


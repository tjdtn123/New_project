<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    UserInfoDTO rDTO = (UserInfoDTO) request.getAttribute("Myinfo");

%>
<%@include file="../import/heads.jsp"%>

    <title>마이페이지</title>
<script>
    function doEdit() {

            location.href = "/board/BoardEditInfo";

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
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <label>이름</label>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getUser_name())%></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <label>이메일</label>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getEmail())%></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <label>주소</label>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getAddr1())%></div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <label>상세주소</label>
                                                <div colspan="3"><%=CmmUtil.nvl(rDTO.getAddr2())%></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div>
                                        <div colspan="4">
                                            <a href="javascript:doEdit();">[수정]</a>
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


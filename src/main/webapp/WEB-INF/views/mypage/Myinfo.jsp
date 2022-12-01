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
    function doEdit(user_id) {
            location.href = "/mypage/EditMyinfo?user_id="+user_id;

    }
</script>
</head>
<body>
<%@include file="../import/Navigation.jsp"%>
    <div class="container" >
        <div class="row justify-content-center">
            <div class="col-lg-9">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                    <div class="card-header"><h1 class="text-center font-weight-light my-4"><strong>회원 정보</strong></h1></div>
    
    
                    <div class="card-body" style="padding: 30px">
    
    
                        <div class="text-center">
                            <div style="display: flex;">
                                <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>아이디</strong></h4></div>
                                <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getUser_id())%></strong></h4></div>
                            </div>
                            <br>
                            <div style="display: flex;">
                                <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>이름</strong></h4></div>
                                <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getUser_name())%></strong></h4></div>
                            </div>
                            <br>
                            <div style="display: flex;">
                                <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>이메일</strong></h4></div>
                                <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getEmail())%></strong></h4></div>
                            </div>
                            <br>
    
                            <br>
                        </div>
                        <div style="display: flex; float: right;">
                            <button class="btn btn--block card__btn" onclick="doEdit('<%=CmmUtil.nvl(rDTO.getUser_id())%>')">수정</button>
                            <button class="btn btn--block card__btn" style="margin-left: 10px;" onclick="history.back()">목록</button>
                        </div>
    
                    </div>
                </div>
            </div>
        </div>
    </div>


<%@include file="../import/footer.jsp"%>


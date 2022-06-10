<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../import/heads.jsp"%>
    <title>마이페이지</title>
    <link rel="stylesheet" href="../css/button.css">
    <script src="../js/scripts.js"></script>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<div class="centerer">
    <h1>마이페이지</h1>

    <div class="wrap">
        <a class="btn-0" href="#">내 별자리</a>
        <a class="btn-1" href="/mypage/Myinfo">회원 정보</a>
    </div>
    <div class="wrap">
        <a class="btn-6" href="/PwdChange">비밀번호 변경<span></span></a>
        <a class="btn-7" href="/mypage/DeleteUser"><span>회원 탈퇴</span></a>
    </div>
</div>
</body>


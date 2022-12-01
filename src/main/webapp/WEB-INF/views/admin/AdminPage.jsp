<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../import/heads.jsp"%>
    <title>관리자</title>

<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/nomal.css">
<link rel="stylesheet" href="../css/login.css">

</head>
<body>
<%@include file="../import/Navigation.jsp"%>

<h1 class="text-center mt-5">관리자 페이지</h1>

<div class="container text-center col-md-3">
    <div >
        <button class="baton-0 mg5 mt-5"onclick=location.href="/admin/AdStarList">별자리관리</button>
        <button class="baton-0 mg5 mt-5"onclick=location.href="/admin/UserList">회원 관리</button>
        <button class="baton-0 mg5 mt-5"onclick=location.href="/Logout">로그아웃</button>

    </div>
</div>

<%@include file="../import/footer.jsp"%>
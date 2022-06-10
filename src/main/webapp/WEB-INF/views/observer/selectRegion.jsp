<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%! String id_session;

%>
<%if(session.getAttribute("user_id") != null) {
    id_session = session.getAttribute("user_id").toString();

}
%>
<%@include file="../import/heads.jsp"%>
        <title>The Big Picture - Start Bootstrap Template</title>





</head>
<body class="bg-primary">
<%@include file="../import/Navigation.jsp"%>
<br>
<br>

<form method="get" action="/observer/obsPage">
    <div class="form-row align-items-center">
        <div class="col-auto my-1">
            <label class="mr-sm-2" for="inlineFormCustomSelect">지역</label>
            <select class="custom-select mr-sm-2" id="inlineFormCustomSelect" name="region">
                <option selected>지역선택</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충북">충북</option>
                <option value="충남">충남</option>
                <option value="대전">대전</option>
                <option value="전북">전북</option>
                <option value="전남">전남</option>
                <option value="광주">광주</option>
                <option value="경북">경북</option>
                <option value="경남">경남</option>
                <option value="부산">부산</option>
                <option value="제주">제주</option>
            </select>
        </div>
        <div class="col-auto my-1">
            <button type="submit" class="btn btn-primary">검색</button>
        </div>
    </div>
</form>

</body>
</html>

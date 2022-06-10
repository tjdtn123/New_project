<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../import/heads.jsp"%>
        <title>날짜 선택</title>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<br>
<br>

<form method="get" action="/Star/StarList">
    <div class="form-row align-items-center">
        <div class="col-auto my-1">
            <label class="mr-sm-2" for="inlineFormCustomSelect">지역</label>
            <select class="custom-select mr-sm-2" id="inlineFormCustomSelect" name="season">
                <option selected>계절</option>
                <option value="봄철 밤하늘 별자리">봄</option>
                <option value="여름철 밤하늘 별자리">여름</option>
                <option value="가을철 밤하늘 별자리">가을</option>
                <option value="겨울철 밤하늘 별자리">겨울</option>

            </select>
        </div>
        <div class="col-auto my-1">
            <button type="submit" class="btn btn-primary">검색</button>
        </div>
    </div>
</form>

</body>
</html>

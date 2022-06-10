<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../import/heads.jsp"%>
        <title>날짜 선택</title>

</head>
<body class="bg-primary">
<%@include file="../import/Navigation.jsp"%>
<br>
<br>

<form method="get" action="/Astro/test">
    <div class="form-row align-items-center">
        <div class="col-auto my-1">
            <label class="mr-sm-2" for="inlineFormCustomSelect">지역</label>
            <select class="custom-select mr-sm-2" id="inlineFormCustomSelect" name="year">
                <option selected>연도</option>
                <option value="2016">2016</option>
                <option value="2017">2017</option>
                <option value="2018">2018</option>
                <option value="2019">2019</option>
                <option value="2020">2020</option>
                <option value="2021">2021</option>
                <option value="2022">2022</option>
            </select>
        </div>
        <div class="col-auto my-1">
            <label class="mr-sm-2" for="custom">지역</label>
            <select class="custom-select mr-sm-2" id="custom" name="month">
                <option selected>월</option>
                <option value="01">1월</option>
                <option value="02">2월</option>
                <option value="03">3월</option>
                <option value="04">4월</option>
                <option value="05">5월</option>
                <option value="06">6월</option>
                <option value="07">7월</option>
                <option value="08">8월</option>
                <option value="09">9월</option>
                <option value="10">10월</option>
                <option value="11">11월</option>
                <option value="12">12월</option>
            </select>
        </div>
        <div class="col-auto my-1">
            <button type="submit" class="btn btn-primary">검색</button>
        </div>
    </div>
</form>

</body>
</html>

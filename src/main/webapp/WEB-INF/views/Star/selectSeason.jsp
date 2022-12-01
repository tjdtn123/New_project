<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width text/html, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" type="image/x-icon" href="/assets/wallpaper.jpg" />

    <script src="https://code.jquery.com/jquery-latest.js"></script>
        <title>날짜 선택</title>
    <!--글꼴 -->

    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="../css/styless.css">
    <link rel="stylesheet" href="../css/nomal.css">

    <link href='https://fonts.googleapis.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" href="../css/stars.css">
    <style>
        *{
            font-family: 'Gowun Dodum', sans-serif;

        }
    </style>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<br>
<br>

<div id="stars"></div>
<div id="stars2"></div>
<div id="stars3"></div>
<br>
<br>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-lg border-0 rounded-lg mt-5">
                <div class="card-header py-3"><h2 class="text-center"><strong>별자리 조회</strong></h2></div>
                <div class="card-body">
                <form method="get" action="/Star/StarList">
                    <div class="form-row align-items-center">
                        <div class="col-auto my-1 text-center">
                            <label class="mr-sm-2" for="inlineFormCustomSelect">지역</label>
                            <select class="form-select" id="inlineFormCustomSelect" name="season">
                                <option selected>계절</option>
                                <option value="봄철 밤하늘 별자리">봄</option>
                                <option value="여름철 밤하늘 별자리">여름</option>
                                <option value="가을철 밤하늘 별자리">가을</option>
                                <option value="겨울철 밤하늘 별자리">겨울</option>

                            </select>
                        </div>
                        <div class="col-auto my-1"  style="margin-left: 88%">
                            <button class="btn btn-secondary"  type="submit">검색</button>
                        </div>
                    </div>
                </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>


</script>

<%@include file="../import/footer.jsp"%>
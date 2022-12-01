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
    <title>연월 선택</title>
    <!--글꼴 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
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
<div id="stars"></div>
<div id="stars2"></div>
<div id="stars3"></div>
<br>
<br>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7">
            <div class="card shadow-lg border-0 rounded-lg mt-5">
                <div class="card-header py-3"><h2 class="text-center"><strong>우주 현상 검색</strong></h2></div>
                <div class="card-body">
                    <form method="get" action="/Astro/test">
                        <div style="display: flex">
                        <select class="form-select" name="year">
                            <option selected>연도</option>
                            <option value="2016">2016</option>
                            <option value="2017">2017</option>
                            <option value="2018">2018</option>
                            <option value="2019">2019</option>
                            <option value="2020">2020</option>
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                        </select>

                        <select class="form-select" id="custom" name="month">
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
                        <div class="class=col-auto my-1" style="margin-left: 88%;">
                            <button type="submit" class="btn btn-secondary">검색</button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
    </div>
</div>
<%@include file="../import/footer.jsp"%>

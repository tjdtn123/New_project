<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>글쓰기</title>
    <!-- include libraries(jQuery, bootstrap) -->
    <script src="https://code.jquery.com/jquery-latest.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <!-- CKEditor 5 CDN 적용-->
    <script src="/static/ckeditor/build/ckeditor.js"></script>
    <style>
        body {
            background-image : url("/static/assets/wallpaper.jpg");

        }

    </style>
</head>


<!-- Navigation-->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container px-4 px-lg-5" >
        <a class="navbar-brand" href="/index">Start Bootstrap</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active"><a class="nav-link" href="/Star000">별자리</a></li>
                <li class="nav-item"><a class="nav-link" href="/History000">우주 현상 </a></li>
                <li class="nav-item"><a class="nav-link" href="Obs000">국내 천문대</a></li>
                <li class="nav-item arrows-on-right-horizontal"><a class="nav-link" href="/BoardList">게시판</a></li>
            </ul>
        </div>
        <div class="collapse navbar-collapse"  align="right">
            <ul class="navbar-nav ml-auto">
                <% if(session.getAttribute("user_id") == null){%>
                <li class="nav-item"><a class="nav-link" href="/LoginPage">로그인</a></li>
                <%}%>
                <!--<form  required oninput="Show()">-->
                <% if(session.getAttribute("user_id") != null){%>
                <li class="nav-item"><a class="nav-link" href="#!">마이페이지</a></li>
                <li class="nav-item"><a class="nav-link" href="/Logout">로그아웃</a></li>
                <%}%>
                <!--</form>-->
            </ul>
        </div>
    </div>
</nav>
<br>
<br>
<br>
    <hr class="divider-w">
    <section class="module-small">
        <div class="container">
            <div class="row multi-columns-row">
                <form>
                    <c:forEach items="${itemList}" var="itemList">
                        <div class="col-sm-6 col-md-3 col-lg-3 mt-60 mb-40">

                            <div class="shop-item">
                                <a href="/main/itemContent?item_no=${itemList.item_no}&page=${cri.page}&perPageNum=${cri.perPageNum}&catemain=${cri.catemain}&catesub=${cri.catesub}&sort=${cri.sort}">
                                    <div class="shop-item-image"><img width="10%" src="/img/${itemList.item_imgmain}" alt="Accessories Pack"/>
                                        <div class="shop-item-detail"><img src="/img/${itemList.item_imgsub}" alt="Accessories Pack"/></div>
                                    </div>
                                    <h4 class="shop-item-title font-alt">${itemList.item_name}</h4>
                                    ₩ <fmt:formatNumber pattern="###,###,###" value="${itemList.item_price}"/>
                                </a>
                            </div>

                        </div>
                    </c:forEach>
                </form>

            </div>

            <div class="row">
                <div class="col-sm-12" style="text-align:center;">
                    <div class="pagination font-alt">

                        <c:if test="${pageMaker.prev}">
                            <a href="/main/itemView${pageMaker.makeQuery(pageMaker.startPage - 1)}"><i class="fa fa-angle-left"></i></a>
                        </c:if>

                        <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
                            <a class="active" href="/main/itemView${pageMaker.makeQuery(idx)}">${idx}</a>
                        </c:forEach>

                        <c:if test="${pageMaker.next && pageMaker.endPage > 0}">
                            <a href="/main/itemView${pageMaker.makeQuery(pageMaker.endPage + 1)}"><i class="fa fa-angle-right"></i></a>
                        </c:if>

                    </div>
                </div>
            </div>
        </div>
    </section>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>

</body>
</html>


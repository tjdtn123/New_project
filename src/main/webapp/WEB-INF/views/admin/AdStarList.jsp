<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="kopo.poly.dto.StarDTO"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@include file="../import/heads.jsp"%>
<% List<StarDTO> rList = (List<StarDTO>)request.getAttribute("rList");
    if (rList == null) {
        rList = new ArrayList<StarDTO>();

    }

%>
    <title>마이페이지</title>

<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/nomal.css">
</head>
<script>
    function domove(starNm){
        location.href = "/admin/AdStarInfo?star_name="+starNm;

    }


</script>
<body>
<%@include file="../import/Navigation.jsp"%>

<section class="py-5">
    <div class="container px-4 px-lg-5 mt-5">
        <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
            <%
                for (int i = 0; i < rList.size(); i++) {
                    StarDTO rDTO = rList.get(i);

                    if (rDTO == null) {
                        rDTO = new StarDTO();
                    }
            %>
            <div class="col mb-5 ">
                <div class="card h-100 p-1">
                    <!-- Product image-->
                    <img class="card-img-top" style="width: auto; height:244px;" src="<%=CmmUtil.nvl(rDTO.getPicture())%>" alt="..." />
                    <!-- Product details-->
                    <div class="card-body p-4">
                        <div class="text-center">
                            <!-- Product name-->
                            <h5 class="fw-bolder"><%=CmmUtil.nvl(rDTO.getStar_name())%></h5>
                        </div>
                    </div>
                    <!-- Product actions-->
                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                        <div class="text-center"><button type="button" style="margin: auto;" class="btn btn__3" onclick="domove('<%=CmmUtil.nvl(rDTO.getStar_name())%>')">자세히 보기</button></div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

<div style="float:right; margin-right: 7%; margin-top: 50px;">
    <button class="submit-btn" onclick="location.href='/admin/StarReg'"><STRONG>별자리 등록</STRONG></button>
</div>

<div style="margin-left: 30%; margin-bottom: 10%;">
        <ul id="pageInfo" class="pageInfo" >
            <!-- 이전페이지 버튼 -->
            <c:if test="${pageMaker.prev}">
                <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}"> << </a></li>
            </c:if>
            <!-- 각 번호 페이지 버튼 -->
            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
            </c:forEach>

            <!-- 다음페이지 버튼 -->
            <c:if test="${pageMaker.next}">
                <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }"> >> </a></li>
            </c:if>
        </ul>
</div>

<form id="moveForm" method="get">
    <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
    <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
</form>


<script type="text/javascript">

    let moveForm = $("#moveForm");

    $(".move").on("click", function (e){
        e.preventDefault();

        moveForm.append("<input type='hidden' name ='board_seq' value='"+ $(this).attr("href")+ "'>");
        moveForm.attr("action", "admin/");
        moveForm.submit();
    });


    $(".pageInfo a").on("click", function(e){

        e.preventDefault();
        moveForm.find("input[name='pageNum']").val($(this).attr("href"));
        moveForm.attr("action", "/admin/AdStarList");
        moveForm.submit();

    });

</script>
<%@include file="../import/footer.jsp"%>

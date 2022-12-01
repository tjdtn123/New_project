<%@ page import="kopo.poly.dto.StarDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../import/heads.jsp"%>
<% List<StarDTO> rList = (List<StarDTO>)request.getAttribute("rList");
    if (rList == null) {
        rList = new ArrayList<StarDTO>();

    }
%>
    <title>내 별자리 조회</title>

<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/nomal.css">
</head>
<script>
    function domove(starNm){
        location.href = "/Star/StarInfo?star_name="+starNm;

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


<%@include file="../import/footer.jsp"%>


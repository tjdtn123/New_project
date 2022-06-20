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
    <title>마이페이지</title>
<link href="../css/styles.css" rel="stylesheet">
</head>
<script>
    function domove(starNm){
        location.href = "/Star/StarInfo?star_name="+starNm;

    }
</script>
<body>
<%@include file="../import/Navigation.jsp"%>
    <!-- <section>
        <ul class="cards">

            <li class="cards__item">
                <div class="card">
                    <div class="card__image" style="background-image: url('<%//=CmmUtil.nvl(rDTO.getPicture())%>');"></div>
                    <div class="card__content">
                        <div class="card__title"><%//=CmmUtil.nvl(rDTO.getStar_name())%></div>
                        <button class="btn btn--block " onclick="domove('<%//=CmmUtil.nvl(rDTO.getStar_name())%>')">자세히 보기</button>
                    </div>
                </div>
            </li>

        </ul>
     </section>
     -->
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
            <div class="col mb-5">
                <div class="card h-100">
                    <!-- Product image-->
                    <img class="card-img-top" style="object-fit: scale-down" src="<%=CmmUtil.nvl(rDTO.getPicture())%>" alt="..." />
                    <!-- Product details-->
                    <div class="card-body p-4">
                        <div class="text-center">
                            <!-- Product name-->
                            <h5 class="fw-bolder"><%=CmmUtil.nvl(rDTO.getStar_name())%></h5>
                        </div>
                    </div>
                    <!-- Product actions-->
                    <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                        <div class="text-center"><a class="btn btn-outline-star mt-auto" onclick="domove('<%=CmmUtil.nvl(rDTO.getStar_name())%>')">자세히 보기</a></div>
                    </div>
                </div>
            </div>
            <%
                }
            %>
        </div>
    </div>
</section>

</body>


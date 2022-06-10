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
<link href="../css/mystar.css" rel="stylesheet">
</head>
<script>
    function domove(starNm){
        location.href = "/Star/StarInfo?star_name="+starNm;

    }
</script>
<body>
<%@include file="../import/Navigation.jsp"%>
     <section>
        <ul class="cards">
            <%
                for (int i = 0; i < rList.size(); i++) {
                    StarDTO rDTO = rList.get(i);

                    if (rDTO == null) {
                        rDTO = new StarDTO();
                    }
            %>
            <li class="cards__item">
                <div class="card">
                    <div class="card__image" style="background-image: url('<%=CmmUtil.nvl(rDTO.getPicture())%>');"></div>
                    <div class="card__content">
                        <div class="card__title"><%=CmmUtil.nvl(rDTO.getStar_name())%></div>
                        <button class="btn btn--block card__btn" onclick="domove('<%=CmmUtil.nvl(rDTO.getStar_name())%>')">자세히 보기</button>
                    </div>
                </div>
            </li>
            <%
                }
            %>
        </ul>
     </section>


</body>


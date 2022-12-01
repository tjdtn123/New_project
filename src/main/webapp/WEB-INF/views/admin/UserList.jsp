<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.PageMakeDTO" %>

<%
    session.getAttribute("user_id");
    List<UserInfoDTO> rList = (List<UserInfoDTO>) request.getAttribute("rList");
    //게시판 조회 결과 보여주기
    if (rList == null) {
        rList = new ArrayList<UserInfoDTO>();

    }

%>
<%@include file="../import/heads.jsp"%>
    <title>회원목록</title>
<link rel="stylesheet" href="../css/UserList.css?after">
<link rel="stylesheet" href="../css/nomal.css">


    <script type="text/javascript">

        //상세보기 이동
        function doDetail(user_id) {
            location.href = "/admin/Userinfo?user_id=" + user_id;
        }

    </script>

</head>
<body>
    <%@include file="../import/Navigation.jsp"%>
    <br>
    <br>

    <header style="margin-left: 7%">
        <h1><strong>회원 목록</strong></h1>
    </header>
    </div>

    <br/>
    <div class="backboard">
        <div class="board_list_warp" >
            <div class="board_list">
                <div class="board_list_head">
                    <div class="c1">아이디</div>
                    <div class="c3">이름</div>
                    <div class="c4">이메일</div>
                    <div class="c5">가입일</div>
                </div>
                <div class="board_list_body">
                <%
                    for (int i = 0; i < rList.size(); i++) {
                        UserInfoDTO rDTO = rList.get(i);

                        if (rDTO == null) {
                            rDTO = new UserInfoDTO();
                        }
                %>
                    <div class="item">
                        <div class="c1"><%=CmmUtil.nvl(rDTO.getUser_id())%></div>

                        <div class="c3">
                        <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getUser_id())%>');">
                            <%=CmmUtil.nvl(rDTO.getUser_name()) %>
                        </a>
                        </div>
                        <div class="c4"><%=CmmUtil.nvl(rDTO.getEmail()) %></div>

                        <div class="c5"><%=CmmUtil.nvl(rDTO.getReg_dt()) %></div>

                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>
    <div style="margin-left: 30%; margin-top: 30px ">
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
            moveForm.attr("action", "/board/BoardInfo");
            moveForm.submit();
        });


        $(".pageInfo a").on("click", function(e){

            e.preventDefault();
            moveForm.find("input[name='pageNum']").val($(this).attr("href"));
            moveForm.attr("action", "/board/BoardList");
            moveForm.submit();

        });

    </script>
<%@include file="../import/footer.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.PageMakeDTO" %>
<%
    session.getAttribute("user_id");
    List<BoardDTO> rList = (List<BoardDTO>) request.getAttribute("rList");
    //게시판 조회 결과 보여주기
    if (rList == null) {
        rList = new ArrayList<BoardDTO>();

    }

%>
<%@include file="../import/heads.jsp"%>
    <title>공지 리스트</title>
<link rel="stylesheet" href="../css/board.css">
<link rel="stylesheet" href="../css/nomal.css">

    <script type="text/javascript">

        //상세보기 이동
        function doDetail(seq) {
            location.href = "/board/BoardInfo?nSeq=" + seq;
        }

    </script>

</head>

<body>
    <%@include file="../import/Navigation.jsp"%>
    <!-- Page Content-->
    <br>
    <br>

    <header style="margin-left: 7%">
        <h1><strong>공지사항</strong></h1>
    </header>
    </div>

    <br/>
    <div class="backboard">
        <div class="board_list_wrap">
            <div class="board_list">
                <div class="board_list_head">
                    <div class="num">순번</div>
                    <div class="tit">제목</div>
                    <div class="read_cnt">조회수</div>
                    <div class="writer">등록자</div>
                    <div class="reg_dt">등록일</div>
                </div>
                <div class="board_list_body">
                <%
                    for (int i = 0; i < rList.size(); i++) {
                        BoardDTO rDTO = rList.get(i);

                        if (rDTO == null) {
                            rDTO = new BoardDTO();
                        }
                %>
                    <div class="item">
                        <%
                            //공지글이라면, [공지]표시
                            if (CmmUtil.nvl(rDTO.getNotice_yn()).equals("1")) {
                                out.print("<div class='num'><b>[공지]</b></div>");

                                //공지글이 아니라면, 글번호 보여주기
                            } else {
                                out.print("<div class='num'>"+CmmUtil.nvl(rDTO.getRownum()) +"</div>");

                            }
                        %>
                        <div class="tit">
                        <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getBoard_seq())%>');">
                                <%=CmmUtil.nvl(rDTO.getTitle()) %>
                        </a>
                        </div>
                        <div class="read_cnt"><%=CmmUtil.nvl(rDTO.getRead_cnt()) %></div>

                        <div class="writer"><%=CmmUtil.nvl(rDTO.getUser_id()) %></div>

                        <div class="reg_dt"><%=CmmUtil.nvl(rDTO.getReg_dt()) %></div>
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>
        </div>
    </div>

    <div style="float:right; margin-right: 7%; margin-top: 50px;">
    <button class="submit-btn" onclick="location.href='/board/BoardReg'"><STRONG>글쓰기</STRONG></button>
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

    <script src="../js/script.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<%@include file="../import/footer.jsp"%>

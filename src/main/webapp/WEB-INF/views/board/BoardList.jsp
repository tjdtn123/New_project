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
<link rel="stylesheet" href="../css/table.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
    <style>

        html	{ overflow: hidden; }
        body	{ overflow: auto; }
        body::before {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-image: url("/assets/wallpaper.jpg");
            background-size: cover;
            -webkit-filter: blur(5px);
            -moz-filter: blur(5px);
            -o-filter: blur(5px);
            -ms-filter: blur(5px);
            filter: blur(5px);
            transform: scale(1.02);
            z-index: -1;
            content: "";
        }
        .pageInfo{
            list-style : none;
            display: inline-block;
            margin: 50px 0 0 100px;
        }
        .pageInfo li{
            float: left;
            font-size: 20px;
            margin-left: 18px;
            padding: 7px;
            font-weight: 500;
        }
        a:link {color:black; text-decoration: none;}
        a:visited {color:black; text-decoration: none;}
        a:hover {color:black; text-decoration: underline;}
         .active{
             background-color: #cdd5ec;
         }
         h1,h2,h3,h4,h5,h6,p,div{
             font-family: 'Gowun Dodum', sans-serif;
             color: white;
         }

    </style>

    <script type="text/javascript">

        //상세보기 이동
        function doDetail(seq) {
            location.href = "/board/BoardInfo?nSeq=" + seq;
        }

    </script>

</head>
<body class="bg-primary">
    <%@include file="../import/Navigation.jsp"%>
    <!-- Page Content-->
    <section>
        <div class="container px-4 px-lg-5">
            <div class="row gx-4 gx-lg-5">
                <div class="col-lg-6">
                    <br>
                    <br>
                    <br>
                </div>
            </div>
        </div>
    </section>
    <h2>공지사항</h2>
    <hr/>
    <br/>
    <div class="board_list_warp" >
        <div class="board_list">
            <div class="board_list_head">
                <div class="num">순번</div>
                <div class="tit">제목</div>
                <div class="read_cnt">조회수</div>
                <div class="writer">등록자</div>
                <div class="reg_dt">등록일</div>
            </div>
            <%
                for (int i = 0; i < rList.size(); i++) {
                    BoardDTO rDTO = rList.get(i);

                    if (rDTO == null) {
                        rDTO = new BoardDTO();
                    }
            %>
            <div class="board_list_body">
                <div class="item">
                    <%
                        //공지글이라면, [공지]표시
                        if (CmmUtil.nvl(rDTO.getNotice_yn()).equals("1")) {
                            out.print("<b>[공지]</b>");

                            //공지글이 아니라면, 글번호 보여주기
                        } else {
                            out.print(CmmUtil.nvl(rDTO.getBoard_seq()));

                        }
                    %>
                    <div class="num">
                    <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getBoard_seq())%>');">
                            <%=CmmUtil.nvl(rDTO.getTitle()) %>
                    </a>
                    </div>
                    <div class="read_cnt"><%=CmmUtil.nvl(rDTO.getRead_cnt()) %></div>

                    <div class="writer"><%=CmmUtil.nvl(rDTO.getUser_id()) %></div>

                    <div class="reg_dt"><%=CmmUtil.nvl(rDTO.getReg_dt()) %></div>

                </div>
            </div>
        </div>
    </div>
        <%
            }
            %>




        <div class="pageInfo_wrap" >
            <div class="pageInfo_area">
                <ul id="pageInfo" class="pageInfo">
                    <!-- 이전페이지 버튼 -->
                    <c:if test="${pageMaker.prev}">
                        <li class="pageInfo_btn previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
                    </c:if>
                    <!-- 각 번호 페이지 버튼 -->
                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                        <li class="pageInfo_btn ${pageMaker.cri.pageNum == num ? "active":"" }"><a href="${num}">${num}</a></li>
                    </c:forEach>

                    <!-- 다음페이지 버튼 -->
                    <c:if test="${pageMaker.next}">
                        <li class="pageInfo_btn next"><a href="${pageMaker.endPage + 1 }">Next</a></li>
                    </c:if>
                </ul>
            </div>
        </div>
        <form id="moveForm" method="get">
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount }">
        </form>
    </div>
    <a href="/board/BoardReg">[글쓰기]</a>

    <script type="text/javascript">

        let moveForm = $("#moveForm");

        $(".move").on("click", function (e){
            e.preventDefault();

            moveForm.append("<input type='hidden' name ='board_seq' value='"+ $(this).attr("href")+ "'>");
            moveForm.attr("action", "board/BoardInfo");
            moveForm.submit();
        });


        $(".pageInfo a").on("click", function(e){

            e.preventDefault();
            moveForm.find("input[name='pageNum']").val($(this).attr("href"));
            moveForm.attr("action", "/board/BoardList");
            moveForm.submit();

        });

    </script>
</body>
</html>
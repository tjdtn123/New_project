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
         *{
             font-family: 'Gowun Dodum', sans-serif;
             color: white;
         }

    </style>

    <script type="text/javascript">

        //상세보기 이동
        function doDetail(user_id) {
            location.href = "/admin/Userinfo?user_id=" + user_id;
        }

    </script>

</head>
<body>
    <%@include file="../import/Navigation.jsp"%>
    <!-- Page Content-->
    <br>
    <br>
    <h2>공지사항</h2>
    <br/>
    <div class="board_list_warp" >
        <div class="board_list">
            <div class="board_list_head">
                <div class="c1">아이디</div>
                <div class="c2">비밀번호</div>
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
                        
                    <div class="c2">
                    <a href="javascript:doDetail('<%=CmmUtil.nvl(rDTO.getUser_id())%>');">
                            <%=CmmUtil.nvl(rDTO.getPassword()) %>
                    </a>
                    </div>
                    <div class="c3"><%=CmmUtil.nvl(rDTO.getUser_name()) %></div>

                    <div class="c4"><%=CmmUtil.nvl(rDTO.getEmail()) %></div>

                    <div class="c5"><%=CmmUtil.nvl(rDTO.getReg_dt()) %></div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>



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


    <script type="text/javascript">

        let moveForm = $("#moveForm");

        $(".move").on("click", function (e){
            e.preventDefault();

            moveForm.append("<input type='hidden' name ='user_id' value='"+ $(this).attr("href")+ "'>");
            moveForm.attr("action", "/admin/UserInfo");
            moveForm.submit();
        });


        $(".pageInfo a").on("click", function(e){

            e.preventDefault();
            moveForm.find("input[name='pageNum']").val($(this).attr("href"));
            moveForm.attr("action", "/admin/UserList");
            moveForm.submit();

        });

    </script>
</body>
</html>
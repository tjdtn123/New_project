<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%
    BoardDTO rDTO = (BoardDTO) request.getAttribute("pageInfo");

//공지글 정보를 못불러왔다면, 객체 생성
    if (rDTO == null) {
        rDTO = new BoardDTO();

    }
    String id_session = CmmUtil.nvl((String) session.getAttribute("user_id"));

//본인이 작성한 글만 수정 가능하도록 하기(1:작성자 아님 / 2: 본인이 작성한 글 / 3: 로그인안함)
    int edit = 1;

//로그인 안했다면....
    if (id_session.equals("")) {
        edit = 3;

//본인이 작성한 글이면 2가 되도록 변경
    } else if (id_session.equals(CmmUtil.nvl(rDTO.getUser_id()))) {
        edit = 2;

    }
    System.out.println("user_id : " + CmmUtil.nvl(rDTO.getUser_id()));
    System.out.println("ss_user_id : " + id_session);

%>
<%@include file="../import/heads.jsp"%>
    
    
    <title>게시판 글보기</title>
    
    
    <script type="text/javascript">
        var bno = '<%=CmmUtil.nvl(rDTO.getBoard_seq())%>'; //게시글 번호
        console.log(bno);
        //수정하기
        function doEdit() {
            if ("<%=edit%>" == 2) {
                location.href = "/board/BoardEditInfo?nSeq=<%=CmmUtil.nvl(rDTO.getBoard_seq())%>";

            } else if ("<%=edit%>" == 3) {
                alert("로그인 하시길 바랍니다.");

            } else {
                alert("본인이 작성한 글만 수정 가능합니다.");

            }
        }


        //삭제하기
        function doDelete() {
            if ("<%=edit%>" == 2) {
                if (confirm("작성한 글을 삭제하시겠습니까?")) {
                    location.href = "/board/BoardDelete?nSeq=<%=CmmUtil.nvl(rDTO.getBoard_seq())%>";

                }

            } else if ("<%=edit%>" == 3) {
                alert("로그인 하시길 바랍니다.");

            } else {
                alert("본인이 작성한 글만 삭제 가능합니다.");

            }
        }

        //목록으로 이동
        function doList() {
            location.href = "/board/BoardList?pageNum=${cri.pageNum}&amount=${cri.amount}";

        }

    </script>
</head>
<body>
<%@include file="../import/Navigation.jsp"%>
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
<div>

    <div>
        <div>제목</div>
        <div colspan="3"><%=CmmUtil.nvl(rDTO.getTitle())%>
        </div>
    </div>
    <div>
        <div>공지글 여부</div>
        <div>예<label>
            <input type="radio" name="noticeYn" value="1"
                    <%=CmmUtil.checked(CmmUtil.nvl(rDTO.getNotice_yn()), "1") %>/>
        </label>
            아니오<input type="radio" name="noticeYn" value="2"
                    <%=CmmUtil.checked(CmmUtil.nvl(rDTO.getNotice_yn()), "2") %>/>
        </div>
    </div>
    <div>
        <div align="center">작성일</div>
        <div><%=CmmUtil.nvl(rDTO.getReg_dt())%>
        </div>
        <div align="center">조회수</div>
        <div><%=CmmUtil.nvl(rDTO.getRead_cnt())%>
        </div>
    </div>
    <div>
        <div colspan="4" height="300px" valign="top">
            <%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %>
        </div>
    </div>
    <div>
        <div align="center" colspan="4">
            <a href="javascript:doEdit();">[수정]</a>
            <a href="javascript:doDelete();">[삭제]</a>
            <a href="javascript:doList();">[목록]</a>
        </div>
    </div>
</div>
<!--  댓글  -->
<div class="container">
    <label for="contents">comment</label>
    <form name="commentInsertForm">
        <div class="input-group">
            <input type="hidden" name="board_seq" value="<%=CmmUtil.nvl(rDTO.getBoard_seq())%>"/>
            <input type="text" class="form-control" id="contents" name="contents" placeholder="내용을 입력하세요.">
            <span class="input-group-btn">
                    <button class="btn btn-default" type="button" name="commentInsertBtn">등록</button>
               </span>
        </div>
    </form>
</div>

<div class="container">
    <div class="commentList"></div>
</div>
</div>
<%@ include file="../import/Comments.jsp" %>
</body>
</html>
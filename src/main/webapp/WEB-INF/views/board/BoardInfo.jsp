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

<link rel="stylesheet" href="../css/login.css">
<link rel="stylesheet" href="../css/nomal.css">
    <script type="text/javascript">
        var bno = '<%=CmmUtil.nvl(rDTO.getBoard_seq())%>'; //게시글 번호
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

    <div class="container" >
        <div class="row justify-content-center">
            <div class="col-lg-10">
                <div class="card shadow-lg border-3 rounded-lg mt-5">
                    <div class="card-header">
                        <div style="display: flex; height: auto;" >
                            <div class="info-border w-25"><h5 class="my-2 text-center"><strong>제목</strong></h5></div>
                            <div class="text-field" style="font-size:15px; margin-left: 10px; width: 60%; padding-top: 5px; padding-left: 3%;"><%=CmmUtil.nvl(rDTO.getTitle())%></div>
                        </div>
                        <div class="mt-2" style="display: flex; height: auto" >
                            <div class="info-border" style="width: 20%;"><h5 class="my-2 text-center"><strong>작성일</strong></h5></div>
                            <div class="info-border" style="margin-left: 10px; width: 25%; padding-top: 5px; padding-left: 3%;"><%=CmmUtil.nvl(rDTO.getReg_dt())%></div>

                            <div class="info-border" style="width: 20%; margin-left: 100px; "><h5 class="my-2 text-center"><strong>조회수</strong></h5></div>
                            <div class="info-border" style="margin-left: 10px; width: 15%; padding-top: 5px; padding-left: 3%;"><%=CmmUtil.nvl(rDTO.getRead_cnt())%></div>

                        </div>
                    </div>

                    <div class="card-body" style="padding: 30px">


                        <div>
                            <div colspan="4" height="300px" valign="top">
                                <%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %>
                            </div>
                        </div>
                    <hr>
                        <div class="row justify-content-center mt-5">
                            <div class="col-lg-7 text-end">
                                <button type="button" class="submit-btn-100 m-2" onclick="doEdit()";>[수정]</button>
                                <button type="button" class="submit-btn-100 m-2" onclick="doDelete()";>[삭제]</button>
                                <button type="button" class="submit-btn-100 m-2" onclick="doList()";>[목록]</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


<!--  댓글  -->
<hr/>
<div class="container" >
    <div class="row justify-content-center">
        <div class="col-lg-9">
            <div class="card shadow-lg border-0 rounded-lg mt-5">
                <div class="card-header"> <label for="contents" style="color: #cccccc"><h3><strong>댓글</strong></h3></label></div>
                <div class="card-body" style="padding: 30px">

                    <form name="commentInsertForm">
                        <div class="input-group">
                            <input type="hidden" name="board_seq" value="<%=CmmUtil.nvl(rDTO.getBoard_seq())%>"/>
                            <input type="text" class="form-control" id="contents" name="contents" placeholder="내용을 입력하세요.">
                            <span class="input-group-btn">
                                    <button class="btn btn-primary " style=" margin-left: 5px" type="button" name="commentInsertBtn">등록</button>
                               </span>
                        </div>
                    </form>
                    <div class="container">
                        <div class="commentList"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../import/Comments.jsp" %>
<%@include file="../import/footer.jsp"%>
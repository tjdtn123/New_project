<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.BoardDTO" %>
<%
	BoardDTO rDTO = (BoardDTO)request.getAttribute("rDTO");

	//공지글 정보를 못불러왔다면, 객체 생성
	if (rDTO==null){
		rDTO = new BoardDTO();

	}

	int access = 1; //(작성자 : 2 / 다른 사용자: 1)
	String id_session = CmmUtil.nvl((String) session.getAttribute("user_id"));
	System.out.println("아이디 : " +id_session);
	System.out.println("rDTO 아이디 : " + CmmUtil.nvl(rDTO.getUser_id()));

	if (id_session.equals(CmmUtil.nvl(rDTO.getUser_id()))) {
		access = 2;
	}
%>
<%@include file="../import/heads.jsp"%>

	<title>게시판 글쓰기</title>
	<script src="/js/MyUploadAdpater.js"></script>
	<!-- CKEditor 5 CDN 적용-->
	<script src="/ckeditor/build/ckeditor.js"></script>
<link rel="stylesheet" href="../css/login.css">
<link rel="stylesheet" href="../css/nomal.css">
	
	<style>
		right{
			float: right;
		}
	</style>
<script type="text/javascript">

//작성자 여부체크
function doOnload(){
	
	if ("<%=access%>"=="1"){
		alert("작성자만 수정할 수 있습니다.");
		location.href="/board/BoardList";
		
	}
}

//전송시 유효성 체크
function doSubmit(f){
	if(f.title.value == ""){
		alert("제목을 입력하시기 바랍니다.");
		f.title.focus();
		return false;
	}
	
	if(calBytes(f.title.value) > 200){
		alert("최대 200Bytes까지 입력 가능합니다.");
		f.title.focus();
		return false;
	}	
	
	var noticeCheck = false; //체크 여부 확인 변수
	for(var i=0;i<f.noticeYn.length;i++){
		if (f.noticeYn[i].checked){
			noticeCheck = true;
		}
	}
	
	if(noticeCheck==false){
		alert("공지글 여부를 선택하시기 바랍니다.");
		f.noticeYn[0].focus();
		return false;
	}	
	
	if(f.contents.value == ""){
		alert("내용을 입력하시기 바랍니다.");
		f.contents.focus();
		return false;
	}	
	
	if(calBytes(f.contents.value) > 4000){
		alert("최대 4000Bytes까지 입력 가능합니다.");
		f.contents.focus();
		return false;
	}		
	
	
}

//글자 길이 바이트 단위로 체크하기(바이트값 전달)
function calBytes(str){
	
	var tcount = 0;
	var tmpStr = new String(str);
	var strCnt = tmpStr.length;

	var onechar;
	for (i=0;i<strCnt;i++){
		onechar = tmpStr.charAt(i);
		
		if (escape(onechar).length > 4){
			tcount += 2;
		}else{
			tcount += 1;
		}
	}
	
	return tcount;
}
function MyCustomUploadAdapterPlugin( editor ) {
	editor.plugins.get( 'FileRepository' ).createUploadAdapter = ( loader ) => {
		return new MyUploadAdapter( loader );
	}
}
</script>
</script>

</head>
<body onload="doOnload();">
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
<div class="container" >
	<div class="row justify-content-center">
		<div class="col-lg-9">
			<div class="card shadow-lg border-0 rounded-lg mt-5">
				<div class="card-header"><h1 class="text-center font-weight-light my-4"><strong>글수정</strong></h1></div>
				<div class="card-body" style="padding: 30px">
					<form name="f" method="post" action="/board/BoardUpdate" target="ifrPrc" onsubmit="return doSubmit(this);">
						<input type="hidden" name="nSeq" id="nSeq" value="<%=CmmUtil.nvl(rDTO.getBoard_seq())%>"/>
						<div class="form-check">
							<label for="title">제목</label>
							<input type="text" class="text-field" id="title" name="title" maxlength="100" style="width: 450px" value="<%=CmmUtil.nvl(rDTO.getTitle())%>"  />
						</div>
						<% if (id_session.equals("admin")) {%>
						<div class="form-check">
							<label for="noticeYn">공지글 여부</label>
							<div>
								예<input type="radio" id="noticeYn" name="noticeYn" value="1" />
								아니오<input type="radio" name="noticeYn" value="2" />
							</div>
						</div>
						<% } %>
						<div class="form-check">
							<label for="contents">내용</label>
							<textarea name="contents" id="contents" class="form-control"><%=CmmUtil.nvl(rDTO.getContents())%></textarea>
						</div>
						<div class="text-end">
							<input type="submit" class="submit-btn-100" style="margin-right: 5px;" value="수정" />
							<input type="reset" class="submit-btn-100" value="다시 작성" />
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	ClassicEditor
			.create( document.querySelector('#contents' ),{
				extraPlugins: [ MyCustomUploadAdapterPlugin ],
			})
			.then( editor => {
				window.editor = editor;
			} )
			.catch( error => {
				console.error(error);
			})

</script>
<%@include file="../import/footer.jsp"%>
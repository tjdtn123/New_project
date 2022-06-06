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
<h2>글 수정!</h2>
<form name="f" method="post" action="/board/BoardUpdate" onsubmit="return doSubmit(this);">
<input type="hidden" name="nSeq" value="<%=CmmUtil.nvl(request.getParameter("nSeq")) %>" />
	<div border="1">
		<div>
			<div align="center">제목</div>
			<div>
			<input type="text" name="title" maxlength="100" 
				   value="<%=CmmUtil.nvl(rDTO.getTitle()) %>" style="width: 450px"/>
			</div>
		</div>
		<div>
			<div align="center">공지글 여부</div>
			<div>
				예<input type="radio" name="noticeYn" value="1"
						<%=CmmUtil.checked(CmmUtil.nvl(rDTO.getNotice_yn()), "1") %>	/>
			        아니오<input type="radio" name="noticeYn" value="2" 
			        	<%=CmmUtil.checked(CmmUtil.nvl(rDTO.getNotice_yn()), "2") %>	/>
			</div>
		</div>
		<div>
			<div colspan="2">
				<textarea id="contents" name="contents" style="width: 550px; height: 400px"><%=CmmUtil.nvl(rDTO.getContents())%></textarea>
			</div>
		</div>
	<div>
		<div align="center" colspan="2">
			<input type="submit" value="수정" />
			<input type="reset" value="다시 작성" />
		</div>
	</div>
	</div>
</form>
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
</body>
</html>
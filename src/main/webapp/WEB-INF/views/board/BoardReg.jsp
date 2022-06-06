<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String id_session = CmmUtil.nvl((String) session.getAttribute("user_id"));
    System.out.println(id_session);
%>
<%@include file="../import/heads.jsp"%>
    <title>글쓰기</title>

    <script src="/js/MyUploadAdpater.js"></script>
    <!-- CKEditor 5 CDN 적용-->
    <script src="/ckeditor/build/ckeditor.js"></script>
  

    <script type="text/javascript">

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
            if (window.contents.getData() == "") {
                alert("내용을 입력해주세요");
                window.contents.editing.view.focus();
                return;
            }
            if(calBytes(window.contents.getData() ) > 4000){
                alert("최대 4000Bytes까지 입력 가능합니다.");
                window.contents.editing.view.focus();
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
</head>
<body class="bg-primary">
<%@include file="../import/Navigation.jsp"%>

<br>
<br>
<br>
<div class="container">

    <h3>글 쓰기</h3>
        <form name="f" method="post" action="/board/BoardInsert" target="ifrPrc" onsubmit="return doSubmit(this);">
            <div class="form-check">
                <label for="title">제목</label>
                <input type="text" id="title" name="title" maxlength="100" style="width: 450px" />
            </div>
            <div class="form-check">
                <label for="noticeYn">공지글 여부</label>
                <div>
                    예<input type="radio" id="noticeYn" name="noticeYn" value="1" />
                    아니오<input type="radio" name="noticeYn" value="2" />
                </div>
            </div>
            <div class="form-check">
                <label for="contents">내용</label>
                  <textarea name="contents" id="contents" class="form-control"></textarea>
            </div>
            <div>
                <input type="submit" class="btn" value="등록" />
                <input type="reset" class="btn" value="다시 작성" />
            </div>
        </form>
</div>
<iframe name="ifrPrc" style="display:none"></iframe>

<!-- 글쓰기 에디터 실행-->
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

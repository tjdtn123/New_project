<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<script>

    $('[name=commentInsertBtn]').click(function(){ //댓글 등록 버튼 클릭시
        var insertData = $('[name=commentInsertForm]').serialize(); //commentInsertForm의 내용을 가져옴
        commentInsert(insertData); //Insert 함수호출(아래)
    });



    //댓글 목록
    function commentList(){
        $.ajax({
            url : '/comment/list',
            type : 'get',
            data : {'board_seq':bno},
            success : function(data){
                var a ='';
                $.each(data, function(key, value){
                    a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
                    a += '<div class="commentInfo'+value.comments_id+'">'+'댓글번호 : '+value.comments_id+' / 작성자 : '+value.user_id;
                    a += '<a onclick="commentUpdate('+value.comments_id+',\''+value.contents+'\',\''+value.user_id+'\');"> 수정 </a>';
                    a += '<a onclick="commentDelete('+value.comments_id+',\''+value.user_id+'\');"> 삭제 </a> </div>';
                    a += '<div class="commentContent'+value.comments_id+'"> <p> 내용 : '+value.contents +'</p>';
                    a += '</div></div>';
                });

                $(".commentList").html(a);
            }
        });
    }

    //댓글 등록
    function commentInsert(insertData){
        $.ajax({
            url : '/comment/insert',
            type : 'post',
            data : insertData,
            success : function(data){
                if(data == 1) {
                    commentList(); //댓글 작성 후 댓글 목록 reload
                    $('[name=contents]').val('');
                }
            }
        });
    }

    //댓글 수정 - 댓글 내용 출력을 input 폼으로 변경
    function commentUpdate(comments_id, contents, user_id){

        if (user_id == "<%=id_session%>"){

            var a ='';

            a += '<div class="input-group">';
            a += '<input type="text" class="form-control" name="contents_'+comments_id+'" value="'+contents+'"/>';
            a += '<span class="input-group-btn"><button class="btn btn-default" type="button" onclick="commentUpdateProc('+comments_id+');">수정</button> </span>';
            a += '</div>';

            $('.commentContent'+comments_id).html(a);

        } else alert("권한이 없습니다");
    }

    //댓글 수정
    function commentUpdateProc(comments_id){
        var updateContent = $('[name=contents_'+comments_id+']').val();

        $.ajax({
            url : '/comment/update',
            type : 'post',
            data : {'contents' : updateContent, 'comments_id' : comments_id},
            success : function(data){
                if(data == 1) commentList(bno); //댓글 수정후 목록 출력
            }
        });
    }

    //댓글 삭제
    function commentDelete(comments_id, user_id){
        if (user_id == "<%=id_session%>"){

            $.ajax({
                url: '/comment/delete/' + comments_id,
                type: 'post',
                data: {'comments_id': comments_id},
                success: function (data) {
                    if (data == 1) commentList(bno); //댓글 삭제후 목록 출력
                }
            });
        } else alert("권한이 없습니다");
    }




    $(document).ready(function(){
        commentList(); //페이지 로딩시 댓글 목록 출력
    });



</script>



<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.ObsDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="kopo.poly.dto.ObsDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%! String id_session;

%>
<%if(session.getAttribute("user_id") != null) {
    id_session = session.getAttribute("user_id").toString();

}
  List<ObsDTO> rList = (List<ObsDTO>) request.getAttribute("rList");
    //게시판 조회 결과 보여주기
    if (rList == null) {
        rList = new ArrayList<ObsDTO>();

    }


%>
<%@include file="../import/heads.jsp"%>
        <title>The Big Picture - Start Bootstrap Template</title>
<link rel="stylesheet" href="../css/nomal.css">
<link rel="stylesheet" href="../css/UserList.css?after">
</head>
<>
<%@include file="../import/Navigation.jsp"%>
<br>
<br>



        <span class="custom-dropdown">
            <select class="custom-select mr-sm-2" id="region" name="region" onchange="typeFn();">
                <option value="">지역선택</option>
                <option value="서울">서울</option>
                <option value="경기">경기</option>
                <option value="강원">강원</option>
                <option value="충북">충북</option>
                <option value="충남">충남</option>
                <option value="대전">대전</option>
                <option value="전북">전북</option>
                <option value="전남">전남</option>
                <option value="광주">광주</option>
                <option value="경북">경북</option>
                <option value="경남">경남</option>
                <option value="부산">부산</option>
                <option value="제주">제주</option>
            </select>
        </span>
      <div class="backboard">
          <div class="backboard-header">
                <h2 style="text-align: center">국내 천문대</h2>
                <br/>
          </div>
          <div class="board_list_warp" >
              <div class="board_list">
                  <div class="board_list_head">
                      <div class="c1">지역</div>
                      <div class="c2">이름</div>
                      <div class="c3">홈페이지</div>
                      <div class="c4">전화번호</div>
                      <div class="c5">비고</div>
                  </div>

                  <div class="board_list_body">

                      <div class="commentList"></div>

                  </div>



              </div>
          </div>
      </div>
<script>



    function typeFn(){
        var region = $('#region option:selected').val();
        console.log(region);

        $.ajax({
            url : '/observer/obsPage',
            type : 'get',
            data : {'region':region},
            success : function(data){
                var a ='';
                $.each(data, function(key, value){

                    a +=        '<div class="board_list_body">'
                    a +=           '<div class="item">'
                    a +=            '<div class="c1">' + value.region +'</div>'
                    a +=                '<div class="c2">' +value.obs_name +'</div>'
                    a +=                '<div class="c3">'
                    a +=                '<a href="' + value.pageurl + '">'
                    a +=                value.pageurl;
                    a +=                    '</a>'
                    a +=            '</div>'
                    a +=                '<div class="c4">' +value.phone+ '</div>'
                    a +=                '<div class="c5">'+value.type+'</div>'
                    a +=        '</div>';

                });

                $(".commentList").html(a);
            }
        });
    }
</script>
</body>
</html>

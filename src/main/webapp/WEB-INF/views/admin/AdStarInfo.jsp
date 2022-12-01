<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.MyDTO" %>
<%@ page import="kopo.poly.dto.StarDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
        StarDTO rDTO = (StarDTO)request.getAttribute("rDTO");
%>
<%@include file="../import/heads.jsp"%>
<title>별자리 상세</title>
<link rel="stylesheet" href="../css/login.css">
<link rel="stylesheet" href="../css/nomal.css">
</head>
<body>
<%@include file="../import/Navigation.jsp"%>

<br>
<!-- Page Content-->
<div class="container" >
        <div class="row justify-content-center">
                <div class="col-lg-9">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header"><h1 class="text-center font-weight-light my-4"><strong>별자리 상세</strong></h1></div>
                                <div style="text-align: center">
                                        <img src="<%=CmmUtil.nvl(rDTO.getPicture())%>" width="350px;" height="250px;">
                                </div>
                                <hr>
                                <div class="card-body" style="padding: 30px">


                                        <div class="text-center">
                                                <div style="display: flex;">
                                                        <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>별자리명</strong></h4></div>
                                                        <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getStar_name())%></strong></h4></div>
                                                </div>
                                                <br>
                                                <div style="display: flex;">
                                                        <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>위치</strong></h4></div>
                                                        <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getPosition())%></strong></h4></div>
                                                </div>
                                                <br>
                                                <div style="display: flex;">
                                                        <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>계절</strong></h4></div>
                                                        <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getSeason()) %></strong></h4></div>
                                                </div>
                                                <br>
                                                <div style="display: flex;">
                                                        <div style="width: 20%; border: black groove 2px; text-align: center"><h4 style="padding: 10px"><strong>별의 개수</strong></h4></div>
                                                        <div style="width: 76%; border: black groove 2px; margin-left: 20px;"><h4 style="padding: 10px"><strong><%=CmmUtil.nvl(rDTO.getStar_cnt()) %></strong></h4></div>
                                                </div>
                                                <br>
                                        </div>
                                        <div class="col-lg-7 text-end">
                                                <button type="button" class="submit-btn-100" onclick="Deletestar()">[별자리 삭제]</button>
                                                <button type="button" class="submit-btn-100" onclick="history.back()">[목록]</button>
                                                <button type="button" class="submit-btn-100" onclick="doEdit('<%=CmmUtil.nvl(rDTO.getStar_name())%>')">[수정]</button>
                                        </div>

                                </div>
                        </div>
                </div>
        </div>

<script>
        function Deletestar(){
                var star_name = '<%=CmmUtil.nvl(rDTO.getStar_name())%>';
                if (confirm("삭제하시겠습니까?")){
                        $.ajax({
                                url : '/admin/deleteStar',
                                type : 'get',
                                data : {'star_name': star_name

                                },
                                success : function(){

                                        alert("삭제되었습니다.");
                                        location.href="/admin/AdStarList";
                                }
                        });
                }

        }
        function doEdit(star_name){
                location.href="/admin/AdStarEdit?star_name="+ star_name;

        }


</script>
<%@include file="../import/footer.jsp"%>
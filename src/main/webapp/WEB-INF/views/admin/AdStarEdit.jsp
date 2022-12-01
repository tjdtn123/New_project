<%@ page import="kopo.poly.dto.StarDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<% StarDTO rDTO = (StarDTO) request.getAttribute("rDTO");
String ori_name = CmmUtil.nvl(rDTO.getStar_name());
%>
<%@include file="../import/heads.jsp"%>
        <title>회원가입</title>
        <!-- Favicon-->
        <link rel="stylesheet" href="../css/login.css">
        <link rel="stylesheet" href="../css/nomal.css">

        <style>
            input[type="text"],
            input[type="password"],
            input[type="date"],
            input[type="datetime"],
            input[type="email"],
            input[type="number"],
            input[type="search"],
            input[type="tel"],
            input[type="time"],
            input[type="url"],
            textarea,
            select {
                background: rgba(255,255,255,0.1);
                border: none;
                font-size: 16px;
                height: auto;
                margin: 0;
                outline: 0;
                padding: 15px;
                width: 100%;
                background-color: #e8eeef;
                color: #8a97a0;
                box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;
                margin-bottom: 30px;
            }
            .id_ok {

            }
            .id_already{
                color: #d40505; display: none;
            }
            .id_length{
                color: #033af5; display: inline-block;
            }
            right {
                float: right;
            }
            .pwd_ok{

            }
            .input-file-button{
                padding: 6px 25px;
                background-color:#FF6600;
                border-radius: 4px;
                color: white;
                cursor: pointer;
            }
        </style>
        <script>
            function readURL(input) {
                document.getElementById("preview").src="";
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('preview').src = e.target.result;
                    };
                    reader.readAsDataURL(input.files[0]);
                } else {
                    document.getElementById('preview').src = "";
                }
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

    <div class="container" >
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                    <div class="card-header"><h1 class="text-center font-weight-light my-4"><strong>별자리수정</strong></h1></div>
                    <div class="card-body" style="padding: 30px">
                        <form name="f" method="post" action="/admin/AdUpdate" enctype="multipart/form-data">
                            <input type="hidden" name="size" id="size" value="<%=rDTO.getSize()%>">
                            <input type="hidden" name="ori_name" id="ori_name" value="<%=ori_name%>">
                            <div class="row">
                                <label for="star_name" style="width: 40%;">별자리이름</label>
                                <div style=" display:flex">
                                       <input class="text-field" style="width: 40%; height: 41px;" id="star_name" name="star_name" type="text" value="<%=rDTO.getStar_name()%>"/>
                                </div>

                                <label for="position">위치</label>
                                <div class="col-md-6">
                                    <input class="text-field" style="height: 41px;" id="position" name="position" type="text" value="<%=rDTO.getPosition()%>" />
                                </div>

                                <label for="season">계절</label>
                                <div style="display:flex;">
                                    <select class="form-select" id="season" name="season">
                                        <option selected value="<%=rDTO.getSeason()%>"><%=rDTO.getSeason()%></option>
                                        <option value="봄철 밤하늘 별자리">봄</option>
                                        <option value="여름철 밤하늘 별자리">여름</option>
                                        <option value="가을철 밤하늘 별자리">가을</option>
                                        <option value="겨울철 밤하늘 별자리">겨울</option>
                                    </select>
                                </div>

                                <label for="star_cnt">별의 개수</label>
                                <div style="display: flex">
                                    <input class="text-field" style="width:60%; height:41px;" id="star_cnt" name="star_cnt" type="text"  value="<%=rDTO.getStar_cnt()%>"/>
                                </div>

                                <label class="input-file-button" for="picture">사진</label>
                                <div class="col-md-10">
                                    <input type="file" style="display: none; width:60%; height:41px;" id="picture" name="picture" onchange="readURL(this);">
                                    <img id="preview" style="width: 70%; " src="<%=rDTO.getPicture()%>"/>
                                </div>

                                <div class="mt-4 mb-0">
                                    <div class="d-grid">
                                        <input type="submit" class="submit-btn" value="등록"/>

                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<iframe name="ifrPrc" style="display:none"></iframe>


<%@include file="../import/footer.jsp"%>

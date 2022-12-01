<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%
    UserInfoDTO rDTO = (UserInfoDTO) request.getAttribute("EditMyinfo");

%>
<%@include file="../import/heads.jsp"%>
        <title>내정보 수정</title>
        <!-- Favicon-->
<link rel="stylesheet" href="../css/login.css">
<link rel="stylesheet" href="../css/nomal.css">
       <script>
           //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ우편번호ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
               
            function doSubmit(f){
                if(f.user_id.value == ""){
                    alert("아이디를 입력하시기 바랍니다.");
                    f.user_id.focus();
                    return false;
                }
                if(f.password.value == ""){
                    alert("비밀번호를 입력하시기 바랍니다.");
                    f.password.focus();
                    return false;
                }
                if(f.emailText.value == ""){
                    alert("이메일을 입력하시기 바랍니다.");
                    f.emailText.focus();
                    return false;
                }
                if(f.certificationYN.value == "false"){
                    alert("메일 인증을 해주시기 바랍니다.");
                    f.certificationYN.focus();
                    return false;
                }
                if(f.addr1.value == ""){
                    alert("주소를 입력하시기 바랍니다.");
                    f.addr1.focus();
                    return false;
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
    <div id="layoutAuthentication">
        <div id="layoutAuthentication_content">
            <main>
                <div class="container">
                    <div class="row justify-content-center">
                        <div class="col-lg-7">
                            <div class="card shadow-lg border-0 rounded-lg mt-5">
                                <div class="card-header"><h3 class="text-center font-weight-light my-4">정보 수정</h3></div>
                                <div class="card-body">
                                    <form name="f" method="post" action="/mypage/UpdateUser" target= "ifrPrc" onsubmit="return doSubmit(this);" >
                                        <div class="row mb-3">

                                            <div class="col-md-6">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <input class="form-control" id="user_name" name="user_name" type="text" value="<%=CmmUtil.nvl(rDTO.getUser_name())%>" />
                                                    <label for="user_name">이름</label>
                                                </div>
                                            </div>

                                            <div class = "col-md-10">
                                                <div class="form-floating mb-3">
                                                    <input class="form-control" id="emailText" name="emailText" type="email" value="<%=CmmUtil.nvl(rDTO.getEmail())%>" />
                                                    <label for="emailText">이메일</label>
                                                </div>
                                            </div>


                                            <div class="col-md-9">
                                                <div class="form-floating mb-3 mb-md-0">
                                                    <input type="text" id="addr1" name="addr1"style="width: 70%" placeholder="주소" value="<%=CmmUtil.nvl(rDTO.getAddr1())%>"><br>
                                                    <input type="text" name="sample6_detailAddress"  style="width: 70%"id="sample6_detailAddress" placeholder="상세주소" value="<%=CmmUtil.nvl(rDTO.getAddr2())%>">
                                                </div>
                                            </div>
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid " >
                                                    <input type="submit" value="수정"/>

                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    <iframe name="ifrPrc" style="display:none"></iframe>
<%@include file="../import/footer.jsp"%>
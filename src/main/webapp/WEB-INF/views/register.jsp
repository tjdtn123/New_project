<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />


        <title>회원가입</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="/assets/wallpaper.jpg" />
        <script src="https://code.jquery.com/jquery-latest.js"></script>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <style>
            html	{ overflow: hidden; }
            body	{ overflow: auto; }
            body::before {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-image: url("/assets/wallpaper.jpg");
                background-size: cover;
                -webkit-filter: blur(5px);
                -moz-filter: blur(5px);
                -o-filter: blur(5px);
                -ms-filter: blur(5px);
                filter: blur(5px);
                transform: scale(1.02);
                z-index: -1;
                content: "";
            }
        </style>
        <script src="js/emailApi.js"></script>
        <style>
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


        </style>

        <script type="text/javascript">
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ이메일 인증ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
            function emailSend() {
                let clientEmail = $('#emailText').val();
                let emailYN = isEmail(clientEmail);

                console.log('입력 이메일' + clientEmail);

                if(emailYN == true){
                    alert('인증 메일을 발송했습니다');

                    $.ajax({
                        type:"POST",
                        url:"/register/email",
                        data:{userEmail:clientEmail},
                        success : function (data) {
                        },error : function (e){
                            alert('오류입니다. 잠시 후 다시 시도해주세요.');
                        }
                    });

                }else if($('#emailText').val() == null){
                    alert('이메일을 입력해주세요');
                }else
                    alert('이메일 형식에 알맞게 입력해주세요 xxx@xxxx.com');


            }

            function isEmail(asValue) {
                var regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
                return regExp.test(asValue);
            }

            function emailCertification() {
                let clientEmail = document.getElementById('emailText').value;
                let inputCode = document.getElementById('certificationNumber').value;

                console.log('이메일' + clientEmail);
                console.log('인증코드' + inputCode);

                $.ajax({
                    type:"POST",
                    url:"/register/certification",
                    data:{userEmail: clientEmail , inputCode:inputCode},
                    success : function (result){
                        console.log(result);
                        if(result==true){
                            alert('인증완료');
                            document.getElementById('certificationYN').value = "true";
                            clientEmail.onchange = function (){
                                document.getElementById('certificationYN').value = "false";
                            }
                        }else{
                            alert('재시도');
                        }
                    }

                })
            }
//ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ아이디 중복 체크ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

            function idCheck(){
                var user_id = $('#user_id').val();
                    $.ajax({
                        url:'/register/idCheck',
                        type:'post',
                        data:{user_id:user_id},
                        success:function(cnt){ //컨트롤러에서 넘어온 cnt값을 받는다

                                if(cnt != 1){ //cnt가 1이 아니면(=0일 경우) -> 사용 가능한 아이디
                                    $('.id_ok').css("color","#033af5");
                                    $('.id_ok').html("사용 가능한 아이디입니다");

                                } else {// cnt가 1일 경우 -> 이미 존재하는 아이디
                                    $('.id_ok').css("color","#f80606");
                                    $('.id_ok').html("중복된 아이디입니다");
                                }


                        },
                            error:function(){
                            alert("에러입니다");
                        }
                    });
            };

            function pwdCheck(){
                var pwd1 = $('#password').val();
                var pwd2 = $('#')

            }

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

    <body class="bg-primary" >
    <%@include file="import/Navigation.jsp"%>
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
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Create Account</h3></div>
                                    <div class="card-body">
                                        <form name="f" method="post" action="/Userinfoinsert" target= "ifrPrc" onsubmit="return doSubmit(this);" >
                                            <div class="row mb-3">
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="user_id" name="user_id" placeholder="아이디" type="text" required oninput="idCheck()" />


                                                    </div>
                                                    <span class="id_ok form-floating mb-3 mb-md-0"></span>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="password" name="password" type="password"  />
                                                        <label for="password">비밀번호</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input class="form-control" id="user_name" name="user_name" type="text"  />
                                                        <label for="user_name">이름</label>

                                                    </div>
                                                </div>

                                                <div class = "col-md-10">
                                                    <div class="form-floating mb-3">
                                                        <input class="form-control" id="emailText" name="emailText" type="email"  />
                                                        <label for="emailText">이메일</label>

                                                    </div>
                                                </div>
                                                <div class = "col-md-10">
                                                    <div class="form-floating mb-3">
                                                        <button type="button" name="emailCheck" id="emailCheck" onclick="emailSend()">인증메일 전송</button>

                                                    </div>
                                                </div>
                                                <div class = "col-md-10">
                                                    <div class="form-floating mb-3">
                                                           <input class="form-control" id="certificationNumber" name="certificationNumber" type="text"  />
                                                    </div>
                                                </div>
                                                <div class = "col-md-10">
                                                    <div class="form-floating mb-3">
                                                        <button type="button" name="certificationBtn" id="certificationBtn" onclick="emailCertification()">인증 하기</button>
                                                        <input type="hidden" name="certificationYN" id="certificationYN" value="false"/>
                                                     </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <input type="text" name="sample6_postcode" id="sample6_postcode" placeholder="우편번호">
                                                        <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                                                        <input type="text" id="addr1" name="addr1" placeholder="주소"><br>
                                                        <input type="text" name="sample6_detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                                                        <input type="text" id="addr2" name="addr2" placeholder="참고항목">
                                                    </div>
                                                </div>
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid">
                                                    <input type="submit" value="회원가입"/>
                                                </div>
                                            </div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="LoginPage.jsp">Have an account? Go to login</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    <iframe name="ifrPrc" style="display:none"></iframe>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


    </body>
</html>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@include file="import/heads.jsp"%>
        <title>회원가입</title>
        <!-- Favicon-->
        <link rel="stylesheet" href="/css/login.css">
        <link rel="stylesheet" href="/css/nomal.css">

        <script src="js/emailApi.js"></script>
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

            function isId(asValue) {
                var regExp = /^[a-z]+[a-z0-9]{5,19}$/g;

                return regExp.test(asValue);
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
                        success:function(cnt){
                            //컨트롤러에서 넘어온 cnt값을 받는다

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

            $(function(){
               $('#password').keyup(function(){
                    $('#pwd_ok').html('');
                });

                $('#pwdCheck').keyup(function(){

                    if($('#password').val() != $('#pwdCheck').val()){
                        $('#pwd_ok').html('비밀번호 일치하지 않음<br><br>');
                        $('.pwd_ok').css('color', '#f60607');
                    } else{
                        $('#pwd_ok').html('비밀번호 일치함<br><br>');
                        $('.pwd_ok').css('color', '#033af4');
                    }

                });
            });
           //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ우편번호ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
               
            function doSubmit(f){
                if(f.user_id.value == ""){
                    alert("아이디를 입력하시기 바랍니다.");
                    f.user_id.focus();
                    return false;
                }

                if(!isId(f.user_id.value)){
                    alert("아이디는 소문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
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

    <div class="container" >
        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-lg border-0 rounded-lg mt-5">
                    <div class="card-header"><h1 class="text-center font-weight-light my-4"><strong>회원가입</strong></h1></div>
                    <div class="card-body" style="padding: 30px">
                        <form name="f" method="post" action="/Userinfoinsert" target= "ifrPrc" onsubmit="return doSubmit(this);" >
                            <div class="row">
                                <label for="user_id">아이디</label>
                                <div style="display: flex">
                                    <input class="text-field" style="width: 60%; height: 41px;" id="user_id" name="user_id" type="text" required oninput="idCheck()" />
                                    <span class="id_ok" style="margin-left: 10px"></span>
                                </div>

                                    <label for="password" style="width: 40%;">비밀번호</label>
                                    <label for="pwdCheck" style="width: 40%;">비밀번호 확인</label>
                                    <div style=" display:flex">
                                        <input class="text-field" style="width: 40%; height: 41px;" id="password" name="password" type="password"  />
                                        <input class="text-field" style="width: 40%; height: 41px; margin-left: 10px;" id="pwdCheck" name="pwdCheck" type="password"  required oninput="pwdCheck()"/>

                                    </div>
                                <span class="pwd_ok" id="pwd_ok" style="margin-left: 10px"></span>


                                <label for="user_name">이름</label>
                                <div class="col-md-6">
                                    <input class="text-field" style="height: 41px;" id="user_name" name="user_name" type="text"  />
                                </div>

                                <label for="emailText">이메일</label>
                                <div style="display:flex;">
                                    <input class="text-field"  style="width: 60%; height: 41px;" id="emailText"  name="emailText" type="email"  />
                                    <button type="button" class="submit-btn-100" style="margin-left: 10px; height: 41px;" name="emailCheck" id="emailCheck" onclick="emailSend()">인증메일 전송</button>
                                </div>


                                <div style="display: flex">
                                    <input class="text-field" style="width:60%; height:41px;" id="certificationNumber" name="certificationNumber" type="text"  />
                                    <button type="button" class="submit-btn-100" style="margin-left: 10px; height: 41px;" name="certificationBtn" id="certificationBtn" onclick="emailCertification()">인증 하기</button>
                                    <input type="hidden" style="height: 41px;" name="certificationYN" id="certificationYN" value="false"/>
                                </div>


                                    <input type="text" style="height: 41px; width:30%;" name="sample6_postcode" id="sample6_postcode" placeholder="우편번호">
                                    <input type="button" class="submit-btn-100" style="margin-left: 10px; height: 41px;" onclick="sample6_execDaumPostcode()" value="우편번호 찾기">
                                    <input type="text" style="height: 41px; width:60%;" id="addr1" name="addr1" placeholder="주소">
                                    <input type="text" style="height: 41px; width:60%;" name="sample6_detailAddress" id="sample6_detailAddress" placeholder="상세주소">
                                    <input type="text" style="height: 41px; width:60%;" id="addr2" name="addr2" placeholder="참고항목">
                                <div class="mt-4 mb-0">
                                    <div class="d-grid">
                                        <input type="submit" class="submit-btn" value="회원가입"/>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center py-3">
                        <div class="small"><a href="/LoginPage">계정이 있으신가요? 로그인</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <iframe name="ifrPrc" style="display:none"></iframe>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<%@include file="import/footer.jsp"%>

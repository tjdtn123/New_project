<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%! String id_session;

%>
<%if(session.getAttribute("user_id") != null) {
    id_session = session.getAttribute("user_id").toString();

}
%>
<%@include file="import/heads.jsp"%>
<link rel="stylesheet" href="/css/login.css">
<link rel="stylesheet" href="/css/nomal.css">

    <title>비밀번호 변경</title>



    <script type="text/javascript">
        //ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ이메일 인증ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ

        function emailSend() {
            let clientEmail = $('#emailText').val();
            let emailYN = isEmail(clientEmail);

            console.log('입력 이메일' + clientEmail);

            if(emailYN == true){
                alert('이메일 형식입니다');

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
        function doSubmit(f){
            if(f.user_id.value == ""){
                alert("아이디를 입력하시기 바랍니다.");
                f.user_id.focus();
                return false;
            }
            if(f.certificationYN.value == "false"){
                alert("메일 인증을 해주시기 바랍니다.");
                f.certificationYN.focus();
                return false;
            }
            if(f.document.getElementById('certificationYN').value == "false"){
                alert('이메일 인증을 해주세요');
                return false;
            }
        }
    </script>

    <script src="https://kit.fontawesome.com/2dc1583151.js" crossorigin="anonymous"></script>
</head>
<body>
<%@include file="import/Navigation.jsp"%>
<div id="layoutAuthentication">
    <div id="layoutAuthentication_content">
        <main>
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-7">
                        <div class="card shadow-lg border-0 rounded-lg mt-5">
                            <div class="card-header"><h3 class="text-center font-weight-light my-4">비밀번호 찾기</h3></div>
                            <div class="card-body">
                                <form name="f" method="get" action="/PwdChange" target= "ifrPrc" onsubmit="return doSubmit(this);" >
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <div class="form-floating mb-3 mb-md-0">
                                                <input class="form-control" id="user_id" name="user_id" type="text" />
                                                <label for="user_id">아이디</label>
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
                                                <button type="button" name="emailCheck"  class="submit-btn-100" id="emailCheck" onclick="emailSend()">인증메일 전송</button>

                                            </div>
                                        </div>
                                        <div class = "col-md-10">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="certificationNumber" name="certificationNumber" type="text"  />
                                            </div>
                                        </div>
                                        <div class = "col-md-10">
                                            <div class="form-floating mb-3">
                                                <button type="button"class="submit-btn-100"  name="certificationBtn" id="certificationBtn" onclick="emailCertification()">인증 하기</button>
                                                <input type="hidden" name="certificationYN" id="certificationYN" value="false"/>
                                            </div>
                                        </div>
                                    <div class="mt-4 mb-0">
                                            <div class="d-grid">
                                                <input type="submit" class="submit-btn" value="확인"/>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <div class="card-footer text-center py-3">
                                <div class="small"><a href="/LoginPage">Have an account? Go to login</a></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>
<%@include file="import/footer.jsp"%>

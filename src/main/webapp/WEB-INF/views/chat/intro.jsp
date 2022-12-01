<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<% String id_session = CmmUtil.nvl((String)session.getAttribute("user_id")); %>
<%@include file="../import/heads.jsp"%>

    <title>채팅방 입장을 위한 별명 설정</title>
    <link rel="stylesheet" href="../css/board.css">
    <script>

        const id_session = "<%=id_session%>";


        $(document).ready(function () {

            let btnSend = document.getElementById("btnSend");

            btnSend.onclick = function () {

                const f = document.getElementById("f");
                f.submit();
                            }
        });

        function gotoroom(roomname){
            location.href = "/chat/room?roomname="+roomname;

        }

        setInterval(function() {
            $.ajax({
                url: "/chat/roomList",
                type: "get",
                dataType: "JSON",
                success: function (json) {

                    let roomHtml = "";

                    for (const room of json) {
                        roomHtml += (
                                `<div class="h-50 p-5 text-white rounded-3 mb-2">
                                 <h2>` + room + `</h2>
                                 <button class="sbutton subscribe float-end me-5"  type="button" onclick="gotoroom('`+ room +`')">입장</button>
                                 </div>`);

                    }

                    $("#rooms").html(roomHtml);
                }
            });

        }, 5000)

        function chk_form(){
            $("#f").submit();
        }

    </script>
</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<div class="container p-5">
    <br>
        <h1 class="text-white"><strong>채팅방 목록</strong></h1>
    <hr/>

        <div id="roomswarp " class="overflow-auto bgbgbg" style="max-height: 1000px;" >
            <div id ="rooms" class="col-md-6 mx-auto d-flex text-center"></div>
        </div>

    </br>
    </br>
    <hr/>
    <div class="board-card p-5 float-end me-5">
        <form method="post" id="f" action="/chat/room">
            <h2 class="text-white"><strong>방 만들기</strong></h2>
            <hr>
            <div class="input-container">
                <span>채팅방 이름 : <input type="text" name="roomname" class="text-input p-2"></span>
            </div>
            <a onclick="chk_form()" id = "btnSend" class="subscribe button float-end"style="color:#fff;" >채팅방 만들기</a>
        </form>
    </div>
</div>
<%@include file="../import/footer.jsp"%>


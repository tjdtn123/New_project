<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String roomname = CmmUtil.nvl(request.getParameter("roomname"));

    String nickname = CmmUtil.nvl((String)session.getAttribute("user_id"));


%>
<%@include file="../import/heads.jsp"%>
    <title>채팅방 입장</title>
    <link rel="stylesheet" href="../css/chatstyle.css">
    <script src="../js/chatscript.js"></script>
    <style>
        .button {
            /*display: block;*/
            width: 175px;
            line-height: 50px;
            font-size: 16px;
            font-weight: 700;
            color: white;
            text-align: center;
            margin: 0 auto;
            border: #03969a;
            border-radius: 5px;
            -webkit-transition: background .3s;
            transition: background .3s;
        }
        .button:hover {
            text-decoration: none;
        }

        .subscribe.button {
            background: #11a8ab;
            margin-top: 10px;
        }
        .subscribe.button:hover {
            background: #0F9295;
        }

        .sbutton {
            /*display: block;*/
            width: 100px;
            line-height: 50px;
            font-size: 16px;
            font-weight: 700;
            color: white;
            border: #03969a;
            text-align: center;
            margin: 0 auto;
            border-radius: 5px;
            -webkit-transition: background .3s;
            transition: background .3s;
        }
        .sbutton:hover {
            text-decoration: none;
        }

        .subscribe.sbutton {
            background: #11a8ab;
            margin-top: 10px;
        }
        .subscribe.sbutton:hover {
            background: #0F9295;
        }


        .subscribe.sbutton:focus {
            background: #0c787a;


        }

    </style>

    <script type="text/javascript">

        let data = {};
        let ws;
        const roomname = "<%=roomname%>";
        const nickname = "<%=nickname%>";


        $(document).ready(function () {

            $.ajax({
                url : "/chat/getMsg",
                type : "post",
                data : {"roomName" : roomname},
                success: function (data) {

                    $.each(data, function (key, value) {

                        if (nickname == value.name) {

                            $("#chat-wrapper").append(`<div class="message-wrapper reverse">
                                                            <div class="message-box-wrapper">
                                                                <span>` +  value.name + `</span>
                                                                <div class="message-box">` + value.msg + `</div><span>` +  value.date + `</span><div class="message-box-wrapper">
                                                                    </div></div>`);


                        } else {
                            $("#chat-wrapper").append(`<div class="message-wrapper">
                                                            <div class="message-box-wrapper">
                                                                <span>` +  value.name + `</span>
                                                                <div class="message-box">` + value.msg + `</div><span>` +  value.date + `</span><div class="message-box-wrapper">
                                                                    </div></div>`);

                            /*$("#chat-wrapper").append(`<div class="message-wrapper">`);
                            $("#chat-wrapper").append(`    <div class="message-box-wrapper">`);
                            $("#chat-wrapper").append(`        <span>` +  value.name + '</span>');
                            $("#chat-wrapper").append(`        <div class="message-box">` + value.msg + `</div>`);
                            $("#chat-wrapper").append(`        <span>` +  value.date + '</span>');
                            $("#chat-wrapper").append(`    </div>`);
                            $("#chat-wrapper").append(`</div>`);*/

                        }

                        $("#msg").focus();
                        $(".chat-wrapper").scrollTop($(".chat-wrapper")[0].scrollHeight);

                    });

                }

            })

            let btnSend = document.getElementById("btnSend");
            btnSend.onclick = function() {
                send();
            }

            console.log("openSocket");
            if(ws !== undefined && ws.readyState !== WebSocket.CLOSED) {
                console.log("WebSocket is already opened.");
                return;

            }

            ws = new WebSocket("ws://" + location.host + "/ws/" + roomname + "/" + nickname);

            ws.onopen = function(event) {
                if (event.data === undefined)
                    return;

                console.log(event.data)
            };

            ws.onmessage = function (msg) {

                let data = JSON.parse(msg.data);

                if (data.name == nickname) {
                    $("#chat-wrapper").append(`<div class="message-wrapper reverse">
                                                            <div class="message-box-wrapper">
                                                                <span>` +  data.name + `</span>
                                                                <div class="message-box">` + data.msg + `</div><span>` +  data.date + `</span><div class="message-box-wrapper">
                                                                    </div></div>`);
                    $("#msg").focus();
                    $(".chat-wrapper").scrollTop($(".chat-wrapper")[0].scrollHeight);
                    /*$("#chat-wrapper").append(`<div class="message-wrapper reverse">`);
                    $("#chat-wrapper").append(`    <div class="message-box-wrapper">`);
                    $("#chat-wrapper").append(`        <span>` +  value.name + '</span>');
                    $("#chat-wrapper").append(`        <div class="message-box">` + value.msg + `</div>`);
                    $("#chat-wrapper").append(`        <span>` +  value.date + '</span>');
                    $("#chat-wrapper").append(`    </div>`);
                    $("#chat-wrapper").append(`</div>`);*/

                } else if (data.name === "관리자") {
                    $("#chat-wrapper").append("<div style='font-family: 'Gowun Dodum',  sans-serif;'>");
                    $("#chat-wrapper").append("<span style='color:red'><b>[보낸 사람] : </b></span>");
                    $("#chat-wrapper").append("<span style='color:red'>" + data.name + "  </span>");
                    $("#chat-wrapper").append("<span style='color:red'><b>[발송 메세지] : </b></span>");
                    $("#chat-wrapper").append("<span style='color:red'>" + data.msg + " </span>");
                    $("#chat-wrapper").append("<span style='color:red'><b>[발송시간] : </b></span>");
                    $("#chat-wrapper").append("<span style='color:red'>" + data.date + " </span>");
                    $("#chat-wrapper").append("</div>");

                }else {
                    $("#chat-wrapper").append(`<div class="message-wrapper ">
                                                            <div class="message-box-wrapper">
                                                                <span>` +  data.name + `</span>
                                                                <div class="message-box">` + data.msg + `</div><span>` +  data.date + `</span><div class="message-box-wrapper">
                                                                    </div></div>`);
                    $("#msg").focus();
                    $(".chat-wrapper").scrollTop($(".chat-wrapper")[0].scrollHeight);
                    /*$("#chat-wrapper").append(`<div class="message-wrapper">`);
                    $("#chat-wrapper").append(`    <div class="message-box-wrapper">`);
                    $("#chat-wrapper").append(`        <span>` +  value.name + '</span>');
                    $("#chat-wrapper").append(`        <div class="message-box">` + value.msg + `</div>`);
                    $("#chat-wrapper").append(`        <span>` +  value.date + '</span>');
                    $("#chat-wrapper").append(`    </div>`);
                    $("#chat-wrapper").append(`</div>`);*/

                }
            }

        });

        function send() {

            let msgObj = $("#msg");

            if (msgObj.value !== ""){
                data.name = nickname;
                data.msg = msgObj.val();
                data.roomName = roomname;


                let temp = JSON.stringify(data);

                console.log(data);
                ws.send(temp);

                $.ajax({
                    url : "/chat/insertChat",
                    type : "POST",
                    data: {'name' : nickname, 'msg' : msgObj.val(), 'roomName' : roomname},
                        success: function (){

                        }
                })
            } else
                alert('채팅을 입력해주세요');

            msgObj.val("");
        }

        function gobefore() {
            window.history.forward();
        }

    </script>
</head>
<body>
<%@include file="../import/Navigation.jsp"%>

<%--<h2><%=nickname%> 님! <%=roomname%> 채팅방 입장하셨습니다.</h2><br/><br/>--%>
<div class="app-container mx-auto">

    <div class="app-main">
        <div class="chat-wrapper" id="chat-wrapper">
            <div class="message-wrapper-comein">
                <div class="message-box-wrapper" >

                        <h3 style="color: #e44b65;"><%=nickname%> 님! <%=roomname%> 채팅방 입장하셨습니다.</h3>


                </div>
            </div>
            <div>

            </div>
        </div> <div class="chat-input-wrapper">
        <div class="input-wrapper">
            <input type="text" id="msg" class="chat-input" placeholder="Enter your message here">
        </div>
        <button class="chat-send-btn" id="btnSend">Send</button>
    </div>
    </div>

</div>
<br>
<br>
<div class="app-container mx-auto">
    <a href="/chat/intro" class="subscribe button float-end"style="color:#fff; height: 60px; " >나가기</a>
</div>


<%@include file="../import/footer.jsp"%>



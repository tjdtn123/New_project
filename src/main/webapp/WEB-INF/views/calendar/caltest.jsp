<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String sessionId = session.getAttribute("user_id").toString();
%>
<%@include file="../import/heads.jsp"%>
    <title>풀캘린더</title>
    <link href='../fullcalendar/main.css' rel='stylesheet' />
    <script src='../fullcalendar/main.js'></script>
    <script src="../fullcalendar/locales-all.js"></script>
    <style>
        @media screen and (max-width:500px){
            body {
                margin: 40px 10px;
                padding: 0;
                font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
                font-size: 11px;
                height:100%;
            }
            .fc-toolbar-title{
                font-size: 10px !important;
            }
        }
        @media screen and (min-width:501px){
            body {
                margin: 40px 10px;
                padding: 0;
                font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
                font-size: 14px;
                height:100%;
            }
        }

        #calendar {
            max-width: 1400px;
            min-height: 500px;
            margin: 0 auto;
        }

        /*요일*/
        .fc-col-header-cell-cushion {
            color: #000;
        }
        .fc-col-header-cell-cushion:hover {
            text-decoration: none;
            color:#000;
        }
        /*일자*/
        .fc-daygrid-day-number{
            color: #000;
            font-size:1em;
        }

        /*종일제목*/
        .fc-event-title.fc-sticky{

        }
        /*more버튼*/
        .fc-daygrid-more-link.fc-more-link{
            color: #000;
        }
        /*일정시간*/
        .fc-daygrid-event > .fc-event-time{
            color:#000;
        }
        /*시간제목*/
        .fc-daygrid-dot-event > .fc-event-title{
            color:#000 !important;
        }
        /*가로 줄 - 월달력 종일 or 복수일자*/
        .fc-h-event{

        }
        /*세로 줄 - 주달력, 일달력*/
        .fc-v-event{

        }
        /*title 옆에 점*/
        .fc-daygrid-event-dot{

        }
        /*month/week/day*/
        .fc-button-active{
            border-color: #ffc107 		!important;
            background-color: #ffc107 	!important;
            color: #000 				!important;
            font-weight: bold 			!important;
        }
        /*노란버튼*/
        .btn-warning{
            font-weight: bold;
        }
        /*모달 푸터*/
        .modal-footer{
            display:inline-block;
        }
    </style>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<div id='calendar'></div>

<!-- insertModal -->
<div class="modal fade insertModal" id="myModal">
    <div class="modal-dialog">
        <div class="modal-content" id="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">일정 등록</h4>
                <button type="button" class="close" onclick="initModal('insertModal', g_arg)">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <div class="form-group">
                    <label for="title">제목:</label>
                    <input type="textbox" class="form-control" placeholder="" id="title">
                </div>
                <br>
                <div class="form-group">
                    <label for="memo">일정내용:</label>
                    <input type="textbox" class="form-control" placeholder="" id="memo">
                </div>

            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-success updateBtn" onclick="updateSch('insertModal',g_arg)">수정</button>
               <%--<button type="button" class="btn btn-danger rejectBtn" onclick="rejectSch('insertModal', g_arg)">반려</button>--%>

                <button type="button" class="btn btn-dark  float-right deleteBtn" onclick="deleteSch('insertModal', g_arg)">삭제</button>
                <button type="button" class="btn btn-warning float-right insertBtn" onclick="insertSch('insertModal', g_arg)">등록</button>
            </div>

        </div>
    </div>
</div>

<script>

    var ceoColor = '#ffc107'; //대표일정 황색
    var regColor = '#343a40';	//일반직원등록 흑색
    var approvalColor = '#28a745'; //승인 녹색
    var rejectColor = '#dc3545'; //반려 적색
    var textWhite = '#fff'; //글씨흰색
    var textBlack = '#000'; //글씨검은색

    var today = new Date();
    var month = today.getMonth()+1;	//getMonth()는 9월이 8으로 나옴
    var date = today.getDate();
    var g_arg;	//이벤트 글로벌 변수(모달창에서 호출하는 함수에서 참조하기 위함)
    var calendar;	//달력 변수
    var todayStr = today.getFullYear() + '-' + stringFormat(month) + '-' + stringFormat(date);
    var sch;

    $('#myModal').on('hide.bs.modal', function (e) {
        $('#title').val('');
        $('#memo').val('');
    })

    $.ajax({
        url: "/calendar/getCalendar",
        type: "GET",
        dataType: "JSON",
        traditional: true,
        async: false,
        success : function(data) {

                sch = data; //스케줄 저장
                console.log(sch);


        },

    });


    document.addEventListener('DOMContentLoaded', function() {


        var calendarEl = $('#calendar')[0];

        calendar = new FullCalendar.Calendar(calendarEl, {
            height: '700px',

            headerToolbar: {
                left: 'prev,next,today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'

            },
            editable: true,
            selectable: true,
            selectMirror: true,
            nowIndicator: true,
            dayMaxEvents: true,
            locale: 'ko',
            initialView: 'dayGridMonth',

            select: function(arg) {

                insertModalOpen(arg);	//일자 클릭 시 모달 호출
            },
            eventClick: function(arg) {
                insertModalOpen(arg);	//이벤트 클릭 시 모달 호출
            },
            eventChange: function(arg){
                //allDay true로 바꾸면 end가 없어서 만듬
                if(arg.event.end == null){
                    var end = new Date();
                    end.setDate(arg.event.start.getDate()+1);
                    arg.event.setEnd(end);
                }
            },
            eventDrop: function(arg){
                insertModalOpen(arg);		//이벤트 드래그드랍 시 모달 호출
            },
            eventResize: function(arg){
                insertModalOpen(arg);		//이벤트 사이즈 변경시(일정변경) 모달 호출
            },

            events : sch

        });

        calendar.render();

    });
    function stringFormat(p_val){
        if(p_val < 10)
            return p_val = '0'+p_val;
        else
            return p_val;
    }
    //시작일자 변경 시 종료일자 +30분 설정
    /*function startChange(){
        var start = $('#start').val();
        var end  = $('#end').val();
        if(start.substring(3, 5) == '00')
            end = start.substring(0, 2) + ':30';
        else
            end = (parseInt(start.substring(0, 2))+1) + ':00';

        $('#end').val(end);
    }*/
    //모달초기화
    function initModal(modal, arg){
        $('.'+modal+' #title').val('');
        $('.'+modal+' #memo').val('');
        $('.'+modal).modal('hide');

        g_arg = null;
    }


    //일정등록창 모달
    function insertModalOpen(arg){

        g_arg = arg;
        //값이 있는경우 세팅
        if(g_arg.event != undefined){
            $('.insertModal .deleteBtn').css('display', 'inline');
            $('.insertModal .updateBtn').css('display', 'inline');
            $('.insertModal .insertBtn').css('display', 'none');
            $('.insertModal #memo').val(g_arg.event.extendedProps.memo);
            $('.insertModal #title').val(g_arg.event.title);

        }else{
            //등록버튼 외 숨김
            $('.insertModal .insertBtn').css('display', 'inline');
            $('.insertModal .deleteBtn').css('display', 'none');
            $('.insertModal .updateBtn').css('display', 'none');
        }
        //모달창 show
        $('.insertModal').modal('show');


        console.log(arg);


        $('.insertModal #title').focus();

       /* $('#myModal').click(function(e) {
            if(!$(e.target).hasClass("modal-content")) {
                alert('영역 밖입니다.');
                $('.'+modal+' #title').val('');
                $('.'+modal+' #memo').val('');
            }
        });*/


    }

    //일정승인
    function insertSch(modal, arg) {
        if (confirm('일정을 저장하시겠습니까?')) {
            if ($('.' + modal + ' #title').val() == '') {
                alert('제목을 입력해주세요');
                return;
            }

            if ($('.' + modal + ' #memo').val() == '') {
                alert('내용을 입력해주세요');
                return;
            }

            $.ajax({
                url: "/calendar/insertCalendar",
                type: "POST",
                data: {
                    "title": $('.' + modal + ' #title').val(),
                    "memo": $('.' + modal + ' #memo').val(),
                    "start": arg.startStr,
                    "end": arg.endStr
                },

                dataType: "TEXT",

                success: function (data) {
                    alert("성공");
                    calendar.addEvent({
                        title : $('.' + modal + ' #title').val(),
                        memo : $('.' + modal + ' #memo').val(),
                        start : arg.startStr,
                        end : arg.endStr,
                    })



                    //모달초기화
                    initModal(modal, arg);
                    location.reload();
                },
                error:function (request, error) {
                    alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                }
            });


        }
    }


    //일정승인
    function updateSch(modal, arg) {
        if (confirm('일정을 저장하시겠습니까?')) {
            if ($('.' + modal + ' #title').val() == '') {
                alert('제목을 입력해주세요');
                return;
            }

            if ($('.' + modal + ' #memo').val() == '') {
                alert('내용을 입력해주세요');
                return;
            }

            $.ajax({
                url: "/calendar/updateCalendar",
                type: "POST",
                data: {
                    "calendar_No" : arg.event.extendedProps.calendar_No,
                    "title": $('.' + modal + ' #title').val(),
                    "memo": $('.' + modal + ' #memo').val(),
                    "start": arg.event.startStr,
                    "end": arg.event.endStr
                },
                dataType: "TEXT",

                success: function (data) {

                    arg.event.setProp('title', $('.' + modal + ' #title').val());
                    arg.event.setStart(arg.event.start);
                    arg.event.setEnd(arg.event.end);


                    //모달초기화
                    initModal(modal, arg);
                    location.reload();
                },
                error:function (request, error) {
                    alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                }
            });


        }
    }
    function updateSch(modal, arg) {
        if (confirm('일정을 저장하시겠습니까?')) {
            if ($('.' + modal + ' #title').val() == '') {
                alert('제목을 입력해주세요');
                return;
            }

            if ($('.' + modal + ' #memo').val() == '') {
                alert('내용을 입력해주세요');
                return;
            }

            $.ajax({
                url: "/calendar/updateCalendar",
                type: "POST",
                data: {
                    "calendar_No" : arg.event.extendedProps.calendar_No,
                    "title": $('.' + modal + ' #title').val(),
                    "memo": $('.' + modal + ' #memo').val(),
                    "start": arg.event.startStr,
                    "end": arg.event.endStr
                },
                dataType: "TEXT",

                success: function (data) {

                    arg.event.setProp('title', $('.' + modal + ' #title').val());
                    arg.event.setStart(arg.event.start);
                    arg.event.setEnd(arg.event.end);


                    //모달초기화
                    initModal(modal, arg);
                    location.reload();
                },
                error:function (request, error) {
                    alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                }
            });


        }
    }
    //일정삭제
    function deleteSch(modal, arg){
        if(confirm('일정을 삭제하시겠습니까?')){
            var datak = {"title": arg.event.title, "memo" : arg.event.extendedProps.memo};
            console.log(arg.event.title);
            console.log(arg.event.extendedProps.memo);
            //DB 삭제
            $.ajax({
                url: "/calendar/deleteCalendar",
                type: "POST",
                data: datak,
                dataType: "TEXT",
                traditional: true,
                success : function(data){
                    arg.event.remove();
                    initModal(modal, arg);
                },
                error:function (request, error) {
                    alert("code : " + request.status + "\n" + "message : " + request.responseText + "\n" + "error : " + error);
                }
            });
            //
        }
    }







</script>
<%@include file="../import/footer.jsp"%>
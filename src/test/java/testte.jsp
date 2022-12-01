<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width text/html, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" type="image/x-icon" href="/assets/wallpaper.jpg" />

    <script src="https://code.jquery.com/jquery-latest.js"></script>

    <!--글꼴 -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Gowun+Dodum&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/styless.css">
    <link rel="stylesheet" href="/css/nomal.css">
    <title>캘린더</title>
    <link rel="stylesheet" href="/css/main.css">
    <script src="/js/main.js"></script>


    <style>
        *{
            font-family: 'Gowun Dodum', sans-serif;

        }
    </style>
<!--
<script>

    var calendar = null;
    var initialLocaleCode = 'ko';
    var localeSelectorEl = document.getElementById('locale-selector');

    $(document).ready(function (){

        $(function () {
            var request = $.ajax({
                url: "/full-calendar/calendar-admin-update", // 변경하기
                method: "GET",
                dataType: "json"
            });
            request.done(function (data) {
                console.log(data); // log 로 데이터 찍어주기.
                var calendarEl = document.getElementById('calendar');
                calendar = new FullCalendar.Calendar(calendarEl, {
                    initialDate: '2022-02-07',
                    initialView: 'timeGridWeek',
                    headerToolbar: {
                        left: 'prev,next today',
                        center: 'title',
                        right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
                    },
                    navLinks: true,
                    editable: true,
                    selectable: true,
                    droppable: true, // this allows things to be dropped onto the calendar

                    // eventAdd: function () { // 이벤트가 추가되면 발생하는 이벤트
                    //     // console.log()
                    // },

                    /**
                     * 드래그로 이벤트 수정하기
                     */
                    eventDrop: function (info){

                        if(confirm("'"+ info.event.title +"' 매니저의 일정을 수정하시겠습니까 ?")){

                            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                            var obj = new Object();

                            obj.title = info.event._def.title;
                            obj.start = info.event._instance.range.start;
                            obj.end = info.event._instance.range.end;

                            obj.oldTitle = info.oldEvent._def.title;
                            obj.oldStart = info.oldEvent._instance.range.start;
                            obj.oldEnd = info.oldEvent._instance.range.end;

                            events.push(obj);

                            console.log(events);
                        }else{
                            // Get 방식으로 데이터를 조회해서 가져와야하는데 새로고침 하지 않고는 어떻게
                            // 해야할지 감이 안잡혀서 우선 reload 방식으로..
                            location.reload();
                        }
                        $(function modifyData() {
                            $.ajax({
                                url: "/full-calendar/calendar-admin-update",
                                method: "PATCH",
                                dataType: "json",
                                data: JSON.stringify(events),
                                contentType: 'application/json',
                            })
                        })


                    },
                    eventResize: function (info){
                        console.log(info);
                        if(confirm("'"+ info.event.title +"' 매니저의 일정을 수정하시겠습니까 ?")){

                            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                            var obj = new Object();

                            obj.title = info.event._def.title;
                            obj.start = info.event._instance.range.start;
                            obj.end = info.event._instance.range.end;

                            obj.oldTitle = info.oldEvent._def.title;
                            obj.oldStart = info.oldEvent._instance.range.start;
                            obj.oldEnd = info.oldEvent._instance.range.end;

                            events.push(obj);

                            console.log(events);
                        }else{
                            location.reload();
                        }
                        $(function modifyData() {
                            $.ajax({
                                url: "/full-calendar/calendar-admin-update",
                                method: "PATCH",
                                dataType: "json",
                                data: JSON.stringify(events),
                                contentType: 'application/json',
                            })
                        })
                    },

                    /**
                     * 드래그로 이벤트 추가하기
                     * 이름 다른 경우 표현 안돼야 하는데 어떻게 해야할까?..
                     */
                    select: function (arg) { // 캘린더에서 이벤트를 생성할 수 있다.

                        var title = prompt('매니저 이름을 입력해주세요.');
                        if (title) {
                            calendar.addEvent({
                                title: title,
                                start: arg.start,
                                end: arg.end,
                                allDay: arg.allDay
                            })
                        }

                        console.log(arg);

                        var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                        var obj = new Object();     // Json 을 담기 위해 Object 선언

                        obj.title = title; // 이벤트 명칭  ConsoleLog 로 확인 가능.
                        obj.start = arg.start; // 시작
                        obj.end = arg.end; // 끝
                        events.push(obj);
                        var jsondata = JSON.stringify(events);
                        console.log(jsondata);


                        $(function saveData(jsondata) {
                            $.ajax({
                                url: "/full-calendar/calendar-admin-update",
                                method: "POST",
                                dataType: "json",
                                data: JSON.stringify(events),
                                contentType: 'application/json',
                            })
                            // .done(function (events) {
                            //     // alert(events);
                            // })
                            // .fail(function (request, status, error) {
                            //      // alert("에러 발생" + error);
                            // });
                            calendar.unselect()
                        });
                    },

                    /**
                     * 이벤트 선택해서 삭제하기
                     */
                    eventClick: function (info){
                        if(confirm("'"+ info.event.title +"' 매니저의 일정을 삭제하시겠습니까 ?")){
                            // 확인 클릭 시
                            info.event.remove();


                            console.log(info.event);
                            var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                            var obj = new Object();
                            obj.title = info.event._def.title;
                            obj.start = info.event._instance.range.start;
                            obj.end = info.event._instance.range.end;
                            events.push(obj);

                            console.log(events);
                        }
                        $(function deleteData(){
                            $.ajax({
                                url: "/full-calendar/calendar-admin-update",
                                method: "DELETE",
                                dataType: "json",
                                data: JSON.stringify(events),
                                contentType: 'application/json',
                            })
                        })
                    },
                    locale: 'ko',
                    // eventRemove: function (obj) { // 이벤트가 삭제되면 발생하는 이벤트
                    //
                    // },
                    events: data
                });
                calendar.render();
            });

        });

    });




</script>-->
<script>


    document.addEventListener('DOMContentLoaded', function() {
        $(function () {
            var request = $.ajax({
                url: "calendar/getCalendar", // 변경하기
                method: "GET",
                dataType: "json"
            });
            request.done(function (data) {
                console.log(data); // log 로 데이터 찍어주기.

                var calendarEl = document.getElementById('calendar');
                var calendar = new FullCalendar.Calendar(calendarEl, {
                    initialView: 'dayGridMonth', // 초기 로드 될때 보이는 캘린더 화면(기본 설정: 달)
                    selectable: true, // 달력 일자 드래그 설정가능
                    droppable: true,
                    editable: true,
                    nowIndicator: true, // 현재 시간 마크
                    locale: 'ko', // 한국어 설정
                    headerToolbar: { // 헤더에 표시할 툴 바
                        start: 'prev next today',
                        center: 'title',
                        end: 'dayGridMonth,dayGridWeek,dayGridDay'
                    },

                    select: function(arg) { // 캘린더에서 이벤트를 생성할 수 있다.
                        var title = prompt('일정명을 입력해주세요.');
                        if (title) {
                            calendar.addEvent({
                                title: title,
                                memo: arg.
                                start: arg.start,
                                end: arg.end,
                                allDay: arg.allDay
                            })
                        }

                        console.log(arg);

                        var events = new Array(); // Json 데이터를 받기 위한 배열 선언
                        var obj = new Object();     // Json 을 담기 위해 Object 선언
                        obj.title = title; // 이벤트 명칭  ConsoleLog 로 확인 가능.
                        obj.start = arg.start; // 시작
                        obj.end = arg.end; // 끝
                        obj.club_no = <%=rDTO.getClub_no()%>
                            events.push(obj);
                        var jsondata = JSON.stringify(events);
                        console.log(jsondata);
                        $(function saveData(jsondata) {
                            $.ajax({
                                url: "/club/insertCalendar",
                                method: "POST",
                                dataType: "json",
                                data: JSON.stringify(events),
                                contentType: 'application/json',
                            })
                            // .done(function (events) {
                            //     // alert(events);
                            // })
                            // .fail(function (request, status, error) {
                            //      // alert("에러 발생" + error);
                            // });
                            calendar.unselect()

                        });
                    },



                    events: data

                });
                calendar.render();
            });

        });
    });

</script>
</head>
<body>
<%@include file="import/Navigation.jsp"%>
<div id='calendar'></div>




<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


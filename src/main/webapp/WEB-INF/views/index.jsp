<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%! String id_session;

%>
<%if(session.getAttribute("user_id") != null) {
    id_session = session.getAttribute("user_id").toString();

}
%>
<%@include file="import/heads.jsp"%>
        <title>The Big Picture - Start Bootstrap Template</title>
        <link rel="stylesheet" href="css/clock.css">
        <link rel="stylesheet" href="css/weather.css">
        <link rel="stylesheet" href="../css/board.css">


    <style>
        .weather{
            color: white;
        }
        .CurrIcon, .CurrTemp{
            display: inline-block;
            font-size: 3rem;
            text-align: center;
        }
        .CurrIcon{
            margin-right: 2px;
        }
        .City{
            font-size: 3rem;
            text-align: center;
        }
        .onecard img{
            float: left;
        }
        .right{
             float: right;
         }
        .id_ok {
            display: block;

        }
         *{
            font-family: 'Gowun Dodum', sans-serif;

        }
        .col-md-6 > div h2 p button{
            text-align: center;
        }


    </style>
    <script src="https://kit.fontawesome.com/2dc1583151.js" crossorigin="anonymous"></script>

</head>
<body>

<%@include file="import/Navigation.jsp"%>

<div class="container">
<header>
    <div class='weather' align="center" >
        <div class = 'CurrIcon'></div>
        <div class = 'CurrTemp'></div>
        <div class = 'City'></div>
    </div>
    <div>
        <h1 class = "h1-clock weather"></h1>
    </div>
    <br>

    <div class="weather-wrapper">
        <div class = 'CurrCon'></div>
    </div>
</header>

<br>
<div class="bgbgbg rounded-3 mx-5">
    <div class="text-center pt-5">
        <STRONG><h2>오늘의 우주사진</h2></STRONG>
    </div>
    <hr/>

    <div id="daily_picture" class="daily_picture">

    </div>
</div>
<br>
<div class="row align-items-md-stretch p-5">
    <div class="col-md-6 mb-2">
        <div class="h-100 p-5 text-white bgbgbg rounded-3">
            <div ><img src="https://seongsoolee-bucket.s3.ap-northeast-2.amazonaws.com/constellation.png"></div>
            <h2>별자리 찾기</h2>
            <p>계절에 따라 관측 가능한 별자리들을 찾아볼 수 있습니다. 원하는 별자리를 찾아 내 별자리로 등록해보세요.</p>
            <button class="sbutton subscribe" type="button" onclick="location.href='/Star/selectSeason'">바로가기</button>
        </div>
    </div>
    <div class="col-md-6 mb-2">
        <div class="h-100 p-5 text-white bgbgbg rounded-3">
            <div ><img src="https://seongsoolee-bucket.s3.ap-northeast-2.amazonaws.com/universe.png"></div>
            <h2>우주 현상 보기</h2>
            <p>이전에 관측되었던 우주 현상이나 앞으로 관측가능한 우주 현상을 조회할 수 있습니다.</p>
            <button class="sbutton subscribe" type="button" onclick="location.href='/Astro/selectDate'">바로가기</button>
        </div>
    </div>
    <div class="col-md-6 mb-2">
        <div class="h-100 p-5 text-white bgbgbg rounded-3">
            <div><img src="https://seongsoolee-bucket.s3.ap-northeast-2.amazonaws.com/telescope.png"></div>
            <h2>국내 천문대</h2>
            <p>관측하고싶은 별자리가 있으신가요? 지역 별 국내 천문대 홈페이지를 참고해보세요.</p>
            <button class="sbutton subscribe" type="button" onclick="location.href='/observer/selectRegion'">바로가기</button>
        </div>
    </div>
    <div class="col-md-6 mb-2">
        <div class="h-100 p-5 text-white bgbgbg rounded-3">
            <div><img src="https://seongsoolee-bucket.s3.ap-northeast-2.amazonaws.com/group.png"></div>
            <h2>자유게시판</h2>
            <p>자유롭게 사람들과 이야기해보세요</p>
            <div><button class="sbutton subscribe" type="button" onclick="location.href='/board/BoardList'">바로가기</button></div>
        </div>
    </div>
</div>
</div>


<!-- Weather Content -->




<!-- Weather script-->

<script>
    $(document).ready(function(){
        let lon, lat;
        let minn;
        let youtube = "youtube";
        var exp = /youtube/;

        let weatherIcon = {
            '01' : 'fas fa-sun',
            '02' : 'fas fa-cloud-sun',
            '03' : 'fas fa-cloud',
            '04' : 'fas fa-cloud-meatball',
            '09' : 'fas fa-cloud-sun-rain',
            '10' : 'fas fa-cloud-showers-heavy',
            '11' : 'fas fa-poo-storm',
            '13' : 'fas fa-snowflake',
            '50' : 'fas fa-smog'
        };

        let weatherCon = {
            '01' : 'sun',
            '02' : 'cloud',
            '03' : 'cloud',
            '04' : 'cloud',
            '09' : 'cloud',
            '10' : 'rain2',
            '11' : 'rain2',
            '13' : 'snow2',
            '50' : 'cloud'
        }

        $.ajax(
            {
                url: 'http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=578bcf4716e39500f688dda050a3491b&units=metric',
                dataType: 'json',
                type: 'GET',
                success: function(data)
                {
                    console.log(data);
                    var $Icon = (data.weather[0].icon).substring(0,2);
                    var $Temp = Math.floor(data.main.temp) + '˚';
                    var $city = data.name;

                    $('.CurrIcon').append('<i class="' + weatherIcon[$Icon] + '"></i>');
                    $('.CurrTemp').prepend($Temp);
                    $('.City').append($city);
                }
             }
        )


        $.ajax({
            url: "http://api.openweathermap.org/data/2.5/forecast?q=Seoul&appid=578bcf4716e39500f688dda050a3491b&units=metric",
            type: "get",
            dataType: "JSON",

            success: function (json) {

                console.log(json);
                $.each(json.list, function (key) {

                    var $Icon = (json.list[key].weather[0].icon).substring(0,2);
                    var now = new Date();
                    var year = now.getFullYear();
                    var mon = (now.getMonth() + 1) > 9 ? ''+ (now.getMonth() + 1) : '0' + (now.getMonth() + 1);
                    var day = now.getDate() > 9 ? '' + now.getDate() : '0' + now.getDate();
                    var today = year + '-' + mon + '-' + day;
                    var week = new Array('일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일');

                    var date = json.list[key].dt_txt.substring(0,10)
                    var time = json.list[key].dt_txt.substring(11,13)
                    var yoil = new Date(date).getDay();
                    var todayLabel = week[yoil];

                    var max = (Math.round(json.list[key].main.temp_max)) + "˚C";
                    var min = (Math.round(json.list[key].main.temp_min)) + "˚C";

                    var weath = json.list[key].weather[0].description;

                    if (time === '21'){
                        minn = (Math.round(json.list[key].main.temp_min)) + "˚C";
                    }
                    console.log(minn);

                    if (date !== today){
                        if (time === '06'){
                            $(".weather-wrapper").append(`<div style='float:left;' class='weather-card'><div class = 'weather-icon ` + weatherCon[$Icon] + `'></div><h1>` + minn + ` / ` + max + `</h1><p>`+todayLabel+`</p></div>`);

                        }
                    }

                });


            }
        });

        $.ajax({
            url: "/nasa/getNasa",
            type: "get",
            dataType: "JSON",
            success: function (json){
                let title = json.title;
                let explanation = json.explanation;
                let picture = json.picture;


                $("#daily_picture").append("<div class='p-5 mb-2 text-center'><h5 style='color:white;' ><strong>" + title + "</strong></h5s></div>");
                if (picture.search(exp) == -1){
                    $("#daily_picture").append(`<div style="text-align: center"><img style="width: 960px; height: 540px; " src="` + picture + `"></div>`);
                } else {
                    $("#daily_picture").append(`<div style="text-align: center"><iframe width="960" height="540" src="` + picture +`" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe></div>`);
                }



                $("#daily_picture").append("<div class='p-5 text-center'><b style='color: white'>"+ explanation +"</b></div>");
                console.log(explanation);
            }
        });
    });
</script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<script src = "js/clock.js"></script>
</body>
</html>

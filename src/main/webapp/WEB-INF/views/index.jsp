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
    </style>
    <script src="https://kit.fontawesome.com/2dc1583151.js" crossorigin="anonymous"></script>

</head>
<body class="bg-primary">
<%@include file="import/Navigation.jsp"%>
<br>
<!-- Page Content-->
<section>
    <div class="container px-4 px-lg-5">
         <div class="row gx-4 gx-lg-5">
            <div class="col-lg-6">
                <h1 class="mt-5 weather" >The Big Picture</h1>
                <p class="weather">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deserunt voluptates rerum eveniet sapiente repellat esse, doloremque quod recusandae deleniti nostrum assumenda vel beatae sed aut modi nesciunt porro quisquam voluptatem.</p>
            </div>
        </div>
    </div>
</section>
<!-- Weather Content -->
<br>
<div class='weather' align="center" >
    <div class = 'CurrIcon'></div>
    <div class = 'CurrTemp'></div>
    <div class = 'City'></div>
</div>

<div>
    <h1 class = "h1-clock weather"></h1>
</div>


<!-- Weather script-->

<script>
    $(document).ready(function(){
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

        $.ajax(
            {
                url: 'http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=578bcf4716e39500f688dda050a3491b&units=metric',
                dataType: 'json',
                type: 'GET',
                success: function(data)
                {
                    var $Icon = (data.weather[0].icon).substring(0,2);
                    var $Temp = Math.floor(data.main.temp) + '˚';
                    var $city = data.name;

                    $('.CurrIcon').append('<i class="' + weatherIcon[$Icon] + '"></i>');
                    $('.CurrTemp').prepend($Temp);
                    $('.City').append($city);
                }
             }
        )
    });
</script>


<script src = "js/clock.js"></script>

</body>
</html>

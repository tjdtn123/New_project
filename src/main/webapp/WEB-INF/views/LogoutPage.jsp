<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
//전달받은 메시지
String msg = "로그아웃 되었습니다";
session.invalidate();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width text/html, initial-scale=1, shrink-to-fit=no" />
    <link rel="icon" type="image/x-icon" href="/assets/wallpaper.jpg" />

<title>처리페이지</title>
<script type="text/javascript">

	alert("<%=msg%>");
	top.location.href="/index";
		
</script>
</head>
<body>

</body>
</html>
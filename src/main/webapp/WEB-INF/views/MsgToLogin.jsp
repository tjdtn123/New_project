<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
//전달받은 메시지
String msg = CmmUtil.nvl((String)request.getAttribute("msg"));
%>
<%@include file="import/heads.jsp"%>
<title>처리페이지</title>
<script type="text/javascript">

	alert("<%=msg%>");
	top.location.href="/index";
		
</script>
</head>
<body>

</body>
</html>
<%@ page import="kopo.poly.util.CmmUtil" %>
<%@ page import="kopo.poly.dto.UserInfoDTO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    UserInfoDTO rDTO = (UserInfoDTO) request.getAttribute("Myinfo");
%>
<%@include file="../import/heads.jsp"%>

    <title>마이페이지</title>

</head>
<body>
<%@include file="../import/Navigation.jsp"%>
<table border="1">
    <col width="100px"/>
    <col width="200px"/>
    <col width="100px"/>
    <col width="200px"/>
    <tr>
        <td align="center">제목</td>
        <td colspan="3"><%=CmmUtil.nvl(rDTO.getTitle())%>
        </td>
    </tr>
    <tr>
        <td align="center">공지글 여부</td>
        <td colspan="3">예<input type="radio" name="noticeYn" value="1"
                <%=CmmUtil.checked(CmmUtil.nvl(rDTO.getNotice_yn()), "1") %>/>
            아니오<input type="radio" name="noticeYn" value="2"
                    <%=CmmUtil.checked(CmmUtil.nvl(rDTO.getNotice_yn()), "2") %>/>
        </td>
    </tr>
    <tr>
        <td align="center">작성일</td>
        <td><%=CmmUtil.nvl(rDTO.getReg_dt())%>
        </td>
        <td align="center">조회수</td>
        <td><%=CmmUtil.nvl(rDTO.getRead_cnt())%>
        </td>
    </tr>
    <tr>
        <td colspan="4" height="300px" valign="top">
            <%=CmmUtil.nvl(rDTO.getContents()).replaceAll("\r\n", "<br/>") %>
        </td>
    </tr>
    <tr>
        <td align="center" colspan="4">
            <a href="javascript:doEdit();">[수정]</a>
            <a href="javascript:doDelete();">[삭제]</a>
            <a href="javascript:doList();">[목록]</a>
        </td>
    </tr>
</table>
</body>


<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%!	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
%>
<%
 	int pageSize = 10;	
	int pageBlock = 10;
	String ctxPath = request.getContextPath(); 
	int bCount = (int)request.getAttribute("bCount"); 
	int pageCount = (int)request.getAttribute("pageCount"); 
	int currentPage = (int)request.getAttribute("currentPage");
	int startPage= (int)request.getAttribute("startPage");
	int endPage= (int)request.getAttribute("endPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 검색 결과</title>
<style>
	#board{
		width:100%;
	}
	#board table{
		margin:0 auto;
	}
	tr .number{
		text-align:center;
		width:50px;
	}
		
	tr #subject{
		width:300px;
		text-align:center;
	}
	tr .writer{
		width:80px;
		text-align:center;
	}
	tr .count{
		width:50px;
		text-align:center;
	}
	tr .date{
		width:100px;
		text-align:center;
	}
	
	#page{
		text-align:center;
	}
</style>
</head>
<body>
<div id="board">
	<table border="1">
		<tr>
			<td colspan="3">
				<form action="postSearchCtrl" method="post">
					<input type="text" name="quesSearch"> <input type="submit" value="검색">
				</form>
			</td>
			<td>
				<form action="postListServlet" method="post">
					<input type="submit" value="전체글보기">
				</form>
			</td>
		</tr>
		<tr>
			<td colspan = "11"><a href="memberQuesWrite.jsp">글쓰기</a></td>
		</tr>
		<tr>
			<td class="number">글번호</td>
			<td id="subject">제목</td>
			<td class="writer">작성자</td>
			<td class="count">조회수</td>
			<td class="date">작성날짜</td>
		</tr>
		<c:if test="${not empty QSearchW }">
		<c:forEach items="${QSearchW }" var="v" varStatus="s">
		
			<tr>
				<td class="number">${v.que_no}</td>
				<td>
					<c:if test="${v.que_level eq 2}">
						&nbsp;&nbsp;->
					</c:if>
					<c:set var="O" value="O"/>
					<c:if test="${v.que_secret ne O || not empty mng_id || v.mem_id eq writer1}">
						<a class="que_cnt" href="memberQuesContent.jsp?que_no=${v.que_no}&pageNum=<%=currentPage%>">${v.que_name }</a>
					</c:if>
					<c:set var="writer1" value="${mem_id }"/>
					
					<c:if test="${v.que_secret eq O && v.mem_id ne writer2 }">
						(secret)
					</c:if>
				</td>
				<td class="writer">${v.mem_id }</td>
				<td class="count">${v.que_cnt }</td>
				<td class="date">${v.que_date }</td>
			<tr>
		</c:forEach>
	</c:if>
	</table>
	
	<input type="hidden" name="pageNum" value="<%=currentPage %>">
 	<div id="page">
<%
	if(startPage!=1){
%>
		<a href="<%=ctxPath %>/postSearchCtrl?pageNum=<%=currentPage-pageBlock%>">[이전]</a>
<%
	} else {
%>
		[이전]
<%
	}
%>
<%
		for( int i = startPage; i <= endPage; i++){
			if (currentPage != i) {
%>
			<a href="<%=ctxPath %>/postSearchCtrl?pageNum=<%=i%>">[<%=i%>]</a>
<%
		} else {
			%>
			[<%=i%>]
			<%
		}
	}
%>
<%
	if(currentPage!=pageCount){
%>
		<a href="<%=ctxPath %>/postSearchCtrl?pageNum=<%=startPage + pageBlock%>">[다음]</a>
<%
	} else {
%>
		[다음]
<%
	}
%> 
	</div>
</div>
</body>
</html>
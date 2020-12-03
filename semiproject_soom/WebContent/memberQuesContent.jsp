<%@page import="post.model.service.PostSrv"%>
<%@page import="post.model.vo.PostVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문의글 게시판</title>
<style>
	  *{
            margin : 0;
           }
           body{
               width : 100%;
               position: relative;
               background-color: #171928;
           }
           a{
               text-decoration: none;
               color: white;
           }
           .contents{
               width: 1080px;
               margin: 0 auto;
               padding-top: 100px;
           }
           table{
               width: 1080px;
               color : white;
               font-size: 15px;
               box-sizing: border-box;
               border-collapse: collapse;
           }
           table tr td{
                height: 50px;
               border-top: 1px solid white;
                border-bottom: 1px solid white;
                
           }
           .write_column2{
                height: 400px;
           }
           tr:nth-child(1) td:nth-child(1){
            border-top: 2px solid white;
            
           }
           .list_btn{
               float: right;
               border-radius: 3px;
               background-color: #ea3855;
               border: none;
               width: 80px;
               height: 30px;
           }
           .write_title{
             font-weight: 700;
             text-align: center;
             border-right: 1px solid white;
           }
           
           #button input{
                border-radius: 3px;
               background-color: #ea3855;
               border: none;
               width: 80px;
               height: 30px;
               color : white;
               margin-left: 20px;
           }
           table tr:nth-child(1) td:nth-child(1){
                border-top: 0;
                height: 80px;
           }
           table tr:last-child td{
                border-bottom: 0;
                height: 80px;
                text-align: right;
            }


</style>
</head>
<body>
	<%
	String ctxPath = request.getContextPath();
	int que_no = Integer.parseInt(request.getParameter("que_no"));
	PostSrv PService = new PostSrv();
	PService.getQuesCnt(que_no);
	List<PostVO> list = PService.getQues(que_no);
	PostVO vo = list.get(0);
	System.out.println("list : " + list);
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "1";
	}
	%>

	<%=pageNum%>
	<div class="contents">
	<form method="post" name="form">
			<!-- //현재 보고 있는 글의 글 번호를 입력  -->
			<input type="hidden" name="que_no" value="<%=que_no%>">
			<!-- //현재 보고 있는 글의 글 번호를 입력 -->
			<input type="hidden" name="que_ref" value="<%=vo.getQue_ref()%>">
			<!-- //현재 보고 있는 글의 글 번호를 입력 -->
			<input type="hidden" name="que_step" value="<%=vo.getQue_step()%>">
			<!-- //현재 보고 있는 글의 글 번호를 입력 -->
			<input type="hidden" name="que_level" value="<%=vo.getQue_level()%>">
			
			<input type="hidden" name="mem_id" value="<%=vo.getMem_id()%>">
			<input type="hidden" name="que_name" value="<%=vo.getQue_name()%>">
			<input type="hidden" name="que_content" value="<%=vo.getQue_content()%>">
			<input type="hidden" name="que_file" value="<%=vo.getQue_file()%>">
			
			<table>
				<tr>
					<td colspan="2"><button class="list_btn"><a href="<%=ctxPath%>/postListServlet?pageNum=<%=pageNum%>">글목록</a></button></td>
				</tr>
				<tr>
					<td class="write_title">작성자ID</td>
					<td id="writer"><%=vo.getMem_id()%></td>
				</tr>
				<tr>
					<td class="write_title">제목</td>
					<td id="subject"><%=vo.getQue_name()%></td>
				</tr>
				<tr>
					<td class="write_title">내용</td>
					<td id="content"><%=vo.getQue_content()%></td>
				</tr>
				<tr>
					<td class="write_title">파일선택</td>
					<td id="file"><%=vo.getQue_file()%></td>
				</tr>
				<tr>
					<td colspan="2" id="button">
						<c:if test="${not empty mng_id }">
							<input type="submit" value="답글작성" onclick="javascript: form.action='memberQuesWrite.jsp';">
							<input type="button" value="삭제"
								onclick="window.location='<%=ctxPath%>/postDeleteServlet?pageNum=<%=pageNum%>&que_no=<%=que_no%>'">
						</c:if> <c:set var="write" value="<%=vo.getMem_id()%>"></c:set> <c:if
							test="${write eq mem_id}">
							<input type="submit" value="글수정" onclick="javascript: form.action='memberQuesUpdate.jsp';">
							<input type="button" value="삭제" onclick="window.location='<%=ctxPath%>/postDeleteServlet?pageNum=<%=pageNum%>&que_no=<%=que_no%>'">
						</c:if> 
							<input type="button" value="글목록" onclick="window.location='<%=ctxPath%>/postListServlet?pageNum=<%=pageNum%>'">
					</td>
				</tr>
			</table>
		</form>
		</div>
	${mng_id } ${mem_id }
	<%=que_no%>
	<%=vo.getMem_id()%>
	<%=vo.getQue_name()%>
	<%=vo.getQue_content()%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP 게시판 만들기 강좌</title>
</head>
<body>
	<%
		try{
			PrintWriter outter = response.getWriter();
			/* 로그인이 안된사람은 먼저 로그인을 하도록 */
			String userID = null; 
			if(session.getAttribute("userID") != null){ 	//getAttribute 는 setAttribute가 우선 선행되어야한다.
				userID = (String) session.getAttribute("userID");
			}
			if(userID == null){
				outter.println("<script> alert('로그인을 하셔야 글쓰기가 가능합니다.'); location.href = 'login.jsp'; </script>");
			} else {
				if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null) {
					outter.println("<script> alert('입력이 안된 부분이 있습니다.'); history.back(); </script>");
				} 
				else{
					BbsDAO bbsDAO = new BbsDAO();
					int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); 		// write
					
					if(result == -1){
						outter.println("<script> alert('글쓰기에 실패했습니다.'); history.back(); </script>");
					}
					else{
						outter.println("<script> alert('글쓰기완료!.'); location.href='bbs.jsp'; </script>");
					}
				}
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>
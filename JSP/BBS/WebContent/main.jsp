<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/MyCss.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 만들기 강좌</title>
</head>
<style type="text/css">
	p {color : orange;}
	.jumbotron {
       background-image: url('images/background.jpg');
       background-size: cover;
       text-shadow: black 0.2em 0.2em 0.2em;
       color:white;
    }        
</style>
<body>
	<%
		/* 로그인이 된 사람들의 세션값을 얻어오기 위한 부분 */
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
	%>

	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp"><strong>JSP 게시판 웹사이트</strong></a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li class="active"><a href="main.jsp">메인</a></li>
				<li><a href="bbs.jsp">게시판</a></li>
			</ul>
			<%
				if(userID == null){ // 로그인이 안된사람들에 한해 보여지는 네비게이션 바
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>	
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>	
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!-- Search Google --> 
	<div class="container">
		<form method=get action="http://www.google.co.kr/search" target="_blank" >
			<div align="right">
				<input type=text name=q size=30 maxlength=255 value="" placeholder=" Search" style="border: 2px solid green; height:33px;"/> <!-- 구글 검색 입력 창 -->           
				<input type=submit name=btnG value="Google 검색" class="btn btn-success" /> <!-- 검색 버튼 -->       
			</div>
		</form>
	</div>
	<br>
	<!-- Jumbotron --> 
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>떼껄룩 사진전 소개</h1>
				<p><strong>이 웹사이트는 부트스트랩 으로 만든 JSP 웹 사이트 입니다.</strong></p>
			</div>
		</div>
	</div>
	<!-- Carousel --> 
	<div class="container">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
		  <!-- 하단 Indicators (● o o) -->
		  <ol class="carousel-indicators">
		    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
		    <li data-target="#myCarousel" data-slide-to="1"></li>
		    <li data-target="#myCarousel" data-slide-to="2"></li>
		  </ol>
		
		  <!-- Wrapper for slides (이미지 들어가는 부분) -->
		  <div class="carousel-inner">
		    <div class="item active">
		      <img src="images/cat1.jpg" alt="cat1">
		    </div>
		
		    <div class="item">
		      <img src="images/cat2.jpg" alt="cat2">
		    </div>
		
		    <div class="item">
		      <img src="images/cat3.jpg" alt="cat3">
		    </div>
		  </div>
		
		  <!-- Left and right controls -->
		  <a class="left carousel-control" href="#myCarousel" data-slide="prev">
		    <span class="glyphicon glyphicon-chevron-left"></span>
		    <span class="sr-only">Previous</span>
		  </a>
		  <a class="right carousel-control" href="#myCarousel" data-slide="next">
		    <span class="glyphicon glyphicon-chevron-right"></span>
		    <span class="sr-only">Next</span>
		  </a>
		</div>
	</div>

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 추가할부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <style>
    	.di{display: flex;}
    	
    	#mainIcon4{
			display:flex;
			font-weight: 900;
			font-size: 80px;
			color: #60CFFF;
			text-shadow:1.5px 1.5px 4px #cacaca,
			3px 3px 4px rgba(0, 0, 0, .3),
			4px 4px 8px rgba(0, 0, 0, .2),
			5px 5px 12px rgba(0, 0, 0, .1);
			margin-left: 3%;
			margin-top:1%;
		}
		#mainIcon5{
			margin-left:2px;
			color: #F2F2F2;
			text-shadow:1px 0.8px 4px #FFAE6D,
			2px 1.6px 4px rgba(0, 0, 0, .3),
			2px 1.6px 6px rgba(0, 0, 0, .2);
		}
	#cen{
	
	font-size: 33px;
	color:#038aff;
	font-weight:700;
	position: absolute;
	top:250px;
	left: 31%;
	text-shadow:1px 1px 1px #cacaca,
			1px 1px 1px rgba(0, 0, 0, .3),
			2px 2px 2px rgba(0, 0, 0, .2),
			3px 3px 3px rgba(0, 0, 0, .1);}
			
	.d11{
	font-size: 20px;
	
	margin-left: 8%;
	font-weight: 600;
	color:#ff9470;}
	.d10{
	
	font-size: 20px;
	margin-left: 23%;
	font-weight: 600;
	color:#ff9470;
	}
	.fwr{
	display:flex;
	margin-top: 50px;}
	
	.a3{maring-top:15px; 
	margin-left:250px;
	color: #ff9470;}
    </style>
    
  </head>
  <body style="margin-top:10%">
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <jsp:include page="menubar.jsp"/>
    
    <div class="container-fluid ">
	  	<div class="row ">
	  		<div class="col ">
	  			<div class="di">
	  		<img alt="1" src="${contextPath }/resources/img/go.png" width="200px" height="200px;" style="margin-left:14%" >
	  		<ul id="mainIcon4">
				  	<li>solo</li>
					<li id="mainIcon5">.</li>
				  	<li >dent</li>
				  	
				</ul>
				
	  		<img alt="1" src="${contextPath }/resources/img/did.png" width="200px" height="200px;"style="margin-left:7%"  >
	  		</div>
	  		</div>
	  	</div>
	 </div>
	 <div class="container-fluid ">
	  	<div class="row ">
	  		<div class="col ">
	  		<div class="fwr">
	  		<div class="d10">자유게시판</div><a href="" class="a3">더보기</a>
	  		</div>
	  		<table style="margin-left: 22%; margin-top:20px;  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); border-radius:20px; padding: 30px;">
	  			<tr>
	  				<td style="width:50px; padding:5px; text-align: center;">번호</td>
	  				<td style="width:100px;">제목</td>
	  				<td style="width:100px; text-align: center;">작성자</td>
	  	 			<td style="width:100px; text-align: center;">작성일</td>
	  				<td style="width:50px; text-align: center;">조회수</td>
	  		
	  			<c:forEach items="${ list }" var="b">
    					<tr style="border-bottom: 1px solid black;">
    						<td class="bId td" id="bId" style="text-align: center;  height:40px;">${ b.boardId }</td>
    						<td class="td">${ b.boardTitle }</td>
    						<td class="writer userId td" id="writer" style="text-align: center">${ b.userId }</td>
    						<td class="td" style="text-align: center">${ b.createDate }</td>
    						<td class="td" style="text-align: center">${ b.boardCount }</td>
    					</tr>
    			</c:forEach>
	  		</table>
	  		</div>
	  		<div class="col ">
	  		<div class="fwr">
	  		<div class="d11">모임게시판</div><a href=""  class="a3">더보기</a>
	  		</div>
	  		<table style="margin-left: 8%; margin-top:20px;  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); border-radius:20px; padding: 10px;">
	  			<tr>
	  				<td style="width:50px;  text-align: center;">번호</td>
	  				<td style="width:100px;">제목</td>
	  				<td style="width:100px;  text-align: center;">작성자</td>
	  	 			<td style="width:100px;  text-align: center;">작성일</td>
	  				<td style="width:50px;  text-align: center;">조회수</td>
	  		
	  			<c:forEach items="${ mist }" var="m">
    					<tr style="border-bottom: 1px solid black;">
    						<td class="bId td" id="bId" style="text-align: center;  height:40px;">${ m.boardId }</td>
    						<td class="td">${ m.boardTitle }</td>
    						<td class="writer userId td" id="writer" style="text-align: center">${ m.userId }</td>
    						<td class="td" style="text-align: center">${ m.createDate }</td>
    						<td class="td" style="text-align: center">${ m.boardCount }</td>
    					</tr>
    			</c:forEach>
	  		</table>
	  		
	  		</div>
	  	</div>
	  </div>
	 <div id="cen">자취하는 학생들을 위한 커뮤니티</div>
  </body>
</html>
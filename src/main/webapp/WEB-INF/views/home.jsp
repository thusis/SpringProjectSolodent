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
    </style>
    
  </head>
  <body style="margin-top:10%">
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <jsp:include page="home/menubar.jsp"/>
    
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
	  		<table>
	  			<tr>
	  				<td>제목</td>
	  				<td>작성자</td>
	  				<td>작성일</td>
	  				<td>조회수</td>
	  		</table>
	  		
	  		</div>
	  		<div class="col ">
	  		
	  		
	  		</div>
	  	</div>
	  </div>
	 <div id="cen">자취하는 학생들을 위한 커뮤니티</div>
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <style>
    .fe2{
    display: flex;}
    .fe1{
    	 margin-left:13%;
    	font-size: 55px;
    	font-weight: 800;
    	text-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);}
    	
    .fe1-bu{
    	font-size: 20px;
    	padding: 10px 70px;
    	margin-left: 12%;
    	margin-top:10px;
    	border: none;
    	border-radius: 20px;
    	background: white;
    	box-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);
	}
	
	
	.fe-drop{
	font-weight: 600;
	margin-left: 42%;

	text-align: left;
	padding-left:20px;
	margin-top:7%;
	font-size:25px;
	
	border: none;
	
	width:500px;
	box-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);
	border-radius:25px;
	background: white;
    }
    
    </style>
  </head>
  <body style="margin-top: 10%;">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <jsp:include page="../home/menubar.jsp"/>
    <div class="container-fluid">
	  	<div class="row">
	  		<div class="col">
	  			<div class="fe2">
    				<div class="fe1">자유게시판</div> 
    			
    					<div class="dropdown">
				  			<button class=" dropdown-toggle fe-drop" type="button" data-bs-toggle="dropdown" aria-expanded="false">
				    		공지사항
				  			</button>
				  		
				 	 	<ul class="dropdown-menu">
				    		<li>
				    			
				    		</li>
				        
				  		</ul>
				  		
						</div>
					</div>
				
    			<button class="fe1-bu" onclick="location.href='${ contextPath }/freeWriter.fe'">글쓰기</button>
    			<table>
    				<tr>
    					<th>번호</th>
    					<th>제목</th>
    					<th>작성일</th>
    					<th>작성자</th>
    					<th>조회수</th>
    				</tr>
    				
    				<c:forEach items="${ list }" var="b">
    					<tr>
    						<td>${ b.boardId }</td>
    						<td>${ b.boardTitle }</td>
    						<td>${ b.userId }</td>
    						<td>${ b.createDate }</td>
    						<td>${ b.boardCount }</td>
    					</tr>
    				</c:forEach>
    				
    			</table>
    			
    		</div>
    		<nav aria-label="Standard pagination example" style="float: right;">
			  <ul class="pagination">
			    <li class="page-item">
			    	<c:url var="goBack" value="${ loc }">
			    		<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
			    	</c:url>
			      <a class="page-link" href="${ goBack }" aria-label="Previous">
			        <span aria-hidden="true">&laquo;</span>
			      </a>
			    </li>
			    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
			    	<c:url var="goNum" value="${ loc }">
			    		<c:param name="page" value="${ p }"></c:param>
			    	</c:url>
			    	<li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
			    </c:forEach>
			    <li class="page-item">
			    	<c:url var="goBack" value="${ loc }">
			    		<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
			    	</c:url>
			    	<a class="page-link" href="${ goNext }" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				</li>
			   
			  </ul>
			</nav>
    		
    	</div>
    </div>
   

    
  </body>
</html>
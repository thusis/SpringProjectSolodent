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
    	 margin-left:35%;
    	font-size: 55px;
    	font-weight: 800;
    	text-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);}
    	
    .fe1-bu{
    	font-size: 20px;
    	padding: 10px 70px;
    	margin-left: 15%;
    	margin-top:50px;
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
	margin-left: 10%;

	text-align: left;
	padding-left:20px;
	margin-top:20px;
	font-size:25px;
	
	border: none;
	
	width:400px;
	box-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);
	border-radius:25px;
	background: white;
    }
    .mov{
    margin-top: 10px;
    margin-left: 15%;}
    
    th{
    text-align: center;
    font-size: 20px;}
    
    .dro{
    width: 500px;
    height: 300px;
    background: #F2F2F2;}
   tr{border: 1px solid black;}
   td{border: 1px solid black;}
   .bttt{ width: 400px;
   height:60px;
		   font-size: 60px;
		   font-weight: 700;
		   margin-top: 50px;
  		 box-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);
   }
   .fil{
   	display: flex;}
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
    			
    					
				        
				  	
				  		
						</div>
						
						
					
					<div>
				<img alt="1" src="${contextPath }/resources/img/spi.png" width="300px" height="200px;"  style="margin-left: 35%;">
				</div>
				</div>
				<div class="col">
				
			
					<button class="btn bttt" style="font-size:30px; padding: 10px 0px; font-weight:600"type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasWithBothOptions" aria-controls="offcanvasWithBothOptions">공지사항</button>

					<div class="offcanvas offcanvas-start" data-bs-scroll="true" tabindex="-1" id="offcanvasWithBothOptions" aria-labelledby="offcanvasWithBothOptionsLabel">
					  <div class="offcanvas-header">
					    <h5 class="offcanvas-title" id="offcanvasWithBothOptionsLabel">공지사항</h5>
					    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
					  </div>
					  <div class="offcanvas-body">
					  <c:forEach items="${ notice }" var="n">
					    <h4>${ n.boardTitle }</h4>
					    <p>${ n.boardContent }</p>
					    </c:forEach>
					  </div>
					</div>
					<br>
					<div class="fil">
					<img alt="1" src="${contextPath }/resources/img/spt.png" width="200px" height="100px;"  style="margin-top: 30px;">
					<p style="color:red; font-size: 50px; margin-top: 30px; margin-left: 10px;">필독!</p>
					</div>
				    
				    </div>
				    </div>
				   </div>
				   
				   
				   
				 
				 <div class="container-fluid">
	  	<div class="row">
	  		<div class="col">
    			<button class="fe1-bu" onclick="location.href='${ contextPath }/freeWriter.fe'">글쓰기</button>
    			<div class="mov">
    				
    	<table>
    		<thead>
    				<tr style="border-bottom: 1px solid black;">
    					<th style="width: 8%; height:50px; text-align: center" >번호</th>
    					<th style="width: 450px;">제목</th>
    					<th style="width: 15%; text-align: center">작성자</th>
    					<th style="width: 15%; text-align: center">작성일</th>
    					<th style="width: 10%; text-align: center">조회수</th>
    				</tr>
    			</thead>
    			<tbody>
    				<c:forEach items="${ list }" var="b">
    					<tr style="border-bottom: 1px solid black;">
    						<td class="bId td" id="bId" style="text-align: center;  height:40px;">${ b.boardId }</td>
    						<td class="td">${ b.boardTitle }</td>
    						<td class="writer userId td" id="writer" style="text-align: center">${ b.userId }</td>
    						<td class="td" style="text-align: center">${ b.createDate }</td>
    						<td class="td" style="text-align: center">${ b.boardCount }</td>
    					</tr>
    				</c:forEach>
    			</tbody>
    			</table>
    			
     
    		<nav aria-label="Standard pagination example" style="margin-left: 30%; margin-top: 20px;">
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
			    	<c:url var="goNext" value="${ loc }">
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
    		</div>
    		</div>
    
			
   <script>
   	window.onload = () =>{
   		
   		
   		const tbody = document.querySelector('tbody');
   		const tds = tbody.querySelectorAll('td');
   		for(const td of tds){
   			td.addEventListener('click',function(){
   				
   				
   				const trTds = this.parentElement.querySelectorAll('td');
   				const bId = trTds[0].innerText;
   				const writer = trTds[2].innerText;
   				location.href='${contextPath}/selectBoard.fe?bId=' + bId + '&writer=' + writer + '&page=' + ${pi.currentPage};
   			});
   		}
   	}
   	
   </script>

    
  </body>
</html>
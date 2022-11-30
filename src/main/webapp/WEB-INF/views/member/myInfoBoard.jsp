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
    	h1.{align-items: center;}
    </style>
  </head>
  <body style="background:#F2F2F2; margin-top:12%">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
     <jsp:include page="../home/menubar.jsp"/>
     	<div class="container-fluid text-center">
	  		<div class="row justify-content-center" style="width: 100%">
                    <div class="col col1"   >
	  					
		     				<div style="font-size: 50px; font-weight:700">내가 쓴글</div>
		     				<div style="width: 700px; height:100%; backgroind:white; box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);  margin-top:30px; display:inLine-block;" >
		     				<div style="padding-top: 30px; padding-left: 30px;">
		     					<table>
		     						<thead>
		     						<tr>
		     							<th>번호</th>
		     							<th style="width: 330px;">제목</th>
		     							<th style="width: 10px;">작성자</th>
		     							<th style="width: 160px;">작성일</th>
		     							<th>조회수</th>
		     						</tr>
		     							</thead>
		     							<tbody>
		     							<c:forEach items="${ b }" var="b">
    					<tr style="border-bottom: 1px solid black;">
    						<td class="bId td" id="bId" style="text-align: center;  height:50px;">${ b.boardId }</td>
    						<td class="td">${ b.boardTitle }</td>
    						<td class="writer userId td" id="writer" style="text-align: center">${ b.userId }</td>
    						<td class="td" style="text-align: center">${ b.createDate }</td>
    						<td class="td" style="text-align: center">${ b.boardCount }</td>
    					</tr>
    				</c:forEach>
		     							</tbody>
		     					</table>
		     				
		     			
		     			</div>
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
		   				location.href='${contextPath}/selectMainBoard.fe?bId=' + bId + '&writer=' + writer ;
		   			});
		   		}
		   	}
   	</script>
  </body>
</html>
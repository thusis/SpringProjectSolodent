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
  </head>
  <body style="background:#F2F2F2; margin-top:12%">
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
     <jsp:include page="../home/menubar.jsp"/>
     	<div class="container-fluid text-center">
	  		<div class="row justify-content-center" style="width: 100%">
	  			<div class="col">
				<div style="font-size: 50px; font-weight:700">내가 쓴글</div>
					<div style="width: 700px; height:100%; backgroind:white; box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); display:inLine-block" >
						<div style="margin-top:30px; margin-left:10px;">
							
								<div style="display:flex; font-size:20px; font-weight:700; padding-bottom: 20px;">
									<div>번호</div>>
									<div style="width:500px;">내용</div>>
									<div>작성일</div>>
								</div>
								<ul>
								<c:forEach items="${ r }" var="r">
									<div style="display:flex; font-size:20px; font-weight:500;  margin-top:30px; height:70px;  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); border-radius:10px; float:left;">
										<li style="width:40px; text-align:center;">${r.replyId }</li>
										<li style="width:430px; float:left; text-align:left; margin-left:20px;">${r.replyContent }</li>
										<li style="width:150px;">${r.boardId }</li>
										
									</div>
								</c:forEach>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
     	
   		<script>
   			window.onload = () =>{
   			const ul = document.querySelectorAll('ul');
 
   	   		for(const li of ul){
   	   			li.addEventListener('click',function(){
   	   				
   	   				const ul = this.parentElement.querySelectorAll('li');
   	   				const bId = ul[2].innerText;
   	   				
   	   				location.href="${contextPath}/selectMainBoard1.fe?bId="+ bId;
   	   			});					
   	   		}
   	   	}
   		</script>
   	
  </body>
</html>
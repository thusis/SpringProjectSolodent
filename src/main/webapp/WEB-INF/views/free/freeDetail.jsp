<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <style>
    	
    	.row1{
    	width: 100%;;
    	height: auto;}
    	.col1{
    	
    	display: flex;
    	 align-items: center;
    	
    	}
    .dtm{	background: white;
    		 height: 400px;
    		 width:70%;
    		 box-shadow:1px 1px 4px #cacaca,
				2px 2px 4px rgba(0, 0, 0, .3),
				3px 3px 6px rgba(0, 0, 0, .2),
				4px 4px 11px rgba(0, 0, 0, .1);
    		 border-radius:30px;
    		 position: absolute;
    		 z-index: 1;
    		 left:15%
    		 
    		 }
    		 .Z1{
    		 position: absolute;
    		 top:23%;
    		 left:11%;
    		 z-index: 2;
    		 }
    		 .butt1{
    		 border: none;
    		 background:white;
    		 border-radius: 10px;
    		 font-size:20px;
    		  box-shadow: 0 10px 20px 0 rgba(0,0,0,0.3);
    		 padding: 5px 20px;
    		 font-weight: 700
    		 }
    		 .butt2{
    		 float: right;
    		 margin-top:-30px;
    		 margin-right: 20px;
    		 }
    </style>
  </head>
  <body style="margin-top:15%; background:#F2F2F2;">
 
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
     <jsp:include page="../home/menubar.jsp"/>
     	<div class="container-fluid ">
	  		<div class="row justify-content-center">
	  			<div class="col col1">
	  			
			  				<div style="display:inLine-block">
			  				<%-- <img alt="1" src="${contextPath }/resources/img/read.png" width="200px" height="100px;"  style="margin-left: 0%;" class="Z1"> --%>
			  				<div class="dtm">
			  					<ul>
			  					<li style="font-weight: 700; font-size: 40px; margin-top: 20px; border-bottom: 1px solid black; width:100%;">     ${ b.boardTitle }  
			  					<div class="butt2">
			  					<c:if test="${ loginUser.id eq b.userId }">
			  					<button class="butt1" onclick="location.href='${contextPath}/freeUpdate.fe?bId= '+' ${b.boardId}'" style="margin-right:10px;">수정</button>
			  					<button class="butt1">삭제</button>
			  					</c:if>
			  					</div>
			  					 </li>
			  					
			  					
			  					<li style="height: 50px; border-bottom: 1px solid black; padding-top:10px; " >
			  					<img alt="1" src="${contextPath }/resources/img/id.png" width="20px" height="20px;" >
			  						${ b.userId }
			  						<img alt="1" src="${contextPath }/resources/img/date.png" width="20px" height="20px;" style=" margin-left: 10%;" >
			  						${ b.createDate }
			  						<img alt="1" src="${contextPath }/resources/img/count.png" width="20px" height="20px;" style=" margin-left: 10%;" >
			  						${ b.boardCount }
			  						<img alt="1" src="${contextPath }/resources/img/good.png" width="20px" height="20px;" style=" margin-left: 10%;" >
			  						${ b.boardCount }
			  					</li>
			  					<li style="margin-top:10px;">
			  						
						  			
						  			${ b.boardContent }
						  			</li>
						  			
						  			
						  			
						  			</ul>
						  		
						  			</div>
						  			</div>
						  		</div>
	  					</div>
						</div>
					<div class="container-fluid text-center">
	  					<div class="row justify-content-center" style="width: 100%">
                    <div class="col "  >
	  					<div style=" background:white; margin-left:2%; margin-top: 430px; display:inLine-block; width:74%; border-radius: 20px;" >
	  					<form action="${ contextPath }/DboardInsert.fe?bId= '+' ${ b.boardId }">
	  					<div style="display: flex;" >
	  						
			  						<textarea rows="3" id="replyContent" style=" height:100px;  width: 72%; border-radius:10px; 
			  										border: none;   box-shadow: 0 10px 20px 0 rgba(0,0,0,0.3);" name="replyContent;" ></textarea>
			  						<button type="button" id="replySubmit" style="height: 100px; width:25%; float:right; margin-left:3%;
			  						border-radius:10px; border-radius:10px;  box-shadow: 0 10px 20px 0 rgba(0,0,0,0.3);
			  						border:none; background: white; font-weight: 700"
			  						>댓글</button>
			  					
			  			</div>			
			  			</form>	
			  			<table>
			  			<tbody>
	  					<c:forEach items="${ list }" var="r">
	  						<tr>
	  							<td><img alt="" src="${contextPath }/resources/img/sign.png" width=50px height=50px;></td>
	  							<td style="font-size: 20px; padding-top:10px; width:10%">${ r.userId }</td>
	  							<td style="font-size: 20px; padding-top:10px; width:70%; text-align:left" >${ r.replyContent }</td>
	  							<td style="font-size: 20px; padding-top:10px; width:20%;">${ r.createDate }</td>
	  							
	  						</tr>
	  					
	  					</c:forEach>
	  				</tbody>
	  					
	  					</table>
	  					</div>
	  				</div>
	  			</div>
	  		</div>  	
	  	<script>
	  	window.onload=()=>{
			document.getElementById('replySubmit').addEventListener('click', ()=>{
				$.ajax({
				   url: '${contextPath}/insertReply.fe',
				   data: {
					    replyContent: document.getElementById('replyContent').value,
						boardId:'${ b.boardId}', 
						userId:'${ loginUser.id}'
					},
				    success: (data)=>{

				      const tbody = document.querySelector('tbody');
				      tbody.innerHTML = ""
				      
				      
				      for(const r of data){
				    	 const tr = document.createElement('tr');
				    	 
				    	 const writerTd = document.createElement('td');
				    	 writerTd.innerText = r.userId;
				    	 
				    	 const ContentTd = document.createElement('td');
				    	 ContentTd.innerText = r.replyContent;
				    	 
				    	 const createDateTd = document.createElement('td');
				    	 createDateTd.innerText = r.createDate;
				    	 
				    	 
				    	 tr.append(writerTd);
				    	 tr.append(ContentTd);
				    	 
				    	 tr.append(createDateTd);
				    	 tbody.append(tr);
				      }
				      document.getElementById("replyContent").value = '';
				   },
				   error: (data)=>{
					  alert("실패!");
				   }
				});
	       	 });
	  	}
	  	</script>				  			
  </body>
</html>
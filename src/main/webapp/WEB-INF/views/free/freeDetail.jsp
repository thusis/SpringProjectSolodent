<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  		<div class="row row1 justify-content-md-center">
	  			<div class="col col1">
			  				<div>
			  				<img alt="1" src="${contextPath }/resources/img/read.png" width="200px" height="100px;"  style="margin-left: 0%;" class="Z1">
			  				<div class="dtm">
			  					<ul>
			  					<li style="font-weight: 700; font-size: 40px; margin-top: 20px; border-bottom: 1px solid black; width:100%;">     ${ b.boardTitle }  
			  					<div class="butt2"><button class="butt1" onclick="location.href='${contextPath}/freeUpdate.fe'" style="margin-right:10px;">수정</button><button class="butt1"">삭제</button></div>
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
	  				<div class="row row1 justify-content-md-center">
	  				<div class="col col1">
	  					<div style="margin-top:820px; width: 73%; margin-left:14.5%;
	  								height:100%; " >
			  						<input type="text" style="width:78%; height:100px; float: left; border-radius:10px; 
			  										border: none;   box-shadow: 0 10px 20px 0 rgba(0,0,0,0.3);">
			  						<button style="height: 100px; width:20%; float:right;;
			  						border-radius:10px; border-radius:10px;  box-shadow: 0 10px 20px 0 rgba(0,0,0,0.3);
			  						border:none; background: white; font-weight: 700"
			  						onclick="location.href='${ contextPath }/DboardInsert.fe'">댓글</button>
			  						
			  			</div>			
			  			
	  					
	  					</div>
	  				</div>
	  			
	  				</div>  					  			
  </body>
</html>
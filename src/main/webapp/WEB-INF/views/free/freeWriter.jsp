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
    .col{
    width:100%;
    }
    .fw{
	    font-size: 50px;
	    font-weight: 700}
	    .fw2{
	    width: 100%;
	  min-height: 100%;
		display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;}
	.fw-bg{
	width: 100%;
	  min-height: 100%;
		display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;
		top-margin: 50px;
		width:60%;
		height: 100%;
		box-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);}
    	}
    </style>
  </head>
  <body style="margin-top:10%;">
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <jsp:include page="../home/menubar.jsp"/>
    
    <div class="container-fluid text-center">
		  	<div class="row">
		  		<div class="col">
		  			<div class="fw">글 등록</div>
		  			<div class="fw2">
		  				<div class="fw-bg">
		  				
		  				<div>제목
		  					<input type="text">
		  				</div>
		  				<div>내용
		  					<input type="text">
		  				</div>
		  				<div>저장
		  				</div>
		  			</div>
		  		</div>
		  	</div>
		  </div>
	 </div>
     
  </body>
  
</html>
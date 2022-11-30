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
	  height: 420px;
		display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;
	  margin-top: 20px;}
	  
	.fw-bg{
	width: 100%;
	  min-height: 100%;
		display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;
		top-margin: 50px;
		width:50%;
		height: 100%;
		box-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);}
    	}
    	.ty{
    	width:500px;}
    	.tx{
    	width:500px;}
    	.bbb{
    	backgroind: F2F2F2;
    	font-size: 15px;
    	padding: 10px 0px;
    	border : none;
    	width: 80%;
    		border-radius: 10px;
    margin-top:20px;
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
		  				<form action="${contextPath }/freeEdit.fe?bId= '+'${ b.boardId }" method="post">
		  				<div><label for="boardTitle">제목</label>
		  					<input type="text" name="boardTitle" class="ty" style="width: 500px; margin-top:30px;" value="${ b.boardTitle}">
		  				</div>
		  				<div >
		  					<div>
		  						<label for="boardCoundt">제목</label>
		  					<textarea rows="10" name="boardContent" style="resize: none" class="tx" >${ b.boardContent }</textarea>
		  					</div>
		  				</div>
		  				<div>
		  				<button class="bbb" type="submit">수정</button>
		  				</div>
		  				</form>
		  			</div>
		  		</div>
		  	</div>
		  </div>
	 </div>
     
  </body>
  
</html>
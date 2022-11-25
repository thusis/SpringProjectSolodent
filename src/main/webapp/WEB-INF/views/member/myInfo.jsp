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
    body{
    	 left: 0px;
    	 height: 100vh;
    	 height: 100%;
    	 width:100%;
    	 
    	 
    	}
    .main{
     display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;
	  width: 100%;
	  min-height: 100%;
     
    
    }
    .info{margin-top:80px;
    max-width: 940px;
   
   }
    .inp{
    margin-bottom: 3%;}
   
   .inf{
   		width: 330px;
   		background: #60CFFF;
   		display:flex;
   		border-radius: 10px;
   		box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
   		}
   	.info2>h4 ,.info2>h5{
   	margin-left: 10px; color: white; text-shadow:1px 1px 4px #cacaca,
												2px 2px 4px rgba(0, 0, 0, .3),
												3px 3px 6px rgba(0, 0, 0, .2),
												4px 4px 11px rgba(0, 0, 0, .1);}
   	.info2>h4{
   	margin-top:25px;}
   	
   	.inf2{
   	margin-top: 50px;}
   	.inf5{
   	height: 335px;
   	background: #60CFFF;
   	 border-radius: 10px;
   	  box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
   	}
   	.inf3{
   	 background: #60CFFF;
   	 border-radius: 10px;
   	 padding:10px;
   	 box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);}
   	 table{
   	 margin: 5px;}
   	 #sc{
   	 font-size: 20px;
   	 font-weight: 900;}
   	 
   	 .ul{
   	 margin-top: 10px;
   	 }
   	 .ul>li>a{
   	 color: #F2F2F2;
   	 text-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);}
   	 .ul>li>a:hover{
   	 color: black;
   	 font-weight: 900;}
   	 table{
   	 margin-top:10px;}
   	 .lab{
   	 font-weight:600;
   	 font-size: 30px;}
   	 .col-form-label{
   	 color: white;
   	 font-weight: 600;
   	 font-size: 20px;}
   	 
   	 .su{margin-top: 20px;
   	 	margin-left: 0px;
   	 	background: white;
   	 	border:none;
   	 	border-radius:5px;
   	 	font-size: 15px;
   	 	padding: 10px 40px;
   	 	font-weight: 700;
   	 	color:grey;}
   	 .bo{
   	 	margin-left:100px;
   	 	background: white;
   	 	border:none;
   	 	border-radius:5px;
   	 	font-size: 15px;
   	 	padding: 10px 40px;
   	 	font-weight: 700;
   	 	color:grey}
   	 	.lab1{
   	 	margin-left: 5px;
   	 	font-size:20px;
   	 	font-weight: 700;
   	 	}
   	 	.su:hover, .bo:hover{color:black}
   	 	.lab4{
   	 	margin-top:30px;}
   	 	table{
   	 	border: 1px solid black}
   	 	.t1{
   	 	border-top: 2px solid black;}
   	 	td{
   	 	border: 1px solid black;}
    </style>
  </head>
  <body style= "background:#F2F2F2;">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <jsp:include page="../home/menubar.jsp"/>
    
    <div class="main">
    <div class="container-fluid info">
	  	<div class="row ">
	  		
	  		<div class="col ">
	  		
				<label class="lab" style="color: #474E68" >${ loginUser.name }님 환영합니다.</label>
				  		<div class="inf">
	  						<div class="info2">
				  				<h4>${ loginUser.nickName }</h4><h5>가입:${ loginUser.enrollDate }</h5>	
			  				</div>
	  						
		  					<ul class="ul">
			  					<li><a href="">방문</a></li>
			  					<li><a href="">내가 쓴 글 보기</a></li>
			  					<li><a href="">내가 쓴 댓글보기</a></li>
			  					<li><a href="">내 거래내역 보기</a></li>
			  				</ul>
			  			</div>
			  		
		  			
	  		<div class="inf2 ">
	  			<label id="sc" style="color:  #474E68">스크랩한 글</label>
	  			
	  			<div class="inf5">
	  			<div class="h-100 p-5 bg-light border rounded-3">
						<h2>My Boards Top 5</h2>
						<table style="text-align: center; width: 100%;">
							<tr>
								<th class="t1">번호</th>
								<th class="t1">제목</th>
								<th class="t1">날짜</th>
								<th class="t1">조화수</th>
							</tr>
							<c:forEach items="${ list }" var="b">
								
									<tr>
										<td>${ b.BOARD_ID }</td>
										<td>${ b.BOARD_TITLE }</td>
										<td>${ b.CREATE_DATE }</td>
										<td>${ b.BOARD_COUNT }</td>
									</tr>
								
							</c:forEach>
						</table>
					</div>
	  			</div>
	  		</div>
	  	</div>
	  		<div class="col d-none d-sm-block" >
	  		<label class="lab1" style="color: #474E68">회원정보</label>
	  		<form class="inf3" action="${ contextPath }/updateMember.me" method="POST">   
	  			<div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">아이디</label>  
	  		     
	  		      		<div class="col-lg-8 col-md-12 "> 
	  		            	<input type="text" class="form-control" id="id" name="id" value="${ loginUser.id }" readonly>
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">비밀번호</label>    
	  		       
	  		      		<div class="col-lg-8 md-12"> 
	  		            	<input type="text" class="form-control" id="pwd" name="pwd">
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12  col-form-label">비밀번호확인</label>    
	  		         
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" name=pwd1 id="pwd1">
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label" >이름</label> 
	  		           
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="name" name="name" value="${ loginUser.name }" readonly>
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">닉네임</label>    
	  		         
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="nickName" name="nickName" value="${ loginUser.nickName }">
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">이메일</label>    
	  		       
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="email" name="email" value="${ loginUser.email }" readonly>
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label" >생년월일</label>    
	  		        
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="birthDate" name="birthDate" value="${ loginUser.birthDate }" readonly>
	  		       		 </div>
	  		        </div>
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">주소</label>  
	  		           
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="address" name="address" value="${ loginUser.address }">
	  		       		 </div>
	  		        </div>
	  		        
	  		        
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">전화번호</label>  
	  		           
	  		      		<div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="phone" name="phone" value="${ loginUser.phone }">
	  		       		 </div>
	  		        </div>
	  		        
	  		        <div class="row mb-3">
	  		        <label for="inputEmail3" class="col-lg-4 col-md-12 col-form-label">성별</label>    
	  		        <div class="col-lg-8 md-12">
	  		            	<input type="text" class="form-control" id="gender" name="gender" value="${ loginUser.gender }" readonly>
	  		       		 </div>
	  		        </div>
	  		        <div class="container-fluid lab4">
	  					<div class="row ">
	  		    	<input type=submit class="su col" value="수정하기">
	  		    	
	  		    		</div>
	  		        </div>
	  		</form>
	  		</div>
	  		
	  	</div>
	</div>
	</div>
  </body>
</html>
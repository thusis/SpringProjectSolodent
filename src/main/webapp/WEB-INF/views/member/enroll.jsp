<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	
	<style>
	body {
	  left: 0px;
	  margin-top: 100px;
	  height: 100vh;
	  }
	  .m2{margin-top: 130px; 
	      position: relative;
	       width: 100%;
	  max-width: 630px;
	      }
	  
	 #mainIcons1{
		padding: 10px 115px;
		text-align: center;
	 	display: inline-block;
		display:flex;
		align-items: center;
	    justify-content: center;  
	  
		font-weight: 900;
		font-size: 48px;
		color: white ;
		text-shadow:1px 1px 4px #cacaca,
		2px 2px 4px rgba(0, 0, 0, .3),
		3px 3px 6px rgba(0, 0, 0, .2),
		4px 4px 11px rgba(0, 0, 0, .1);
	}
	#mainIcons2{
		margin-left:2px;
		color: #FFB800;
		text-shadow:1px 0.8px 4px #FFAE6D,
		2px 1.6px 4px rgba(0, 0, 0, .3),
		2px 1.6px 6px rgba(0, 0, 0, .2);
	} 
	.m1{ -webkit-border-radius: 10px 10px 10px 10px;
	  border-radius: 10px 10px 10px 10px;
	  background: #60CFFF;
	  
	  width: 100%;
	  max-width: 630px;
	  position: relative;
	  padding: 0px;
	  -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	 
	}	
	#formFooter {
	  background-color: #f6f6f6;
	  border-top: 1px solid #dce8f1;
	  
	  text-align: center;
	  
	  border-radius: 0 0 10px 10px;
	  margin-top: 30px;
	  margin-left:-12px;
	  width: 104%;
	  height: 30px;
	}
	.in1{ width: 100%;
	  
	   padding: 0px;
	  text-align: center;
	}
	.in{
		width: 90%;
		height: 42px;
		text-decoration: none;
	border: 1px solid white;
	color: grey;
	 border-radius: 10px 10px 10px 10px;
	}
	.la{
	font-size: 20px;
	margin-left: 5%;
	color: white;
	margin-top: 20px;
	 }

	.in3{
	width: 177px;
	height: 42px;
	border: 1px solid white;
	 border-radius: 10px 10px 10px 10px;
	 box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	 }
	 #bu{
	 margin-left: 5%;
	 margin-top:5px;}
	 #memailconfirm{
	 width: 64%;
		height: 42px;
		text-decoration: none;
	border: 1px solid white;
	color: grey;
	 border-radius: 10px 10px 10px 10px;
	 }
	 #checkEmail{
	 width: 30%;
		height: 42px;
		text-decoration: none;
	border: 1px solid white;
	color: grey;
	 border-radius: 10px 10px 10px 10px;
	 }
	 
	 /* 효과 */
	 .fadeInDown {
	  -webkit-animation-name: fadeInDown;
	  animation-name: fadeInDown;
	  -webkit-animation-duration: 1s;
	  animation-duration: 1s;
	  -webkit-animation-fill-mode: both;
	  animation-fill-mode: both;
	}
	
	@keyframes fadeInDown {
	  0% {
	    opacity: 0;
	    -webkit-transform: translate3d(0, -100%, 0);
	    transform: translate3d(0, -100%, 0);
	  }
	  100% {
	    opacity: 1;
	    -webkit-transform: none;
	    transform: none;
	  }
	}
	
	@-webkit-keyframes fadeInDown {
	  0% {
	    opacity: 0;
	    -webkit-transform: translate3d(0, -100%, 0);
	    transform: translate3d(0, -100%, 0);
	  }
	  100% {
	    opacity: 1;
	    -webkit-transform: none;
	    transform: none;
	  }
	}
	@-webkit-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
	@-moz-keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
	@keyframes fadeIn { from { opacity:0; } to { opacity:1; } }
	
	.fadeIn {
	  opacity:0;
	  -webkit-animation:fadeIn ease-in 1;
	  -moz-animation:fadeIn ease-in 1;
	  animation:fadeIn ease-in 1;
	
	  -webkit-animation-fill-mode:forwards;
	  -moz-animation-fill-mode:forwards;
	  animation-fill-mode:forwards;
	
	  -webkit-animation-duration:1s;
	  -moz-animation-duration:1s;
	  animation-duration:1s;
	}
	.one {
	  -webkit-animation-delay: 0.4s;
	  -moz-animation-delay: 0.4s;
	  animation-delay: 0.4s;
	}
	
	.two {
	  -webkit-animation-delay: 0.5s;
	  -moz-animation-delay: 0.5s;
	  animation-delay: 0.5s;
	}
	.three {
	  -webkit-animation-delay: 0.6s;
	  -moz-animation-delay: 0.6s;
	  animation-delay: 0.6s;
	}
	.four {
	  -webkit-animation-delay: 0.7s;
	  -moz-animation-delay: 0.7s;
	  animation-delay: 0.7s;
	}
	.five {
	  -webkit-animation-delay: 0.8s;
	  -moz-animation-delay: 0.8s;
	  animation-delay: 0.8s;
	}
	.six {
	  -webkit-animation-delay: 0.9s;
	  -moz-animation-delay: 0.9s;
	  animation-delay: 0.9s;
	}
	.seven {
	  -webkit-animation-delay: 1s;
	  -moz-animation-delay: 1s;
	  animation-delay: 1s;
	}
	.eight {
	  -webkit-animation-delay: 1.1s;
	  -moz-animation-delay: 1.1s;
	  animation-delay: 1.1s;
	}
	.nine {
	  -webkit-animation-delay: 1.2s;
	  -moz-animation-delay: 1.2s;
	  animation-delay: 1.2s;
	}
	.ten {
	  -webkit-animation-delay: 1.3s;
	  -moz-animation-delay: 1.3s;
	  animation-delay: 1.3s;
	}
	.ele {
	  -webkit-animation-delay: 1.4s;
	  -moz-animation-delay: 1.4s;
	  animation-delay: 1.4s;
	}
	.elee {
	  -webkit-animation-delay: 1.5s;
	  -moz-animation-delay: 1.5s;
	  animation-delay: 1.5s;
	}
	.VV{
	color:grey;
	}
	.VV:hover{
	font-weight: 700;
	color:black;
	}
	.check1{
	color: white;
	margin-left:45%;
	font-weight: 500;}
	</style>
	</head>
	<body style= "background:#F2F2F2;">
		<jsp:include page="../home/menubar.jsp"/>
		
		<div class="container-fluid m2 fadeInDown">
	  		<div class="row ">
	  		<div class="col m1">
	  			<form action="${ contextPath }/insertMember.me" method="POST" id="insertForm" >
	  		 <ul id="mainIcons1" class="one fadeIn">
			  <li >solo</li>
			  <li id="mainIcons2">.</li>
			  <li >dent</li>
			</ul>
			<div class="two fadeIn">
			
				<label class="la">아이디</label><label for="id" id="checkId" class="check1">아이디를 입력해주세요</label><br>
					<div class="in1 in1">
				<input type="text" class="in" name="id" id="id" placeholder="아이디" required>
					</div>
			 </div>
            <div class="three fadeIn">
				<label class="la">비밀번호</label><br>
					<div class="in1">
				<input type="password" class="in" name="pwd" id="pw" placeholder="비밀번호" onkeyup="" required>
					</div>
			 </div >
			 <div class="second fadeIn four">
				<label class="la">비밀번호 확인</label><br>
					<div class="in1">
				<input type="password" class="in" name="pwd1" id="pw1" class="in" placeholder="비밀번호" required>
					</div>
			 </div>
			 <div class="five fadeIn">
				<label class="la">이름</label><br>
					<div class="in1">
				<input type="text" class="in" name="name"placeholder="이름" required>
					</div>
			 </div>
			 <div class="six fadeIn">
				<label class="la">닉네임</label><label for="nickName" id="checkNickName" class="check1">닉네임를 입력해주세요</label><br>
					<div class="in1 in1">
				<input type="text" class="in" name="nickName" id="nickName" placeholder="닉네임" required>
					</div>
			 </div>
			  <div class="seven fadeIn">
				<label class="la">이메일</label> <label for="memailconfirm" id="memailconfirmTxt" class="check1">인증번호를 입력해주세요</label><br>
					<div class="in1">
				<input type="text" class="in" name="email" id="memail" class="in" placeholder="이메일" required>
					</div>
					<div id="bu">
						<input type="text"  name="bu1" id="memailconfirm" class="seven" placeholder="인증번호" >
						<button  type="button" id="checkEmail">인증번호 받기</button>
					</div>
					</div>
	
				
			
			
			 <div class="eight fadeIn">
				<label class="la">생년월일</label><br>
					<div class="in1">
				<input type="text" class="in3"  name="yyyy" placeholder="년도" required>
				 <select class="in3" id="mm" name="mm">
						        <option>월</option>
						        <option>1</option>
						        <option>2</option>
						        <option>3</option>
						        <option>4</option>
						        <option>5</option>
						        <option>6</option>
						        <option>7</option>
						        <option>8</option>
						        <option>9</option>
						        <option>10</option>
						        <option>11</option>
						        <option>12</option>
						     </select>
				<input type="text" class="in3" name="dd"  placeholder="일">
					</div>
			 </div>
			  <div class="nine fadeIn">
				<label class="la">주소</label><br>
					<div class="in1 in1">
				<input type="text" class="in" name="address" class="in" placeholder="주소" required>
					</div>
			 </div>
			  <div class="ten fadeIn">
				<label class="la">전화번호</label><br>
					<div class="in1 in1">
				<input type="text" class="in" name="phone" class="in" placeholder="전화번호" required>
					</div>
			 </div>
			  <div class="ele fadeIn">
				<label class="la">성별</label><br>
					<div class="in1 ">
						<select class="in" name="gender" required>
								        <option>선택안함</option>
								        <option>남</option>
								        <option>여</option>
						</select>
					</div>
			 </div>
			 <div class=" fadeIn elee">
			 	<label class="la"></label>
			 	<div class="in1">
			 		<button  type="button" class="in VV">가입하기</button>
			 	</div>
			 </div>
			 <div id="formFooter" class="ele fadeIn">
      			
      		</div>
             </form>
  			</div>
  		</div>
  		</div>
  		<script>
				let okId = false;
				let okPwd = false;
				let okEmail = false;
					window.onload = ()=>{
						document.getElementById("id").addEventListener('keyup', function(){
							const idResult = document.getElementById('checkId');
							if(this.value.trim()== ''){
								idResult.innerText = '닉네임을 입력해주세여';
								idResult.style.color= 'white';
							}else{
								$.ajax({
									url: '${ contextPath}/checkId.me',
									data: {id:this.value},
									success: (data)=>{
										console.log(data);
										if(data.trim() == 'yes'){
											idResult.innerText = "사용가능한 닉네임 입니다.";
											idResult.style.color= "#0D6EFD";
											okId = true;
										}else if(data.trim() == 'no'){
											idResult.innerText = "중복된 닉네임 입니다.";
											idResult.style.color= "red";
											
										}
									},
									error: (data)=>{
										console.log(data);
									}
									
								});
							}
						});
						
					document.getElementById("nickName").addEventListener('keyup', function(){
						const nickNameResult = document.getElementById('checkNickName');
						if(this.value.trim()== ''){
							nickNameResult.innerText = '닉네임을 입력해주세여';
							nickNameResult.style.color= 'white';
						}else{
							$.ajax({
								url: '${ contextPath}/checkNickName.me',
								data: {nickName:this.value},
								success: (data)=>{
									console.log(data);
									if(data.trim() == 'yes'){
										nickNameResult.innerText = "사용가능한 닉네임 입니다.";
										nickNameResult.style.color= "#0D6EFD";
									}else if(data.trim() == 'no'){
										nickNameResult.innerText = "중복된 닉네임 입니다.";
										nickNameResult.style.color= "red";
										
									}
								},
								error: (data)=>{
									console.log(data);
								}
								
							});
						}
					});
					$(function() {
				
						var $pwd = $("#pwd");
						var $pwd1 = $("#pwd1");
						var $checkEmail = $("#checkEmail"); // 인증번호 발송 버튼
						var $memailconfirm = $("#memailconfirm"); // 인증번호 확인input
						var $memailconfirmTxt = $("#memailconfirmTxt"); // 인증번호 확인 txt
						
					// 이메일 인증번호
					$checkEmail.click(function() {
						$.ajax({
							type : "POST",
							url : '${ contextPath}/pleaseMail.me',
							data : {
								"email" : document.getElementById("memail").value
							},
							success : function(data){
								alert("해당 이메일로 인증번호 발송이 완료되었습니다. \n 확인부탁드립니다.")
								console.log("data : "+data);
								chkEmailConfirm(data, $memailconfirm, $memailconfirmTxt);
							}
						});
					});
					function chkEmailConfirm(data, $memailconfirm, $memailconfirmTxt){
						$memailconfirm.on("keyup", function(){
							if (data != $memailconfirm.val()) { //
								emconfirmchk = false;
								$memailconfirmTxt.html("<span id='emconfirmchk'>인증번호가 잘못되었습니다</span>")
								$("#emconfirmchk").css({
									"color" : "#FA3E3E"
									
									
								});
								//console.log("중복아이디");
							} else { // 아니면 중복아님
								emconfirmchk = true;
								$memailconfirmTxt.html("<span id='emconfirmchk'>인증번호 확인 완료</span>")
								$("#emconfirmchk").css({
									"color" : "#0D6EFD"
									
									
								});
								okEmail = true;
							}
						});
					}
					
						

					});
				}
				 
					
					
					$('.in.VV').click(function(){
						
							$('#insertForm').submit();
						
					});
			
				</script>
  		</body>
	</html>
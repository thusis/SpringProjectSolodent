<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
	<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<style>
	
/* BASIC */

	body {
	  left: 0px;
	  font-family: "Poppins", sans-serif;
	  height: 100vh;
	}
	
	a {
	  color: #92badd;
	  display:inline-block;
	  text-decoration: none;
	  font-weight: 400;
	}
	
	h2 {
	  text-align: center;
	  font-size: 16px;
	  font-weight: 600;
	  text-transform: uppercase;
	  display:inline-block;
	  margin: 40px 8px 10px 8px; 
	  color: #cccccc;
	}
	
	
	
	
	.wrapper {
	  display: flex;
	  align-items: center;
	  flex-direction: column; 
	  justify-content: center;
	  width: 100%;
	  min-height: 100%;
	  
	}
	
	#formContent {
	  -webkit-border-radius: 10px 10px 10px 10px;
	  border-radius: 10px 10px 10px 10px;
	  background: #60CFFF;
	  
	  width: 100%;
	  height:440px;
	  max-width: 450px;
	  position: relative;
	  padding: 0px;
	  -webkit-box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	  text-align: center;
	}
	
	#formFooter {
	  background-color: #f6f6f6;
	  border-top: 1px solid #dce8f1;
	  
	  margin-bottom:0px;
	  text-align: center;
	  -webkit-border-radius: 0 0 10px 10px;
	  border-radius: 0 0 10px 10px;
	}
	
	
	
	
	
	h2.inactive {
	  color: #cccccc;
	}
	
	h2.active {
	  color: #0d0d0d;
	  border-bottom: 2px solid #5fbae9;
	}
	
	
	
	
	
	input[type=button], input[type=submit], input[type=reset]  {
	  background-color: #56baed;
	  border: none;
	  color: white;
	  padding: 15px 80px;
	  text-align: center;
	  text-decoration: none;
	  display: inline-block;
	  text-transform: uppercase;
	  font-size: 13px;
	  -webkit-box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
	  box-shadow: 0 10px 30px 0 rgba(95,186,233,0.4);
	  -webkit-border-radius: 5px 5px 5px 5px;
	  border-radius: 5px 5px 5px 5px;
	  margin: 5px 20px 40px 20px;
	  -webkit-transition: all 0.3s ease-in-out;
	  -moz-transition: all 0.3s ease-in-out;
	  -ms-transition: all 0.3s ease-in-out;
	  -o-transition: all 0.3s ease-in-out;
	  transition: all 0.3s ease-in-out;
	}
	input[type=submit]{
	background: #F5F6F6;
	color: #60CFFF;}
	
	input[type=button]:hover, input[type=submit]:hover, input[type=reset]:hover  {
	  background-color: #F5F6F6;
	  color: #277BC0;
	  font-size: 20px;
	font-weight: 800;
	}
	
	input[type=button]:active, input[type=submit]:active, input[type=reset]:active  {
	  -moz-transform: scale(0.95);
	  -webkit-transform: scale(0.95);
	  -o-transform: scale(0.95);
	  -ms-transform: scale(0.95);
	  transform: scale(0.95);
	}
	
	.input{
	  background-color: #f6f6f6;
	  border: none;
	  color: #0d0d0d;
	  padding: 15px 32px;
	  
	  text-decoration: none;
	  display: inline-block;
	  font-size: 16px;
	  margin: 5px;
	  width: 85%;
	  border: 2px solid #f6f6f6;
	  -webkit-transition: all 0.5s ease-in-out;
	  -moz-transition: all 0.5s ease-in-out;
	  -ms-transition: all 0.5s ease-in-out;
	  -o-transition: all 0.5s ease-in-out;
	  transition: all 0.5s ease-in-out;
	  -webkit-border-radius: 5px 5px 5px 5px;
	  border-radius: 5px 5px 5px 5px;
	}
	
	input[type=text]:focus {
	  background-color: #fff;
	  border-bottom: 2px solid #5fbae9;
	}
	
	input[type=text]:placeholder {
	  color: #cccccc;
	}
	#mainIcons1{
		 padding: 15px 115px;
	  text-align: center;
	  
	  display: inline-block;
	 
		display:flex;
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
	
	
	/* ANIMATIONS */
	
	/* Simple CSS3 Fade-in-down Animation */
	.fadeInDown {
	  -webkit-animation-name: fadeInDown;
	  animation-name: fadeInDown;
	  -webkit-animation-duration: 1s;
	  animation-duration: 1s;
	  -webkit-animation-fill-mode: both;
	  animation-fill-mode: both;
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
	
	/* Simple CSS3 Fade-in Animation */
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
	
	.fadeIn.first {
	  -webkit-animation-delay: 0.4s;
	  -moz-animation-delay: 0.4s;
	  animation-delay: 0.4s;
	}
	
	.fadeIn.second {
	  -webkit-animation-delay: 0.6s;
	  -moz-animation-delay: 0.6s;
	  animation-delay: 0.6s;
	}
	
	.fadeIn.third{
	  -webkit-animation-delay: 0.8s;
	  -moz-animation-delay: 0.8s;
	  animation-delay: 0.8s;
	}
	
	.fadeIn.fourth {
	  -webkit-animation-delay: 1s;
	  -moz-animation-delay: 1s;
	  animation-delay: 1s;
	}
	
	.fadeIn.fifth {
	  -webkit-animation-delay: 1.2s;
	  -moz-animation-delay: 1.2s;
	  animation-delay: 1.2s;
	}
	.fadeIn.six {
	  -webkit-animation-delay: 1.4s;
	  -moz-animation-delay: 1.4s;
	  animation-delay: 1.4s;
	}
	
	/* Simple CSS3 Fade-in Animation */
	.underlineHover:after {
	  display: block;
	  left: 0;
	  bottom: -10px;
	  width: 0;
	  height: 2px;
	  background-color: #56baed;
	  content: "";
	  transition: width 0.2s;
	}
	
	.underlineHover:hover {
	  color: #0d0d0d;
	}
	
	.underlineHover:hover:after{
	  width: 100%;
	}
	.lo{
	color: #60CFFF; 
	}
	.lo:hover{
	color: #277BC0;
	font-weight: 800;
	}
	
	
	/* OTHERS */
	
	*:focus {
	    outline: none;
	} 
	
	#icon {
	  width:60%;
	}
	#mainIcon{
		margin-left:-30px;
	}
	#bu{
	display: flex;
	align-items: center;
	justify-content: center;}	
	#memailconfirm{
	width: 60%;}
	#checkEmail{
	width:24%;
	border: none;
	border-radius: 10px;
	height:58px;
	color:#92badd;
	}
	
	#checkEmail:hover{
	color: #277BC0;
	  
	font-weight: 800;
	
	
	}
	</style>
  </head>
  <body style= "background:#F2F2F2;">
  
  <div class="wrapper fadeInDown">
  <div id="formContent">
    <!-- Tabs Titles -->

    <!-- Icon -->
    <div class="fadeIn first">
      <ul id="mainIcons1">
			  <li >solo</li>
			  <li id="mainIcons2">.</li>
			  <li >dent</li>
			</ul>
    </div>
	<form action="${ contextPath }/changePwd.me" method="POST" id="for">
				<div class="in1">
				<input type="text" class="in fadeIn second input" name="id"  placeholder="아이디">
					</div>
					<div class="in1">
				<input type="text" id="memail" class="in fadeIn third input" name="email"  placeholder="이메일">
					</div>
					<div id="bu">
						<input type="text" id="memailconfirm" name="email1" class="fadeIn fourth input" placeholder="인증번호">
						<button type="button" id="checkEmail" class="fadeIn fourth">인증번호<br> 받기</button>
					</div>
					 <input type="button" id="sub" class="fadeIn fifth" value="비밀번호 변경">
	</form>
 
    <div id="formFooter">
      <a class="lo fadeIn six" href="${ contextPath }/loginView.me">로그인</a>
       <a class="lo fadeIn six" href="${ contextPath }/findId.me">아이디 찾기</a>
    </div>

  </div>
</div>
<jsp:include page="../home/menubar.jsp"/>
<script>
	let okEmail = false;
	window.onload = () =>{
		$(function() {
			
			
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
					findEail(data, $memailconfirm);
				}
			});
		});
			function findEail(data, $memailconfirm){
				$('#sub').click(function(){
			
				if (data != $memailconfirm.val()) { //
					alert("인증번호가 일치하지 않습니다");
						
						
					
					//console.log("중복아이디");
				} else { // 아니면 중복아님
					
					$('#for').submit();
				}
			});
				}
		});
		
			

		}
	
	
	</script>
  </body>
</html>
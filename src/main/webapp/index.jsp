<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 추가할부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <style >
    .j1 {
	  -webkit-animation-name: j1;
	  animation-name:j1;
	  -webkit-animation-duration: 1s;
	  animation-duration: 1s;
	  -webkit-animation-fill-mode: both;
	  animation-fill-mode: both;
	}
	
	@-webkit-keyframes j1 {
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
	
	@keyframes j1 {
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
	
	.j1 {
	  opacity:0;
	  -webkit-animation:j1 ease-in 1;
	  -moz-animation:j1 ease-in 1;
	  animation:j1 ease-in 1;
	
	  -webkit-animation-fill-mode:forwards;
	  -moz-animation-fill-mode:forwards;
	  animation-fill-mode:forwards;
	
	  -webkit-animation-duration:1s;
	  -moz-animation-duration:1s;
	  animation-duration:1s;
	}
	
	.j1.y1 {
	  -webkit-animation-delay: 0s;
	  -moz-animation-delay: 0s;
	  animation-delay: 0s;
	}
	.j1.y2 {
	  -webkit-animation-delay: 0.2s;
	  -moz-animation-delay: 0.2s;
	  animation-delay: 0.2s;
	}
	.j1.y3 {
	  -webkit-animation-delay: 0.3s;
	  -moz-animation-delay: 0.3s;
	  animation-delay: 0.3s;
	}
	.j1.y4 {
	  -webkit-animation-delay: 0.4s;
	  -moz-animation-delay: 0.4s;
	  animation-delay: 0.4s;
	}
	.j1.y5 {
	  -webkit-animation-delay: 0.5s;
	  -moz-animation-delay: 0.5s;
	  animation-delay: 0.5s;
	}
	.j1.y6 {
	  -webkit-animation-delay: 0.6s;
	  -moz-animation-delay: 0.6s;
	  animation-delay: 0.6s;
	}
	.j1.y7 {
	  -webkit-animation-delay: 0.7s;
	  -moz-animation-delay: 0.7s;
	  animation-delay: 0.7s;
	}
	.j1.y8 {
	  -webkit-animation-delay: 0.8s;
	  -moz-animation-delay: 0.8s;
	  animation-delay: 0.8s;
	}
	.j1.y9 {
	  -webkit-animation-delay: 0.9s;
	  -moz-animation-delay: 0.9s;
	  animation-delay: 0.9s;
	}
	.j1.y10 {
	  -webkit-animation-delay: 1s;
	  -moz-animation-delay: 1s;
	  animation-delay: 1s;
	}
	.j1.y11 {
	  -webkit-animation-delay: 1.1s;
	  -moz-animation-delay: 1.1s;
	  animation-delay: 1.1s;
	}
	.j1.y12 {
	  -webkit-animation-delay: 1.2s;
	  -moz-animation-delay: 1.2s;
	  animation-delay: 1.2s;
	}
	.j1.y13 {
	  -webkit-animation-delay: 1.3s;
	  -moz-animation-delay: 1.3s;
	  animation-delay: 1.3s;
	}
	.j1{text-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);
	background:#1e8bc3;}
	
	#mainIcon4{
	 	text-shadow:1px 1px 4px #cacaca,
			2px 2px 4px rgba(0, 0, 0, .3),
			5px 5px 8px rgba(0, 0, 0, .2),
			7px 7px 15px rgba(0, 0, 0, .1);
			display:flex;
			font-weight: 900;
			font-size: 100px;
			color: white;
			
			margin-top:1%;
		}
		#mainIcon5{
			
		}
    	li{
			list-style: none;}
			a{
		text-decoration: none;
		}
		a:hover{
			text-decoration: none;}
			
			
	@-webkit-keyframes j2 { from { opacity:0; } to { opacity:1; } }
	@-moz-keyframes j2 { from { opacity:0; } to { opacity:1; } }
	@keyframes j2 { from { opacity:0; } to { opacity:1; } }
	
	.j2 {
	  opacity:0;
	  -webkit-animation:j2 ease-in 1;
	  -moz-animation:j2 ease-in 1;
	  animation:j2 ease-in 1;
	
	  -webkit-animation-fill-mode:forwards;
	  -moz-animation-fill-mode:forwards;
	  animation-fill-mode:forwards;
	
	  -webkit-animation-duration:1s;
	  -moz-animation-duration:1s;
	  animation-duration:1s;
	}
	
	.j2.first {
	  -webkit-animation-delay: s;
	  -moz-animation-delay: 1s;
	  animation-delay: 1s;
	}
	@-webkit-keyframes j3 { from { opacity:0; } to { opacity:1; } }
	@-moz-keyframes j3 { from { opacity:0; } to { opacity:1; } }
	@keyframes j3 { from { opacity:0; } to { opacity:1; } }
	.j3 {
	  opacity:0;
	  -webkit-animation:j3 ease-in 1;
	  -moz-animation:j3 ease-in 1;
	  animation:j3 curve a 1;
	
	  -webkit-animation-fill-mode:forwards;
	  -moz-animation-fill-mode:forwards;
	  animation-fill-mode:forwards;
	
	  -webkit-animation-duration:1s;
	  -moz-animation-duration:1s;
	  animation-duration:2s;
	  
	  animation-iteration-count: infinite;
	}
	
	
	
	
    </style>
  </head>
  <body style="background:#89c4f4">
   <c:set var="contextPath" value="${ pageContext.request.contextPath }" scope="application"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    	 <div class="container-fluid text-center">
	  		<div class="row justify-content-center" style="width: 100%">
                 <div class="col">
                 	 
                 	<div style="font-size: 50px; font-weight:700; color:white; display:inLine-block; border-bottom: 3px solid white; width:1000px;">
                 	<div style="display: flex; text-align: center; align-items: center; justify-content:center; margin-top:20%; text-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);">
                 	<div class="j1 y1">자</div>
                 	<div class="j1 y2">취</div>
                 	<div class="j1 y3">하</div>
                 	<div class="j1 y4">는 </div>
                 	&nbsp;
                 	<div class="j1 y5">학</div>
                 	<div class="j1 y6">생</div>
                 	<div class="j1 y7">들</div>
                 	<div class="j1 y8">을 </div>
                 	&nbsp;
                 	<div class="j1 y9">위</div>
                 	<div class="j1 y10">한</div>
                 	&nbsp;
                 	<div class="j1 y11">사</div>
                 	<div class="j1 y12">이</div>
                 	<div class="j1 y12">트 </div>
                 	   
                 	</div>
                 			
                 </div>
                
				</div>
                 	</div>
                 	<div class="row justify-content-center" style="width: 100%">
                 <div class="col">
                 	 
                 	<div style="font-size: 50px; font-weight:700; color:white; display:inLine-block; width:1000px; height:20%; padding: 0px 10px;">
                 	<div style="display: flex; text-align: center; align-items: center; justify-content:center; margin-top:0; text-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);">
                 	<div class="j2 first">
                 	<a href="${ contextPath }/home.do">
                 	 <ul id="mainIcon4">
						<li>solo</li>
						<li id="mainIcon5">.</li>
						<li >dent</li>
						</ul>
						</a>
						</div>
              	</div>
						</div>
						</div>
					
                
         </div>
         <div class="row justify-content-center" style="width: 100%">
                 <div class="col">
                 	 
                 	<div style="font-size: 50px; font-weight:700; color:white; display:inLine-block;  width:1000px;">
                 	<div style="display: flex; text-align: center; align-items: center; justify-content:center; margin-top:0; text-shadow: 0 30px 60px 0 rgba(0,0,0,0.3);">
                 	<div style="font-size:30px; font-weight:500;" class="j3">클릭하세요!</div>
                 	<img alt="1" class="j3" src="${contextPath }/resources/img/cl.png" width="200px" height="100px;" style="margin-right: 55%; margin-top:-5%;"  >
         </div>
         </div>
         </div>
         </div>
        
  </body>
</html>
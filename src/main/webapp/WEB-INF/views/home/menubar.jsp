<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<c:set value="${pageContext.servletContext.contextPath }" var="contextPath" scope="application"/>
    
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    
    <!--jQuery-->
   	<script src = "https://code.jquery.com/jquery-3.6.1.min.js"></script>
   
	<!-- Fontawesome-->
	<script src="https://kit.fontawesome.com/25fd41a4c0.js" crossorigin="anonymous"></script>
	
	<!-- Google Fonts -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,600;1,700&family=Montserrat:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&family=Raleway:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400;1,500;1,600;1,700&display=swap" rel="stylesheet">
	
	 <!-- Vendor CSS Files -->
	<link href="/solodent/resources/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
	<link href="/solodent/resources/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
<!-- 	<link href="/solodent/resources/assets/vendor/aos/aos.css" rel="stylesheet"> -->
	<link href="/solodent/resources/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
	<link href="/solodent/resources/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">
	
	
	<!-- Template Main CSS File -->
	<link href="/solodent/resources/assets/css/main.css" rel="stylesheet">
		
    <style>
	    .nav1{height: 83px; background-color: #60CFFF; top:0px; left: 0px; width:100%; position: fixed; z-index:9999;}
	    
		a{
		text-decoration: none;
		}
		a:hover{
			text-decoration: none;
		}
		li{
			list-style: none;
		}
		#icon{width: 300px;
		}
		#mainIcon{
			display:flex;
			font-weight: 900;
			font-size: 48px;
			color: white;
			text-shadow:1px 1px 4px #cacaca,
			2px 2px 4px rgba(0, 0, 0, .3),
			3px 3px 6px rgba(0, 0, 0, .2),
			4px 4px 11px rgba(0, 0, 0, .1);
		}
		#mainIcon2{
			margin-left:2px;
			color: #FFB800;
			text-shadow:1px 0.8px 4px #FFAE6D,
			2px 1.6px 4px rgba(0, 0, 0, .3),
			2px 1.6px 6px rgba(0, 0, 0, .2);
		}
		.middle{
			width: 110px;
		}
		.middle>a{
			
			display: flex;
			margin-top: 40px;
			color: white;
			font-weight: 700;
			
			text-shadow:1px 1px 4px #cacaca,
			2px 2px 4px rgba(0, 0, 0, .3),
			3px 3px 6px rgba(0, 0, 0, .2),
			4px 4px 11px rgba(0, 0, 0, .1);
		}
		.middle>a:hover{
		color: lightgrey;}
		#search{
			margin-top: 35px; 
			
		}
		#search2{
			width: 220px;
			background: white;
			border-radius: 50px;
		}
		#mainSearch{
		/* border: 1px solid white; */
		width: 200px;
		margin-left: 20px;
		border-radius: 50px;}
		.dropdown-toggle{
		    background: #60cfff;
		    border:none;    
		    color: white;
		    font-weight: 700;
		    text-shadow: 1px 1px 4px #cacaca, 2px 2px 4px rgb(0 0 0 / 30%), 3px 3px 6px rgb(0 0 0 / 20%), 4px 4px 11px rgb(0 0 0 / 10%);
		}
		.dropdown-toggle:hover, .dropdown-toggle:active{
		    background: #60cfff;
		     color: #dee2e6 !important;
		}
		.badge-danger {
		    color: #fff;
		          
		    background-color: #e74a3b;
		    /* width: 30px; */
		    font-size: 10px;
		    border: none;
		    left: -10px;
		    top: -13px !important;
		    position: relative;
		    position: relative !important;
		}
		.dropdown  .alert{
		    position: absolute;
		    top: -11px;
		    left: -43px;
		}       
		  	</style>
		  </head>
  
  
  <body>
  	 <input type="hidden" id="home" value="${pageContext.request.contextPath}">  
    <input type="hidden" id="loginUser" value="${loginUser}"> 
    <c:set var="contextPath" value="${ pageContext.request.contextPath }" scope="application"/>
    <header id="header"  align-items-center">
	   <nav class="nav1">
	   	<div class="container-fluid text-center">
	  		<div class="row">
				<div class="col-lg-2 "  id="icon">
	    			<a href="${ contextPath }/home.do">
			 			<ul id="mainIcon">
				  			<li>solo</li>
							<li id="mainIcon2">.</li>
				  			<li >dent</li>
						</ul>
					</a>
				</div>
	   			<div class="col-lg-1 middle">
	     			<a href="${ contextPath }/freeHome.fe">자유게시판</a>
	    		</div>
	    		
			    <div class="col-lg-1 d-none d-sm-block middle">
			    	<a href="${ contextPath }/tipList.bo">자취꿀팁</a>
			    </div>
			    
			    <div class="col-lg-1 d-none d-md-block middle">
			    	<a href="${ contextPath }/usedList.bo">중고거래</a>
			    </div>
			    <div class="col-lg-1 d-none d-md-block middle">
			   		<a href="${ contextPath }/list.moim">모임게시판</a>
			    </div>
			    
			    
			    
			    
	    		<div class="col-lg d-none d-lg-block "> </div>
	    		
                 <c:if test="${not empty loginUser }">
                     <div class="col-lg-1 d-none d-md-block middle">
                        <div class="dropdown" style="top: 32px;left: -65px;">
                          <a class="btn  dropdown-toggle" href="#" style="position: relative;"
                           role="button" id="notificationListBtn" data-bs-toggle="dropdown" aria-expanded="false">
                           <span  class="alert" >
                               <i class="fas fa-bell fa-fw"></i>
                               <span id="ntcntSpan"></span>                       
                          </span>
                            알림 메시지
                          </a>
                               <div  id="notificationList">
                               </div>     
                         </div>
                     </div>
                </c:if>    
	    
			    <div class="col-lg-1 d-none d-lg-block middle">
			   		<c:if test="${ empty loginUser }">
			    		<a href="${ contextPath  }/loginView.me">로그인</a>
			    	</c:if>
			    	<c:if test="${ !empty loginUser }">
			    		<a href="${ contextPath  }/myInfo.me">내정보보기</a>
			    	</c:if>
			    </div>
			    <div class="col-lg-1 d-none d-lg-block middle">
				    <c:if test="${ empty loginUser }">
				    	<a href="${ contextPath  }/enroll.me">회원가입</a>
				    </c:if>
				    <c:if test="${ !empty loginUser }">
			    		<a href="${ contextPath  }/logout.me">로그아웃</a>
			    	</c:if>
			    </div>
			</div>
		</div>
	</nav>
	</header>   
   
<!-- Vendor JS Files --> <!--이거 없으면 화면 안 나옴-->
    <script src="/solodent/resources/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="/solodent/resources/assets/vendor/aos/aos.js"></script>
    <script src="/solodent/resources/assets/vendor/glightbox/js/glightbox.min.js"></script>
    <script src="/solodent/resources/assets/vendor/purecounter/purecounter_vanilla.js"></script>
    <script src="/solodent/resources/assets/vendor/swiper/swiper-bundle.min.js"></script>
    <script src="/solodent/resources/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
    <script src="/solodent/resources/assets/vendor/php-email-form/validate.js"></script>

    <!-- Template Main JS File -->
    <script src="/solodent/resources/assets/js/main.js"></script>
    
    
    <!-- ============================채팅=======================-->
    <%-- <%@ include   file="../chat/chatModal.jsp" %> --%>
	<script>
	$(function(){
	   const loginUser =$("#loginUser").val();
	   //console.log(loginUser);
	   if(loginUser!=""){   
	      notificationList();
	      setInterval(() => {
	         //notificationList();
	      }, 3000);
	   }
	});
	
	function notificationList(){
	   const home=$("#home").val();   
	   $.ajax({
	      url:home+"/chat/notificationList.do",
	      type:"post",      
	      success:function(res){
	         //console.log(" res : ", res);
	         $("#notificationList").html(res);
	         const notificationCnt=parseInt($("#notificationCnt").val());
	        // console.log("notificationCnt  : " + notificationCnt);
	         
	         if(notificationCnt==0){
	            $(".badge-danger").hide();
	            $("#notificationListBtn").on("click", function(){
	               //alert("도착한 메시지가 없습니다.");
	            })
	         }else{
	            const html ='<span class="badge badge-danger badge-counter " id="ntcntSpan">'+notificationCnt +'+</span>';
	            $("#ntcntSpan").html(html);
	         }
	      },
	      error:function(error){
	         //console.log("에러 : ",error);
	      }      
	   });
	}
	
	
	</script>    
    
	</body>
</html>
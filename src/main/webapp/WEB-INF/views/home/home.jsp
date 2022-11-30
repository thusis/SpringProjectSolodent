<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <!-- 추가할부분 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <style type="text/css">
		.djCard{
			cursor: pointer;
		}
	</style>
    <style>
/*     	.di{display: flex;} */
    	
    	#mainIcon4{
			display:flex;
			font-weight: 900;
			font-size: 80px;
			color: #60CFFF;
			text-shadow:1.5px 1.5px 4px #cacaca,
			3px 3px 4px rgba(0, 0, 0, .3),
			4px 4px 8px rgba(0, 0, 0, .2),
			5px 5px 12px rgba(0, 0, 0, .1);
			
			margin-top:1%;
		}
		#mainIcon5{
			
			color: #F2F2F2;
			text-shadow:1px 0.8px 4px #FFAE6D,
			2px 1.6px 4px rgba(0, 0, 0, .3),
			2px 1.6px 6px rgba(0, 0, 0, .2);
		}
		.mi{width:100%;}
	.mi1{width:100%}
	.roro{
	max-width:1000px;}
    </style>
    
  </head>
  <body style="margin-top:10%">
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
    <jsp:include page="menubar.jsp"/>
    
    <div class="container-fluid text-center ">
	  	<div class="row roro justify-content-md-center">
	  			
	  			
	  			<div class="col-2" style="margin-left:23%"> 
	  				<img  alt="1" src="${contextPath }/resources/img/go.png" width="100%" height="200px;" >
 	  			</div>
	  			<div class="col-5">
	  			
					<ul id="mainIcon4">
						<li>solo</li>
						<li id="mainIcon5">.</li>
						<li >dent</li>
					</ul>
					<br>
					<div style="margin-top:-23px; color:#fbc093; font-size:27px; font-weight:600;   text-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); margin-left:35px;" >자취하는 학생들의 커뮤니티</div>
	  			
	  			</div>
				<div class="col-2" >
	  				<img  alt="1" src="${contextPath }/resources/img/did.png" width="100%" height="200px;" >
	  			</div>
	  				
	  			</div>
	  			

	  		
	  		
	  		
	 		<div class="row ">
	  		<div class="col ">
	  		<div style="float:right; margin-top:50px; color:grey; font-weight:900 ">
	  		<div style="display:flex"> 
	  		<div class="d10" style="color:#fbc093; font-weight:600">자유게시판</div><a href="${ contextPath }/freeHome.fe" class="a3" style="margin-left:73%">더보기</a>
	  		</div>
	  		<div style=" margin-top:20px;  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); border-radius:20px; width:500px; height:320px;">
	  		<table style=" padding: 30px; margin-left:20px; padding: 50px 50px;"  >
	  		<thead>
	  			<tr >
	  				<td style="width:50px; padding-top:10px; text-align: center; height:25px;">번호</td>
	  				<td style="width:150px; padding-top:10px;">제목</td>
	  				<td style="width:100px; text-align: center; padding-top:10px;">작성자</td>
	  	 			<td style="width:100px; text-align: center; padding-top:10px;">작성일</td>
	  				<td style="width:50px; text-align: center; padding-top:10px;">조회수</td>
	  			</tr>
	  		</thead>
	  		<tbody>
	  			<c:forEach items="${ list }" var="b">
    					<tr style="border-bottom: 1px solid #2e3131; background:white;">
    						<td class="bId td"  style="text-align: center;  height:70px;">${ b.boardId }</td>
    						<td class="td">${ b.boardTitle }</td>
    						<td class="writer userId td"  style="text-align: center">${ b.userId }</td>
    						<td class="td" style="text-align: center">${ b.createDate }</td>
    						<td class="td" style="text-align: center">${ b.boardCount }</td>
    					</tr>
    			</c:forEach>
    		</tbody>
	  		</table>
	  		</div>
	  		</div>
	  		</div>
	  		<div class="col" >
	  		
	  		<div style="float: left; margin-top:50px; background:white;  color:grey; font-weight:900 ">
	  		<div style="display:flex">
	  		<div class="d11" style="color:#fbc093; font-weight:600">모임게시판</div><a href="${ contextPath }/list.moim"  class="a3" style="margin-left:73%">더보기</a>
	  		</div>
	  		<div style="background:white;  box-shadow: 0 30px 60px 0 rgba(0,0,0,0.3); width:500px; margin-top: 20px; border-radius: 20px; height:320px;">
	  			
	  			<ul >
	  			<div style="display:flex; padding:17px 0px;"><div style="width:50px;">번호</div><div style="width:150px; text-align:center">제목</div><div style="width:100px;">작성자</div>
	  			<div style="width:100px;">작성일</div><div style="width:80px;">조회수</div></div>
	  			<c:forEach items="${ mist }" var="m">
    					<div style="display:flex; border-bottom: 1.5px solid #2e3131; margin-top:10p;">
    						<li class="bId td" id="bId" style="text-align: center;  height:40px; width:50px; height: 15px; padding-bottom: 10px; margin-bottom:30px; margin-top:0px;">${ m.boardId }</li>
    						<li class="td" style="width:190px; height: 20px; ">${ m.boardTitle }</li>
    						<li class="writer userId td" id="writer" style=" width:100px; height: 20px; " >${ m.userId }</li>
    						<li class="td" style="text-align: center; width:150px; height: 20px; ">${ m.createDate }</li>
    						<li class="td" style="text-align: center; width:60px; height: 20px; ">${ m.boardCount }</li>
    				</div>
    				<br>
    			</c:forEach>
    </ul>
    </div>
	  		
	  	</div>
	  </div>
	  </div>
	  </div>
	  <input type="hidden" value="${ loginUser.id }" id="checkLogin">
	<div style="margin-top: 100px;"></div>
	<!-- ======= Portfolio Section ======= -->
    <div id="portfolio" class="portfolio sections-bg" style="margin-top: 70px;">
      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>최근 올라온 중고</h2>

        </div>

          <div class="row gy-4">
          <c:forEach items="${ LatestUsedBoardList }" var="b">
	                		<c:if test="${ b.status eq 'Y' }">
            <div class="col-xl-3 col-md-6">
              <div class="portfolio-wrap card djCard" id="listCard">
		          <input type="hidden" name="boardId" class="bId" value="${ b.boardId }">
		          <input type="hidden" name="userId" class="uId" value="${ b.userId }">
	                <c:forEach items="${ usedAttmList }" var="a">
	                	<c:if test="${ b.boardId eq  a.boardId}">
			                	<div class="m-4 color-secondary">
			                		<img src="${ contextPath }/resources/uploadFiles/${ a.rename }" class="img-fluid" alt="" style="width: 370px; height: 200px; ">
		                		</div>
                		</c:if>
                	</c:forEach>
                <div class="portfolio-info">
	                <c:forEach items="${ usedList }" var="u">
	                <c:if test="${ b.boardId eq u.boardId }">
	                  <h4 class="text-truncate" style="width: 400px;">${ b.boardTitle }</h4><!-- 물건 타이틀 -->
	                  <p class="pb-2 text-truncate" style="width: 400px;">${ b.boardContent }</p><!-- 물건 내용 -->
	                  <div class="container">
	                  	<div class="row">
	                  		<div class="col text-start text-white">${ u.price }원</div>
	                  		<div class="col text-end">${ u.local }</div>
	                  	</div>
	                  </div>
	                  </c:if>
	                  </c:forEach>
                </div>
              </div>
            </div><!-- End Portfolio Item -->
                	</c:if>
            </c:forEach>
          </div><!-- End Portfolio Container -->
        </div>
    </div><!-- End Portfolio Section -->

          <script type="text/javascript">
          	window.onload=()=> {
          		const dives = document.getElementsByClassName('card');
           	 for(const div of dives) {
           		 div.addEventListener('click', function() {
           			 const boardId = this.querySelector('.bId').value;
           			 const writer = this.querySelector('.uId').value;
           			 const checkLogin = document.getElementById('checkLogin').value;
           			 
           			 if(checkLogin == '') {
           				const gradeModalText = document.getElementById('dongjunModalText');
    					gradeModalText.innerHTML = '로그인 후 이용가능합니다..';
    					$('#dongjunModal').modal('show');
           			 } else {
	           			 location.href = '${ contextPath }/selectUsed.bo?bId=' + boardId + '&writer=' + writer;
           			 }
           		 });
           	 }
          	}
          </script>
	 <script>
   	window.onload = () =>{
   		
   		
   		const tbody = document.querySelector('tbody');
   		const tds = tbody.querySelectorAll('td');
   		for(const td of tds){
   			td.addEventListener('click',function(){
   				
   				
   				const trTds = this.parentElement.querySelectorAll('td');
   				const bId = trTds[0].innerText;
   				const writer = trTds[2].innerText;
   				location.href='${contextPath}/selectMainBoard.fe?bId=' + bId + '&writer=' + writer ;
   			});
   		}
   		const ul = document.querySelectorAll('ul');
   		
   		for(const li of ul){
   			li.addEventListener('click',function(){
   				
   				
   				const ul = this.parentElement.querySelectorAll('li');
   				const bId = ul[0].innerText;
   				const writer = ul[2].innerText;
   				location.href='${contextPath}/selectMainBoard.fe?bId=' + bId + '&writer=' + writer ;
   			});
   		}
   		
   	}
   	
   </script>
  </body>
</html>
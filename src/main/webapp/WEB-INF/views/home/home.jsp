<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
		.djCard{
			cursor: pointer;
		}
	</style>
</head>
<body style= "background:#F2F2F2;">
	<jsp:include page="menubar.jsp"></jsp:include>
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
</body>
</html>
 
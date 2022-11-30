<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	#likeIcon:hover{
		cursor: pointer;
	}
	#likeIcon {
		font-size: 30px;
		margin: 10px;
		border-radius: 10px;
	}
	
	
</style>
</head>
<body>
	<jsp:include page="../home/menubar.jsp"/>
	 <section id="portfolio-details" class="portfolio-details" style="margin: 70px;">
      <div class="container" data-aos="fade-up" >

        <div class="position-relative h-100">
          <div class="slides-1 portfolio-details-slider swiper">
            <div class="swiper-wrapper align-items-center">
			
				<c:forEach items="${ aList }" var="a">
	              <div class="swiper-slide" style="height: 600px; width: 1400px;">
	                <img src="${ contextPath }/resources/uploadFiles/${ a.rename }" alt="" style="height: 100%; width: 100%;">
	              </div>
              </c:forEach>

            </div>
            <div class="swiper-pagination"></div>
          </div>
          <div class="swiper-button-prev"></div>
          <div class="swiper-button-next"></div>

        </div>

        <div class="row justify-content-between gy-4 mt-4">
        <input type="hidden" value="${ b.boardId }" name="boardId">
        <input type="hidden" value="${ isLike }" id="isLike">

          <div class="col-lg-8">
            <div class="portfolio-description">
              	<h3>${ b.boardTitle }</h3>
              	<hr>
              	<br>
             	<h5>${ b.boardContent }</h5>
				<hr>
				<br>
            </div>
            <div class="d-inline">
            	<c:if test="${ loginUser.id ne b.userId }">
	            	<c:if test="${ isLike == 1 }">
	            		<i class="bi bi-hand-thumbs-up-fill" style="background-color: #52cbffd3; color: white;" id="likeIcon"></i>
	            	</c:if>
	            	<c:if test="${ isLike == 0 }">
	            		<i class="bi bi-hand-thumbs-up-fill"  id="likeIcon"></i>
	            	</c:if>
            			<span id="likeCount" style="margin-right: 10px;">${ likeCount }</span>
<!--             			<div style="display: inline;"> -->
	            			<button type="button" class="btn btn-outline-info" onclick="chatModal('${ b.userId }')">판매자 채팅</button>
		            		<button type="button" class="btn btn-outline-info" id="declareBtn">게시글 신고</button>
	            			<form action="${ contextPath }/declareBoard.bo" method="post" id="declareForm">
	            				<input type="hidden" value="${ b.userId }"  name="boardWriter">
	     						<input type="hidden" value="${ b.boardTitle }"  name="boardTitle">	
	<%--      						<input type="hidden" value="${ loginUser.id }" id="loginUserId"> --%>
								<input type="hidden" value="${ b.boardId }"  name="boardId">
	            			</form>
<!--             			</div> -->
	            </c:if>
            	<c:if test="${ loginUser.id eq b.userId }">
	            	<i class="bi bi-hand-thumbs-up-fill" style="font-size: 30px; margin: 10px;" ></i>
            		<span id="likeCount" style="margin-right: 10px;">${ likeCount }</span>
            		<button type="button" class="btn btn-outline-info"  onclick="location.href='${ contextPath }/editUsed.bo?bId=${ b.boardId }'">글 수정</button>
            		<button type="button" class="btn btn-outline-info"  id="deleteModal">글 삭제</button>
             	</c:if>
            </div>
          </div>

          <div class="col-lg-3">
            <div class="portfolio-info">
              <h3>판매제품 정보</h3>
              <ul>
                <li><strong>판매자 닉네임</strong><span>${ nickName }</span></li>
                <li><strong>카테고리</strong> <span>${ u.productCate }</span></li>
                <li><strong>가격</strong> <span>${ u.price }</span></li>
                <li><strong>등록 일자</strong> <span>${ b.modifyDate }</span></li>
                <li><strong>조회수</strong> <span>${ b.boardCount }</span></li>
              </ul>
            </div>
          </div>

        </div>

      </div>
    </section><!-- End Portfolio Details Section -->
    <div class="modal fade" tabindex="-1" role="dialog" id="modalChoice" style="top: 50%;">
		<div class="modal-dialog" role="document">
    		<div class="modal-content rounded-3 shadow">
      			<div class="modal-body p-4 text-center">
        			<h3 class="mb-0">정말로 삭제하시겠습니까?</h3>
        			<p class="mb-0">삭제 후 게시글은 복구할 수 없습니다.</p>
      			</div>
      			<div class="modal-footer flex-nowrap p-0">
        			<button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0 border-end"  id="delete">
        				<strong>네</strong>
        			</button>
        			<button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-6 m-0 rounded-0" data-bs-dismiss="modal">아니오</button>
      			</div>
    		</div>
  		</div>
	</div>
    
    <script type="text/javascript">
		window.onload=()=> {
			const isLike = document.getElementById('isLike');
			const icon = document.getElementById('likeIcon');
			if(icon != null) {
				icon.addEventListener('click', function() {
					const likeCount = document.getElementById('likeCount');
					if(isLike.value == 0) {
						$.ajax({
							url : '${ contextPath }/addLike.bo',
							data : { boardId : ${ b.boardId }, userId : '${ loginUser.id }' },
							success : (data)=> {
								console.log("addLike");
								console.log(data);
								this.style.background = '#52cbffd3';
								this.style.color = 'white';
								isLike.value++;
								likeCount.innerText = data;
							},
							error : (data) => {
								console.log(data);
							}
						});
					} else {
						$.ajax({
							url : '${ contextPath }/deleteLike.bo',
							data : { boardId : ${ b.boardId }, userId :'${ loginUser.id }' },
							success : (data)=> {
								console.log("deleteLike");
								console.log(data);
								this.style.background = 'none';
								this.style.color = '#52cbffd3';
								isLike.value--;
								likeCount.innerText = data;
							},
							error : (data) => {
								console.log(data);
							}
						});
					}
				});
			}
			
			const deleteModal = document.getElementById('deleteModal');
			if(deleteModal != null) {
				document.getElementById('deleteModal').addEventListener('click', ()=> {
					$('#modalChoice').modal('show');
				});
			}
			document.getElementById('delete').addEventListener('click', ()=> {
				location.href='${ contextPath }/delete.bo?boardId=${ b.boardId }';
			});
			
			const declareBtn = document.getElementById('declareBtn');
			if(declareBtn != null) {
				
			document.getElementById('declareBtn').addEventListener('click', function() {
				var url = "${contextPath}/declareBoard.bo";
			      var title = "신고창";
			      var status ="width=500, height=400, top=150, left=200";
			      
			    const form = document.getElementById("declareForm");
			      console.log(form);
			      
			      form.target=title;
			      form.action=url;
			      form.method="post";
			      window.open(url, title, status);
			      form.submit();
			});
			}
		}
  	</script> 
    
</body>
</html>
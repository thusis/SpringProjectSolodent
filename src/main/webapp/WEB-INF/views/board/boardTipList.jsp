<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
      .bd-placeholder-img {
        font-size: 1.125rem;
        text-anchor: middle;
        -webkit-user-select: none;
        -moz-user-select: none;
        user-select: none;
      }

      @media (min-width: 768px) {
        .bd-placeholder-img-lg {
          font-size: 3.5rem;
        }
      }

      .b-example-divider {
        height: 3rem;
        background-color: rgba(0, 0, 0, .1);
        border: solid rgba(0, 0, 0, .15);
        border-width: 1px 0;
        box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
      }

      .b-example-vr {
        flex-shrink: 0;
        width: 1.5rem;
        height: 100vh;
      }

      .bi {
        vertical-align: -.125em;
        fill: currentColor;
      }

      .nav-scroller {
        position: relative;
        z-index: 2;
        height: 2.75rem;
        overflow-y: hidden;
      }

      .nav-scroller .nav {
        display: flex;
        flex-wrap: nowrap;
        padding-bottom: 1rem;
        margin-top: -1px;
        overflow-x: auto;
        text-align: center;
        white-space: nowrap;
        -webkit-overflow-scrolling: touch;
      }
      
      #searchTipIcon:hover {
      	cursor: pointer;
      }
      
      .tipCard:hover {
      	cursor: pointer;
      }
      
    </style>
</head>
<body>
	<jsp:include page="../home/menubar.jsp"/>

	
	<div class="container">
	<div style="height: 35px;"></div>
		<div class="row row-cols-auto justify-content-end pb-4">
			<select class="form-select d-flex" aria-label="Default select example" style="width:  150px;" name="tipCate" id="category">
				<option value="" selected="selected">카테고리</option>
				<option value="취미/여가" >취미/여가</option>
				<option value="요리">요리</option>
				<option value="쇼핑">쇼핑</option>
				<option value="부동산">부동산</option>
			</select>
			<select class="form-select d-flex" aria-label="Default select example" style="width:  150px;" name="titleOrContent" id="titleOrContent">
				<option value="">검색 분류</option>
				<option value="boardTitle">제목</option>
				<option value="boardContent">내용</option>
			</select>
				<div class="col pt-1">
	         	<input type="text" style="width: 300px" id="searchWord" placeholder="검색할 단어 입력">
	         	</div>
	         	<div class="col pt-1">
	        	 <i class="bi bi-search" id="searchTipIcon"></i>
	       	  </div>
		</div>    
		<c:forEach items="${ bList }" var="b" varStatus="status">
			<c:if test="${ status.index mod 2 == 0}">
				<div class="row mb-2">
			</c:if>
<%-- 			${ status.index } --%>
<%-- 			${ status.index mod 2 == 0 } --%>
	    		<div class="col-md-6 tipSelect"  id="tipSelect"> <!-- addeventLister 할 곳 -->
					<input type="hidden" value="${ b.boardId }" class="bId" name = boardId>
					<input type="hidden" value="${ b.userId }" class="uId" name="userId">
	      			<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative tipCard">
	        			<div class="col p-4 d-flex flex-column position-static">
	        				<c:forEach items="${ tList }" var="t">
	        					<c:if test="${ t.boardId eq b.boardId }">
	          						<strong class="d-inline-block mb-2 text-primary">${ t.tipCate }</strong>
	        					</c:if>
	        				</c:forEach>
	          				<h3 class="mb-0 text-truncate" style="width: 300px;">${ b.boardTitle }</h3>
	          				<div class="mb-1 text-muted">${ b.modifyDate }</div>
	          				<br>
	          				<p class="card-text mb-auto text-truncate" style="width: 300px;">${ b.boardContent }</p>
	<!--           				<a href="#" class="stretched-link">Continue reading</a> -->
							<div class="d-inline-block">
								<p style="float: right;">조회 수 ${ b.boardCount }</p>
								<span style="float: right; margin-right: 30px;"> 좋아요 ${ likeCountList[status.index] }개 </span>
							</div>
	        			</div>
	        			<div class="col-auto d-none d-lg-block">
	        				<c:set var="yn" value="false"></c:set>
	        				<c:forEach items="${ aList }" var="a">
	        					<c:if test="${ b.boardId eq a.boardId }">
		          					<img src="${ contextPath }/resources/uploadFiles/${ a.rename }" width="250" height="250">
		          					<c:set var="yn"  value="true"></c:set>
	        					</c:if>
	        				</c:forEach>
	        					<c:if test="${ not yn }">
	          						<svg class="bd-placeholder-img" width="250" height="250" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false"><title>Placeholder</title><rect width="100%" height="100%" fill="#55595c"/><text x="50%" y="50%" fill="#eceeef" dy=".3em">No picture</text></svg>
	        					</c:if>
	        			</div>
	      			</div>
	    		</div>
	    		<c:if test="${ status.index mod 2 == 1}">
	  		</div>
	    		</c:if>	
  		</c:forEach>
	</div>		
		<nav aria-label="Page navigation example">
		  <ul class="pagination justify-content-center">
		    <li class="page-item">
		    	<c:url var="goBack" value="${ loc }">
		    		<c:if test="${ category != null }">
		    			<c:param name="category" value="${ category }"></c:param>
		    		</c:if>
		    		<c:if test="${ searchWhere != null }">
		    			<c:param name="searchWhere" value="${ searchWhere }"></c:param>
		    			<c:param name="word" value="${ word }"></c:param>
		    		</c:if>
		    		<c:param name="page" value="${ pi.currentPage-1 }"></c:param>
		    	</c:url>
		      <a class="page-link" href="${ goBack }" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		    </li>
		    <c:forEach begin="${ pi.startPage }" end="${ pi.endPage }" var="p">
		    	<c:url var="goNum" value="${ loc }">
		    	<c:if test="${ category != null }">
		    			<c:param name="category" value="${ category }"></c:param>
		    		</c:if>
		    		<c:if test="${ searchWhere != null }">
		    			<c:param name="searchWhere" value="${ searchWhere }"></c:param>
		    			<c:param name="word" value="${ word }"></c:param>
		    		</c:if>
		    		<c:param name="page" value="${ p }"></c:param>
		    		
		    	</c:url>
			    <li class="page-item"><a class="page-link" href="${ goNum }">${ p }</a></li>
		    </c:forEach>
		    <li class="page-item">
		    	<c:url var="goNext" value="${ loc }">
		    	<c:if test="${ category != null }">
		    			<c:param name="category" value="${ category }"></c:param>
		    		</c:if>
		    		<c:if test="${ searchWhere != null }">
		    			<c:param name="searchWhere" value="${ searchWhere }"></c:param>
		    			<c:param name="word" value="${ word }"></c:param>
		    		</c:if>
		    		<c:param name="page" value="${ pi.currentPage+1 }"></c:param>
		    	</c:url>
		      <a class="page-link" href="${ goNext }" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
	</nav>
	<div class="container">
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		  <button type="button" class="btn btn-outline-primary" onclick="location.href='${ contextPath }/enrollTip.bo'">글 작성</button>
		</div>
	</div>
	
	<script type="text/javascript">
		window.onload=()=> {
			document.getElementById('searchTipIcon').addEventListener('click', ()=> {
				const category = document.getElementById('category').value;
				const titleOrContent = document.getElementById('titleOrContent').value;
				const word = document.getElementById('searchWord').value;
// 				const page = 
				
				let paramStr = '?';
				
				if(category != '') {
					paramStr = paramStr + "category=" + category;
				}
				
				if(titleOrContent != '' && word.trim() != '') {
						paramStr = paramStr + '&searchWhere=' + titleOrContent + '&word=' + word;
				}
				
				if(paramStr != '?') {
					location.href='${ contextPath }/searchTip.bo' + paramStr;
				}
				
			});
			
			const dives = document.getElementsByClassName('tipSelect');
			for(const div of dives) {
				div.addEventListener('click', function() {
					const boardId = this.querySelector('.bId').value;
					const writer = this.querySelector('.uId').value;
					
					location.href='${ contextPath }/selectTip.bo?bId=' + boardId + '&writer=' + writer;
				});
			}
		}
	</script>
	
</body>
</html>
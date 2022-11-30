<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set value="${pageContext.servletContext.contextPath }" var="contextPath" scope="application"/>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>솔로던트 모임게시판-상세글</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Abril+Fatface&family=Alexandria:wght@200;300;400;500&family=Black+Han+Sans&family=Do+Hyeon&family=Hahmlet:wght@100;200;300;400;500;600;700&family=Jost:wght@500;600;700;800&family=Nanum+Gothic+Coding:wght@400;700&family=Nanum+Gothic:wght@400;700;800&display=swap" rel="stylesheet">
</head>

<body>
  
	<jsp:include page="../home/menubar.jsp"/>

    <main id="main" style="margin-top: 70px;">
    
    <!-- ======= Blog Details Section ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">
      
      	<c:if test="${ !empty dclmsg }"><div class="row mb-3"><h5>${ dclmsg }</h5></div></c:if>

        <div class="row g-5">

          <div class="col-lg-12">

            <article class="blog-details">
              <div class="row">
                <div class="col-10"><h2 class="title">${moim.boardTitle} ( ${moim.moimStart}~${moim.moimEnd} )</h2></div>
                
				<button class="col-lg-1 d-flex align-items-center justify-content-center btn" id="isScrap" onclick="changeScrap()"><h2>
					<c:if test="${ isScrap eq 0 }"><i class="save fa-regular fa-bookmark"></i></c:if>
					<c:if test="${ isScrap ne 0 }"><i class="fa-solid fa-bookmark"></i></c:if>
				</h2></button>
				
				<div class="dropdown col-lg-1 d-flex align-items-center justify-content-center">
					<button class="btn" type="button" data-bs-toggle="dropdown" aria-expanded="false">
						<i class="bi lg bi-three-dots" style="font-size: 2rem; color:darkgray;"></i>
					</button>
					
					<c:if test="${loginUser.id eq moim.userId }">
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="${contextPath}/update.moim?bId=${moim.boardId}&pi=${page}">수정하기</a></li>
							<li><a class="dropdown-item" href="${contextPath}/delete.moim?bId=${moim.boardId}">삭제하기</a></li>
						</ul>
					</c:if>
					<c:if test="${ !empty loginUser && loginUser.id ne moim.userId }">
						<ul class="dropdown-menu">
							<li><a onclick="openPopUp();" class="dropdown-item">신고하기</a></li>
						</ul>
					</c:if>
							<form id="declareForm">
								<input type="hidden" name="moimWriter" value="${ moim.moimWriter }">
								<input type="hidden" name="boardTitle" value="${ moim.boardTitle }">
								<input type="hidden" name="boardId" value="${ moim.boardId }">
								<input type="hidden" name="loginUserId" value="${ loginUser.id }">
							</form>
		        </div>
              </div>
              
              <div class="meta-top">
                  <ul>
                  	<li hidden="hidden" id="userId">${moim.userId }</li>
                    <li class="align-items-center"><i class="bi bi-person"></i>${moim.moimWriter}</li>
                    <li class="align-items-center"><i class="bi bi-clock"></i> <time datetime="2020-01-01">${moim.createDate}</time></li>
  
                    <li class="align-items-center"> | </li>
                    <li class="align-items-center"><i class="bi bi-chat-dots"></i> <a href="#comments">${replyList.size()}</a></li><!--누르면댓글로이동-->
                    <li class="align-items-center"><i class="bi bi-heart-fill"></i>${ boardLikeCount }</li> 
                    <li class="align-items-center"><i class="view fa-solid fa-eye"></i>${moim.boardCount}</li>
                    <li class="align-items-center" id="scrapCount"><i class="save fa-regular fa-bookmark"></i>${ boardScrapCount }</li>
                    <li class="align-items-center"> | </li>
                    
					<c:if test="${moim.local eq '전체 전체'}">
	                    <li class="align-items-center"><i class="bi bi-geo-alt"></i> <a>전체</a></li><!--누르면 지역으로 검색-->
					</c:if>

					<c:if test="${moim.local ne '전체 전체'}">
	                    <li class="align-items-center"><i class="bi bi-geo-alt"></i> <a>${moim.local}</a></li><!--누르면 지역으로 검색-->
					</c:if>
                    <li class="align-items-center"><i class="bi bi-people-fill"></i> <a>${moim.moimCategory}</a></li><!--누르면 모임형태로 검색-->
                    
                    <li class="align-items-center"><i class="bi bi-patch-check-fill"></i>
                       	<c:if test="${fn:contains(moim.moimStatus , 'Y')}"><a>모집중</a></c:if>
                       	<c:if test="${fn:contains(moim.moimStatus , 'B')}"><a>모집전</a></c:if>
                       	<c:if test="${fn:contains(moim.moimStatus , 'N')}"><a>모집종료</a></c:if>
                    </li>
                  </ul>
              </div><!-- End meta top -->

              <div class="content">
                <h4><p>${moim.boardContent}</p></h4>
   
				<c:forEach items="${list}" var="att">
					<img src="${contextPath }/resources/uploadFiles/${att.rename}" alt="" class="img-fluid">
					<br>
				</c:forEach>

              </div><!-- End post content -->
        <hr>

        <!--댓글 쓰는 곳-->
        <div class="reply-form" id="comments">
          <div class="row">
            <div class="col-lg-1 d-inline" style="margin:0; padding:0;">
              <h6 class="d-inline">&nbsp; &nbsp;댓글&nbsp;<h5 class="d-inline">${replyList.size()}</h5>&nbsp;개</h6>
            </div>
            <div class="col-lg d-flex align-items-center" >
              <h4 class="bn_txt_strong">댓글을 남기세요&nbsp;&nbsp;<i class="bi bi-chat-dots"></i></h4>
            </div>
          </div>

          <form action="">
            <div class="row justify-content-center align-items-center">
              <div class="col-1" style="position: relative;display:flex;text-align:center;justify-content:center;">
	              <c:if test="${isLike==1}">
	              	<button type="button" onclick="changeHeart()" class="btn" id="btnh" style="color:var(--color-primary);">
	              	<i class="bn_btnh bi bi-suit-heart-fill"></i></button>
	                <h5 id="boardLikeCount" style="color:white;font-family:Jost;font-weight:600;font-size:1rem;position: relative; text-align: center;position: absolute;top: 50%;left: 50%;transform: translate( -50%, -50% );">${boardLikeCount}</h5>
	              </c:if>
	              
	              <c:if test="${isLike==0}">
	              	<button type="button" onclick="changeHeart()" class="btn" id="btnh" style="color:grey;">
	              	<i class="bn_btnh bi bi-suit-heart"></i></button>
	                <h5 id="boardLikeCount" style="color:grey;font-family:Jost;font-weight:600;font-size:1rem;position: relative; text-align: center;position: absolute;top: 50%;left: 50%;transform: translate( -50%, -50% );">${boardLikeCount}</h5>
	              </c:if>
	                
              </div>

              <div class="col-lg">
                  <textarea name="comment" class="form-control" placeholder="Your Comment*" id="replyContent"></textarea>
              </div>
              
              <div class="col-lg-2"> 
                <button class="btn btn-primary" id="replySubmit" type="button" <c:if test="${ empty loginUser }">disabled</c:if>>Post Comment</button>
              </div>
            </div>
          </form>
          
        </div>

        <!--댓글 리스트-->
          <div class="reply-form">

            <div class="bn_replies row  justify-content-center">
              <ul style="font-weight: 900; color:#0067a3; font-size:1.2rem;">
                <li class="col-lg">댓글작성자</li>
                <li class="col-lg-6">내용</li>
                <li class="col-lg">추천</li>
                <li class="col-lg">작성날짜</li>
              </ul>
              <hr>
              <div class="row justify-content-center" id="boxOfReplies"> 
              
	              <c:if test="${ replyList.size()==0 }">
	              	<h5 class="text-center" style="margin:15px;">등록된 댓글이 없습니다. 첫 댓글을 작성해보세요!</h5>
	              </c:if>
	              
	              <c:if test="${ replyList.size()!=0 }">
		              <c:forEach items="${replyList}" var="r" varStatus="Rstatus">
<%-- 		              	<c:if test="${ loginUser.id eq }"> --%>
			              <ul>
			                <li class="col-lg">${r.userId}</li>
			                <li class="col-lg-6"><div>${r.replyContent}</div></li>
			                <li class="col-lg">${replyLikeCount[Rstatus.index]}</li>
			                <li class="col-lg">${r.createDate}</li>
			              </ul>
<%-- 			          	</c:if> --%>
		              </c:forEach>
	              </c:if>
              
              </div>
              
            </div>

        </div><!-- End blog comments -->
    </article><!-- End blog post -->
    
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->

  </main><!-- End #main -->
  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
  <div id="preloader"></div>
  
  <script>
	//=======신고===========
	function openPopUp(){
		var url = "${contextPath}/declare-popup.moim";
		var title = "신고창";
		var status ="width=500, height=400, top=150, left=200"
		
		const form = document.getElementById("declareForm");
// 		console.log(form);
		
		form.target=title;
		form.action=url;
		form.method="post";
		window.open(url, title, status);
		form.submit();
	}
 	//=======좋아요 불러오기

 	var boardId = ${moim.boardId};
 	var userId = '${loginUser.id}';
	var isLike = ${isLike};
	var boardLikeCountSpan = document.getElementById('boardLikeCount');
	var isScrap = ${isScrap};
	
	function changeHeart(){
		console.log("isLike은" + isLike +" 이고, boardLikeCountSpan은 " + boardLikeCountSpan.innerText);
		
		if(isLike==1){
   			$.ajax({
   				url:'${contextPath}/deleteBoardLike.moim',
   				data :{boardId:boardId,userId:userId},
   				success : (data)=>{
    				boardLikeCountSpan.innerText = "";
					document.getElementById('btnh').style.color = "grey";
					document.getElementById('btnh').innerHTML = '<i class="bn_btnh bi bi-suit-heart"></i>';
    				boardLikeCountSpan.style.color = "grey";
    				boardLikeCountSpan.innerText = data;
    				isLike = 0;
   				}
   			}); // ajax 좋아요 취소
		} else {
			$.ajax({
  				url:'${contextPath}/setBoardLike.moim',
   				data :{boardId:boardId,userId:userId},
   				success : (data)=>{
    				boardLikeCountSpan.innerText = "";
   					document.getElementById('btnh').style.color = "var(--color-primary)";
   					document.getElementById('btnh').innerHTML = '<i class="bn_btnh bi bi-suit-heart-fill"></i>';
    				boardLikeCountSpan.style.color = "white";
    				boardLikeCountSpan.innerText = data;
    				isLike = 1;
  				}
  			}); // ajax 좋아요 추가
		}
	} // changeHeart 함수 끝
	
	function changeScrap(){
		console.log("isScrap은" + isScrap);
		
		if(isScrap==1){
   			$.ajax({
   				url:'${contextPath}/deleteScrap.moim',
   				data :{boardId:boardId,userId:userId},
   				success : (data)=>{
   					
					document.getElementById('isScrap').innerHTML = '<h2><i class="save fa-regular fa-bookmark"></i></h2>';
// 					this.innerHTML = '<h2><i class="save fa-regular fa-bookmark"></i></h2>';
					document.getElementById('scrapCount').innerHTML = '<i class="save fa-regular fa-bookmark"></i>' + data;
    				isScrap = 0;
   				}
   			}); // ajax 좋아요 취소
		} else {
			$.ajax({
  				url:'${contextPath}/setScrap.moim',
   				data :{boardId:boardId,userId:userId},
   				success : (data)=>{
   					document.getElementById('isScrap').innerHTML = '<h2><i class="fa-solid fa-bookmark"></i></h2>';
					document.getElementById('scrapCount').innerHTML = '<i class="fa-solid fa-bookmark"></i>' + data;
    				isScrap = 1;
  				}
  			}); // ajax 좋아요 추가
		}
	} // changeScrap 함수 끝

	//=====================댓글 달기===========================
	window.onload=()=>{
		document.getElementById('replySubmit').addEventListener('click', ()=>{
			$.ajax({
			   url: '${contextPath}/insertReply.moim',
			   data: {
				    replyContent: document.getElementById('replyContent').value,
					boardId:'${moim.boardId}', 
					userId:'${loginUser.id}'
				},
			    success: (data)=>{

			      const replyDiv = document.querySelector('#boxOfReplies');
			      replyDiv.innerHTML = "" ;
			      
			      for(const r of data){
			    	 const ul = document.createElement('ul');
			    	 
			    	 const writerLi = document.createElement('li');
			    	 writerLi.classList.add('col-lg');
			    	 writerLi.innerText = r.userId;
			    	 
			    	 const ContentLi = document.createElement('li');
			    	 ContentLi.classList.add('col-lg-6');
			    	 ContentLi.innerText = r.replyContent;
			    	 
			    	 const replyLikeCountLi = document.createElement('li');
			    	 replyLikeCountLi.classList.add('col-lg');				    		 
			    	 replyLikeCountLi.innerText = "${replyLikeCount[status.index]}";
			    	 
			    	 const createDateLi = document.createElement('li');
			    	 createDateLi.classList.add('col-lg');
			    	 createDateLi.innerText = r.createDate;
			    	 
			    	 ul.append(writerLi);
			    	 ul.append(ContentLi);
			    	 ul.append(replyLikeCountLi);
			    	 ul.append(createDateLi);
			    	 replyDiv.append(ul);
			      }
			      document.getElementById("replyContent").value = "";
			   },
			   error: (data)=>{
				  alert("실패!");
			   }
			});
       	 });
	}
		</script>
</body>
</html>
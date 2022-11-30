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
	
	#mainContent {
		border: 2px solid  #52cbffd3;
		border-radius: 15px;
		margin : 10px;
		padding: 20px;
		
	}
	
	.replyContent {
		border: 1px solid  #52cbffd3;
		border-radius: 15px;
		margin: 10px;
		padding: 3px;
	}
	
	.bi:hover {
		cursor: pointer;
	}

</style>
</head>
<body>
	<jsp:include page="../home/menubar.jsp"/>
	<input type="hidden" value="${ loginUser.id }" id="loginUserId">
<%-- 	<input type="hidden" value="${ b.boardId }" id="declareBoardId"> --%>
<%-- 	<input type="hidden" value="${ b.userId }" id="declareUserName"> --%>
<%--      <input type="hidden" value="${ b.boardTitle }" id="declareBoardTitle"> --%>
	 <section id="portfolio-details" class="portfolio-details" style="margin-top: 70px;">
      <div class="container" data-aos="fade-up" >
		<c:if test="${ aList != null }">
	        <div class="position-relative h-100" style="width: 800px; margin: 0 auto;">
	          <div class="slides-1 portfolio-details-slider swiper" >
	            <div class="swiper-wrapper align-items-center">
					
					<c:forEach items="${ aList }" var="a">
		              <div class="swiper-slide" style="height: 600px; width: 800px;">
		                <img src="${ contextPath }/resources/uploadFiles/${ a.rename }" alt="" style="height: 100%; width: 100%;">
		              </div>
	              </c:forEach>
	
	            </div>
	            <div class="swiper-pagination"></div>
	          </div>
	          <div class="swiper-button-prev"></div>
	          <div class="swiper-button-next"></div>
	
	        </div>
		</c:if>

        <div class="row justify-content-between gy-4 mt-4">
        <input type="hidden" value="${ isLike }" id="isLike">
		
		<div class="col-2"></div>
          <div class="col-lg-8" >
            <div class="portfolio-description" id="mainContent">
              	<h3>${ b.boardTitle }</h3>
              	<hr style="color: #52cbffd3;">
              	<br>
             	<h5>${ b.boardContent }</h5>
				<br>
				<div class="replyContent" id="replyListArea" style="margin: 10px; padding: 10px;">
					<c:forEach begin="0" end="${ rList.size() }" var="i" varStatus="status">
						<div class="row" style="margin-bottom: 10px; border-bottom: 1px solid black;">
							<div class="col-2" style="text-align: center; margin: auto;" id="nIndex${ status.index+1 }">${ rList[i].nickName }</div>
							<div class="col-8" style="border-right: 1px solid black; border-left: 1px solid black;" id="replyContent${ status.index+1 }">${ rList[i].replyContent }</div>
							<div class="col-2" style="margin: auto;" id="otherIndex${ status.index+1 }">
								<c:if test="${ loginUser.id ne rList[i].userId }">
									<c:if test="${ isReplyLikeList[i] == 0 }">
										<i class="bi bi-hand-thumbs-up-fill likeIcon"   id="likeIcon${ status.index+1 }"  style="margin-right: 10px; color:  #52cbffd3;"></i>
										<span id="likeCount${ status.index+1 }">${ likeCountList[i] }<br></span>
									</c:if>
									<c:if test="${ isReplyLikeList[i] == 1 }">
										<i class="bi bi-hand-thumbs-up-fill likeIcon"    id="likeIcon${ status.index+1 }"  style="margin-right: 10px; background-color: #52cbffd3; color: white;"></i>
										<span id="likeCount${ status.index+1 }">${ likeCountList[i] }<br></span>
									</c:if>
										<input type="hidden" id="isReplyLike${ status.index + 1 }" value="${ isReplyLikeList[i] }">
										<input type="hidden" id="replyLike${ status.index+1 }" value="${ rList[i].replyId }">
								</c:if>
								<c:if test="${ loginUser.id eq rList[i].userId }">
									<c:if test="${ isReplyLikeList[i] == 0 }">
										<i class="bi bi-hand-thumbs-up-fill "    style="margin-right: 10px;"></i>
										<span id="likeCount${ status.index+1 }">${ likeCountList[i] }<br></span>
									</c:if>
									<c:if test="${ isReplyLikeList[i] == 1 }">
										<i class="bi bi-hand-thumbs-up-fill "     style="margin-right: 10px; background-color: #52cbffd3; color: white;"></i>
										<span id="likeCount${ status.index+1 }">${ likeCountList[i] }<br></span>
									</c:if>
										<input type="hidden" id="isReplyLike${ status.index + 1 }" value="${ isReplyLikeList[i] }">
										<input type="hidden" id="replyLike${ status.index+1 }" value="${ rList[i].replyId }">
										<i class="bi bi-trash-fill deleteReply" style="border: 1px solid #52cbffd3; border-radius: 5px; background: #52cbffd3; color: white;">댓글 삭제</i><!--  여기 -->
										<i class="bi bi-pencil"  id="contentIndex${ status.index+1 }" onclick="editReply(this);" style="border: 1px solid #52cbffd3; border-radius: 5px; background: #52cbffd3; color: white;">댓글 수정</i>
								</c:if>
			            		${ rList[i].createDate }
							</div>
						</div>
					</c:forEach>
					
	            	
				</div>
				<div class="row replyContent"  style="margin: 10px; padding: 10px;">
					<div class="col-2"></div>
					<div class="col-8">
						<textarea class="form-control" rows="3" cols="55" id="replyContent"></textarea>
					</div>
	            	<div class="col-2"><button type="button" class="btn btn-outline-info" style="height: 100%; width: 100%; " id="replySubmit">작성하기</button></div>
				</div>
            </div>
          </div>
			<div class="col-2">
				<div class="portfolio-info">
					<h3>작성자 정보</h3>
					<ul>
						<li><strong>작성자 닉네임</strong><span>${ nickName }</span></li>
						<li><strong>게시글 등록일자</strong><span>${ b.modifyDate }</span></li>
						<li><strong>조회수</strong><span>${ b.boardCount }</span></li>
					</ul>
				</div>
            	<c:if test="${ loginUser.id ne b.userId }">
	            	<c:if test="${ isLike == 1 }">
	            		<i class="bi bi-hand-thumbs-up-fill" style="background-color: #52cbffd3; color: white;" id="likeIcon"></i>
	            	</c:if>
	            	<c:if test="${ isLike == 0 }">
	            		<i class="bi bi-hand-thumbs-up-fill"  id="likeIcon"></i>
	            	</c:if>
            		<span id="likeCount" style="margin-right: 10px;">${ likeCount }</span>
            			<c:set var="scrapResult" value="${ isScrap }" ></c:set>
            			<button type="button" class="btn btn-outline-info"  style="margin-left: 10px;" id="scrapBtn">스크랩</button>
            			<button type="button" class="btn btn-outline-info"  style="margin-left: 10px; margin-bottom: 10px;" id="scrapDeleteBtn" >스크랩 취소</button>
            			<form action="${ contextPath }/declareBoard.bo" method="post" id="declareForm">
            				<input type="hidden" value="${ b.userId }"  name="boardWriter">
     						<input type="hidden" value="${ b.boardTitle }"  name="boardTitle">	
<%--      						<input type="hidden" value="${ loginUser.id }" id="loginUserId"> --%>
							<input type="hidden" value="${ b.boardId }"  name="boardId">
	            			<button type="button" class="btn btn-outline-info" id="declareBtn">게시글 신고</button>
            			</form>
	            </c:if>
            	<c:if test="${ loginUser.id eq b.userId }">
            			<c:set var="scrapResult" value="${ isScrap }" ></c:set>
	            	<i class="bi bi-hand-thumbs-up-fill" style="font-size: 30px; margin: 10px;" ></i>
            		<span id="likeCount" style="margin-right: 10px;">${ likeCount }</span>
            		<br>
            		<br>
            		<button type="button" class="btn btn-outline-info"  onclick="location.href='${ contextPath }/editTip.bo?bId=${ b.boardId }'">글 수정</button>
            		<button type="button" class="btn btn-outline-info"  id="deleteModal">글 삭제</button>
             	</c:if>
            			
			
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
	
    <div class="modal fade" tabindex="-1" role="dialog" id="modalScrap" style="top: 50%;">
		<div class="modal-dialog" role="document">
    		<div class="modal-content rounded-3 shadow">
      			<div class="modal-body p-4 text-center">
        			<h3 class="mb-0" id="modalText"></h3>
      			</div>
      			<div class="modal-footer flex-nowrap p-0">
        			<button type="button" class="btn btn-lg btn-link fs-6 text-decoration-none col-12 m-0 rounded-0 border-end"  id="scrapConfirm" data-bs-dismiss="modal">
        				<strong>확인</strong>
        			</button>
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
				location.href='${ contextPath }/deleteTip.bo?boardId=${ b.boardId }';
			});
			
			const loginUser = '${ loginUser.id }';
			const boardWriter = '${ b.userId }';
			

				replyLikeFunc();
				deleteReply();

			
			const loginUserId = document.getElementById('loginUserId').value;
			document.getElementById('replySubmit').addEventListener('click', ()=> {
				$.ajax({
					url : '${ contextPath }/insertReply.bo',
					data : {replyContent : document.getElementById('replyContent').value,
								boardId : ${ b.boardId }, userId : '${ loginUser.id }'},
								
					success : (data)=> {
						selectReply(data);

						replyLikeFunc();
						deleteReply();
					},
					
					error : (data)=> {
						console.log(data);
					}
				});
			});
			
			const isScrap = ${ scrapResult };
			if(loginUser != boardWriter) {
				showHide(isScrap);
			}
			
			if(loginUser != boardWriter) {
				document.getElementById('scrapBtn').addEventListener('click', function() {
				const bId = ${ b.boardId };
				const userId = '${ loginUser.id }';
				let isScrap = ${ scrapResult };
				
				$.ajax({
					url : '${ contextPath }/boardScrap.bo',
					data : {boardId : bId, userId : userId},
					success : (data)=> {
						console.log(data);
						
						document.getElementById('modalText').innerHTML = '스크랩되었습니다.<br> 마이페이지에서 스크랩한 게시물들을 확인 가능합니다.';
						$('#modalScrap').modal('show');
						isScrap = 1;
						showHide(isScrap);
							
					},
					error : (data)=> {
						console.log(data);
					}
				});
			});
			document.getElementById('scrapDeleteBtn').addEventListener('click', function() {
				const bId = ${ b.boardId };
				const userId = '${ loginUser.id }';
				let isScrap = ${ scrapResult };
				
				$.ajax({
					url : '${ contextPath }/deleteScrap.bo',
					data : {boardId : bId, userId : userId},
					success : (data)=> {
						console.log(data);
						document.getElementById('modalText').innerText = '스크랩이 취소되었습니다.';
						$('#modalScrap').modal('show');
						
						isScrap = 0;
						showHide(isScrap);
					},
					error : (data)=> {
						console.log(data);
					}
				});
			});
			}
			
			//window.onload 끝부분
			
			const declareBtn = document.getElementById('declareBtn');
			if(declareBtn != null) {
				declareBtn.addEventListener('click', function() {
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
			function deleteReply() {
				const deleteReplyIcon = document.getElementsByClassName('deleteReply');
				
				for(let i=0 ; i<deleteReplyIcon.length ; i++) {
					deleteReplyIcon[i].addEventListener('click', function() {
						const rId = this.previousElementSibling;
						$.ajax({
							url : '${ contextPath }/deleteReply.bo',
							data : {replyId : rId.value,
										boardId : ${ b.boardId }, userId : '${ loginUser.id }'},
										
							success : (data)=> {
								selectReply(data);
								replyLikeFunc();
								deleteReply();
							},
							
							error : (data)=> {
								console.log(data);
							}
						});
						
					});
				}
			}
			
			function selectReply(data) {
				console.log(data);					
				const replyArea = document.getElementById('replyListArea');
				const loginUserId = '${ loginUser.id }';
				replyArea.innerHTML = '';
				console.log(data.isReplyLikeList);
				
				for(let i=0 ; i<data.rList.length ; i++) {
					
					const row = document.createElement('div');
					row.className = 'row';
					row.style.marginBottom = '10px';
					row.style.borderBottom = '1px solid black';
					
					const divNickName = document.createElement('div');
					divNickName.className = 'col-2';
					divNickName.style.textAlign = 'center';
					divNickName.style.margin = 'auto';
					divNickName.id =  "nIndex" + i;
					divNickName.innerText = data.rList[i].nickName;
					
					const divContent = document.createElement('div');
					divContent.className = 'col-8';
					divContent.style.borderRight = '1px solid black';
					divContent.style.borderLeft = '1px solid black';
					divContent.id =  "replyContent" + i;
					divContent.innerText = data.rList[i].replyContent;
					
					const divOther = document.createElement('div');
					divOther.className = 'col-2';
					divOther.style.margin = 'auto';
					divOther.id = "otherIndex" + i;
					if(loginUserId != data.rList[i].userId) {
						if(data.isReplyLikeList[i] == 0) {
							divOther.innerHTML = '<i class="bi bi-hand-thumbs-up-fill likeIcon"  id="likeIcon' + i + '" style="margin-right :10px; color : #52cbffd3" ></i><span id="likeCount' + i + '">' + data.likeCountList[i] +
																	'<br></span><input type="hidden" id="isReplyLike' + i +  '" value="' + data.isReplyLikeList[i] + '"><input type="hidden" id="replyLike' + i + '" value="' + data.rList[i].replyId 
																	+ '">' + data.rList[i].createDate + '</div>';
						} else {
							divOther.innerHTML = '<i class="bi bi-hand-thumbs-up-fill likeIcon"  id="likeIcon' + i + '" style="margin-right :10px; background : #52cbffd3; color : white;" ></i><span id="likeCount' + i + '">' + data.likeCountList[i] +
																	'<br></span><input type="hidden" id="isReplyLike' + i +  '" value="' + data.isReplyLikeList[i] + '"><input type="hidden" id="replyLike' + i + '" value="' + data.rList[i].replyId 
																	+ '">' + data.rList[i].createDate + '</div>';
						}
					} else {
						if(data.isReplyLikeList[i] == 0) {
							divOther.innerHTML = '<i class="bi bi-hand-thumbs-up-fill "  id="likeIcon' + i + '" style="margin-right :10px; color : #52cbffd3" ></i><span id="likeCount' + i + '">' + data.likeCountList[i] +
																	'<br></span><input type="hidden" id="isReplyLike' + i +  '" value="' + data.isReplyLikeList[i] + '"><input type="hidden" id="replyLike' + i + '" value="' + data.rList[i].replyId 
																	+ '"><i class="bi bi-trash-fill deleteReply" style="border: 1px solid #52cbffd3; border-radius: 5px; background: #52cbffd3; color: white;">댓글 삭제</i><br><i class="bi bi-pencil"  id="contentIndex' + i + '" onclick="editReply(this);" style="border: 1px solid #52cbffd3; border-radius: 5px; background: #52cbffd3; color: white;">댓글 수정</i>' 
																	+ data.rList[i].createDate + '</div>';
						} else {
							divOther.innerHTML = '<i class="bi bi-hand-thumbs-up-fill "  id="likeIcon' + i + '" style="margin-right :10px; background : #52cbffd3; color : white;" ></i><span id="likeCount' + i + '">' + data.likeCountList[i] +
																	'<br></span><input type="hidden" id="isReplyLike' + i +  '" value="' + data.isReplyLikeList[i] + '"><input type="hidden" id="replyLike' + i + '" value="' + data.rList[i].replyId 
																	+ '"><i class="bi bi-trash-fill deleteReply" style="border: 1px solid #52cbffd3; border-radius: 5px; background: #52cbffd3; color: white;">댓글 삭제</i><br><i class="bi bi-pencil"  id="contentIndex' + i + '" onclick="editReply(this);" style="border: 1px solid #52cbffd3; border-radius: 5px; background: #52cbffd3; color: white;">댓글 수정</i>'
																	+ data.rList[i].createDate + '</div>';
						}
					}
					
					row.append(divNickName);										
					row.append(divContent);										
					row.append(divOther);				
					
					replyArea.append(row);
				}
				
				document.getElementById('replyContent').value = '';
			}
			
			function replyLikeFunc() {
				
				const likeIcon = document.getElementsByClassName('likeIcon');
				console.log(likeIcon);
				
				if(likeIcon != null) {
					for(let i=0 ; i<likeIcon.length ; i++) {
							const likeCount = likeIcon[i].nextElementSibling;
							const isReplyLike = likeCount.nextElementSibling;
							console.log(isReplyLike.value);
	 						const rIdInput = isReplyLike.nextElementSibling;
	 						const rId = rIdInput.value;
						likeIcon[i].addEventListener('click', function() {
							
							if(isReplyLike.value == 0) {
								$.ajax({
									url : '${ contextPath }/addReplyLike.bo',
									data : {replyId : rId, userId : '${ loginUser.id }'},
									success : (data)=> {
										console.log(data);
										this.style.background = '#52cbffd3';
										this.style.color = 'white';
										isReplyLike.value++;
										likeCount.innerHTML = data + '<br>';
									},
									error : (data)=> {
										console.log(data);
									}
								});
							} else {
								$.ajax({
									url : '${ contextPath }/deleteReplyLike.bo',
									data : {replyId : rId, userId : '${ loginUser.id }'},
									success : (data)=> {
										console.log(data);
										this.style.background = 'none';
										this.style.color = '#52cbffd3';
										isReplyLike.value--;
										likeCount.innerHTML = data + '<br>';
									},
									error : (data)=> {
										console.log(data);
									}
								});
							}
						});
					}
				}
			}
			
			function showHide(isScrap) {
				if(isScrap == 0) {
					document.getElementById('scrapBtn').style.visibility = 'visible';
					document.getElementById('scrapDeleteBtn').style.visibility = 'hidden';
				} else {
					document.getElementById('scrapBtn').style.visibility = 'hidden';
					document.getElementById('scrapDeleteBtn').style.visibility = 'visible';
					
				}
			}
			
			function editReply(icon) {
				console.log(icon);
				console.log(icon.id);
				const idx = icon.id.substring(icon.id.length-1, icon.id.length);
				console.log(idx);
				const preContent = document.getElementById('replyContent' + idx);
				console.log(preContent);
				const content = preContent.innerText;
				const rId = document.getElementById('replyLike' + idx).value;
				
				preContent.innerText = '';
				preContent.innerHTML = '<textarea class="form-control" rows="3" cols="50" id="editReplyContent">' + content + '</textarea>';
				
				const otherDiv = document.getElementById('otherIndex' + idx);
				otherDiv.innerText = '';
				otherDiv.innerHTML = '<button type="button" id= "editSubmit" class="btn btn-outline-info" style="height: 100%; width: 100%; ">작성하기</button>';
				
				document.getElementById('editSubmit').addEventListener('click', function() {
					
					const content = document.getElementById('editReplyContent').value;
					
					$.ajax({
						url : '${ contextPath }/editReply.bo',
						data : {replyId : rId, replyContent : content, boardId : ${b.boardId}, userId : '${ loginUser.id }'},
						success : (data)=> {
							selectReply(data);
							replyLikeFunc();
							deleteReply();
						},
						error : (data)=> {
							
						}
					});
				});
				
			}
			
			
  	</script> 
    
</body>
</html>
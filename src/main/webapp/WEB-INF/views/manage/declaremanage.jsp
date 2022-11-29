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
    <title>솔로던트 관리자페이지 - 신고관리</title>
    
    <style>
		.content_overflow{
		  overflow: hidden;
		  text-overflow: ellipsis;
		  display: -webkit-box;
		  -webkit-line-clamp: 1; /* 라인수 */
		  -webkit-box-orient: vertical;
		  word-wrap:break-word; 
		}
    </style>
</head>

<body>
  
	<jsp:include page="../home/menubar.jsp"/>
	<main id="main" style="margin-top: 100px;">
		<div class="container">
            <div class="row text-center mb-1 d-flex align-items-center" style="margin-top:50px;">
                <h1><strong>신고 관리 페이지</strong></h1>
	            <div class="text-center col-lg-6 align-content-center">
	                <h3>처리여부가 바뀌는 두 가지 경우</h3>
	                <ul style="list-style:none;">
	                    <li>1 . "신고당한 사용자"가 3번 이상의 신고를 당했음이 분명할 때</li>
	                    <li>2 . 관리자 재량으로 직접 선택하여 회원을 제명할 때</li>
	                </ul>
	            </div>
	            <div class="col-lg-6">
	            	<h3>신고사유 구분</h3>
	                <ul style="list-style:none;">
	                    <li>1 . 스팸홍보/도배글</li>
	                    <li>2 . 음란물</li>
	                    <li>3 . 욕설/생명경시/혐오/차별적 표현</li>
	                    <li>4 . 불쾌한 표현</li>
	                    <li>5 . 기타</li>
	                </ul>
	            </div>
            </div>
            <hr>
            <div style="box-shadow: 0 4px 16px rgb(0 0 0 / 10%); height: 100%; border-radius: 30px; overflow: hidden;">
            
            <table class="table table-striped m-2" style="table-layout:fixed; ">
                <thead>
                    <tr style="font-size:0.8rem; color:">
                    	<th scope="col">선택</th>
                        <th scope="col">신고<br>번호</th>
                        <th scope="col">신고한<br>사용자</th>
                        <th scope="col" style="font-weight:600; color:#0d6efd;">신고당한<br>사용자</th>

                        <th scope="col">게시판</th>
                        <th scope="col" class="col-lg-2">제목</th>
                        <th scope="col" class="col-lg-5" >내용</th>
                        <th scope="col">신고<br>사유</th>
                        <th scope="col">신고<br>일자</th>
                        <th scope="col">처리<br>여부</th>
                    </tr>
                </thead>
                <form id="selectMemberForm">
                <tbody>
                	<c:forEach items="${list}" var="list">
                    <tr>
                        <td><input type="checkbox" name="userId" value="${ list.whoIsDeclared }"></td>
                        <td>${ list.declareCode }</td>
                        <td>${ list.whoDeclare }</td>
                        <td style="font-weight:600; color:#0d6efd;">${ list.whoIsDeclared }</td>
                        <td>
	                        <c:if test="${ list.boardCode eq 1 }">자유</c:if>
	                        <c:if test="${ list.boardCode eq 2 }">중고</c:if>
	                        <c:if test="${ list.boardCode eq 3 }">꿀팁</c:if>
	                        <c:if test="${ list.boardCode eq 4 }">모임</c:if>
                        </td>
                        <td style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${ list.boardTitle }</td>
                        <td class="col-lg-3" style="overflow:hidden;white-space:nowrap;text-overflow:ellipsis;">${ list.boardContent }</td>
                        <td>${ list.declareType }</td>
                        <td>${ list.declareDate }</td>
                        <td>
	                        <c:if test="${ list.declareStatus eq Y }">O</c:if>
	                        <c:if test="${ list.declareStatus ne Y }">X</c:if>
						</td>
                    </tr>
                    </c:forEach>
                </tbody>
                </form>
            </table>
            </div>
            <br>
            <div class="row align-items">
                <div class="col"></div>
                <button onclick="deleteMember()" class="btn btn-sm btn-primary col-lg-1">선택 회원 제명</button>
                <div class="col-1"></div>
            </div>

        </div>
	
	</main>
	<a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
	<div id="preloader"></div>

	<script>
		function deleteMember(){
			// 버튼을 클릭하면 체크박스(checked) 속성을 post 방식으로 담아 deleteMember.mng 로 보낸다. 
			// 결과값이 redirect 된다
			
			const form = document.getElementById("selectMemberForm");
			console.log(form);
			
			form.target="_self";
			form.action="${contextPath}/deleteMember.mng";
			form.method="post";
			form.submit();
			
		}
	</script>

</body>
</html>
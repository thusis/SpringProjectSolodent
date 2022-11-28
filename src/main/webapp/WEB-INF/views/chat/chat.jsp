<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="${pageContext.request.contextPath}/resources/assets/css/chat.css" rel="stylesheet">
<c:forEach items="${messageList}" var="row">
	<c:if test="${receiveId eq row.sendId }">
		<div class="incoming_msg mt-5 mb-5">
			<div class="incoming_msg_img">
				${row.sendName}
				 <p>[${row.sendId}]</p>
			</div>
			<div class="received_msg">						
				<div class="received_withd_msg">				
				   <span class="time_date"> 
						<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd hh:mm:ss" />					 					
					</span>
					<p>${row.content}</p>					
					<span class="time_date"> 
						<c:choose>
							<c:when test="${row.readCnt==0}">
								읽지않음
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd hh:mm:ss" />	
							</c:otherwise>
						</c:choose>						 					
					</span>
				</div>
			</div>
		</div>
	</c:if>


	<c:if test="${ loginUser.id eq row.sendId }">

		<div class="outgoing_msg">
			<div class="sent_msg">
				   <span class="time_date"> 
						<fmt:formatDate value="${row.sendDate}" pattern="yyyy-MM-dd hh:mm:ss" />					 					
					</span>
				<p>${row.content}</p>
				<span class="time_date"> 
						<c:choose>
							<c:when test="${row.readCnt==0}">
								읽지않음
							</c:when>
							<c:otherwise>
								<fmt:formatDate value="${row.readDate}" pattern="yyyy-MM-dd hh:mm:ss" />	
							</c:otherwise>
						</c:choose>	
				</span>
			</div>
		</div>

	</c:if>


</c:forEach>







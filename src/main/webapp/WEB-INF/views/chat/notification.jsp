<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>	

	

 	<input type="hidden" id="notificationCnt" value="${notificationList.size()}">
	
	<c:if test="${not empty notificationList}">
	  <ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
	   <c:forEach items="${notificationList}" var="row">	  
	   	  <li><a class="dropdown-item" href="#">
	     	${row.sendName} : <span
	     	style="overflow: hidden; text-overflow: ellipsis; white-space: nowrap; max-width: 150px;display: inline-block;}" 
	     	>${fn:substring(row.content,0, 20)}</span>
	     	
	     	 <button class="btn btn-sm btn-info" onclick="chatModal('${row.sendId }')">채팅하기</button></a>
	   	  	</li>
	   </c:forEach>
    </ul>
   </c:if>
   
 

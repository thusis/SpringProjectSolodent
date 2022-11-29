<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:requestEncoding value="utf-8" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<!-- socket -->
<script
	src="${pageContext.request.contextPath }/resources/dist/sockjs.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<style>
/* .chatcontent {
	overflow: auto;
	height: 100%;
	position: relative;
}   */
.chat-containerK {
	/* overflow: hidden; */
	width : 100%;
	/* max-width : 200px; */
}
.chatcontent {
	height: 700px;
	width : 100%;
	/* width:300px; */
	overflow-y: scroll;
}
.chat-fix {
	position: fixed;
	bottom: 0;
	width: 100%;
}
#alertK{
	display : none;
}
#msgi{	
	resize: none;
}
.myChat{
	background-color : #E0B1D0;
	display:inline-block;
	/* position: absolute;*/  
	/* right: 0px; */
	/* float: right; */
	 max-width : 200px;  
	/* width : 100%; */
}
li{
	list-style-type:none;
}
.chatBox{
	display : inline-block;
}
.chatBox dateK{
vertical-align: text-bottom;
} 
.me{
	text-align : right;
	/* text-align:center; */
}
.otherChat{
	max-width : 200px;
}
</style>

<div id="chat-containerK" class="border border-secondary">

	<div class="chatWrap">
		<div class="content chatcontent " data-room-no="${roomNo}"
			data-member="${loginMember}">
			<div id="list-guestbook" class="">
				<c:forEach items="${firstList}" var="chat">
					<!-- 내 채팅일 경우 -->
					<c:if test="${loginMember.memberId eq chat.memberId}">
				
					<li data-no="${chat.no}" class="me pr-2">
					<strong class="">${chat.memberId}</strong>
					<div class="me ">
					
					<strong style="display : inline;" class="align-self-end"><fmt:formatDate value="${chat.sendDate }" pattern="yy/MM/dd HH:mm" /></strong>
					
					</div>
					</li>
					
					</c:if>
					<!-- 다른사람의 채팅일 경우 -->
					<c:if test="${loginMember.memberId ne chat.memberId}">
			
					<li data-no="${chat.no}" class="pl-2">
					<strong>${chat.memberId}</strong>
					<div class="row ml-0">
					<p class="otherChat bg-light p-2">${chat.chatContent }</p> 
					<strong class="align-self-center"><fmt:formatDate value="${chat.sendDate }" pattern="yy/MM/dd HH:mm" />
					
					</div></li>
					</c:if>
				</c:forEach>
			</div>
			
		</div>
		<div class="chat-fixK">
			<div id="alertK" onclick="moveDown();" class="alert alert-success" role="alert">
				<strong></strong> 
			</div>
			<div class="fix_btn row">
				<textarea name="msg" id="msgi" rows="2" class="form-control col-sm-8"></textarea>
				<!-- <input type="text" id="msgi" name="msg" placeholder="메세지를 입력하세요" /> -->
				<button type="button"  class="send col-sm-4 btn btn-secondary">보내기</button>
			</div>
		</div>

	</div>
</div>
<script>
var client;
//채팅 저장
function insertChat(){
	$.ajax({
		url : "${pageContext.request.contextPath}/chat/insertChat.do",
		type : "POST",
		data :
			{
				memberId : "${loginMember.memberId}",
				srNo : "${roomNo}",
				chatContent : $("#msgi").val()
						
			} ,
		dataType : "json",
		success : function(result) {
			sendmsg();
		},
		error : function(xhr, status, err) {
			console.log("처리실패!");
			console.log(xhr);
			console.log(status);
			console.log(err);
		}
	});
}
//생성된 메시지로 가기
function moveDown(){
	$(".chatcontent").scrollTop($(".chatcontent")[0].scrollHeight);
	$('#alertK').css('display','none');
	
}


		// 채팅리스트 불러오기
		var endNo = $("#list-guestbook li").first().data("no") || 0;
		console.log("endNo" + endNo);
		$.ajax({
			url : "${pageContext.request.contextPath}/chat/chatList.do?endNo="
					+ endNo + "&roomNo=${roomNo}",
			type : "GET",
			dataType : "json",
			success : function(result) {
				var length = result.size;
				if (length < 10) {
					isEnd = true;
				}
				$.each(result, function(index, vo) {
					var html = renderList(vo,0);
					$("#list-guestbook").prepend(html);
				})
				var position = $('[data-no='+endNo+']').prev().offset();//위치값
				console.log(position);
				document.querySelector('.chatcontent').scrollTo({top : position.top,behavior : 'auto'});
				isScrolled = false;
			},
			error : function(xhr, status, err) {
				console.log("처리실패!");
				console.log(xhr);
				console.log(status);
				console.log(err);
			}
		});
	}
	var renderList = function(vo,endNo) {
		// 리스트 html을 정의
		var date = moment(vo.sendDate).format('YY/MM/DD HH:mm');
		var html = "";
		if(endNo==0) endNo = vo.no;
		
		//내가 보낸 채팅일 경우
		if(vo.memberId=="${loginMember.memberId}"){
		
		html = 	"<li class='me pr-2' data-no='"+ endNo +"'>"
				+ "<strong>" + vo.memberId + "</strong>"
				+"<div class='me'>"
				+ "<strong style='display : inline;' class='align-self-end'>" + date + "</strong>"
				+ content
				+"</div>"
				+ "</li>";
		
		}
		//남이 보낸 채팅일 경우
		else{
			var content ="";
			html = "<li class='pl-2' data-no='"+ vo.no +"'>"
				+ "<strong>" + vo.memberId + "</strong>"
				+"<div class='row ml-0'>"
				+ content
				+ "<strong class='align-self-center'>" + date + "<a href='#' class='reportModalK'>"+report+"</a></strong>"
				+"</div>"
				+ "</li>";
		
		}
		return html;
			
		
	}
	////////////////////socket
	//새로운 메시지 알림
	function newAlerts(content,endNo) {
		$('#alertK').css('display','block');
		$('#alertK').html("<strong>"+content.memberId+"</strong>님이 메시지를 보냈습니다.");
	}
	
	$(function() {
		var chatBox = $('.box');
		var messageInput = $('textarea[name="msg"]');
		var roomNo = "${roomNo}";
		var member = $('.content').data('member');
		var sock = new SockJS(
				"${pageContext.request.contextPath}/endpoint");
		client = Stomp.over(sock);
		function sendmsg() {
			var message = messageInput.val();
			//alert("메시지"+message);
			if (message == "") {
				return false;
			}
			//insertChat();
			client.send('/app/hello/' + roomNo, {}, JSON
					.stringify({
						chatContent : message,
						memberId : "${loginMember.memberId}",
						srNo : "${roomNo}"
					}));
			messageInput.val('');
		}
		client.connect({},function() {
			//일반메세지 들어오는곳         
			client.subscribe('/subscribe/chat/'+ roomNo,function(chat) {
				//받은 데이터
				var content = JSON.parse(chat.body);
				var endNo = content.no;
				/*var endNo = $("#list-guestbook li").last().data("no");
				if(isNaN(endNo))
					endNo = 1;
				else
					endNo = endNo+1;
				*/
				var html = renderList(content,endNo);
				$("#list-guestbook").append(html);
				newAlerts(content,endNo);
								
				});
		//대화시
		 $('.send').click(function() {
			sendmsg();
		}); 
		//채팅창 나가기
		function disconnect() {
			if (client != null) {
				client.disconnect();
			}
		}
		window.onbeforeunload = function(e) {
			disconnect();
		}
		function closeConnection() {
			sock.close();
		}
		function viewList() {
			alert('viewList');
			var url = "/chat/chatList?page=" + page
					+ "&perPageNum=" + perPageNum;
			location.replace(url);
		}
	});
});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

        <!-- Modal -->
<div class="modal fade" id="chatModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="false" data-backdrop="static">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content" >
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">판매자 채팅</h5>
        <div style="    position: absolute;right: 102px;">
        <button type="button" class="btn bnt-sm btn-danger" onclick="endChat()"	style="padding: 5px;font-size: 12px;">대화방 나가기</button>
        </div>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
	<div class="container">
		<input  type="hidden" name="receiveId"  id ="receiveId" >	
		<!-- <h3 class=" text-center">채팅</h3> -->
		<div class="messaging">
			<div class="inbox_msg">
	
				<div class="mesgs">
					<div class="msg_history">
					
					
					
					
					
					<span></span>
					
					</div>
					<div class="type_msg">
						<div class="input_msg_write">
							<input type="text" class="write_msg" placeholder="메시지 보내기" />
							<button class="msg_send_btn" type="button" id="msg_send_btn"  onclick="messageSend()">
								<i class="fa fa-paper-plane-o" aria-hidden="true"></i>
							</button>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
	    
      </div>
    </div>
  </div>
</div>
 

  
<script type="text/javascript">
let messageInterval;
function chatModal(receivedId){	
	console.log("receivedId : ", receivedId);	
	messageList(receivedId);	
	
	$("#chatModal").modal("show");			
	
	messageInterval=setInterval(function(){
		messageList(receivedId);		
	}, 1);
	
	//알림 메시지 갱신 처리
	notificationList();
}

$(".msg_history").scrollTop($(".msg_history")[0].scrollHeight);
$(function(){	
	
	$("#chatModal").modal({backdrop:'static'});
	
	$(".write_msg").on("keyup", function(event){
		if(event.keyCode===13){
			 messageSend();
		}
	});
	
	$("#chatModal").on("click", function(e){
		e.preventDefault();
		const dispaly =$("#chatModal").css("display");	
		//메시지 갱신 종료
		//clearTimeout(messageInterval);		
	})
	
	$("#chatModal .btn-close").on("click", function(e){
		console.log(" 메시지 갱신 종료");
		//메시지 갱신 종료
		clearTimeout(messageInterval);		
	})
	
});

function messageList(receivedId){
	const home=$("#home").val();	
	$.ajax({
		url:home+"/chat/messageList.do",
		type:"GET",
		data:{receivedId},
		success:function(res){
			$("#receiveId").val(receivedId);
			$("#chatModal .msg_history").html(res);								
			$(".msg_history").scrollTop($(".msg_history")[0].scrollHeight);
		},
		error:function(error){
			console.log("에러 : ",error);
		}		
	});
}

function messageSend(){
	const home=$("#home").val();
	const receivedId=$("#receiveId").val();
	const content=$(".write_msg").val();
	if(!content){
		alert("내용을 입력해 주세요.");
		$(".write_msg").focus();
		return;
	}
	
	$.ajax({
		url:home+"/chat/send.do",
		type:"post",
		data:{
			receivedId, content
		},
		success:function(res){	
			messageList(receivedId);
			$(".msg_history").scrollTop($(".msg_history")[0].scrollHeight);
			$(".write_msg").val("");
		},
		error:function(error){
			console.log("에러 : ",error);
		}		
	});
	
}

function endChat(){
	if(confirm("정말 대화방을 나가시겠습니까?")){
		const home=$("#home").val();
		const receivedId=$("#receiveId").val();
		$.ajax({
			url:home+"/chat/endChat.do",
			type:"post",
			data:{
				receivedId
			},
			success:function(res){
				console.log(res);
				if(res=="success"){
					$("#chatModal .btn-close").click();
					$("#chatModal").modal("hide");
				}				
			},
			error:function(error){
				console.log("에러 : ",error);
			}		
		});

	}


}
</script>    
    
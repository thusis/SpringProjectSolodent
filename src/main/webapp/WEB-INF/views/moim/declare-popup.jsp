<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <div class="header text-center justify-content-md-between" >
            <br><h1>신고하기</h1>
        </div>
        
        <div class="container">
            <form action="${contextPath}/declare.moim" method="post"></form>
            <div class="boardInfo" style="margin:30px;">
                <span hidden id="bId">boardId</span>
                <h5>작성자 : 김어쩌구</h5><input type="hidden" name="user_id" value="userId">
                <h5>글 제목 : 커피가 어쩌구 </h5><input type="hidden" name="declare_to" value="boardId">
            </div>
            <hr>
            <div class="declareReason" style="margin:50px;">
                <strong>신고 사유</strong>

                <div><input type="radio" name="declare_content" id="1" value="1" class="declareReason">
                <label for="1">스팸홍보/도배글입니다.</label></div>
                
                <div><input type="radio" name="declare_content" id="2"  value="2" class="declareReason">
                <label for="2">음란물입니다</label></div>
                
                <div><input type="radio" name="declare_content" id="3"  value="3" class="declareReason">
                <label for="3">욕설/생명경시/혐오/차별적 표현입니다</label></div>
                
                <div><input type="radio" name="declare_content" id="4"  value="4" class="declareReason">
                <label for="4">불쾌한 표현이 있습니다</label></div>
                
                <div><input type="radio" name="declare_content" id="5"  value="5" class="declareReason">
                <label for="5">기타</label></div>
            </div>
            <hr>
            <div class="footer justify-content-md-between text-end">
                <button id="submitDeclare" class="btn btn-lg btn-primary" style="color:white;">
                    신고하기
                </button>
            </div>
        </div>



</body>
</html>
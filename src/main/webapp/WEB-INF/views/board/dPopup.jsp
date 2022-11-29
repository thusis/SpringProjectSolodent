<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
</head>
<body>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
   <div class="header text-center justify-content-md-between" >
            <br><h1>신고하기</h1>
        </div>
        
        
        <div class="container">
            <form action="${contextPath}/insertDeclare.bo" method="post" id="goToDeclare">
               <div class="boardInfo" style="margin:30px;">
                   <h5>작성자 : ${ boardWriter }</h5>
                   <h5>글 제목 : ${ boardTitle }</h5>
                   <input type="hidden" name="userId" value="${ loginUser }">
                   <input type="hidden" name="declareTo" value="${ boardId }">
               </div>
               <hr>
               <div class="declareReason" style="margin:50px;">
                   <strong>신고 사유</strong>
   
                   <div><input type="radio" name="declareType" id="1" value="1" class="declareReason">
                   <label for="1">스팸홍보/도배글입니다.</label></div>
                   
                   <div><input type="radio" name="declareType" id="2"  value="2" class="declareReason">
                   <label for="2">음란물입니다</label></div>
                   
                   <div><input type="radio" name="declareType" id="3"  value="3" class="declareReason">
                   <label for="3">욕설/생명경시/혐오/차별적 표현입니다</label></div>
                   
                   <div><input type="radio" name="declareType" id="4"  value="4" class="declareReason">
                   <label for="4">불쾌한 표현이 있습니다</label></div>
                   
                   <div><input type="radio" name="declareType" id="5"  value="5" class="declareReason">
                   <label for="5">기타</label></div>
               </div>
               <hr>
               <div class="footer justify-content-md-between text-end">
                  <input type="button" value="신고하지 않고 닫기" class="btn" onclick="self.close();"/>
                  <button type="submit" class="btn">신고하기</button>
               </div>
         </form>
         
        </div>
        
<!--     <script> -->

<!--    </script> -->
        



</body>
</html>
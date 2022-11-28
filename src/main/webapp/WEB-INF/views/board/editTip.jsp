<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.delIcon{
		font-size: 30px;
		color: black;
	}
	
	.delIcon:hover{
		cursor: pointer;
	}
</style>

</head>
<body>
	<jsp:include page="../home/menubar.jsp"/>
	<input type="hidden" id="aLength" value="${ fn:length(aList) }">
	<!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>글 수정</h2>
        </div>

            <form action="${ contextPath }/updateTip.bo" method="post" enctype="multipart/form-data" class="php-email-form" id="usedForm">
        <div class="row gx-lg-0 gy-4">

          <div class="col-lg-4">

            <div class="info-container d-flex flex-column align-items-center justify-content-center" id="previewImage">
            	<c:forEach items="${ aList }" var="a"  varStatus="status">
            		<img class="img-fluid rounded-4" id="preview-image${status.index + 1 }"  src="${ contextPath }/resources/uploadFiles/${ a.rename }">
            		<i class="bi bi-file-x delIcon" name="delIcon" id="delIcon${ status.index + 1 }"></i>
            		<input type="hidden" value="${ a.rename }_${ a.isThum }"  id="atVal">
            		<input type="hidden" name="deleteAttm" >
            		
            		<br>
            	</c:forEach>
            </div>

          </div>

          <div class="col-lg-8" style="padding-left: 15px;">
            <input type="hidden"  name="boardId" value="${ b.boardId }">
        
              <div class="row">
                <div class="container">
							
				          	<div class="container d-flex justify-content-end">
				          		<select class="form-select d-flex" aria-label="Default select example" style="width:  150px;" name="tipCate">
						          <option value="취미/여가" <c:if test="${ t.tipCate eq '취미/여가' }">selected</c:if>>취미/여가</option>
						          <option value="요리" <c:if test="${ t.tipCate eq '요리' }">selected</c:if>>요리</option>
						          <option value="쇼핑" <c:if test="${ t.tipCate eq '쇼핑' }">selected</c:if>>쇼핑</option>
						          <option value="부동산" <c:if test="${ t.tipCate eq '부동산' }">selected</c:if>>부동산</option>
						        </select>
						     </div>    
				          </div>
              </div>
	              <div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">제목</label>
					<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="제목" name="boardTitle" value="${ b.boardTitle }">
				</div>
				<div class="mb-3">
					<label for="exampleFormControlTextarea1" class="form-label">내용</label>
					<textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="boardContent">${ b.boardContent }</textarea>
				</div>
				<div class="mb-3">
					 <button type="button" class="btn btn-primary btn-sm" id="addFile" style="padding: 10px;">파일 추가</button>
				</div>
				<div id="fileArea">
					<div class="mb-3"  style="height: 35px;">
					</div>
					<c:forEach items="${ aList }" var="a" varStatus="status">
						<div class="mb-3">
							<input class="form-control myFiles" type="file" name="file" id="file${ status.index + 1 }" style="display: none;" accept="image/*">
						</div>
					</c:forEach>
				</div>
				<div class="d-flex justify-content-end">
					<button type="button" class="btn btn-primary btn-sm m-2" id="submitBtn">수정하기</button>
					<button type="button" class="btn btn-secondary btn-sm m-2" onclick="javascript:history.back();">뒤로가기</button>
				</div>
          </div><!-- End Contact Form -->
        </div>
            </form>
      </div>
    </section><!-- End Contact Section -->
    
    <script type="text/javascript">
    $(function() {
    	
    	 const fileArea = document.querySelector('#fileArea');
    	 let count = document.getElementById('aLength').value;
    	    document.getElementById('addFile').addEventListener('click', ()=> {
    	    	count++;
    	    	const newDiv = document.createElement('div');
    			newDiv.classList.add('mb-3');
    			newDiv.innerHTML = '<input class="form-control myFiles" type="file"  name="file" id="file' + count +'" style="display: none" accept="image/*">';
    			fileArea.append(newDiv);
    			$('#file' + count).click();
    			
    			const imgDiv = document.getElementById('previewImage');
    			imgDiv.innerHTML += '<img class="img-fluid rounded-4" id="preview-image' + count + '">';
    			$('#file' + count).on('change', e=> {
    				if(window.FileReader) {
    					imgDiv.innerHTML += '<i class="bi bi-file-x delIcon" name="delIcon" id="delIcon' + count + '"></i><br>';
    					readImage(e.target, count);
    				}
    			});
    	    });
    	    
    	    const form = document.getElementById('usedForm');
    	    document.getElementById('submitBtn').addEventListener('click', ()=> {
    	    	form.submit();
    	    });
    	    
    	    const arr = document.getElementsByClassName('delIcon');
			console.log(arr);
            
            if(arr != null) {
            	for(const i of arr) {
            		i.addEventListener('click', function() {
            			const idValue = $(this).attr("id");
            			const num = idValue.substr(-1);
            			console.log(num);
            			
            			const atVal = this.nextElementSibling;
            			const deleteAttm = atVal.nextElementSibling;
            			deleteAttm.value = atVal.value;
            			
            			console.log(deleteAttm);
            			
            			$('#preview-image' + num).remove();
            			$('#delIcon' + num).remove();
            			$('#file' + num).remove();
            		});
            	}
            }
    	});
    

	    function readImage(input, count) {
	        // 인풋 태그에 파일이 있는 경우
	        if(input.files && input.files[0]) {
	    	console.log(count);
	            // 이미지 파일인지 검사 (생략)
	            // FileReader 인스턴스 생성
	            const reader = new FileReader();
	            // 이미지가 로드가 된 경우
	            reader.onload = e => {
						const img = document.getElementById('preview-image' + count);
						img.src = e.target.result;
						console.log(img);
	
						
	            }
	            // reader가 이미지 읽도록 하기
	            reader.readAsDataURL(input.files[0]);
	            
	            const arr = document.getElementsByClassName('delIcon');
				console.log(arr);
	            
	            if(arr != null) {
	            	for(const i of arr) {
	            		i.addEventListener('click', function() {
	            			const idValue = $(this).attr("id");
	            			const num = idValue.substr(-1);
	            			console.log(num);
	            			
	      					
	            			
	            			$('#preview-image' + num).remove();
	            			$('#delIcon' + num).remove();
	            			$('#file' + num).remove();
	            		});
	            	}
	            }
	        }
	    }
    
	   
    </script>
</body>
</html>
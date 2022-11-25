<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
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
	<c:set var="uSido" value="${ fn:split(u.local, ' ')[0] }"></c:set>
	<c:set var="uGugun" value="${ fn:split(u.local, ' ')[1] }"></c:set>
	<input type="hidden" id="aLength" value="${ fn:length(aList) }">
	<!-- ======= Contact Section ======= -->
    <section id="contact" class="contact">
      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>글 수정</h2>
        </div>

            <form action="${ contextPath }/updateItem.bo" method="post" enctype="multipart/form-data" class="php-email-form" id="usedForm">
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
				          		<select class="form-select d-flex" aria-label="Default select example" style="width:  150px; margin-right: 10px;" name="sido1" id="sido1">
						          
						        </select>
				          		<select class="form-select d-flex" aria-label="Default select example" style="width:  150px; margin-right: 10px;" name="gugun1" id="gugun1">
						          
						        </select>
						        <select class="form-select d-flex" aria-label="Default select example" style="width:  150px;" name="productCate">
						          <option value="디지털/가전"  <c:if test="${ u.productCate eq  '디지털/가전' }">selected</c:if>>디지털/가전</option>
						          <option value="의류" <c:if test="${ u.productCate eq  '의류' }">selected</c:if>>의류</option>
						          <option value="액세서리" <c:if test="${ u.productCate eq  '액세서리' }">selected</c:if>>액세서리</option>
						          <option value="스포츠/레저" <c:if test="${ u.productCate eq  '스포츠/레저' }">selected</c:if>>스포츠/레저</option>
						          <option value="도서/문구" <c:if test="${ u.productCate eq  '도서/문구' }">selected</c:if>>도서/문구</option>
						          <option value="생활/식품" <c:if test="${ u.productCate eq  '생활/식품' }">selected</c:if>>생활/식품</option>
						        </select>
						     </div>    
				          </div>
              </div>
	              <div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label" >가격</label>
					<input type="text" class="form-control" id="exampleFormControlInput1" name="price"  style="width: 50%;" onkeyup="inputNumberFormat(this);" value="${ u.price }">
				</div>
	              <div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label">상품명</label>
					<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="상품명" name="boardTitle" value="${ b.boardTitle }">
				</div>
				<div class="mb-3">
					<label for="exampleFormControlTextarea1" class="form-label">물품 상세내용</label>
					<textarea class="form-control" id="exampleFormControlTextarea1" rows="10" name="boardContent">${ b.boardContent }</textarea>
				</div>
				<div class="mb-3">
					 <label for="formFile" class="form-label">상품 사진</label>
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
    	
    	 var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
    	  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
    	   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
    	   var area3 = ["대덕구","동구","서구","유성구","중구"];
    	   var area4 = ["광산구","남구","동구","북구","서구"];
    	   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
    	   var area6 = ["남구","동구","북구","중구","울주군"];
    	   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
    	   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
    	   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
    	   var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
    	   var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
    	   var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
    	   var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
    	   var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
    	   var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
    	   var area16 = ["서귀포시","제주시","남제주군","북제주군"];

    	 // 시/도 선택 박스 초기화
    	 $("select[name^=sido]").each(function() {
    	  $selsido = $(this);
    	  $.each(eval(area0), function() {
//     	   $selsido.append("<option value='"+this+"'>"+this+"</option>");
				if('${ uSido }' == this) {
    	   $selsido.append("<option value='"+this+"' selected>"+this+"</option>");
				} else {
    	   $selsido.append("<option value='"+this+"'>"+this+"</option>");
				}
    	  });
    	  $selsido.next().append("<option value=''>구/군 선택</option>");
    	  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
    	  var $gugun = $(this).next(); // 선택영역 군구 객체
    	  $.each(eval(area), function() {
    		 if('${ uGugun }' == this) {
    	    	$gugun.append("<option value='"+this+"' selected>"+this+"</option>");
    		 } else {
    	    	$gugun.append("<option value='"+this+"'>"+this+"</option>");
    		 } 
    	  });
    	 });

    	 // 시/도 선택시 구/군 설정
    	 $("select[name^=sido]").change(function() {
    	  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
    	  console.log(area);
    	  var $gugun = $(this).next(); // 선택영역 군구 객체
    	  $("option",$gugun).remove(); // 구군 초기화

    	  if(area == "area0")
    	   $gugun.append("<option value=''>구/군 선택</option>");
    	  else {
    	   $.each(eval(area), function() {
    	    	$gugun.append("<option value='"+this+"'>"+this+"</option>");
    	   });
    	  }
    	 });

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
    
	    function comma(str) {
	        str = String(str);
	        return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	    }
	
	    function uncomma(str) {
	        str = String(str);
	        return str.replace(/[^\d]+/g, '');
	    } 
	    
	    function inputNumberFormat(obj) {
	        obj.value = comma(uncomma(obj.value));
	    }
	    
	    function inputOnlyNumberFormat(obj) {
	        obj.value = onlynumber(uncomma(obj.value));
	    }
	    
	    function onlynumber(str) {
		    str = String(str);
		    return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g,'$1');
		}
    </script>
</body>
</html>
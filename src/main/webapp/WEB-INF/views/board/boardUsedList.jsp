<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery menubar.jsp 에 있어서 지워도 될 것 같아요. -->
<style type="text/css">
	#listCard:hover {
		cursor: pointer;
	}
</style>
</head>
<body>
	<jsp:include page="../home/menubar.jsp"/>
	
	<!-- ======= Portfolio Section ======= -->
    <section id="portfolio" class="portfolio sections-bg" style="margin-top: 70px;">
      <div class="container" data-aos="fade-up">

        <div class="section-header">
          <h2>중고거래</h2>
          	<button type="button" class="btn btn-primary btn-lg" onclick="location.href='${ contextPath }/enrollUsed.bo'">중고 등록하기</button>
          	
        </div>

		<div class="container">
			<div class="row row-cols-auto justify-content-end pb-4">
		          <select class="form-select d-flex" aria-label="Default select example" style="width:  150px; margin-right: 10px;" name="sido1" id="sido1"></select>
		          <select class="form-select d-flex" aria-label="Default select example" style="width:  150px; margin-right: 10px;" name="gugun1" id="gugun1"> </select>
	          <div class="col">
				<select class="form-select d-flex" aria-label="Default select example" style="width:  150px;" name="productCate" id="category">
					<option value="">카테고리 선택</option>
					<option value="디지털/가전" >디지털/가전</option>
					<option value="의류">의류</option>
					<option value="액세서리">액세서리</option>
					<option value="스포츠/레저">스포츠/레저</option>
					<option value="도서/문구">도서/문구</option>
					<option value="생활/식품">생활/식품</option>
				</select>
	          </div>
				<select class="form-select d-flex" aria-label="Default select example" style="width:  150px;" name="titleOrContent" id="titleOrContent">
					<option value="">검색 분류</option>
					<option value="boardTitle">제목</option>
					<option value="boardContent">내용</option>
				</select>
	          <div class="col pt-1">
	          	<input type="text" style="width: 300px" id="searchWord" placeholder="검색할 단어 입력">
	          </div>
	          <div class="col pt-1">
	          	<i class="bi bi-search" id="searchUsedIcon"></i>
	          </div>
          	</div>
          </div>
          <div class="row gy-4">
          <c:forEach items="${ bList }" var="b">
	                		<c:if test="${ b.status eq 'Y' }">
            <div class="col-xl-4 col-md-6">
              <div class="portfolio-wrap card" id="listCard">
		          <input type="hidden" name="boardId" class="bId" value="${ b.boardId }">
		          <input type="hidden" name="userId" class="uId" value="${ b.userId }">
	                <c:forEach items="${ aList }" var="a">
	                	<c:if test="${ b.boardId eq  a.boardId}">
			                	<div class="m-4 color-secondary">
			                		<img src="${ contextPath }/resources/uploadFiles/${ a.rename }" class="img-fluid" alt="" style="width: 370px; height: 200px; ">
		                		</div>
                		</c:if>
                	</c:forEach>
                <div class="portfolio-info">
	                <c:forEach items="${ uList }" var="u">
	                <c:if test="${ b.boardId eq u.boardId }">
	                  <h4 class="text-truncate" style="width: 400px;">${ b.boardTitle }</h4><!-- 물건 타이틀 -->
	                  <p class="pb-2 text-truncate" style="width: 400px;">${ b.boardContent }</p><!-- 물건 내용 -->
	                  <div class="container">
	                  	<div class="row">
	                  		<div class="col text-start text-white">${ u.price }원</div>
	                  		<div class="col text-end">${ u.local }</div>
	                  	</div>
	                  	
	                  </div>
	                  </c:if>
	                  </c:forEach>
                </div>
              </div>
            </div><!-- End Portfolio Item -->
                	</c:if>
            </c:forEach>
          </div><!-- End Portfolio Container -->

        </div>

<!--       </div> -->
    </section><!-- End Portfolio Section -->
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
    		  if(this == '시/도 선택') {
    	   $selsido.append("<option value=''>"+this+"</option>");
    		  } else {
    	   $selsido.append("<option value='"+this+"'>"+this+"</option>");
    		  }
    	  });
    	  $selsido.next().append("<option value=''>구/군 선택</option>");
    	 });

    	 // 시/도 선택시 구/군 설정
    	 $("select[name^=sido]").change(function() {
    	  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
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
 
    	 const dives = document.getElementsByClassName('card');
    	 for(const div of dives) {
    		 div.addEventListener('click', function() {
    			 const boardId = this.querySelector('.bId').value;
    			 const writer = this.querySelector('.uId').value;
    			 console.log(boardId);
    			 console.log(writer);
    			 location.href = '${ contextPath }/selectUsed.bo?bId=' + boardId + '&writer=' + writer;
    		 });
    	 }
    	 
    	 const searchIcon = document.getElementById('searchUsedIcon');
    	 searchIcon.addEventListener('click', ()=> {
    		 const sido = document.getElementById('sido1');
    		 const gugun = document.getElementById('gugun1');
    		 const category = document.getElementById('category').value;
    		 const titleOrContent = document.getElementById('titleOrContent').value;
    		 const word = document.getElementById('searchWord').value;
    		 
    		 console.log(sido.value);
    		 console.log(gugun.value);
    		 console.log(category.value);
    		 console.log(word.value);
    		 
    		 let local = "";
    		 if(sido.value != '' && gugun.value != '') {
    			 local = sido.value + "+" + gugun.value;
    		 }
    		 
    		 let paramStr = '?';

    		 if(local != '' && local != ' ') {
    			 paramStr = paramStr + 'local=' + local;
    		 }
    		 if(category != '') {
    			 paramStr = paramStr + '&category=' + category;
    		 }
    		 if(titleOrContent != '' && word.trim() != '') {
    			 if(titleOrContent == 'boardTitle') {
    				 paramStr = paramStr + '&searchWhere=' + titleOrContent + '&word=' + word;
    			 } else {
    				 paramStr = paramStr + '&searchWhere=' + titleOrContent + '&word=' + word;
    			 }
    		 }
    		 
    		 if(paramStr != '?') {
    		 location.href='${ contextPath }/searchUsed.bo' + paramStr;
    		 }
    	 });
    	});

    </script>
</body>
</html>
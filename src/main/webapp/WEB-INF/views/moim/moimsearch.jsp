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

    <title>솔로던트 모임게시판 - 검색 </title>
</head>

<body>
  
	<jsp:include page="../home/menubar.jsp"/>
    <main id="main" style="margin-top: 100px;">
    	
	    <div class="container">
    
    	<div style="height:120px;" class="row bn_txt_strong text-center align-items-center"> <h2><b>${str}</b>에 대한 검색 결과입니다 😀 </h2></div>
        <hr>
        <form action="${contextPath }/search.moim" method="post">
	        <div class="form-check form-switch">
	            <input class="form-check-input" type="checkbox" id="selectOngoing" name="moimStatus">
	            <label class="form-check-label" for="selectOngoing">모집중인 글만 보기</label>
	        </div>
			<br>
	        <div class="row align-items-center">
	            <div class="col-lg-2 bn_txt_strong ">모임분류</div>
	            <div class="col">
                         <div class="form-check form-check-inline">
                             <input class="form-check-input" type="checkbox" name="moimCategory" id="dongari" value="동아리">
                             <label class="form-check-label" for="dongari">동아리</label>
                         </div>
                         <div class="form-check form-check-inline">
                             <input class="form-check-input" type="checkbox" name="moimCategory" id="gongmojeon" value="공모전">
                             <label class="form-check-label" for="gongmojeon">공모전</label>
                         </div>
                         <div class="form-check form-check-inline">
                             <input class="form-check-input" type="checkbox" name="moimCategory" id="hobby" value="취미활동">
                             <label class="form-check-label" for="hobby">취미활동</label>
                         </div>
                         <div class="form-check form-check-inline">
                             <input class="form-check-input" type="checkbox" name="moimCategory" id="jagigebal" value="자기개발">
                             <label class="form-check-label" for="jagigebal">자기개발</label>
                         </div>
                         <div class="form-check form-check-inline">
                             <input class="form-check-input" type="checkbox" name="moimCategory" id="etc" value="기타">
                             <label class="form-check-label" for="etc">기타</label>
                         </div>
	            </div>
	            <div class="col"></div>
      	  	</div>
     		<br>
        <div class="row align-items-center">
            <div class="col-lg-2 bn_txt_strong ">모임지역</div>
            <div class="col-lg-8">
            	<!-- 지역구분 -->
            	<select name="sido1" id="sido1"></select><select name="gugun1" id="gugun1"></select>

	            <script>
	                $('document').ready(function() {
	                    var area0 = ["시/도 선택","전체","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
	                    var area1 = ["전체"];
	                    var area2 = ["전체","강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
	                    var area3 = ["전체","계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
	                    var area4 = ["전체","대덕구","동구","서구","유성구","중구"];
	                    var area5 = ["전체","광산구","남구","동구",     "북구","서구"];
	                    var area6 = ["전체","남구","달서구","동구","북구","서구","수성구","중구","달성군"];
	                    var area7 = ["전체","남구","동구","북구","중구","울주군"];
	                    var area8 = ["전체","강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
	                    var area9 = ["전체","고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
	                    var area10 = ["전체","강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
	                    var area11 = ["전체","제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
	                    var area12 = ["전체","계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
	                    var area13 = ["전체","군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
	                    var area14 = ["전체","광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
	                    var area15 = ["전체","경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
	                    var area16 = ["전체","거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
	                    var area17 = ["전체","서귀포시","제주시","남제주군","북제주군"];
	         
	                    // 시/도 선택 박스 초기화
	                    $("select[name^=sido]").each(function() {
	                    $selsido = $(this);
	                    $.each(eval(area0), function() {
	                            $selsido.append("<option value='"+this+"'>"+this+"</option>");
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
	                });
	            </script>
            </div>  
        </div>
        <br>
        <div class="row align-items-center">
            <div class="col-lg-2 bn_txt_strong">
            찾을 내용 검색
            </div>
            <div class="col-lg">
					<select class="col-lg" name="selectOption">
						<option value="title">제목</option>
						<option value="content">내용</option>
						<option value="nickname">작성자</option>
					</select>
            </div>
            <div class="col-lg-7"><input type="text" name="searchContent" class="form-control col-lg-8" aria-label="찾고 싶은 내용을 입력하세요" aria-describedby="inputGroup-sizing-sm"></div>
            <div class="col-lg-2"><button type="submit" class="btn btn-primary">검색하기</button></div>
        </div>
        <hr>
    </div>
    </form>
    
	<c:if test="${ empty list }">
	    <div style="height:150px;" class="row bn_txt_strong text-center align-items-center"> 
		   <h2>${msg}</h2>
	    </div>
	</c:if>
	
	<c:if test="${ !empty list }">
    <!-- =========게시글================--> 
    <section id="blog" class="blog">
        <div class="container">
  
            <div class="row gy-4 posts-list">

                <c:forEach items="${list}" var="moim" varStatus="status">

	                <div class="col-xl-4 col-md-6">
	                <article>
	                	<div style="display:none">
		                	<span class="bId">${moim.boardId}</span>
		                	<span class="moimWriter">${moim.moimWriter}</span>
		                	<span class="userId" hidden="hidden">${moim.userId}</span>
	                	</div>

	                    <div class="post-img">
							<img src="${contextPath }/resources/uploadFiles/${attmlist[status.index].rename}" alt="" class="img-fluid">
	                    </div>
		                    
	                    <div class="row justify-content-between">
 
							<c:if test="${moim.local eq '전체 전체'}">
		                        <span class="col group_type"><i class="bi bi-geo-alt"></i> 전체</span>
							</c:if>
	
							<c:if test="${moim.local ne '전체 전체'}">
		                        <span class="col group_type"><i class="bi bi-geo-alt"></i> ${moim.local}</span>
							</c:if>
							
	                        <span class="col text-end group_status date" style="color:black;">
	                       		<i class="bi bi-people-fill"></i>${moim.moimCategory}<br>
	                        	<c:if test="${fn:contains(moim.moimStatus, 'Y')}">모집중</c:if>
	                        	<c:if test="${fn:contains(moim.moimStatus, 'B')}">모집전</c:if>
	                        	<c:if test="${fn:contains(moim.moimStatus, 'N')}">모집종료</c:if>
	                        </span>
							
	                    </div>
	                    <br>
	                    
	                    <h2 class="title">
	                    <a href="blog-details.html">${moim.boardTitle}</a>
	                    </h2>
	
	                    <div class="row justify-content-between">
	                        <span class="col text-start">${moim.moimWriter}</span>
	                        <span class="col text-end">${moim.createDate}</span>
	                    </div>
	                    <div class="row justify-content between">
	                        <span class="col text-end">
	                            <i class="view fa-solid fa-eye"></i>&nbsp;${moim.boardCount}&nbsp;
	                            <i class="like fa-regular fa-heart"></i>&nbsp;${likeCount[status.index]} &nbsp;&nbsp;
	                          	<i class="fa-regular fa-comment-dots"></i>&nbsp; ${replyLikeCount[status.index]} &nbsp;&nbsp;
	                            <i class="save fa-regular fa-bookmark"></i>&nbsp;${scrapCount[status.index] }
	                        </span>
	                     </div>
	                </article>
	                
	                </div><!-- End post list item -->
                </c:forEach>
                <div class="col-xl-4 col-md-6">
               
            </div><!-- End blog posts list -->
        </div>
        </div>
    </section><!-- End Blog Section -->
    </c:if>

    <br>

    </main>

    <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>
    <div id="preloader"></div>

</body>

<script>
	window.onload=()=>{
		const dives = document.getElementsByTagName('article');
		console.log(dives);
		for(const div of dives){
			div.addEventListener('click', function(){
				const boardId = this.querySelector('.bId').innerText;
				const userId = this.querySelector('.userId').innerText;
				location.href='${contextPath}/selectMoim.moim?boardId='+boardId+'&userId='+userId;
			})
		}
	}
</script>
    
    
    
    </main>
</body>
</html>
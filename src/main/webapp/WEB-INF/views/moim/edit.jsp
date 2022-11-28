<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>솔로던트 모임게시판</title>

    <link href="/solodent/resources/assets/vendor/aos/aos.css" rel="stylesheet">
    
  	<!-- data picker --->
	<!-- css -->
	<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	

    <!-- =======================================================
    * Template Name: Impact - v1.1.1
    * Template URL: https://bootstrapmade.com/impact-bootstrap-business-website-template/
    * Author: BootstrapMade.com
    * License: https://bootstrapmade.com/license/
    ======================================================== -->
</head>

<body>

	<jsp:include page="../home/menubar.jsp"/>
  
	<!--data picker js-->
	<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
	<!-- data picker end--->
	
	<main id="main" style="margin-top: 70px;">
    
    <!-- ======= 글 작성 ======= -->
    <section>
    <div class="container mb-16" >

          <div class="col-lg-12">

            <form action="${contextPath }/updateBoard.moim" method="post" enctype="multipart/form-data" id="moimForm">
            
                <div class="container">
                  <div class="mb-3 row align-items-center">
                    <div class="col-lg-2 bn_txt_strong ">제목</div>
                    <div class="col">
                    	<input type="hidden" value="${moim.boardId }" name="boardId">
                    	<input type="hidden" value="${moim.userId }" name="userId">
                    	<input type="hidden" value="${page}" name="page">
                      <input type="text" id="boardTitle" name="boardTitle" class="form-control col-lg-8" value="${moim.boardTitle }">
                    </div>
                  </div>
          
          
                  <div class="mb-3 row align-items-center">
                      <div class="col-lg-2 bn_txt_strong ">모임분류</div>
                      <div class="col">
                      <c:set var="cate" value="${moim.moimCategory}"/>
                      
                      
                          <div class="form-check form-check-inline">
                              <input <c:if test="${ cate eq '동아리' }"> checked="checked" </c:if> class="form-check-input" type="checkbox" name="moimCategory" id="dongari" value="동아리" >
                              <label class="form-check-label" for="dongari">동아리</label>
                          </div>
                          <div class="form-check form-check-inline">
                              <input <c:if test="${ cate eq '공모전' }"> checked="checked" </c:if> class="form-check-input" type="checkbox" name="moimCategory" id="gongmojeon" value="공모전">
                              <label class="form-check-label" for="gongmojeon">공모전</label>
                          </div>
                          <div class="form-check form-check-inline">
                              <input <c:if test="${ cate eq '취미활동' }"> checked="checked" </c:if> class="form-check-input" type="checkbox" name="moimCategory" id="hobby" value="취미활동">
                              <label class="form-check-label" for="hobby">취미활동</label>
                          </div>
                          <div class="form-check form-check-inline">
                              <input <c:if test="${ cate eq '자기개발' }"> checked="checked" </c:if> class="form-check-input" type="checkbox" name="moimCategory" id="jagigebal" value="자기개발">
                              <label class="form-check-label" for="jagigebal">자기개발</label>
                          </div>
                          <div class="form-check form-check-inline">
                              <input <c:if test="${ cate eq '기타' }"> checked="checked" </c:if> class="form-check-input" type="checkbox" name="moimCategory" id="etc" value="기타">
                              <label class="form-check-label" for="etc">기타</label>
                          </div>
                      </div>
                      <div class="col"></div>
                  </div>
                  
                  <script>
			          $(document).ready(function(){
			              $("input[type='checkbox']").on('click', function(){
			                  let count = $("input[type='checkbox']:checked").length;
			                  if(count>2){
			                      $(this).prop("checked", false);
			                      alert("카테고리는 두 개까지만 선택할 수 있어요!");
			                  }
			              });
			          });
			       </script>
                  
                  <!--============== DateRange =====================-->
                  <div class="mb-3 row align-items-center">
                    <div class="col-lg-2 bn_txt_strong ">모집기간</div>

                    <div class="col input-group">
                      <input type="text" class="form-control" id="daterangepicker" name="moimdate">
                    </div>

                    <div class="col">
                    </div>
                  </div>

                  <script>
					var startDate = '${moim.moimStart}';
					var endDate = '${moim.moimEnd}';

                    $("#daterangepicker").daterangepicker({
                   		"startDate": startDate,
                		"endDate" : endDate,
	                    locale: {
	                        "separator": " 부터 ",                     // 시작일시와 종료일시 구분자
	                        "format": 'YYYY-MM-DD',     // 일시 노출 포맷
	                        "applyLabel": "확인",                    // 확인 버튼 텍스트
	                        "cancelLabel": "취소",                   // 취소 버튼 텍스트
	                        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
	                        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	 
	                    },
	                    autoApply: false                         // 확인/취소 버튼 사용여부
                    });

                  </script>
              	<!-- ======== Date Range 끝 ========== -->
              
                  <div class="mb-3 row align-items-center">
                      <div class="col-lg-2 bn_txt_strong ">모임지역</div>
                      <div class="col-lg-8">
                      
                      <select name="sido1" id="sido1"></select>
                      <select name="gugun1" id="gugun1"></select>
                      <script>
                          $('document').ready(function() {
                              var area0 = ["전체","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
                              
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
							var local = '${moim.local}';
							var local0 = local.split(' ')[0];
							var local1 = local.split(' ')[1];
							$("select[name^=sido]").each(function() {
								$selsido = $(this);
								area0.splice(0,0,local0);
								$.each(eval(area0), function() {
									$selsido.append("<option value='"+this+"'>"+this+"</option>");
								});
								$selsido.next().append("<option value='"+local1+"'>"+local1+"</option>");
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
          
                  <div class="mb-3 row align-items-center">
                      <div class="col-lg-2 bn_txt_strong">내용작성</div>
                      <br>
                  </div>

                  <div class="mb-3 row form-floating">
                    <textarea class="form-control" id="boardContent" name="boardContent" style="height: 500px">${moim.boardContent }</textarea>
                    <label for="boardContent">내용을 작성하세요</label>
                  </div>
				
				<div class="row">
				<c:forEach items="${list}" var="a">
					<div class="col-sm">
						<img src="${contextPath }/resources/uploadFiles/${a.rename}" alt="" class="img-fluid" width="100px" height="100px">
	                    <a href="${contextPath}/resources/uploadFiled/${a.rename}" download="${a.rawname}">${a.rawname}</a>
	                    <button type="button" class="btn btn-outline-dark" id="delete-${a.rename}/${a.isThum}">삭제하기</button>
                    </div>
				</c:forEach>
				</div>
				
				<div id="fileArea">
				  <div class="mb-3 input-group">
		                <input type="file" class="form-control" id="attachment" name="attachment" aria-label="파일첨부">
	                    <button type="button" class="btn btn-outline-secondary" id="addFile">파일 추가하기</button>
                  </div>
				</div>
                
                  <div class="row mb-3">
                    <button type="button" class="btn btn-lg col-lg-12" style="background-color: var(--color-primary); color: white;" id="btnSubmit">작성하기</button>
                    <!-- 버튼type="button"으로 설정한 후 스크립트 통해 제출한다. btnSubmit 아이디는 스크립트에서 사용 -->
                  </div>
              </div>

            </form>
            </div>
          </div>
        </section>

  </main><!-- End #main -->
  
  <div class="modal fade" tabindex="-1" role="dialog" id="modalChoice">
  	<div class="modal-dialog" role="document">
  		<div class="modal-content rounded-3 shadow">
  			<div class="modal-body p-4 text-center">
  				<h4 class="mb-0">❌첨부파일이 삽입되지 않았습니다❌</h4>
  				<p class="mb-0">사진은 필수 포함항목입니다!</p>
  			</div>
  			<div class="modal-footer" flex-nowrap p-0>
  				<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
  			</div>
  		</div>
  	</div>
  </div>
  
  <script>
  	window.onload=()=>{
  		const fileArea = document.querySelector('#fileArea');
  		// 파일 여러개 삽입
  		document.getElementById('addFile').addEventListener('click', ()=>{
  			const newDiv = document.createElement('div');
  			newDiv.classList.add('mb-3');
  			newDiv.innerHTML = '<input type="file" class="form-control" id="attachment" name="attachment" aria-label="파일첨부">';
  			fileArea.append(newDiv);
  		})
  	}
  	
    const delBtns = document.getElementsByClassName('deleteAttm');
    console.log("delBtns"+delBtns); // 잘 들어왔나? 생각이 되면 꼭 찍어보세요.
    
    for(const btn of delBtns){
       btn.addEventListener('click', function(){
          console.log(this); // 잘 들어왔나? 생각이 되면 꼭 찍어보세요.
          const nextHidden = this.nextElementSibling;
          console.log("nh"+nextHidden);
          if(nextHidden.value==''){
             this.style.background = 'black';
             this.style.color = 'white';
             this.innerText = '삭제 ON';
             nextHidden.value = this.id.split("-")[1];
          } else {
             this.style.background = 'none';
             this.style.color = 'black';
             this.innerText = '삭제 OFF';
          }
       });
    }
    
  		// 파일 보내기
		const form = document.getElementById('moimForm');
		document.getElementById('btnSubmit').addEventListener('click', ()=>{
			const attachments = document.getElementsByName('attachment');
			let isEmpty = true;
			for(const f of attachments){
				if(f.value != ''){
					isEmpty = false;
				}
			}
			if(isEmpty){
				$('#modalChoice').modal('show');
			} else {
// 				document.getElementById('moimForm').submit();
				form.submit();
// 				$('#moimForm').submit(); //첨부파일 있는 경우에만 제출 가능
			}
		}); 
  	
  </script>


    <!-- Vendor JS Files --> <!--이거 없으면 화면 안 나옴-->
    <script src="/solodent/resources/assets/vendor/aos/aos.js"></script>

</body>
</html>
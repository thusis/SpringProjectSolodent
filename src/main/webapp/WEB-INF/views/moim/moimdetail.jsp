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

    <title>솔로던트 모임게시판-상세글</title>
</head>

<body>
  
	<jsp:include page="../home/menubar.jsp"/>

    <main id="main" style="margin-top: 70px;">
    
    <!-- ======= Blog Details Section ======= -->
    <section id="blog" class="blog">
      <div class="container" data-aos="fade-up">

        <div class="row g-5">

          <div class="col-lg-12">


            <article class="blog-details">
              <div class="row">
                <div class="col-10"><h2 class="title">${moim.boardTitle}</h2></div>
                <div class="col-2 d-flex align-items-center justify-content-center">
                  <a href=""> <!-- 글쓴이의 경우: 수정 / 삭제 // 보는 사람의 경우 : 신고-->
                    <i class="bi lg bi-three-dots" style="font-size: 2rem; color:darkgray;"></i>
                  </a>
                </div>
              </div>

              
              <div class="meta-top">
                  <ul>
                    <li class="align-items-center"><i class="bi bi-person"></i>${moim.moimWriter}</li>
                    <li class="align-items-center"><i class="bi bi-clock"></i> <time datetime="2020-01-01">${moim.createDate}</time></li>
                    <li class="align-items-center"><i class="bi bi-chat-dots"></i> <a href="#comments">댓글수</a></li><!--누르면댓글로이동-->
  
                    <!--누르면 하트 채움 / 추천 수 나타냄-->
                    <li class="align-items-center"><i class="bi bi-heart"></i>좋아요 수</li> 
                    <li class="align-items-center"><i class="bi bi-heart-fill"></i>좋아요 수</li> 
                    
                    <li class="align-items-center"> | </li>
  
                    <!-- 여기부터 모임만 해당-->
					<c:if test="${moim.local eq '전체 전체'}">
	                    <li class="align-items-center"><i class="bi bi-geo-alt"></i> <a href="blog-details.html">전체</a></li><!--누르면 지역으로 검색-->
					</c:if>

					<c:if test="${moim.local ne '전체 전체'}">
	                    <li class="align-items-center"><i class="bi bi-geo-alt"></i> <a href="blog-details.html">${moim.local}</a></li><!--누르면 지역으로 검색-->
					</c:if>
                    <li class="align-items-center"><i class="bi bi-people-fill"></i> <a href="blog-details.html">${moim.moimCategory}</a></li><!--누르면 모임형태로 검색-->
                    
  
                    <!--모집중인지, 마감인지 여부에 따라-->
                    <c:if test="${moim.moimStatus eq Y}">
	                    <li class="align-items-center"><i class="bi bi-patch-check-fill"></i>모집중</li>
                    </c:if>
                    <c:if test="${moim.moimStatus eq N}">
	                    <li class="align-items-center"><i class="bi bi-x-circle-fill"></i>모집마감</li>
                    </c:if>
                  </ul>
              </div><!-- End meta top -->

              <div class="content">
                <p>${moim.boardContent}</p>
   
				<c:forEach items="${list}" var="att">
<%-- 					<img src="${contextPath}/resources/uploadFiles/${att.rename}" alt="" class="img-fluid"> --%>
					<img src="${contextPath }/resources/uploadFiles/${att.rename}" alt="" class="img-fluid">
					<br>
				</c:forEach>

              </div><!-- End post content -->
        <hr>

        <!--댓글 쓰는 곳-->
        <div class="reply-form" id="comments">
          <div class="row">
            <div class="col-lg-1">
              <h5> 댓글 8개 </h5>
            </div>
            <div class="col-lg">
              <h4>댓글을 남기세요</h4>
            </div>
          </div>

          <form action="">
            <div class="row  justify-content-center align-items-center">
              <div class="col-1">
                <button type="button" onclick="Toggle4()" id="btnh" class="btn"><i class="bn_btnh bi bi-suit-heart"></i></button>
              </div>

                <script>
                  var btnvar4 = document.getElementById('btnh');
                  function Toggle4(){
                    if(btnvar4.style.color=="var(--color-primary)"){
                      btnvar4.style.color="grey";
                      btnvar4.innerHTML = '<i class="bn_btnh bi bi-suit-heart"></i>';
                    } else {
                      btnvar4.style.color = "var(--color-primary)";
                      btnvar4.innerHTML = '<i class="bn_btnh bi bi-suit-heart-fill"></i>';
                    }
                  }
                </script>
                
              <div class="col-lg">
                  <textarea name="comment" class="form-control" placeholder="Your Comment*"></textarea>
              </div>
              
              <div class="col-lg-2"> 
                <button type="submit" class="btn btn-primary">Post Comment</button>
              </div>
            </div>
          </form>
        </div>

        <!--댓글 리스트-->
          <div class="reply-form">

            <div class="bn_replies row  justify-content-center">
              <ul>
                <li class="col-lg">댓글작성자</li>
                <li class="col-lg-6">내용</li>
                <li class="col-lg-1">?</li>
                <li class="col-lg">추천</li>
                <li class="col-lg">작성날짜</li>
              </ul>
              
              <!--foreach들어갈 부분-->
              <ul>
                <li class="col-lg">댓글작성자</li>
                <li class="col-lg-6">내용</li>
                <li class="col-lg-1">?</li>
                <li class="col-lg">추천</li>
                <li class="col-lg">작성날짜</li>
              </ul>
            </div>

        </div><!-- End blog comments -->

    </article><!-- End blog post -->
    
          </div>
        </div>
      </div>
    </section><!-- End Blog Details Section -->

  </main><!-- End #main -->

  <!-- ======= Footer ======= -->
  <footer id="footer" class="footer">

    <div class="container">
      <div class="row gy-4">
        <div class="col-lg-5 col-md-12 footer-info">
          <a href="index.html" class="logo d-flex align-items-center">
            <span>Impact</span>
          </a>
          <p>Cras fermentum odio eu feugiat lide par naso tierra. Justo eget nada terra videa magna derita valies darta donna mare fermentum iaculis eu non diam phasellus.</p>
          <div class="social-links d-flex mt-4">
            <a href="#" class="twitter"><i class="bi bi-twitter"></i></a>
            <a href="#" class="facebook"><i class="bi bi-facebook"></i></a>
            <a href="#" class="instagram"><i class="bi bi-instagram"></i></a>
            <a href="#" class="linkedin"><i class="bi bi-linkedin"></i></a>
          </div>
        </div>

        <div class="col-lg-2 col-6 footer-links">
          <h4>Useful Links</h4>
          <ul>
            <li><a href="#">Home</a></li>
            <li><a href="#">About us</a></li>
            <li><a href="#">Services</a></li>
            <li><a href="#">Terms of service</a></li>
            <li><a href="#">Privacy policy</a></li>
          </ul>
        </div>

        <div class="col-lg-2 col-6 footer-links">
          <h4>Our Services</h4>
          <ul>
            <li><a href="#">Web Design</a></li>
            <li><a href="#">Web Development</a></li>
            <li><a href="#">Product Management</a></li>
            <li><a href="#">Marketing</a></li>
            <li><a href="#">Graphic Design</a></li>
          </ul>
        </div>

        <div class="col-lg-3 col-md-12 footer-contact text-center text-md-start">
          <h4>Contact Us</h4>
          <p>
            A108 Adam Street <br>
            New York, NY 535022<br>
            United States <br><br>
            <strong>Phone:</strong> +1 5589 55488 55<br>
            <strong>Email:</strong> info@example.com<br>
          </p>

        </div>

      </div>
    </div>

    <div class="container mt-4">
      <div class="copyright">
        &copy; Copyright <strong><span>Impact</span></strong>. All Rights Reserved
      </div>
      <div class="credits">
        <!-- All the links in the footer should remain intact. -->
        <!-- You can delete the links only if you purchased the pro version. -->
        <!-- Licensing information: https://bootstrapmade.com/license/ -->
        <!-- Purchase the pro version with working PHP/AJAX contact form: https://bootstrapmade.com/impact-bootstrap-business-website-template/ -->
        Designed by <a href="https://bootstrapmade.com/">BootstrapMade</a>
      </div>
    </div>

  </footer><!-- End Footer -->
  <!-- End Footer -->

  <a href="#" class="scroll-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

  <div id="preloader"></div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>받은 쪽지함</title>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- 부트스트랩 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- jquery -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<style>
/* Remove the navbar's default margin-bottom and rounded borders */
.navbar {
	margin-bottom: 0;
	border-radius: 0;
}

/* Add a gray background color and some padding to the footer */
footer {
	background-color: #f2f2f2;
	padding: 25px;
}

.carousel-inner img {
	width: 100%; /* Set width to 100% */
	margin: auto;
	min-height: 200px;
}

/* Hide the carousel text when the screen is less than 600 pixels wide */
@media ( max-width : 600px) {
	.carousel-caption {
		display: none;
	}
}

body {

	position: relative; /* For scrollyspy */
	padding-top: 350px; /*Account for fixed navbar */
	background-color: #f8f8f8;

  position: relative; /* For scrollyspy */
  padding-top: 300px;   /*Account for fixed navbar */
  background-color: #f8f8f8;
}

</style>

</head>
<body>
<%@ include file="/WEB-INF/views/header.jspf"%>
<div class="container text-center">
<br/><br/><br/>
<img alt="이미지"
				src="${pageContext.request.contextPath}/resources/msg2.png"
				style="background-color: white; width: 110px; height: 110px;" />
		<br/>		
	<h1><b>받은 쪽지함</b></h1><br/>
<div class="container text-center">
	<table class="table">
		<thead>
			<tr>
				<th style="text-align: center;">보낸 사람</th>
				<th style="text-align: center;">내용</th>
				<th style="text-align: center;">수신 일자</th>
			</tr>
		</thead>
		<tbody style="text-align: center;">
		
			<c:forEach var="receive" items="${receiveList}">
				<!-- 받은 쪽지함 에서 받는사람(mem_id2)와 
				로그인 아이디가 같을 때 보낸사람 보이게  -->
				<c:if test="${receive.mem_id2 eq loginId}">
            			<tr>
							<td>${receive.mem_id}</td>
								<c:choose>
									<c:when test="${fn:length(receive.msg_content) > 16}">
									<!-- 받은 쪽지 내용이 15자 이상 넘어가면 뒤에 내용 ...으로 표기 -->
										<c:set var="textValue" value="${receive.msg_content}" />				
											<td id="receive_content">
											<a class="table-title-link" href="${receive.msg_no}">${fn:substring(textValue, 0, 15)}...</a>
											</td>
									</c:when>
									
									<c:otherwise>
											<td>
											<a class="table-title-link" href="${receive.msg_no}">${receive.msg_content}</a>
											</td>
									</c:otherwise>
								</c:choose>
								
								<fmt:formatDate value="${receive.msg_regdate}"
								pattern="yyyy.MM.dd HH:mm" var="msg_regdate" />
							<td>${msg_regdate}</td>
						</tr>
				</c:if>
			</c:forEach>
			
		</tbody>
	</table>
	</div>
	<div class="container text-center">
			<ul class="pagination">
				<c:if test="${pageMaker.hasPrev}">
					<li><a class="page-link" href="${pageMaker.startPageNo - 1}">이전</a></li>
				</c:if>
				<c:forEach begin="${pageMaker.startPageNo}"
					end="${pageMaker.endPageNo}" var="num">
					<li><a class="page-link" href="${num}">${num}</a></li>
				</c:forEach>
				<c:if test="${pageMaker.hasNext}">
					<li><a class="page-link" href="${pageMaker.endPageNo + 1}">다음</a></li>
				</c:if>
			</ul>
	</div>
	
	
		<form id="page-form">
			<input type="hidden" name="page" id="page" value="${pageMaker.criteria.page}" />
			<input type="hidden" name="numsPerPage" id="numsPerPage" value="${pageMaker.criteria.numsPerPage}" />
			<input type="hidden" name="msg_no" id="page-form-msg_no" />
		</form>
	
	</div>	
	
	<script>
	$('.page-link').click(function () {
		event.preventDefault();
		var targetPage = $(this).attr('href');
		$('#page').val(targetPage);
		var frm = $('#page-form');
		frm.attr('action', 'receive');
		frm.attr('method', 'get');
		frm.submit();
	});
	
	$('.table-title-link').click(function () {
		event.preventDefault();
		var msg_no = $(this).attr('href');
		$('#page-form-msg_no').val(msg_no);
		var frm = $('#page-form');
		frm.attr('action', 'receivedetail');
		frm.attr('method', 'get');
		frm.submit();
	});
	
	</script>
	
		
	
	<%@ include file="/WEB-INF/views/footer.jspf"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page  import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
	<%
		String userID = null;
		if (session.getAttribute("userID") !=null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요.');");
			script.println("location.href = 'userLogin.jsp';");
			script.println("</script>");
			script.close();
			return;
		}
		String toID = null;
		if(request.getParameter("toID") != null) {
			toID = (String) request.getParameter("toID");
		}
	%>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>캡스톤디자인 1팀</title>
	<!-- 부트스트랩 버전3 css -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/css/bootstrap.min.css">
	<!-- 커스텀 css -->
	<link rel="stylesheet" href="./css/custom.css">
	<!-- 폰트어썸 -->
	<script src="https://kit.fontawesome.com/ada8c39352.js"></script>
	<script src="./js/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function findFunction(){
			var userID = $('#findID').val();
			$.ajax({
				type: "POST",
				url:'./UserRegisterCheckServlet',
				data: {userID: userID},
				success: function(result) {
					if(result == 0) {
					
						getFriend(userID);
					} else {
					
						failFriend();
					}
				}
			});
			$('#findID').val('');
		}
		function getFriend(findID){
			$('#friendResult').html('<thead>' +
					'<tr>' +
					'<th><h4>검색 결과</h4></th>' +
					'</tr>' +
					'</thead>' +
					'<tbody>' +
					'<tr>' +
					'<td style="text-align: center;"><h3>' + findID + '</h3><a href="chatindex.jsp?toID=' + encodeURIComponent(findID) + '" class="btn btn-primary pull-right">' + '메세지 보내기</a></td>' +
					'</tr>' +
					'</tbody>');
		}
		function failFriend() {
			$('#friendResult').html('');
		}
	</script>
</head>
<body>

	<!-- 상단바 -->
	<nav class="navbar navbar-inverse">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="chatindex.jsp">인비과 채팅방</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="chatindex.jsp">메인</a></li>
				<li><a href="index.jsp">강의평가</a></li>
				<li class="active"><a href="find.jsp">친구찾기</a></li>
			</ul>
			<%
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						접속하기<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="userLogin.jsp">로그인</a></li>
						<li><a href="userRegister.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
						회원관리<span class="caret"></span>
					</a>
					<ul class="dropdown-menu">
						<li><a href="userLogout.jsp">로그아웃</a></li>
						
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd;">
			<thead>
				<tr>
					<th colspan="2"><h4>검색으로 친구찾기</h4></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width: 110px;"><h5>친구 아이디</h5></td>
					<td><input class="form-control" type="text" id="findID" maxlength="20" placeholder="찾을 아이디를 입력하세요."></td>
				</tr>
				<tr>
					<td colspan="2"><button class="btn btn-primary pull-right" onclick="findFunction();">검색</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="container">
		<table id="friendResult" class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd;">
			
		</table>
	</div>
	
	<div class="modal fade" id="checkModal" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="vertical-alignment-helper">
			<div class="modal-dialog">
				<div id="checkType" class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							확인 메시지 
						</h4>
					</div>
					<div id="checkMessage" class="modal-body alert-info">
					
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button> 
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div class="alert alert-success" id="successMessage" style="display: none;">
	<strong>친구찾기에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong>데이터베이스 오류가 발생했습니다.</strong>
	</div>
	<!-- 푸터 -->
	<!--footer class="bg-dark mt-4 p-5 text-left" style="color:#FFFFFF;">
		<div class="container">
			<br>
			<div class="row">
				<div class="col-sm-2 mt-4" style="text-align: center;">인비과 캡스톤디자인AirPod</div>
				<div class="col-sm-4"><h5>페이지 소개</h5><p>학생들의 강의평가페이지 및 커뮤니티를 졸업작품으로 만들어 보았습니다.</p></div>
				<div class="col-sm-2"><h5 style="text-align: center;">학교</h5>
					<div class="list-group">
						<a href="https://www.hsc.ac.kr/site/hsc/main.do" class="list-group-item" style="color:#353535">한림성심대학교</a>
						<a href="https://internet.hsc.ac.kr/internet/index.do" class="list-group-item" style="color:#353535">인비과홈페이지</a>
					</div>
				</div>
				<div class="col-sm-2"><h5 style="text-align: center;">SNS</h5>
					<div class="list-group">
						<a href="https://www.youtube.com/" class="list-group-item" style="color:#353535">유튜브</a>
						<a href="https://www.facebook.com/" class="list-group-item" style="color:#353535">페이스북</a>
					</div>
				</div>
				<div class="col-sm-2"><h5 style="text-align: center;"><span class="fas fa-check"></span>by 박재만</h5></div>
			</div>
		</div>
	</footer -->
	
	<!-- 제이쿼리 추가 -->
	
	<!-- 파퍼 추가 -->
	<script src="./popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가 -->
	
</body>
</html>
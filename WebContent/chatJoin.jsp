<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" buffer='16kb'%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<title>캡스톤디자인 1팀</title>
	<!-- 부트스트랩 css -->
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<!-- 커스텀 css -->
	<link rel="stylesheet" href="./css/custom.css">
	<!-- 폰트어썸 -->
	<script src="https://kit.fontawesome.com/ada8c39352.js"></script>
	<script type="text/javascript">
		function registerCheckFunction() {
			$(document).off('.data-api');
			var ChatuserID = $('#ChatuserID').val();
			$.ajax({
				type: 'POST',
				url: './UserRegisterCheckServlet',
				data: {ChatuserID: ChatuserID},
				success: function(result){
					if(result == 1){
						$('#checkMessage').html('사용할 수 있는 아이디입니다.');
						$('#checkType').attr('class','modal-content panel-success');
					} else{
						$('#checkMessage').html('사용할 수 없는 아이디입니다.');
						$('#checkType').attr('class','modal-content panel-warning');						
					}
					$('#checkModal').modal("show");
				}
			});
		}
		function passwordCheckFunction(){
			var ChatuserPassword1 = $('#ChatuserPassword1').val();
			var ChatuserPassword2 = $('#ChatuserPassword2').val();
			if(ChatuserPassword1 != ChatuserPassword2){
				$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');
			} else {
				$('#passwordCheckMessage').html('');
			}
		}
	</script>

</head>
<body>
	<%
		String ChatuserID = null;
		if (session.getAttribute("ChatuserID")!=null){
			ChatuserID = (String) session.getAttribute("ChatuserID");
		}
	%>
	<!-- 상단바 -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="chatindex.jsp">인비과 실시간채팅</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbar">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item active">
					<a class="nav-link" href="index.jsp">메인</a>
				</li>
				<li class="nav-item dropdown">
					<a class="nav-link dropdown-toggle" id ="dropdown" data-toggle="dropdown" >
						회원 관리
					</a>
					<div class="dropdown-menu" aria-labelledby="dropdown">
<%
	if(ChatuserID == null){
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="chatJoin.jsp">회원가입</a>
<%
	} else{
%>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>			
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<div class="container">
		<form method="post" action="./userRegister">
			<table class="table table-bordered table-hover" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"><h4>회원 등록 양식</h4>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 110px;"><h5>아이디</h5></td>
						<td><input class="form-control" type="text" id="ChatuserID" name="ChatuserID"maxlength="20" placeholder="아이디를 입력하세요."></td>
						<td style="width: 120px;"><button class="btn btn-primary" onclick="registerCheckFunction();" type="button">중복체크</button></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호</h5></td>
						<td colspan="2"><input class="form-control" onkeyup="passwordCheckFunction();" id="ChatuserPassword1" type="password" name="ChatuserPassword1" maxlength="20" placeholder="비밀번호를 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>비밀번호 확인</h5></td>
						<td colspan="2"><input class="form-control" onkeyup="passwordCheckFunction();" id="ChatuserPassword2" type="password" name="ChatuserPassword2" maxlength="20" placeholder="비밀번호 확인을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이름</h5></td>
						<td colspan="2"><input class="form-control" id="ChatuserName" type="text" name="ChatuserName" maxlength="20" placeholder="이름을 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>나이</h5></td>
						<td colspan="2">
							<div class="form-group" style="text-align: center; margin: 0 auto;">
								<div class="btn-group" data-toggle="buttons">
									<label class="btn btn-primary active">
										<input type="radio" name="ChatuserGender" autocomplete="off" value="남자" checked>남자
									</label>
									<label class="btn btn-primary">
										<input type="radio" name="ChatuserGender" autocomplete="off" value="여자">여자
									</label>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>성별</h5></td>
						<td colspan="2"><input class="form-control" id="ChatuserAge" type="number" id="ChatuserAge" maxlength="20" placeholder="나이를 입력하세요."></td>
					</tr>
					<tr>
						<td style="width: 110px;"><h5>이메일</h5></td>
						<td colspan="2"><input class="form-control" id="ChatuserEmail" type="email" id="ChatuserEmail" maxlength="20" placeholder="이메일을 입력하세요."></td>
					</tr>
					<tr>
						<td style="text-align: right;" colspan="3"><h5 style="color: red;" id="passwordCheckMessage"></h5><input class="btn btn-primary pull-right" type="submit" value="등록"></td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>
	<%
		String messageContent = null;
		if(session.getAttribute("messageContent") != null){
			messageContent = (String) session.getAttribute("messageContent");
		}
		String messageType = null;
		if(session.getAttribute("messageType") != null){
			messageType = (String) session.getAttribute("messageType");
		}
		if(messageContent != null){
	%>
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-hidden="true" aria-labelledby="modal">
			<div class="modal-dialog">
				<div class="modal-content <% if(messageType.equals("warning")) out.println("alert-warning");else out.println("alert-success");%>">
					<div class="modal-header alert-info">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times;</span>
							<span class="sr-only">Close</span>
						</button>
						<h4 class="modal-title">
							<%= messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%= messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" data-dismiss="modal">확인</button> 
					</div>
				</div>
			</div>
	s
	</div>
	<script>
		$('#messageModal').modal('show');	
	</script>
	<%}%>
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
	<!-- 푸터 -->
	<footer class="bg-dark mt-4 p-5 text-left" style="color:#FFFFFF;">
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
	</footer>
	
	<!-- 제이쿼리 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 추가 -->
	<script src="./popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>
	
</body>
</html>
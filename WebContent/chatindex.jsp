<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page  import="java.io.PrintWriter" %>
    <%@ page import="java.net.URLDecoder" %>
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
	
	<script src="./js/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.1/js/bootstrap.min.js"></script>
	
	<script type="text/javascript">
		function autoClosingAlert(selector, delay) {
			var alert = $(selector).alert();
			alert.show();
			window.setTimeout(function(){alert.hide()}, delay);
		}
		function submitFunction(){
			var fromID = '<%= userID %>'
			var toID = '<%= toID %>'
			var chatContent = $('#chatContent').val();
			$.ajax({
				type: "POST",
				url: "./ChatSubmitServlet",
				data: {
					fromID: encodeURIComponent(fromID),
					toID: encodeURIComponent(toID),
					chatContent: encodeURIComponent(chatContent)
				},
				success: function(result){
					if(result == 1){
						autoClosingAlert('#successMessage',2000);
					} else if (result == 0){
						autoClosingAlert('#dangerMessage',2000);
					} else {
						autoClosingAlert('#warningMessage',2000);
					}
				}
				
			});
			$('#chatContent').val('');
		}
		var lastID = 0;
		function chatListFunction(type){
			var fromID = '<%= userID %>';
			var toID = '<%= toID %>';
			
			$.ajax({
				type: "POST",
				url: "./ChatListServlet",
				data: {
					fromID: encodeURIComponent(fromID),
					toID: encodeURIComponent(toID),
					listType: type
				},
				success: function(data) {
					if(data == "") return;
					var parsed = JSON.parse(data);
					var result = parsed.result;
					for(var i = 0; i< result.length; i++){
						if(result[i][0].value == fromID){
							result[i][0].value = '나';
						}
						addChat(result[i][0].value, result[i][2].value, result[i][3].value);
					}
					lastID = Number(parsed.last);
				}
			});
		}
		function addChat(chatName, chatContent, chatTime) {
			$('#chatlist').append('<ul class="chat">' +
				'<li class="left clearfix"><span class="chat-img pull-left">' +
				'<img src="http://placehold.it/50/55C1E7/fff&text=U" alt="User Avatar" class="img-circle" />' +
				'</span>'+
				'<div class="chat-body clearfix">'+
				'<div class="header">' +
				'<strong class="primary-font">'+
				chatName +
				'</strong>'+
				'<small class="pull-right text-muted">' +
				'<span class="glyphicon glyphicon-time"></span>' + 
				chatTime +
				'</small>' +
				'</div>' +
				'<p>' +
				chatContent +
				'<p>' +
				'</div>' +
				'</li>' +
				'</ul>'
			);
			$('#chatlist').scrollTop($('#chatlist')[0].scrollHeight);
		}
		function getInfiniteChat() {    
			setInterval(function(){
				chatListFunction(lastID);
			}, 1000);
		}
		
		function getUnread() {
			$.ajax({
				type: "POST",
				url: "./chatUnread",
				data:{
					userID: encodeURIComponent('<%= userID %>')
				},
				success: function(result){
					if(result >= 1) {
						showUnread(result);
					} else {
						showUnread('');
					}
				}
			});
		}
		function getInfiniteUnread() {
			setInterval(function(){
				getUnread();
			},4000);
		}
		function showUnread(result){
			$('#unread').html(result);
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
				<li class="active"><a href="chatindex.jsp">메인</a></li>
				<li><a href="index.jsp">강의평가</a></li>
				<li><a href="find.jsp">친구찾기</a></li>
				<li><a href="Box.jsp">메세지함<span id="unread" class="label label-info"></span></a></li>

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
						<li><p>접속한 아이디: <%= userID %></p></li>
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
    <div class="row">
        <div class="col-xs-12">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <span class="glyphicon glyphicon-comment"></span> 실시간 채팅방
                    <div class="btn-group pull-right">
                        <button type="button" class="btn btn-default btn-xs dropdown-toggle" data-toggle="dropdown">
                            <span class="glyphicon glyphicon-chevron-down"></span>
                        </button>
                        <ul class="dropdown-menu slidedown">
                            <li><a href="http://www.jquery2dotnet.com"><span class="glyphicon glyphicon-refresh">
                            </span>Refresh</a></li>
                            <li><a href="http://www.jquery2dotnet.com"><span class="glyphicon glyphicon-ok-sign">
                            </span>Available</a></li>
                            <li><a href="http://www.jquery2dotnet.com"><span class="glyphicon glyphicon-remove">
                            </span>Busy</a></li>
                            <li><a href="http://www.jquery2dotnet.com"><span class="glyphicon glyphicon-time"></span>
                                Away</a></li>
                            <li class="divider"></li>
                            <li><a href="http://www.jquery2dotnet.com"><span class="glyphicon glyphicon-off"></span>
                                Sign Out</a></li>
                        </ul>
                    </div>
                </div>
                <div id="chat" class="panel-collapse collapse in">
                	<div id="chatlist" class="panel-body" style="overflow-y: auto; width: auto; height: 600px;">
                   		
                	</div>
                </div>
                <div class="panel-footer">
                    <div class="row" style="height: 90px;">
                        <div class="form-group col-xs-10">
                        	<textarea style="height: 80px;" id="chatContent" class="form-control" placeholder="메세지를 입력하세요" maxlength="100"></textarea>
                        </div>
                        <div class="form-group col-xs-2">
                        	<button type="button" class="btn btn-warning btn-sm" onclick="submitFunction();">전송</button>
                        	<div class="clearfix"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
	<script>

		$(document).ready(function(){
			chatListFunction('0');
			getInfiniteChat();
		});
	</script>
	
	<%
		if(userID != null){
	%>
		<script type="text/javascript">
			$(document).ready(function(){
				getInfiniteUnread();
				getUnread();
			});
		</script>	
	<%
	} 
	%>
	<div class="alert alert-success" id="successMessage" style="display: none;">
		<strong>메세지 전송에 성공했습니다.</strong>
	</div>
	<div class="alert alert-danger" id="dangerMessage" style="display: none;">
		<strong>이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div class="alert alert-warning" id="warningMessage" style="display: none;">
		<strong>친구를 찾을 수 없습니다.</strong>
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
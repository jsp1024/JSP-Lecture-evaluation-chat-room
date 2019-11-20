<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page  import="java.io.PrintWriter" %>
<%@ page import = "user.UserDAO"%>
<%@ page import = "evaluation.EvaluationDTO" %>
<%@ page import = "evaluation.EvaluationDAO" %>
<%@ page import = "java.util.ArrayList" %>
<%@ page import = "java.net.URLEncoder" %>
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
	<!-- 제이쿼리 추가 -->
	<script src="./js/jquery.min.js"></script>
	<!-- 파퍼 추가 -->
	<script src="./popper.js"></script>
	<!-- 부트스트랩 자바스크립트 추가 -->
	<script src="./js/bootstrap.min.js"></script>

</head>
<body>
<%	
	request.setCharacterEncoding("UTF-8");
	String lectureDivide = "전체";
	String searchType = "최신순";
	String search = "";
	int pageNumber = 0;
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lectureDivide");
	}
	if(request.getParameter("searchType") != null){
		searchType = request.getParameter("searchType");
	}
	if(request.getParameter("search") != null){
		search = request.getParameter("search");
	}
	if(request.getParameter("pageNumber") != null){
		try{
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}catch (Exception e){
			System.out.println("검색 페이지 번호 오류");
		}
		
	}
	String userID = null;
	if(session.getAttribute("userID")!= null){
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
	boolean emailChacked = new UserDAO().getUserEmailChacked(userID);
	if(emailChacked == false){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';");
		script.println("</script>");
		script.close();
		return;
	}
%>
	<script type="text/javascript">
	$(function () {
		  $('[data-toggle="tooltip"]').tooltip()
		})
	$('#example').tooltip('show')
	
	
	</script>
	<!-- 상단바 -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<a class="navbar-brand" href="index.jsp">인비과 강의평가</a>
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
	if(userID == null){
%>
						<a class="dropdown-item" href="userLogin.jsp">로그인</a>
						<a class="dropdown-item" href="userJoin.jsp">회원가입</a>
<%
	} else{
%>
						<p class="dropdown-item">접속한 아이디: <%= userID %></p>
						<a class="dropdown-item" href="userLogout.jsp">로그아웃</a>
<%
	}
%>
					</div>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="chatindex.jsp">채팅방</a>				
				</li>
						
			</ul>
			<form action="./index.jsp" method="get" class="form-inline my-2 my-lg-0">
				<input type="text" name="search" class="form-control mr-sm-2" type="search" placeholder="내용을 입력하세요." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
			</form>
		</div>
	</nav>
	<section class= "container">
		<!-- 경고창 -->
		<div class="alert alert-info alert-dismissable">
    		<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
    		<strong>주의!</strong> 비방 및 욕설을 개재한 게시물은 신고 처리가 될 수 있습니다.
		</div>
		<!-- 검색,등록하기,신고 버튼 -->
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="lectureDivide" class="form-control mx-1 mt-2">
				<option value="전체">전체</option>
				<option value="전공" <% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
				<option value="교양"<% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
				<option value="기타"<% if(lectureDivide.equals("기타")) out.println("selected"); %>>기타</option>
			</select>
			<select name="searchType" class="form-control mx-1 mt-2">
				<option value="최신순">최신순</option>
				<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
			</select>
			<input type="text" name="search" class="form-control mx-1 mt-2" placeholder="내용을 입력하세요.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">검색</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal" href="#registerModal">등록하기</a>
			<a class="btn btn-danger mx-1 mt-2" data-toggle="modal" href="#reportModal">신고</a>
		</form>

<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null)
		for(int i = 0 ; i < evaluationList.size();i++){
			if(i==5) break;
			EvaluationDTO evaluation = evaluationList.get(i);
%>
		<!-- 본문 -->
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left"><%= evaluation.getLectureName() %>&nbsp;<small><%= evaluation.getProfessorName() %></small></div>
					<div class="col-4 text-right">
						종합<span style="color: red;"><%= evaluation.getTotalScore() %></span>
					</div>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h5 class="card-title">
				<%= evaluation.getEvaluationTitle() %>&nbsp;<small><%= evaluation.getLectureYear() %>년 <%= evaluation.getSemesterDivide() %></small>
			</h5>
			<p class="card-text"><%= evaluation.getEvaluationContent() %></p>
			<div class="row">
				<div class="col-9 text-left">
					성적 <span style="color: red;"><%= evaluation.getCreditScore() %></span>
					성격 <span style="color: red;"><%= evaluation.getComfortableScore() %></span>
					강의 <span style="color: red;"><%= evaluation.getLectureScore() %></span>
					<span style="color: green;">(추천: <%= evaluation.getLikeCount() %>)</span>
				</div>
				<div class="col-3 text-right">
					<a onclick="return confirm('추천하시겠습니까?')" href="./likeAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">추천</a>
					<a onclick="return confirm('삭제하시겠습니까?')" href="./deleteAction.jsp?evaluationID=<%= evaluation.getEvaluationID() %>">삭제</a>
				</div>
			</div>
		</div>
<%
		}
%>
	</section>
	<ul class="pagination justify-content-center mt-3">
		<li class="page-item">
<%
	if(pageNumber <= 0){
%>
	<a class="page-link disabled">이전</a>
<%
	} else{
%>
	<a class="page-link" href="./index.jsp?LectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8")%>&pageNumber=
	<%= pageNumber - 1%>">이전</a> 
<%
	}
%>
	</li>
	<li class="page-item">
<%
	if(evaluationList.size() < 6){
%>
	<a class="page-link disabled">다음</a>
<%
	} else{
%>
	<a class="page-link" href="./index.jsp?LectureDivide=<%= URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=
	<%= URLEncoder.encode(searchType, "UTF-8") %>&search=<%= URLEncoder.encode(search,"UTF-8")%>&pageNumber=
	<%= pageNumber + 1%>">다음</a>
<%
	}
%>
	</li>
	</ul>
	<!-- 등록하기 모달 -->
	<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">평가 등록</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterAction.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>강의명</label>
								<select name="lectureName" class="form-control" >
									<option value="객체지향설계분석">객체지향설계분석</option>
									<option value="캡스톤디자인">캡스톤디자인</option>
									<option value="모바일콘텐츠">모바일콘텐츠</option>
									<option value="웹디자인">웹디자인</option>
									<option value="전자상거래">전자상거래</option>
									<option value="창업전략">창업전략</option>
									<option value="인터넷마케팅">인터넷마케팅</option>
								</select>
							</div>
							<div class="form-group col-sm-6">
								<label>교수명</label>
								<select name="professorName" class="form-control">
									<option value="반종오">반종오</option>
									<option value="김영규">김영규</option>
									<option value="허계범">허계범</option>
									<option value="정혜옥">정혜옥</option>
									<option value="권진하">권진하</option>
									<option value="이인배">이인배</option>
									<option value="장경생">장경생</option>
								</select>
							</div>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-4">
								<label>수강 연도</label>
								<select name="lectureYear" class="form-control">
									<option value="2011">2011</option>
									<option value="2012">2012</option>
									<option value="2013">2013</option>
									<option value="2014">2014</option>
									<option value="2015">2015</option>
									<option value="2016">2016</option>
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019" selected>2019</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>수강 학기</label>
								<select name="semesterDivide" class="form-control">
									<option value="1학기">1학기</option>
									<option value="2학기" selected>2학기</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>강의 구분</label>
								<select name="lectureDivide" class="form-control">
									<option value="전공" selected>전공</option>
									<option value="교양">교양</option>
									<option value="기타">기타</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>제목</label>
							<input type="text" name="evaluationTitle" class="form-control" maxlength="30">		
						</div>
						<div class="form-group">
							<label>내용</label>
							<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>종합</label>
								<select name="totalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>성적</label>
								<select name="creditScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>성격</label>
								<select name="comfortableScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>강의</label>
								<select name="lectureScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-primary">등록하기</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 신고하기 모달 -->
	<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="modal">신고하기</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportAction.jsp" method="post">
						<div class="form-group">
							<label>신고 제목</label>
							<input type="text" name="reportTitle" class="form-control" maxlength="30">		
						</div>
						<div class="form-group">
							<label>신고 내용</label>
							<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
							<button type="submit" class="btn btn-danger">신고하기</button>
						</div>
					</form>
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
	
	
	
</body>
</html>
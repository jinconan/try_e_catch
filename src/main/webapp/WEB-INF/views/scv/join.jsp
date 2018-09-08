<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 
	form정보
	action : 미정
	method : post
	-------------
	[필드명, 이름, 아이디(이름과 아이디가 다를 경우에 명시)]
	이름		: emp_name
	아이디	: emp_id
	이메일	: emp_email
	생일		: emp_birthday
	성별		: emp_gender(남 : emp_male, 여 : emp_female)
 --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>직원등록</title>
<%@ include file="/WEB-INF/views/_common/commonUI.jsp"%>
<script>
	$(document).ready(function() {
		$(".form_datetime").datetimepicker({
			format : 'yyyy-mm-dd'
			, minView : 2
			, 
		});
	})
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/_common/header.jsp" />

	<div class="container">
		<jsp:include page="/WEB-INF/views/_common/submenu.jsp" />
		<!-- 본문 -->
		<div class="col-sm-10">
			
			<form action="" class="form-horizontal" method="post">
				<h2>직원 등록</h2>
				<div class="form-group">
					<label for="emp_name" class="col-sm-3 control-label">이름</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="emp_name" name="emp_name" required/>
					</div>
				</div>
				<div class="form-group">
					<label for="emp_id" class="col-sm-3 control-label">아이디</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="emp_id" name="emp_id" required/>
					</div>
				</div>
				<div class="form-group">
					<label for="emp_email" class="col-sm-3 control-label">이메일</label>
					<div class="col-sm-3">
						<input type="text" class="form-control" id="emp_email" name="emp_email" placeholder="xxxx@xxxXX.xxx" required/>
					</div>
				</div>
				<div class="form-group">
					<label for="emp_birthday" class="control-label col-sm-3">생일</label>
					<div class="col-sm-3">
						<input type="text" class="form-control form_datetime" id="emp_birthday" name="emp_birthday" readonly>
					</div>
				</div>
				<div class="form-group">
					<label for="d_gender" class="col-sm-3 control-label">성별</label>
					<div id="d_gender" class="col-sm-3">
						<label class="radio-inline control-label">
							<input type="radio" id="emp_male" name="emp_gender" value="남" checked>남
						</label>
						<label class="radio-inline control-label">
							<input type="radio" id="emp_female" name="emp_gender" value="여">여
						</label>
					</div>
				</div>
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-3">
						<button class="btn btn-primary">등록</button>
					</div>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/_common/footer.jsp" />
</body>
</html>
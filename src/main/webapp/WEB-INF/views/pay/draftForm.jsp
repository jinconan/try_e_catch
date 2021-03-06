<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	List<Map<String,Object>> upperTeamMemberList = (List<Map<String,Object>>)request.getAttribute("upperTeamMemberList");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>트라E캐치-기안문서 작성</title>
<%@ include file="/WEB-INF/views/_common/commonUI.jsp"%>
<script type="text/javascript">
var $selectedDateField = null;
$(function() {
	//기안 타입 변경 콜백
	$("#dtname").change(function() {
		var dtnameVal = $("#dtname").val();
		if(dtnameVal == "휴가") {
			$("#d_picker").collapse("hide");
			$("#d_annu").collapse("show");
		} else {
			//휴가부분에서 선택했던 모든 값을 초기화해준다.
			$("#d_picker").collapse("hide");
			$("#d_annu").collapse("hide");
			$("#tdate").val("");
			$("#fdate").val("");
			
		}
	})
	
	//휴가 타입 변경 콜백
	$("#annuType").change(function() {
		$("#fdate").val("");
		$("#tdate").val("");
		$selectedDateField=null;
	})
	
	//날짜 창 클릭시 콜백
	$("#fdate").click(function() {
		$selectedDateField = $("#fdate");
		$("#d_picker").collapse("show");
	})
	
	$("#tdate").click(function() {
		if($("#annuType").val() !="연차") {
			return false;
		} else {
			$selectedDateField = $("#tdate");
			$("#d_picker").collapse("show");
		}
		
	})
	
	//달력 초기 세팅
	$("#annuDateTimePicker").datetimepicker({
		 inline: true
		 ,sideBySide: true
		 ,format : 'yyyy-mm-dd'
		 ,minView : 2
	})
	
	//달력 값 변경 콜백
	$("#annuDateTimePicker").datetimepicker().on("changeDate",function(ev) {
		$selectedDateField.val(dateToString(new Date(ev.date.valueOf())));
		$selectedDateField = null;
		$("#d_picker").collapse("hide");
	})
})
</script>
</head>
<body>
	<%@ include file="/WEB-INF/views/_common/header.jsp"%>
	<div class="container">
		<%@ include file="/WEB-INF/views/_common/submenu.jsp"%>
		<div class="col-md-10">
			<!-- title, dtname, content,ceno,aeno -->
			<form action="<%=request.getContextPath() %>/pay/draftInsert" class="form-horizontal" method="post">
				<div class="page-header">
					<h1>기안문서 작성</h1>
				</div>

				<div class="form-group">
					<label class="col-sm-3 control-label" for="doc_name">제목</label>
					<div class="col-sm-6">
						<input class="form-control" id="title" name="title" type="text" placeholder="제목" required="required">
					</div>
				</div>

				<div class="form-group">
					<label for="dtname" class="col-sm-3 control-label">문서 분류</label>
					<div class="col-sm-6">
						<select class="form-control" id="dtname" name="dtname">
							<option value="휴가">휴가</option>
							<option value="외근">외근</option>
							<option value="프로젝트보고서">프로젝트보고서</option>
							<option value="협찬보고서">협찬보고서</option>
							<option value="협업승인서">협업승인서</option>
							<option value="작업지시서">작업지시서</option>
							<option value="공간대여">공간대여</option>
							<option value="공용장비대여">공용장비대여</option>
							<option value="주말근무보고서">주말근무보고서</option>
							<option value="회식보고서">회식보고서</option>
							<option value="계약서">계약서</option>
							<option value="근로계약서">근로계약서</option>
							<option value="고용계약서">고용계약서</option>
							<option value="사직서">사직서</option>
						</select>
					</div>
				</div>
				<div class="form-group">
					<div id="d_annu" class="col-sm-offset-3 col-sm-6 collapse in">
						<div class="well">
							<div class="form-group">
								<label for="annuType" class="control-label sr-only"></label>
								<div class="col-sm-4">
									<select name="annuType" id="annuType" class="form-control">
										<option value="연차">연차</option>
										<option value="반차">반차</option>
										<option value="위로휴가">위로휴가</option>
									</select>
								</div>
								<div class="col-sm-8 input-group">
									<input type="text" id="fdate" name="fdate" class="form-control" readonly="readonly" aria-describedby="sizing-addon1"/>
									<span class="input-group-addon" id="sizing-addon1">~</span>
									<input type="text" id="tdate" name="tdate" class="form-control" readonly="readonly" aria-describedby="sizing-addon1"/>
								</div>
							</div>
							<div id="d_picker" class="form-group collapse">
								<div class="col-sm-offset-4 col-sm-8" style="text-align: center">
									<div id="annuDateTimePicker" style="display: inline-block;">
										<input id="annuDateTimePickerVal" type="hidden">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-3 control-label" for="ceno">승인자</label>
					<div class="col-sm-2">
						<select class="form-control" id="ceno" name="ceno" placeholder="승인자" required="required">
							<%if(upperTeamMemberList == null || upperTeamMemberList.size() == 0) { %>
								<option value="${sessionScope.emp_no}">${sessionScope.emp_name }</option>
							<%} else {%>
								<%for(int i=0;i<upperTeamMemberList.size();i++) { %>
									<option value="<%=upperTeamMemberList.get(i).get("ENO")%>"><%=upperTeamMemberList.get(i).get("ENAME") %></option>
								<%} %>
							<%} %>
						</select>
					</div>
					<label class="col-sm-2 control-label" for="aeno">결재자</label>
					<div class="col-sm-2">
						<select class="form-control" id="aeno" name="aeno" placeholder="결재자" required="required">
							<%if(upperTeamMemberList == null || upperTeamMemberList.size() == 0) { %>
								<option value="${sessionScope.emp_no}">${sessionScope.emp_name }</option>
							<%} else {%>
								<option value="<%=upperTeamMemberList.get(0).get("ENO")%>"><%=upperTeamMemberList.get(0).get("ENAME") %></option>
							<%} %>
						</select>
					</div>
				</div>
				
				<div class="form-group">
					<label class="col-sm-3 control-label" for="content">내용</label>
					<div class="col-sm-6">
						<textarea class="form-control" id="content" name="content" rows="20"  style="resize:vertical;" required="required"></textarea>
					</div>
				</div>
			 
				<div class="form-group">
					<div class="col-sm-offset-3 col-sm-6">
						<button class="btn btn-primary">작성</button>
						<a href="<%=request.getContextPath() %>/pay/draftList" class="btn btn-danger">취소</a>
					</div>
				</div>
			</form>
		</div>

	</div>

	<jsp:include page="/WEB-INF/views/_common/footer.jsp" />
</body>
</html>
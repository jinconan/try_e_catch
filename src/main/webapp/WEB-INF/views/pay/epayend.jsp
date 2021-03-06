<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    	  List<Map<String,Object>> epaywaitList = (List<Map<String,Object>>)request.getAttribute("epaywaitList"); 
         Object semp_no = session.getAttribute("emp_no");
         Object semp_name = session.getAttribute("emp_name");
         
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 대기 문서</title>
<%@ include file="/WEB-INF/views/_common/commonUI.jsp"%>
</head>
<body>

<script type="text/javascript">
var modal_row = null;

$(function() {
	$('#p_table').on('click-row.bs.table', function(e, row, $element, field) {
		modal_row = row;
		if (modal_row.SIGN_YN == -1) {
			$("#cname").html(row.CENAME + "<span class='glyphicon glyphicon-thumbs-down' aria-hidden='true'></span>");
		} else if (modal_row.SIGN_YN == -2) {
			$("#cname").html(row.CENAME + "<span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span>");
			$("#aname").html(row.AENAME + "<span class='glyphicon glyphicon-thumbs-down' aria-hidden='true'></span>");
		} else if (modal_row.SIGN_YN == 1) {
			$("#cname").html(row.CENAME + "<span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span>");
		} else if (modal_row.SIGN_YN == 2) {
			$("#cname").html(row.CENAME + "<span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span>");
			$("#aname").html(row.AENAME + "<span class='glyphicon glyphicon-thumbs-up' aria-hidden='true'></span>");
		}

		$("#exampleModal").modal('show');
		$("#dno").text(row.DNO);
		$("#udate").text(row.UDATE);
		$("#cdate").text(row.CDATE);
		$("#adate").text(row.ADATE);
		$("#name").text(row.ENAME);

		$("#content").html(row.CONTENT);
		$("#title").text(row.TITLE);
	})
	$('#printinp').click(function() {
		$('#print_table').printThis();
	});
});

</script>
	<jsp:include page="/WEB-INF/views/_common/header.jsp" />
	<div class="container">
		<%@ include file="/WEB-INF/views/_common/submenu.jsp"%>
		<div class="col-md-10">

			<div class="page-header">
				<h1>결재 완료 문서</h1>
			</div>
			<table class="table table-striped" id="p_table" 
				data-toggle="table"
				data-url="<%=request.getContextPath() %>/payR/epayend"
				data-show-columns="true" data-toolbar="#table-toolbar"
				data-pagination="true" data-page-list="[10]"
				data-side-pagination="server">
				<!-- RNO, DNAME, TITLE, CONTENT, UDATE, CENAME, AENAME, SIGN_YN, SRESULT -->
				<thead>
					<tr>
						<th data-field="RNO" data-visible="false">#</th>
						<th data-field="DNAME" data-sortable="true">종류</th>
						<th data-field="TITLE" data-sortable="true">제목</th>
						<th data-field="UDATE">기안날짜</th>
						<th data-field="CENAME">승인자</th>
						<th data-field="AENAME">결재자</th>
						<th data-field="SRESULT">현황</th>
					</tr>
				</thead>
			</table>
		</div>
		
		
		<!-- 상세내역 모달 페이지 -->
		<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header bg-primary">
						<h5 class="modal-title" id="exampleModalLabel">결재 완료 문서</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<div id="d_viewwork">
							<form id="f_update" method="post" action="<%=request.getContextPath()%>/payR/epay/epayend">
								<input type="hidden" name="signVal" id="signVal">
								<table id="print_table" border="1" class="center-block" style="width: 532px; text-align:center;" >
									<tr>
										<td colspan="5">
											<h3>기 안 서</h3>
										</td>
									</tr>
									<tr>
										<td width="15%">문서번호</td>
										<td width="45%" id="dno"></td>
										<td rowspan="2" width="10%">결재</td>
										<td width="15%">승인</td>
										<td width="15%">결재</td>
									</tr>
									<tr>
										<td>기안일자</td>
										<td id="udate"></td>
										<td id="cname"></td>
										<td id="aname"></td>
									</tr>
									<tr>
										<td>승인일자</td>
										<td id="cdate"></td>
										<td colspan="3">기안자</td>
									</tr>
									<tr>
										<td>결재일자</td>
										<td id="adate"></td>
										<td colspan="3" id="name"></td>
									</tr>
									<tr>
										<td>제목</td>
										<td colspan="4" id="title"></td>
									</tr>
									<tr>
										<td colspan="5">내용</td>
									</tr>
									<tr>
										<td id="content" colspan="5" rowspan="10" width="532" height="420"></td>
									</tr>
								</table>
								</form>
						</div>
					</div>
					
					<div class="modal-footer" >
					    <button type="button" class="btn btn-success" id="printinp">Print</button>
						<button type="button" class="btn btn-danger"
							data-dismiss="modal">닫기</button>

					</div>
				</div>
			</div>
		</div>
		<!-- 상세내역 모달 끝 -->
	</div>
	<jsp:include page="/WEB-INF/views/_common/footer.jsp" />
</body>
</html>
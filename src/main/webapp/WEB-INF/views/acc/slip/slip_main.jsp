<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/_common/commonUI.jsp"%>
<style>
.los {
	padding-right: 5px;
	padding-left: 5px;
}

.table-striped {
	margin-top: 10px;
}

.sx-buttom {
	margin-top: 30px;
}
</style>
<%
	int counts = (Integer)request.getAttribute("counts");
	int list = (((counts-1)/10)*10)+1;
	int num = (counts%10);
%>
</head>
	<script type="text/javascript">
		$(function() {
			$('#p_table').bootstrapTable({
				url:'<%=request.getContextPath()%>/accR/slip/<%=counts%>'				
			});		
			var base = $('#liid'+<%=num%>);
			base.addClass('active');
		});
	</script>
<body>
	<jsp:include page="/WEB-INF/views/_common/header.jsp" />
	<div class="container">
			<jsp:include page="/WEB-INF/views/_common/submenu.jsp" />
		<div class="col-sm-10">
			<form class="form-signin">
				<div class="row">
				<h2 class="form-signin-heading">작성한 전표</h2>
				</div>
				<div class="row">
					<table class="table table-striped" id="p_table">
						<thead>
							<tr>
								<th data-field="순번">번호</th>
								<th data-field="일자">일자</th>
								<th data-field="분류">분류</th>
								<th data-field="구분">구분</th>
								<th data-field="적요">적요</th>
								<th data-field="작성자">담당자</th>
								<th data-field="금액">금액</th>
								<th data-field="첨부자료">첨부자료</th>
							</tr>   
						</thead>
						<tbody>
					</tbody>
					</table>
					</div>
				<div class="row">
					<div class="col-xs-10 .col-md-10">
						<nav>
							<ul class="pagination">
								<li><a href="<%=request.getContextPath()%>/acc/slip/1" aria-label="Previous"><span
										aria-hidden="true"> << </span></a></li>
								<li><a href="<%=request.getContextPath()%>/acc/slip/<%=list-1%>" aria-label="Previous"><span aria-hidden="true"> < </span></a></li>
								<li id="liid1"><a href="<%=request.getContextPath()%>/acc/slip/<%=list%>"><%=list%><span class="sr-only">(current)</span></a></li>
								<li id="liid2"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+1%>"><%=list+1%><span class="sr-only">(current)</span></a></li>
								<li id="liid3"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+2%>"><%=list+2%><span class="sr-only">(current)</span></a></li>
								<li id="liid4"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+3%>"><%=list+3%><span class="sr-only">(current)</span></a></li>
								<li id="liid5"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+4%>"><%=list+4%><span class="sr-only">(current)</span></a></li>
								<li id="liid6"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+5%>"><%=list+5%><span class="sr-only">(current)</span></a></li>
								<li id="liid7"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+6%>"><%=list+6%><span class="sr-only">(current)</span></a></li>
								<li id="liid8"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+7%>"><%=list+7%><span class="sr-only">(current)</span></a></li>
								<li id="liid9"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+8%>"><%=list+8%><span class="sr-only">(current)</span></a></li>
								<li id="liid0"><a href="<%=request.getContextPath()%>/acc/slip/<%=list+9%>"><%=list+9%> <span class="sr-only">(current)</span></a></li>
								<li><a href="<%=request.getContextPath()%>/acc/slip/<%=list+10%>" aria-label="Previous"><span aria-hidden="true"> > </span></a></li>
								<li><a href="<%=request.getContextPath()%>/acc/slip/<%=list+100%>" aria-label="Previous"><span aria-hidden="true"> >> </span></a></li>
							</ul>
						</nav>
					</div>
					<div class="col-xs-2 col-md-2 sx-buttom">
						<input type="button" class="form-control" value="글작성" onclick="location.href='in'">
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
		$('#fromDate').datetimepicker({
			language : 'ko', // 화면에 출력될 언어를 한국어로 설정한다.
			pickTime : false, // 사용자로부터 시간 선택을 허용하려면 true를 설정하거나 pickTime 옵션을 생략한다.
			defalutDate : new Date() // 기본값으로 오늘 날짜를 입력한다. 기본값을 해제하려면 defaultDate 옵션을 생략한다.
		});
	
		$('#toDate').datetimepicker({
			language : 'ko',
			pickTime : false,
			defalutDate : new Date()
		});
	</script>
	<jsp:include page="/WEB-INF/views/_common/footer.jsp" />
</body>
</html>
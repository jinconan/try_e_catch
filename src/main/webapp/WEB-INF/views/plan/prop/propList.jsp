<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>기획서 리스트</title>
<%@ include file="/WEB-INF/views/_common/commonUI.jsp"%>
<script>
	$(document).ready(function() {
		$(".tr_prop").click(function() {
			var propNo = $(this).find("td")[0].innerText;
			location.href="<%=request.getContextPath()%>/plan/view/propDetail?propNo="+propNo;
		})
	})
	
</script>
</head>
<body>
	<!-- 헤더 -->
	<jsp:include page="/WEB-INF/views/_common/header.jsp" />

	<!-- 본문 -->
	<div class="container">
		<!-- 좌측 사이드 메뉴 -->
		<%@ include file="/WEB-INF/views/_common/submenu.jsp" %>
		
		<!-- 중앙 게시판 -->
		<!-- 테이블 + 페이지네이션 + 검색창 -->
		<div class="col-sm-10">
			<div class="well">
				<h2><strong>기획서 리스트</strong></h2>
				<table class="table table-condensed">
					<thead>
						<tr>
							<th width="10%">번호</th>
							<th width="50%">제목</th>
							<th width="20%">작성자</th>
							<th width="15%">작성일자</th>
							<th width="5%">
								<!-- 파일 다운로드URL 아이콘자리 -->
							</th>
						</tr>
					</thead>
					<tbody>
						<tr class="tr_prop">
							<td>1</td>
							<td>1빠</td>
							<td>견자단</td>
							<td>2015-09-30</td>
							<td></td>
						</tr>
						<tr class="tr_prop">
							<td>2</td>
							<td>2빠</td>
							<td>홍금보</td>
							<td>2016-09-30</td>
							<td></td>
						</tr>
						<tr class="tr_prop">
							<td>3</td>
							<td>3빠</td>
							<td>주성치</td>
							<td>2015-09-30</td>
							<td></td>
						</tr>
						<tr class="tr_prop">
							<td>4</td>
							<td>4빠</td>
							<td>이연걸</td>
							<td>2015-09-30</td>
							<td></td>
						</tr>
						<tr class="tr_prop">
							<td>5</td>
							<td>5빠</td>
							<td>재키찬</td>
							<td>2016-09-30</td>
							<td></td>
						</tr>
						<tr class="tr_prop">
							<td>6</td>
							<td>6빠</td>
							<td>이소룡</td>
							<td>2015-09-30</td>
							<td></td>
						</tr>
					</tbody>
				</table>
	
				<!-- 페이지네이션 -->
				<nav class="text-center">
					<ul class="pagination">
						<li class="disabled"><a href="#" aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
						</a></li>
						<li class="active"><a href="#">1 <span class="sr-only">(current)</span></a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#" aria-label="Next"> <span aria-hidden="true">&raquo;</span>
						</a></li>
					</ul>
				</nav>
	
				<!-- 검색창 -->
				<form class="form-inline text-center">
					<div class="form-group">
						<select class="form-control" id="searchPropColumn">
							<option>제목</option>
							<option>작성자</option>
						</select> 
						<label class="sr-only" for="searchProp">검색창</label> 
						<input type="text" class="form-control" id="searchProp" placeholder="검색">
						<button type="submit" class="btn btn-default">검색</button>
					</div>
				</form>
			</div>
		</div>

	</div>

	<jsp:include page="/WEB-INF/views/_common/footer.jsp" />
</body>
</html>
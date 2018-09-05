<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="/dev_jsp201809020/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/dev_jsp201809020/bootstrap/css/bootstrap-theme.min.css">
<script src="/dev_jsp201809020/bootstrap/js/jquery-2.2.4.min.js"></script>
<script src="/dev_jsp201809020/bootstrap/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<hr>
  <div class="container-fluid">
	<div class="row">
	  <div class="col-sm-10">
		<div class="panel panel-primary">
		  <div class="panel-heading">
		    <h3 class="panel-title">
		      <span class="glyphicon glyphicon-tags"></span>
				  &nbsp;&nbsp;재고 관리 대장
			</h3>
		   </div>
			
			 
			 <table class="table">
				  <thead>
				  	    <tr>
				  	    	<th>상품코드</th>
				  			<th>상품종류코드</th>
				  			<th>등록일자</th>
				  			<th>판매여부</th>
				  			<th>수량</th>
				  			<th>가격</th>
				 			<th>최근 거래일자</th>
				  		</tr>
				  	</thead>
				  	<tbody>
				  		<tr>
				  			<td>CRD-12</td>
				  			<td>rp-12</td>
				  			<td>2018-09-04</td>
				  			<td>판매중</td>
				  			<td>3</td>
				  			<td>19,000원</td>
				  			<td>2018-09-03</td>
				  			
				  		</tr>	
				  	</tbody>		
				  </table>
				  <button class="btn btn-default btn-xs" type="submit">추가</button>
				  <button class="btn btn-default btn-xs" type="submit">수정</button>
				  <button class="btn btn-default btn-xs" type="submit">수정</button>
				  <button class="btn btn-default btn-xs" type="submit">삭제</button>
			</div>	  
		</div>
	</div>
</div>	
	
			   
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 접속 중 리스트 -->
<div id="d_messenger" class="panel panel-info"" style="position: fixed; width: 300px; height: 100%; top: 0px; right: 0px;">
	<div class="panel-heading">
		<span>${sessionScope.emp_level}</span>
		<span>${sessionScope.emp_name}</span>
		<span>${sessionScope.emp_dept}</span>
	</div>
	<div style="height:100%;overflow:auto;">
		<ul id="online_list" class="list-group"></ul>
	</div>
</div>

<!-- 채팅창 -->
<div id="d_chat" class="panel panel-info" style="display:none;position: fixed; width: 350px; height: 50%; bottom: 0px; right: 300px;">
	<input type="hidden" class="emp_no"/>
	<input type="hidden" class="emp_level"/> 
	<input type="hidden" class="emp_name"/> 
	<input type="hidden" class="emp_dept"/> 
	
	<div class="panel-heading">
		<span id="panel-heading-title"></span>
		<a class="btn pull-right" aria-hidden="true" href="javascript:$('#d_chat').hide()">
			<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
		</a>
	</div>
	<div class="panel-body">
		<div style="overflow:auto; height: 250px; top: 0px; right: 0px;">
			<ul class="list-grouplist-group"></ul>
		</div>
	</div>
	<!-- 내부 입력창 -->
	<div class="input-group">
		<label for="chat_content" class="sr-only control-label">입력창</label>
		<input type="text" id="chat_content" class="form-control"> 
		<span class="input-group-btn">
			 <button id="btn_sendchat" class="btn btn-default" type="button">전송</button>
		</span>
	</div>
</div>


<!-- 메신저 스크립트 부분 -->
<script src=" <%=request.getContextPath()%>/resources/js/sockjs.min.js"></script>
<script>
	var wsocket = new SockJS("/tra_e_catch/echo-ws");
	
	wsocket.onopen = function() {
        console.log("연결되었습니다.");
    }
	wsocket.onmessage = function (evt) {
        var data = JSON.parse(evt.data);
        console.log("--서버로 부터 받은 메시지 -- ");
        console.log(data);
        
        switch(data.mtype) {
        case "open_self":
        	openSelfMsg(data);
        	break;
        case "open_other":
        	openOtherMsg(data);
        	break;
        case "close":
        	closeMsg(data);
        	break;
        case "clog":
        	$("#d_chat .list-grouplist-group").text("");
        	break;
        case "chat":
        	chatMsg(data);
        	break;
        }
        
    }
	wsocket.onclose = function () {
        console.log("연결끊김");
    }
	
	//채팅 전송 버튼 클릭 이벤트
	$("#btn_sendchat").click(function() {
		sendChat();
	})
	//채팅 입력창 엔터키 입력 이벤트
	$("#chat_content").keydown(function(e){
		if(e.key == "Enter")
			sendChat();
		else
			return;
	})
	
	//채팅 전송
	function sendChat() {
		var content = $("#chat_content").val();
		var msg = {
			mtype:"chat" 
			,from: ${sessionScope.emp_no}
			,to:Number($("#d_chat").find(".emp_no").val())
			,content:content
		}
		wsocket.send(JSON.stringify(msg));
		$("#chat_content").val("");
	}
	
	//현재 호스트가 접속했다는 메시지를 받았을때 함수
	function openSelfMsg(data) {
		var emp_no = data.emp_no;
		var emp_name = data.emp_name;
		var emp_level = data.emp_level;
		var emp_dept = data.emp_dept;
		var onlineList = data.onlineList;
		
		//접속자 리스트를 받아오는 것에 성공했다면 그것을 접속자 리스트에 출력한다.
		if(onlineList != null) {
			console.log("나를 제외한 접속자 수 : " + onlineList.length);
			
			for(var i=0;i<onlineList.length;i++) {
				$("#online_list").append("<li class='list-group-item' onclick='selectEmp($(this))'>"
						+"<span class='emp_no' style='display:none;'>"+onlineList[i].emp_no+"</span>"
						+"<span class='emp_level'>"+onlineList[i].emp_level+"</span>"
						+"<span class='emp_name'>"+onlineList[i].emp_name+"</span>"
						+"<span class='emp_dept'>("+onlineList[i].emp_dept+")</span></li>");
			}
		}
	}
	//새 접속자가 있음을 알리는 메시지를 받았을 때 함수
	function openOtherMsg(data) {
		var emp_no = data.emp_no;
		var emp_name = data.emp_name;
		var emp_level = data.emp_level;
		var emp_dept = data.emp_dept;
		
		$("#online_list").append("<li class='list-group-item' onclick='selectEmp($(this))'>"
				+"<span class='emp_no' style='display:none;'>"+emp_no+"</span>"
				+"<span class='emp_level'>"+emp_level+"</span>"
				+"<span class='emp_name'>"+emp_name+"</span>"
				+"<span class='emp_dept'>("+emp_dept+")</span></li>");
	}
	
	//타 호스트의 소켓 연결 해제 메시지를 받았을때 함수
	function closeMsg(data) {
		var emp_no = data.emp_no;
		var $onlineEmp = $("#online_list .emp_no");
		
		$.each($onlineEmp, function(i,data){
			if($onlineEmp.eq(i).text() == emp_no) {
				$onlineEmp.eq(i).closest(".list-group-item").remove();
				return;
			}
		})
	}
	
	//채팅로그 요청에 대한 응답메시지를 받았을때 함수
	function clogMsg(data) {
		
	}
	
	//서버로부터 받은 채팅메시지 처리에 대한 함수
	function chatMsg(data) {
		//현재 열린 창에서의 대화인 경우 출력. 아닌경우 출력X.
    	var another = $("#d_chat").find(".emp_no").val();
		//another ==data.to : 보낸것
    	//another ==data.from : 받은것.
    	if(another == data.from || another == data.to) {
    		var newchat = "<li class='list-group-item'>";
    		if(another == data.from)
    			newchat = newchat +"&lt;"+$("#d_chat").find(".emp_name").val()+"&gt;";
   			else
   				newchat = newchat +"&lt;${sessionScope.emp_name}&gt;";	
			newchat+="<span>["+data.timestamp+"]</span>";
    		newchat+="<div>"+data.content+"</div></li>";
    		$("#d_chat .list-grouplist-group").append(newchat);
    		$("#d_chat .panel-body>div").scrollTop($("#d_chat .list-grouplist-group")[0].scrollHeight);
    	}
	}
	
	//사람 선택
	function selectEmp($obj) {
		$("#d_chat").show();
		$("#d_chat").find(".emp_no").val($obj.find(".emp_no").text());
		$("#d_chat").find(".emp_level").val($obj.find(".emp_level").text());
		$("#d_chat").find(".emp_name").val($obj.find(".emp_name").text());
		$("#d_chat").find(".emp_dept").val($obj.find(".emp_dept").text());
		
		$("#panel-heading-title").html($("#d_chat").find(".emp_name").val()+$("#d_chat").find(".emp_dept").val());
		var msg= { 
			mtype:"clog"
			,from: ${sessionScope.emp_no}
			,to : Number($("#d_chat").find(".emp_no").val())
		}
		wsocket.send(JSON.stringify(msg));
	}
</script>
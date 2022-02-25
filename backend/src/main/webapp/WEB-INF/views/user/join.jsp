<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
        	var isId = false;
        	var isPwd = false;
        	// 아이디 중복검사
        	$("#userid").keyup(function () {
        		var ckid = $("#userid").val();
        		if(ckid.length < 6 || ckid.length > 16) {
        			$("#idresult").text("아이디는 6자이상 16자이하입니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
        			isId = false;
        		} else {
	                $.ajax({
	                	url: '${root}/user/idcheck',
	                	data: {'ckid': ckid},
	                  	type: 'GET',
	                  	dataType: 'json',
	                  	success: function (response) {
	                  		console.log(response);
	                    	var cnt = response.idcount;
	                    	if(cnt == 0) {
	                    		$("#idresult").text(ckid + "는 사용가능합니다.").removeClass('text-dark').removeClass('text-danger').addClass('text-primary');
	                    		isId = true;
	                    	} else {
	                    		$("#idresult").text(ckid + "는 사용할 수 없습니다.").removeClass('text-dark').removeClass('text-primary').addClass('text-danger');
	                    		isId = false;
	                    	}
	                  	}, 
	                  	error: function(request, status, error) {
	                  		console.log("status : " + request.status + "\tmsg : " + error);
	                  	}
					});
        		}
			}); 
        	
        	//비밀번호 보안 검사
        	$("#userpwd").keyup(function () {
        		 var pw = $("#userpwd").val();
        		 var num = pw.search(/[0-9]/g);
        		 var eng = pw.search(/[a-z]/ig);
        		 var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);

        		 if(pw.length < 8 || pw.length > 16){
        			 $("#pwdresult").text("아이디는 8자이상 16자이하입니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
        			 isPwd = false;
        		 }else if(pw.search(/\s/) != -1){
        			 $("#pwdresult").text("8~16자 영문자, 숫자, 특수문자를 사용하세요...").removeClass('text-primary').removeClass('text-dark').addClass('text-danger');
        			 isPwd = false;
        		 }else if(num < 0 || eng < 0 || spe < 0 ){
        			 $("#pwdresult").text("8~16자 영문자, 숫자, 특수문자를 사용하세요...").removeClass('text-primary').removeClass('text-dark').addClass('text-danger');
        			 isPwd = false;
        		 }else {
        			 $("#pwdresult").text("사용가능한 비밀번호입니다").removeClass('text-danger').removeClass('text-dark').addClass('text-primary');
        			 isPwd = true;
        			 
        		 }
			}); 
        	
        	//비밀번호 보안 검사 (서버)
        	/* $("#userpwd").keyup(function () {
        		var pw = $("#userpwd").val();
       		 	var num = pw.search(/[0-9]/g);
       		 	var eng = pw.search(/[a-z]/ig);
       		 	var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
       		 
       		 
       		 if(pw.length < 8 || pw.length > 16){
    			 $("#pwdresult").text("아이디는 8자이상 16자이하입니다.").removeClass('text-primary').removeClass('text-danger').addClass('text-dark');
    			 isPwd = false;
    		 } else if(pw.search(/\s/) != -1){
    			 $("#pwdresult").text("8~16자 영문자, 숫자, 특수문자를 사용하세요...").removeClass('text-primary').removeClass('text-dark').addClass('text-danger');
    			 isPwd = false;
    		 } else if(num < 0 || eng < 0 || spe < 0 ){
    			 $("#pwdresult").text("8~16자 영문자, 숫자, 특수문자를 사용하세요...").removeClass('text-primary').removeClass('text-dark').addClass('text-danger');
    			 isPwd = false;
    		 } else {
	                $.ajax({
	                	url: '${root}/user/pwdcheck',
	                	data: {'ckpwd': ckpwd},
	                  	type: 'GET',
	                  	dataType: 'json',
	                  	success: function (response) {
	                  		console.log(response);
	                  		 $("#pwdresult").text("사용가능한 비밀번호입니다").removeClass('text-danger').removeClass('text-dark').addClass('text-primary');
	                  		 isPwd=true;
	                  	}, 
	                  	error: function(request, status, error) {
	                  		console.log("status : " + request.status + "\tmsg : " + error);
	                  	}
					});
        		}
			}); */
        	
        	// 회원가입
            $("#registerBtn").click(function () {
                if (!$("#username").val()) {
                    alert("이름 입력!!!");
                    return;
                } else if (!isId) {
                    alert("아이디 확인!!!");
                    return;
                } else if (!isPwd) {
                    alert("보안에 취약한 비밀번호입니다!!!");
                    return;
                } else if ($("#userpwd").val() != $("#pwdcheck").val()) {
                    alert("비밀번호 확인!!!");
                    return;
                } else {
                	$("#email").val($("#emailid").val() + "@" + $("#emaildomain").val());
                    $("#memberform").attr("action", "${root}/user/register").submit();
                }
            });

            // $('#zipcode').focusin(function () {
            //     $('#zipModal').modal();
            // });
        });
    </script>
</head>
<body>
	<div class="container">
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	    <div class="container text-center mt-3">
		    <div class="p-3 mb-3 shadow bg-light" style="margin-top:50px">
		        <div class="col-lg-8 mx-auto">
		            <h2>🏠 회원가입 🏠</h2>
		            <form id="memberform" class="text-left mb-3" method="post" action="">
		            <input type="hidden" id="email" name="email">
		                <div class="form-group">
		                    <label for="username">이름</label>
		                    <input type="text" class="form-control" id="username" name="userName" placeholder="이름입력...">
		                </div>
		                <div class="form-group">
		                    <label for="userid">아이디</label>
		                    <input type="text" class="form-control" id="userid" name="userId" placeholder="아이디입력...">
		                    <div id="idresult" class="mt-1"></div>
		                </div>
		                <div class="form-group">
		                    <label for="userpwd">비밀번호</label>
		                    <input type="password" class="form-control" id="userpwd" name="userPwd" placeholder="8~16자 영문자, 숫자, 특수문자를 사용하세요...">
		                    <div id="pwdresult" class="mt-1"></div>
		                </div>
		                <div class="form-group">
		                    <label for="pwdcheck">비밀번호재입력</label>
		                    <input type="password" class="form-control" id="pwdcheck" name="pwdcheck" placeholder="비밀번호재입력...">
		                </div>
		                <div class="form-group">
		                    <label for="emailid">이메일</label><br>
		                    <div id="email" class="custom-control-inline">
		                        <input type="text" class="form-control" id="emailid" name="emailid" placeholder="이메일아이디입력..."
		                            size="25"> @
		                        <select class="form-control" id="emaildomain" name="emaildomain">
		                            <option value="ssafy.com">싸피</option>
		                            <option value="naver.com">네이버</option>
		                            <option value="kakao.com">카카오</option>
		                            <option value="google.com">구글</option>
		                        </select>
		                    </div>
		                </div>
		                
		                <div class="form-group text-center">
		                    <button type="button" id="registerBtn" class="btn btn-warning">회원가입</button>
		                    <button type="reset" class="btn btn-outline-danger">초기화</button>
		                </div>
		            </form>
		        </div>
		     </div>
	    </div>
    </div>
   
</body>
</html>
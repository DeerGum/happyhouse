<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#registerBtn").click(function () {
                if (!$("#subject").val()) {
                    alert("제목 입력!!!!");
                    return;
                } else if (!$("#content").val()) {
                    alert("내용 입력!!!!");
                    return;
                } else {
                    $("#writeform").attr("action", "${root}/guestbook/register").submit();
                }
            });
        });
    </script>
    
    <div class="container">
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
    <div class="container text-center mt-3">
        <div class="col-lg-8 mx-auto" style="margin-top:50px">
            	<h2>🏠 공지사항 작성 🏠</h2>
            <form id="writeform" class="text-left mb-3" method="post" enctype="multipart/form-data" action="">
                <div class="form-group">
                    <label for="subject">제목:</label>
                    <input type="text" class="form-control" id="subject" name="subject" placeholder="제목...">
                </div>
                <div class="form-group">
                    <label for="content">내용:</label>
                    <textarea class="form-control" rows="15" id="content" name="content"></textarea>
                </div>
                <div class="form-group" align="left">
					<label for="upfile">파일:</label>
					<input type="file" class="form-control-file border" name="upfile" multiple="multiple">
				</div>
                <div class="text-center">
                    <button type="button" id="registerBtn" class="btn btn-outline-primary">글작성</button>
                    <button type="reset" class="btn btn-outline-danger">초기화</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
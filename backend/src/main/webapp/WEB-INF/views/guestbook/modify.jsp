<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#modifyBtn").click(function () {
                if (!$("#subject").val()) {
                    alert("제목 입력!!!!");
                    return;
                } else if (!$("#content").val()) {
                    alert("내용 입력!!!!");
                    return;
                } else {
                    $("#writeform").attr("action", "${root}/guestbook/modify").submit();
                }
            });
        });
    </script>
	<div class="container">
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
	    <div class="container text-center mt-3">
	        <div class="col-lg-8 mx-auto" style="margin-top:50px">
            	<h2>🏠 공지사항 수정 🏠</h2>
	            <form id="writeform" class="text-left mb-3" method="post" action="">
	            	<input type="hidden" name="articleNo" value="${article.articleNo}">
	                <!-- <div class="form-group">
	                    <label for="userid">작성자ID:</label>
	                    <input type="text" class="form-control" id="userid" name="userid" placeholder="작성자ID...">
	                </div> -->
	                <div class="form-group">
	                    <label for="subject">제목:</label>
	                    <input type="text" class="form-control" id="subject" name="subject" value="${article.subject}">
	                </div>
	                <div class="form-group">
	                    <label for="content">내용:</label>
	                    <textarea class="form-control" rows="15" id="content" name="content">${article.content}</textarea>
	                </div>
	                <div class="text-center">
	                    <button type="button" id="modifyBtn" class="btn btn-outline-primary">글수정</button>
	                    <button type="reset" class="btn btn-outline-danger">초기화</button>
	                </div>
	            </form>
	        </div>
	    </div>
	</div>
</body>
</html>
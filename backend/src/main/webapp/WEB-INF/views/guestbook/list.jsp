<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/header.jsp" %>

	<c:if test="${!empty msg}">
	<script>
	alert("${msg}");
	</script>
	</c:if>
    <script type="text/javascript">
        $(document).ready(function () {
        	
        	if("${key}")
        		$("#skey").val("${key}").prop("selected", true);

        	$("#mvRegisterBtn").click(function () {
                location.href = "${root}/guestbook/register";
            });
        	
        	$("#searchBtn").click(function () {
                var word = $("#sword").val();
                if(word == "") {
                	alert("모든 목록 조회!!!");
                }
                $("#searchform").attr("action", "${root}/guestbook/list").submit();
            });
        	
        	$(".page-item").click(function() {
				$("#pg").val(($(this).attr("data-pg")));
				$("#pageform").attr("action", "${root}/guestbook/list").submit();
			});
        	
        	//file download
            $('.filedown').click(function() {
        		// alert("원본 :  " + $(this).attr('ofile') + "      실제 :  " + $(this).attr('sfile'));
        		$(document).find('[name="sfolder"]').val($(this).attr('sfolder'));
        		$(document).find('[name="ofile"]').val($(this).attr('ofile'));
        		$(document).find('[name="sfile"]').val($(this).attr('sfile'));
        		$('#downform').attr('action', '${root}/guestbook/download').attr('method', 'get').submit();
        	});
        });
    </script>
    <form name="pageform" id="pageform" method="GET" action="">
		<input type="hidden" name="pg" id="pg" value="">
		<input type="hidden" name="key" id="key" value="${key}">
		<input type="hidden" name="word" id="word" value="${word}">
	</form>
	<form id="downform">
		<input type="hidden" name="sfolder">
		<input type="hidden" name="ofile">
		<input type="hidden" name="sfile">
	</form>
	<div class="container">
	<%@ include file="/WEB-INF/views/include/nav.jsp" %>
    <div class="container text-center mt-3">
        <div class="col-lg-8 mx-auto" style="margin-top:50px">
            <h2>🏠 공지사항 목록 🏠</h2>
            <div class="m-3 text-right">
            	<c:if test="${!empty userinfo}">
                	<button type="button" id="mvRegisterBtn" class="btn btn-outline-secondary">공지사항 작성</button>
                </c:if>
            </div>
            <div class="m-3 row justify-content-end">
            	<form id="searchform" class="form-inline" method="get">
            		<input type="hidden" name="pg" value="1">
	            	<select id="skey" name="key" class="form-control">
	            		<option value="userid"> 아이디
	            		<option value="articleno"> 글번호
	            		<option value="subject"> 제목
	            	</select>
	            	<input type="text" class="ml-1 form-control" id="sword" name="word" value="${word}">
	            	<button type="button" id="searchBtn" class="ml-1 btn btn-outline-primary">검색</button>
            	</form>
            </div>
		<c:if test="${!empty articles}">
			<c:forEach var="article" items="${articles}">
			<table class="table table-active text-left">
				<tbody>
					<tr class="table-info">
						<td>작성자 : ${article.userName}</td>
						<td class="text-right">작성일 : ${article.regTime}</td>
					</tr>
					<tr>
						<td colspan="2" class="table-primary">
							<strong>${article.articleNo}. ${article.subject}</strong>
						</td>
					</tr>
					<tr>
						<td class="p-4" colspan="2">
							${article.content}
						</td>
					</tr>
					<c:if test="${!empty article.fileInfos}">
					<tr>
						<td colspan="2">
							<ul>
								<c:forEach var="file" items="${article.fileInfos}">
									<li>${file.originFile} <a href="#" class="filedown" sfolder="${file.saveFolder}" sfile="${file.saveFile}" ofile="${file.originFile}">[다운로드]</a>
								</c:forEach>
							</ul>
						</td>
					</tr>
					</c:if>
					<c:if test="${userinfo.userId eq article.userId}">
					<tr>
						<td colspan="2" class="text-right">
							<a href="${root}/guestbook/modify?articleno=${article.articleNo}">수정</a>
							<a href="${root}/guestbook/delete?articleno=${article.articleNo}">삭제</a>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
			</c:forEach>
			<div class="m-3 row justify-content-center">${navigation.navigator}</div>
		</c:if>
		<c:if test="${empty articles}">
			<table class="table table-active text-center">
				<tr class="table-info">
					<td>작성한 글이 없습니다.</td>
				</tr>
			</table>
		</c:if>
		</div>
    </div>
   </div>
</body>
</html>
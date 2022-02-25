<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script type="text/javascript">
	$(document).on("click", ".list", function() {
		$.get(root + "/map/list/"
				,{aptCode: $(this).text()}
				,function(data, status){
					$("#searchResult").empty();
					$.each(data, function(index, vo) {
						console.log(data);
						let str = `
							<tr class="${ '${colorArr[index%3]}' }">
							<td>${ '${vo.aptName}' }</td>
							<td>${ '${vo.sidoName}' } ${ '${vo.gugunName}' } ${ '${vo.dongName}' } ${ '${vo.jibun}' }</td>
							<td>${ '${vo.dealYear}' }-${ '${vo.dealMonth}' }-${ '${vo.dealDay}' }</td>
							<td>${ '${vo.dealAmount}' }</td>
							</tr>
						`;
						$("#searchResult").append(str);
					});
				}
				, "json"
		);
	});
	
	$('#apt-modal').on('show.bs.modal', function(event) {
		var button = $(event.relatedTarget) // Button that triggered the modal
		var recipient = button.data('whatever') // Extract info from data-* attributes
		// If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
		// Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
		var modal = $(this)
		modal.find('.modal-title').text('New message to ' + recipient)
		modal.find('.modal-body input').val(recipient)
	})
	
	
</script>
<div class="modal fade" id="apt-modal" tabindex="-1" role="dialog"
	aria-labelledby="aptModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">부동산 거래내역</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<table class="table mt-2">
							<colgroup>
								<col width="150">
								<col width="*">
								<col width="120">
								<col width="120">
							</colgroup>	
							<thead>
								<tr>
									<th>아파트이름</th>
									<th class="text-center">주소</th>
									<th>거래날짜</th>
									<th>거래금액</th>
								</tr>
							</thead>
							<tbody id="searchResult"></tbody>
						</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
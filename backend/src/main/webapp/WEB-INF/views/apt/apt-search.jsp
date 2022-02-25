<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/include/header.jsp"%>
</head>
<body>
	<div class="container">
		<%@ include file="/WEB-INF/views/include/nav.jsp"%>

		<section id="index_section">
			<div class="card col-sm-12 mt-1" style="min-height: 850px;">
				<div class="card-body">
					<h3>아파트 검색</h3>
					<hr>
					<div class="input-group w-25 mb-3">
						<input type="text" id="input-name" class="form-control"
							placeholder="아파트 이름으로 검색" aria-label="apt-search"
							aria-describedby="basic-addon2">
						<div class="input-group-append">
							<button class="btn btn-outline-dark" type="button"
								id="aptSearchBtn">검색</button>
						</div>
					</div>
					<div class="mt-1 text-dark">검색어 중간에 공백이 없어야 하고 ('-' ',' '(' ')')를 제외한 특수문자는 사용하지 말아주세요.</div>
					<table class="table mt-2">
						<colgroup>
							<col width="100">
							<col width="150">
							<col width="*">
							<col width="120">
							<col width="120">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>아파트이름</th>
								<th class="text-center">주소</th>
								<th>건축연도</th>
								<th>최근거래금액</th>
							</tr>
						</thead>
						<tbody id="recentResult"></tbody>
					</table>
					<div id="map" style="width: 100%; height: 500px;"></div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ba1dc50f910fba4b5a6474cab7c94362&libraries=services"></script>
					<script type="text/javascript" src="js/map.js"></script>
					<script type="text/javascript">
					let colorArr = ['table-primary','table-success','table-danger'];
					
					
					$(document).on("click", "#aptSearchBtn", function() {
						console.log($("#input-name").val());
						let keyword = $("#input-name").val();
		                $.get(root + "/map/keywordcheck/"
		                		,{'keyword': keyword}
		                		,function (data, status) {
		                		console.log(data);
		                		if(data.isValid == 'pass') {	//유효한 키워드
		                			$.get(root + "/map/search"
		    								,{aptName: $("#input-name").val()}
		    								,function(data, status){
		    									let isEmpty = true;
		    									$("#recentResult").empty();
		    									$.each(data, function(index, vo) {
		    										console.log(data);
		    										isEmpty = false;
		    										let str = `
		    											<tr class="${ '${colorArr[index%3]}' }">
		    											<td class="list btn btn-outline-dark btn-lg" data-toggle="modal" data-target="#apt-modal" data-whatever="@getbootstrap">${ '${vo.aptCode}' }</td>
		    											<td>${ '${vo.aptName}' }</td>
		    											<td>${ '${vo.sidoName}' } ${ '${vo.gugunName}' } ${ '${vo.dongName}' } ${ '${vo.jibun}' }</td>
		    											<td>${ '${vo.buildYear}' }</td>
		    											<td>${ '${vo.recentPrice}' }</td>
		    											</tr>
		    										`;
		    										$("#recentResult").append(str);
		    									});
		    									
		    									if(!isEmpty) 
		    										displayMarkers(data);
		    									else {
		    										let str = `
		    											<tr class="table-danger">
		    											<td>-</td>
		    											<td>-</td>
		    											<td>검색 결과가 없습니다.</td>
		    											<td>-</td>
		    											<td>-</td>
		    											</tr>
		    										`;
		    										$("#recentResult").append(str);
		    									}
		    								}
		    								, "json"
		    						);
		                    	} else {	//유효하지 않은 키워드
		                    		alert("검색어가 유효하지 않습니다.");
		                    	}
		                	}
		                	, "json"
		                );
		                
		                /*  */
					});
					
					
					</script>
				</div>
			</div>
			<%@ include file="/WEB-INF/views/apt/apt-modal.jsp"%>
		</section>
	</div>
</body>
</html>

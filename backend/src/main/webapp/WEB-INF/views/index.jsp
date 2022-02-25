<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/views/include/header.jsp" %>
</head>
<body>
	<div class="container">
		<%@ include file="/WEB-INF/views/include/nav.jsp" %>
			<section id="index_section">
				<div class="card col-sm-12 mt-1" style="min-height: 850px;">
					<div class="card-body">
						시도 : 
						<select id="sido">
							<option value="0">선택</option>
						</select>
						구군 : 
						<select id="gugun">
							<option value="0">선택</option>
						</select>
						읍면동 : 
						<select id="dong">
							<option value="0">선택</option>
						</select>
						<button type="button" id="aptSearchBtn">검색</button>
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
					<div id="map" style="width:100%;height:500px;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ba1dc50f910fba4b5a6474cab7c94362&libraries=services"></script>
					<script type="text/javascript" src="js/map.js"></script>
					<script type="text/javascript">
					let colorArr = ['table-primary','table-success','table-danger'];
					$(document).ready(function(){					
						$.get(root + "/map/sido"
							,function(data, status){
								$.each(data, function(index, vo) {
									$("#sido").append("<option value='"+vo.sidoCode+"'>"+vo.sidoName+"</option>");
								});
							}
							, "json"
						);
					});
					$(document).on("change", "#sido", function() {
						$.get(root + "/map/gugun"
								,{sido: $("#sido").val()}
								,function(data, status){
									$("#gugun").empty();
									$("#gugun").append('<option value="0">선택</option>');
									$.each(data, function(index, vo) {
										$("#gugun").append("<option value='"+vo.gugunCode+"'>"+vo.gugunName+"</option>");
									});
								}
								, "json"
						);
					});
					$(document).on("change", "#gugun", function() {
						$.get(root + "/map/dong"
								,{gugun: $("#gugun").val()}
								,function(data, status){
									$("#dong").empty();
									$("#dong").append('<option value="0">선택</option>');
									$.each(data, function(index, vo) {
										$("#dong").append("<option value='"+vo.dongCode+"'>"+vo.dongName+"</option>");
									});
								}
								, "json"
						);
					});
					$(document).on("change", "#dong", function() {
						$.get(root + "/map/apt"
								,{dong: $("#dong").val()}
								,function(data, status){
									$("#recentResult").empty();
									$.each(data, function(index, vo) {
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
									displayMarkers(data);
								}
								, "json"
						);
					});
					
					$(document).on("click", "#aptSearchBtn", function() {
						var param = {
								serviceKey:'rIGDG4GJOBHSiJzAcycITR+pTLX0dfw7m3x96ibyz0ypQ5TwMxWEOmC7Vx2yqaXHESp08e3iM1m75pxUxNMKmw==',
								pageNo:encodeURIComponent('1'),
								numOfRows:encodeURIComponent('10'),
								LAWD_CD:encodeURIComponent($("#gugun").val()),
								DEAL_YMD:encodeURIComponent('202110')
						};
						$.get('http://openapi.molit.go.kr/OpenAPI_ToolInstallPackage/service/rest/RTMSOBJSvc/getRTMSDataSvcAptTradeDev'
								,param
								,function(data, status){
									var items = $(data).find('item');
									var jsonArray = new Array();
									items.each(function() {
										var jsonObj	= new Object();
										jsonObj.aptCode = $(this).find('일련번호').text();
										jsonObj.aptName = $(this).find('아파트').text();
										jsonObj.dongCode = $(this).find('법정동읍면동코드').text();
										jsonObj.buildYear = $(this).find('건축년도').text();
										jsonObj.jibun = $(this).find('지번').text();
										jsonObj.recentPirce = $(this).find('거래금액').text();
											
										jsonObj = JSON.stringify(jsonObj);
										jsonArray.push(JSON.parse(jsonObj));
									});
									console.log(jsonArray);
								}
								, "xml"
						);
						
					});
					</script>
					</div>
				</div>
				<%@ include file="/WEB-INF/views/apt/apt-modal.jsp" %>
			</section>
		</div>
	</body>
</html>

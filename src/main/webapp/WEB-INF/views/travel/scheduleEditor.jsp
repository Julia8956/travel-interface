<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TI - Schedule Editor</title>
</head>
<style>
	.overlayPanel {
		display:inline-block;
	}
	.panel-heading {
		background:#8e44ad;
		color:white;
	}
	.notification {
		background:#C6E4F3;
	}
	.tag.is-primary {
		color:white !important;
		text-decoration:none !important;
	}
	.dayMemo {
		width:60%;
	}
	.tag:hover{
		cursor:pointer;
	}
	.schInfoBtn:hover, .backBtn:hover {
		cursor:pointer;
		color:#7AD9FC;
	}
	.overlay {
	  height: 100%;
	  width: 0;
	  position: fixed;
	  z-index: 10;
	  top: 0;
	  left: 0;
	  background-color: rgb(0,0,0);
	  background-color: rgba(0,0,0, 0.9);
	  overflow-x: auto;
	  transition: 0.9s;
	}
	.overlay-content {
	  position: relative;
	  top: 25%;
	  width: 100%;
	  text-align: center;
	  margin-top: 30px;
	}
	.overlay .closebtn {
	  position: absolute;
	  top: 100px;
	  right: 45px;
	  font-size: 60px;
	}
	@media screen and (max-height: 450px) {
	  .overlay a {font-size: 20px}
	  .overlay .closebtn {
	  font-size: 40px;
	  top: 15px;
	  right: 35px;
	  }
	}
	#left-panel {
		background: #fff;
    	opacity: 0.8;
		width:200px;
		height:400px;
		overflow-y:scroll;
		display:inline-block;
		position:absolute;
		z-index:10;
	}
	#detail-panel {
		background: #fff;
		height:500px;
		width:250px;
		overflow-y:scroll;
		display:inline-block;
		position:absolute;
		z-index:11;
	}
	#placeDetail {
		overflow-y:scroll;
	}
	#left-panel>ul {
		overflow-y:scroll;
	}
	#left-panel li {
		border:1px solid lightgray;
	}
	#left-panel li:hover {
		cursor:pointer;
		background:lightgray;
		opacity:0.9;
	}
	.dayList {
		min-height:400px;
		overflow-y:scroll;
	}
	#likeList, #recommList {
		min-height:430px;
		overflow-y:scroll;
	}
</style>
<body>
	<div id="myNav" class="overlay">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<div class="overlay-content">
			<c:forEach var="trvDay" items="${ trvDayList }" varStatus="st" >
				<nav class="panel dayPanel overlayPanel" style="width:300px">
					<div class="panel-heading" align="center"
						style="background: whitesmoke; color: black; height: 30px">
						<p class="help">${ trvDay.dayDate }</p>
					</div>
					<div class="panel-heading" align="center" style="margin: 0">
						<span>DAY ${ trvDay.dayNumber }</span>&nbsp; 
						<input type="hidden" value="${ trvDay.dayId }">
						<input class="input dayMemo is-small day${ trvDay.dayId }Memo" type="text" placeholder="MEMO" value="${ trvDay.dayMemo }">
					</div>
					<!-- <label class="panel-block"><input type="checkbox">시간 보이기</label> -->
					<ul class="connectedSortable menu-list dayList" style="background:white">
						<c:forEach var="sch" items="${ trvDay.schList }" varStatus="st">
							<li class=" panel-block" style="background: white">
								<div class="media-left" style="width: 20%">
									
									<p>${ sch.startTime } - ${ sch.endTime }</p>
								</div>
								<div class="media-content" style="width: 70%">
									<div class="content">
										<p><strong>${ sch.schTitle }</strong></p>
										<small>${ sch.trvCost.costType } : 
											<strong>${ sch.trvCost.costAmount }</strong>
											${ sch.trvCost.currency }
										</small> 
										<small>${ sch.schTransp }</small> 
										<small>
											<a style="color: purple"> 
												<span class="icon is-small"style="color: purple"> 
													<i class="fas fa-map-marker-alt"></i>
												</span> 
												<c:if test="${ sch.plcName ne null }">
													${ sch.plcName }
												</c:if> 
												<c:if test="${ sch.plcName eq null }">
													(장소 정보 없음)
												</c:if>
											</a>
										</small>
									</div>
								</div>
								<div class="media-right" style="width: 10%">
									<input type="hidden" value="${ sch.schId }" name="schId"> 
									<button class="delete schDeleteBtn" aria-label="close" ></button>
									<br><br> 
									<span class="icon schInfoBtn" data-tooltip="일정 정보 수정" data-variation="mini"
									data-position="left center">
										<i class="fas fa-edit"></i>
									</span>
								</div>
							</li>
						</c:forEach>
					</ul>
					<div class="panel-block">
						<button class="button is-primary is-outlined is-fullwidth"
							onclick="$('#newScheduleModal').toggleClass('is-active')">일정 추가</button>
					</div>
				</nav>
			</c:forEach>
		</div>
	</div>


	<!-- ------------------------------------------------------------- -->
	<div class="columns">
		<div class="column">
			<section class="section">
				<div class="columns">
					<div class="column is-3">
						<div style="height:50px">
							<span style="font-size:20px;cursor:pointer" onclick="openNav()">&#9776; 일정 펼쳐보기</span>
						</div>
						<c:forEach var="trvDay"  items="${ trvDayList }" varStatus="st" >
							<nav class="panel dayPanel" id="day${ trvDay.dayNumber }" style="display:none">
								<div class="panel-heading" align="center" 
								style="background:whitesmoke;color:black;;height:30px">
									<p class="help">${ trvDay.dayDate }</p>
								</div>
								<div class="panel-heading columns is-mobile" align="center" style="margin:0">
									<div class="column is-2" style="padding-left:0">
										<a class="button is-small dayLeftBtn">
											<span class="icon"> 
												<i class="fas fa-2x fa-caret-left"></i>
											</span>
										</a>
									</div>
									<div class="column is-8 dayTitle"  style="padding-left:0; padding-right:0">
										<span>DAY ${ trvDay.dayNumber }</span>&nbsp;
										<input type="hidden" value="${ trvDay.dayId }" />
										<input class="input dayMemo is-small day${ trvDay.dayId }Memo" type="text" placeholder="MEMO"
											value="${ trvDay.dayMemo }" >
									</div>
									<div class="column is-2" style="padding-right:0">
										<a class="button is-small dayRightBtn">
											<span class="icon"> 
												<i class="fas fa-2x fa-caret-right"></i>
											</span>
										</a>
									</div>
								</div>
								<!-- <label class="panel-block"><input type="checkbox">시간 보이기</label> -->
								<ul class="connectedSortable menu-list dayList" id="day${ trvDay.dayNumber }List">
									<c:forEach var="sch" items="${ trvDay.schList }" varStatus="st">
										<li class=" panel-block" style="background:white">
											<div class="media-left" style="width:20%">
												<input type="hidden" value="${ sch.dayId }" name="dayId"/>
												<p class="schTime">${ sch.startTime } - ${ sch.endTime }</p>
												
											</div>
											<div class="media-content" style="width:70%">
												<div class="content">
													<p>
														<strong class="schTitle">${ sch.schTitle }</strong>
													</p>
													<c:if test="${ !empty sch.trvCost }">
														<small class="costType">${ sch.trvCost.costType } : </small>
														<small class="costAmount"><strong>${ sch.trvCost.costAmount }</strong></small>
														<small class="costCurrency">(${ sch.trvCost.currency }) /</small>
													</c:if>
													<small class="schTransp">${ sch.schTransp }</small>
													<small class="schPlc">
														<c:if test="${ sch.plcId ne null }" >
															<a style="color:purple" class="schPlc">
																<input type="hidden" value="${ sch.plcId }" name="plcId"> 
														 		<span class="icon is-small" style="color:purple"> 
																	<i class="fas fa-map-marker-alt"></i>
																</span>
																<span class="plcName">${ sch.plcName }</span>
														 	</a>
														</c:if>
														<c:if test="${ sch.plcId eq null }" >
															<a style="color:purple" class="schPlcName">
																(장소 정보 없음)
															</a>
														</c:if>
													</small>
												</div>
											</div>
											<div class="media-right" style="width:10%">
												<input type="hidden" value="${ sch.schId }" name="schId">
												<button class="delete schDeleteBtn" aria-label="close" data-tooptip="일정 삭제"></button>
												<br><br>	
												<span class="icon schInfoBtn" data-tooltip="일정 정보 수정" data-variation="mini"
													data-position="left center">
													<i class="fas fa-edit"></i>
												</span>
											</div>
										</li>
									</c:forEach>
								</ul>
								<div class="panel-block">
									<button class="button is-primary is-outlined is-fullwidth"
									onclick="$('#newScheduleModal').toggleClass('is-active')">
									일정 추가</button>
								</div>
							</nav>
						</c:forEach>
					</div>	
					
					
					<!-- --------------------------------- -->
								
					<div class="column is-3">
						<div style="height:50px;"></div>
						<nav class="panel">
							<div class="panel-heading" align="center" 
								style="background:whitesmoke;color:black;height:30px">
								<p class="help"><i class="far fa-hand-point-up"></i>
								원하는 장소를 일정에 골라 넣어보세요</p>
							</div>
							<div class="tabs is-toggle placeTab" align="center" style="padding:0;margin:0">
								<ul>
									<li class="is-active" style="width:50%">
								    	<a>
								        	<span class="icon is-small"><i class="far fa-heart"></i></span>
								          	<span>좋아요장소</span>
								        </a>
								    </li>
								    <li style="width:50%">
								     	<a>
								          	<span class="icon is-small"><i class="fas fa-thumbs-up"></i></span>
								          	<span>추천장소</span>
								        </a>
								    </li>
								</ul>
							</div>
							<!-- <label class="panel-block"><input type="checkbox">선택</label> -->
							<ul id="likeList" class="connectedSortable menu-list" >
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>좋아요 1</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn1"><i class="fas fa-reply"></i></span>	
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>좋아요 2</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn1"><i class="fas fa-reply"></i></span>	
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>좋아요 3</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn1"><i class="fas fa-reply"></i></span>	
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>좋아요 4</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn1"><i class="fas fa-reply"></i></span>	
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>좋아요 5</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn1"><i class="fas fa-reply"></i></span>	
									</div>
								</li>
							</ul>
							
							<ul id="recommList" class="connectedSortable menu-list" style="display:none">
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>추천 1</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn2"><i class="fas fa-reply"></i></span>
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>추천 2</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn2"><i class="fas fa-reply"></i></span>
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>추천 3</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn2"><i class="fas fa-reply"></i></span>
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>추천 4</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn2"><i class="fas fa-reply"></i></span>
									</div>
								</li>
								<li class="ui-state-highlight panel-block">
									<div class="media-content">
										<p>추천 5</p>
									</div>
									<div class="media-right">
										<span class="icon backBtn2"><i class="fas fa-reply"></i></span>
									</div>
								</li>
							</ul>
							
							<div class="panel-block">
								<button class="button is-primary is-outlined is-fullwidth">모두 삭제</button>
							</div>
						</nav>
					</div>
					
					
					<!-- ----------------------------------- -->
					
					
					<div class="column is-6">
						<div class="field is-horizontal">
							<div class="field-label is-normal">
								<label class="label">지도 검색</label>
							</div>
							<div class="field-body">
								<div class="field is-narrow">
									<div class="control">
										<div class="select is-fullwidth">
											<select id="placeType">
												<option>장소 찾기</option>
												<option>식당</option>
												<option>카페</option>
												<option>바</option>
												<option>쇼핑몰</option>
												<option>공원</option>
												<option>박물관</option>
												<option>호텔</option>
											</select>
										</div>
									</div>
								</div>
								<div class="field" >
									<p class="control is-grouped">
										<input class="input is-info" type="text" placeholder="장소 이름, 주소 검색" id="searchInput">
									</p>
								</div>
							</div>
						</div>
						<div style="border:1px solid gray; height:500px">
							<div id="left-panel" class="panel">
								<div class="panel-heading media">
									<div class="media-content" >검색 결과</div>
									<div class="media-right">
										<button class="delete" id="typeSearchDelete"></button>
									</div>
								</div>
								<ul id="placeList"></ul>
								<button class="button is-primary is-outlined is-fullwidth" 
									id="more">결과 더보기</button>
							</div>
							<div id="detail-panel" class="panel" style="display:none">
								<div class="panel-heading media" >
									<div class="media-content" id="placeName"></div>
									<div class="media-right">
										<button class="delete" id="closePlaceDetail"></button>
									</div>
								</div>
								<div class="card" id="placeDetail">
									<div class="card-image">
										<figure class="image" style="margin:0">
											<img src="" id="placePhoto">
										</figure>
									</div>
									<div class="card-content">
										<input type="hidden" id="placeId">
										<button class="button is-small is-link" id="placeInsertBtn">+ 일정에 추가</button>
										<p id="placeAdd"></p>
										<p class="subtitle is-6" id="placePhone"></p>
										<div class="ui star rating" data-rating="" data-max-rating="5" id="ratingStar"></div>
										<small id="placeRating"></small>
										
										<p><small id="openHour"></small></p>
										<hr style="border:1px solid lightgray">
										<div id="placeReview"></div>
									</div>
								</div>
							</div>	
							<div id="map" style="height:100%"></div>
						</div>
					</div>
				</div>
			</section>
			
			
			
			<!-- ------------------------------------------------------------------------ -->
			
						
			<section class="section">
				<div class="notification">
					<h4 class="title is-4">
						<i class="fas fa-tags"></i>여행테마 선택
					</h4>
					<div class="tags">
						<c:forEach var="tag" items="${ allTagList }" varStatus="st">
							<span class="tag is-white themes">
								<input type="hidden" value="${ tag.tagId }" name="tagId">
								${ tag.tagName }
							</span>
						</c:forEach>
					</div>
					<hr style="border:1px solid lightgray">
					<h6 class="title is-6">
						<i class="fas fa-hashtag"></i>내 여행 테마
					</h6>
					<div class="field is-grouped is-grouped-multiline" id="myTagArea">
						<c:forEach var="trvTag" items="${ trvTagList }" varStatus="st">
							<div class="control">
								<div class="tags has-addons">
									<a class="tag is-primary">${ trvTag.tagName }</a>
									<a class="tag is-delete tagDelete"></a>
									<input type="hidden" value="${ trvTag.tagId }" />
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</section>
		</div>
	</div>
	
	
	
	
	
	
	
	<jsp:include page="newScheduleModal.jsp" />
	<jsp:include page="scheduleInfoModal.jsp" />

	<script>
		$(function() {
			$("#day1").show();
			$(".dayList").sortable({
				connectWith:".dayList"
			});
			$("#likeList, #recommList").sortable({
				connectWith : ".dayList"
			});
			$('.ui.rating').rating('disable');
			
			var places = [];
			$("#day1").find("input[name=plcId]").each(function() {
				places.push($(this).val());
			});
			showRoute(places);	
			
			
			//좋아요/추천 장소탭
			$(".placeTab").find("li").click(function() {
				$(this).addClass("is-active");
				$(this).siblings().removeClass("is-active");
				var text = $(this).children().children().eq(1).text();
				if(text == '추천장소') {
					$("#recommList").show();
					$("#likeList").hide();
				}else {
					$("#likeList").show();
					$("#recommList").hide();
				}
			});
			
			
			//day-1
			$(".dayLeftBtn").click(function() {
				
				var nav = $(this).parents("nav");
				if(!nav.is("#day1")) {
					nav.hide();
					nav.prev().show();
					var places = [];
					nav.prev().find("input[name=plcId]").each(function() {
						places.push($(this).val());
					});
					console.log(places);
					showRoute(places);				
				}
				
			});
			
			//day+1
			$(".dayRightBtn").click(function() {
				
				var nav = $(this).parents("nav");
				if(!nav.is("#day${ trvDayList.size() }")) {
					nav.hide();
					nav.next().show();
					var places = [];
					nav.next().find("input[name=plcId]").each(function() {
						places.push($(this).val());
					});
					console.log(places);
					showRoute(places);	
				}
				
			});
			
			
			//일정 수정
			$(".schInfoBtn").click(function() {
				var schId = $(this).siblings().eq(0).val();
				var li = $(this).parent().parent();
				var dayId = li.find("input[name=dayId]").val();
				var schTitle = li.find(".schTitle").text();
				var plcId = li.find("input[name=plcId]").val();
				var plcName = li.find(".plcName").text();
				
				var schTransp = li.find(".schTransp").text();
				var schTime = li.find(".schTime").text();
				var index = schTime.indexOf("-");
				var startTime = "";
				var endTime = "";
				if(schTime != " - ") {
					startTime = schTime.substring(0, index - 1);
					endTime = schTime.substring(index + 2);
				}
				var costTypeStr = li.find(".costType").text().substring();
				var costType = costTypeStr.substring(0, costTypeStr.indexOf(":") - 1);
				var costAmount = li.find(".costAmount").children().text();
				var costCurrency = li.find(".costCurrency").text();
				var currency = costCurrency.substring(1, costCurrency.length - 3);
				
				
				var modal = $("#scheduleInfoModal");
				modal.find("#schId2").val(schId);
				modal.find("#schTitle2").val(schTitle);
				modal.find("#plcId2").val(plcId);
				modal.find("#plcName2").val(plcName);
				modal.find("#dayId2").children().each(function() {
					if($(this).val() == dayId) {
						$(this).prop("selected", true);
					}
				});
				
				if(startTime == "" && endTime == "") {
					modal.find("#isTimeset2").prop("checked", true);
					modal.find("#startTime2").val("");
					modal.find("#endTime3").val("");
				}else {
					modal.find("#isTimeset2").prop("checked", false);
					modal.find("#startTime2").val(startTime);
					modal.find("#endTime3").val(endTime);
				}
				
				modal.find("#costType2").children().each(function() {
					if($(this).text() == costType) {
						$(this).prop("selected", true);
					}
				});
				
				
				if(costAmount == "") {
					modal.find("#costAmount2").val(0);
				}else {
					modal.find("#costAmount2").val(parseInt(costAmount));
				}
				modal.find("#currency2").children().each(function() {
					if($(this).text() == currency) {
						$(this).prop("selected", true);
					}
				});
				modal.find("#schTransp2").val(schTransp);
				
				modal.toggleClass('is-active');
			});
			
			//일정 삭제
			$(".schDeleteBtn").click(function() {
				var schId = $(this).prev().val();
				var answer = window.confirm("일정을 삭제하시겠습니까? ");
				if(answer) {
					$(this).parents("li").remove();
					location.href="deleteSch.trv?schId=" + schId + "&trvId=${ trv.trvId }";
				}
			});
			
			
			//좋아요/추천일정 되돌리기
			$(".backBtn1").click(function() {
				if(!$(this).parents("ul").is("#likeList")) {
					$(this).parents("li").appendTo($("#likeList"));
				}
			});
			$(".backBtn2").click(function() {
				if(!$(this).parents("ul").is("#recommList")) {
					$(this).parents("li").appendTo($("#recommList"));
				}
			});
			
			
			//지도 타입검색
			$("#placeType").change(function() {
				var type = $(this).children("option:selected").text();
				$("#placeList").empty();
				
				switch(type) {
				case '식당': type = 'restaurant'; break;
				case '카페': type = 'cafe'; break;
				case '바': type = 'bar'; break;
				case '쇼핑몰': type = 'shopping_mall'; break;
				case '공원': type = 'park'; break;
				case '박물관': type = 'museum'; break;
				case '호텔' : type = 'hotel'; break;
				case '장소찾기':return;
				}
				placeTypeSearch(type);
			});
			

			//장소insert
			$("#placeInsertBtn").click(function() {
				var plcId = $("#placeId").val();
				console.log(plcId);
				var placeName = $("#placeName").text();
				$("#plcId1").val(plcId);
				$("#plcName1").val(placeName);
				$('#newScheduleModal').toggleClass('is-active');
			});
			
			//장소select
			$(".schPlc").click(function() {
				var plcId = $(this).children("input[name=plcId]").val();
				placeDetailSearch(plcId);
				
			});
			
			
			
			//여행테마 선택
			$(".themes").each(function() {
				var tag = $(this);
				var tagId = $(this).children().val();
				$(".tags.has-addons").each(function() {
					var trvTagId = $(this).children("input").val();
					if(tagId == trvTagId) {
						tag.removeClass('is-white').addClass('is-link');
					}
				});
			});
			
			$(".themes").click(function() {
				var tag = $(this);
				var tagName = $(this).text();
				var tagId = $(this).children().val();
				if(tag.is(".is-white")) {
					$.ajax({
						url:"insertTrvTag.trv",
						data:{tagId:tagId, trvId:"${ trv.trvId }"},
						type:"post",
						success:function(data) {
							console.log(data);
							tag.removeClass('is-white').addClass('is-link');
							$("#myTagArea").append($('<div class="control"><div class="tags has-addons"><a class="tag is-primary">' 
									+ tagName + '</a><a class="tag is-delete tagDelete"></a><input type="hidden" value="' + tagId + '"></div></div>'));
							
							$(".tagDelete").click(function() {
								var name = $(this).prev().text();
								var id = parseInt($(this).next().val());
								var trvTag = $(this).parent().parent();
								$.ajax({
									url:"deleteTrvTag.trv",
									data:{tagId:id, trvId:"${ trv.trvId }"},
									type:"post",
									success:function(data) {
										trvTag.remove();
										$(".themes").each(function() {
											if($(this).children().val() == id) {
												$(this).removeClass('is-link').addClass('is-white');
											}
										});
									},
									error:function(data) {
										//alert("서버전송 실패");
									}
								});
								
							});
						},
						error:function(data) {
							alert("여행테마 insert 서버전송 실패");
						}
					});
					
					
					
				}else {
					$.ajax({
						url:"deleteTrvTag.trv",
						data:{tagId:tagId, trvId:"${ trv.trvId }"},
						type:"post",
						success:function(data) {
							console.log(data);
							tag.removeClass('is-link').addClass('is-white');
							$("#myTagArea .tags.has-addons").each(function() {
								if($(this).children().last().val() == tagId) {
									$(this).parent().remove();
								}
							});
						},
						error:function(data) {
							alert("서버전송 실패");
						}
					});
				}
			});
			
			$(".tagDelete").click(function() {
				var tagName = $(this).prev().text();
				var tagId = parseInt($(this).next().val());
				var trvTag = $(this).parent().parent();
				$.ajax({
					url:"deleteTrvTag.trv",
					data:{tagId:tagId, trvId:"${ trv.trvId }"},
					type:"post",
					success:function(data) {
						console.log(data);
						trvTag.remove();
						$(".themes").each(function() {
							if($(this).children().val() == tagId) {
								$(this).removeClass('is-link').addClass('is-white');
							}
						});
					},
					error:function(data) {
						alert("deleteTrvTag.trv 서버전송 실패");
					}
				});
				
			});

		});
		
		
		
		
		
		//curtain menu open
		function openNav() {
			document.getElementById("myNav").style.width = "100%";
		}
		function closeNav() {
			document.getElementById("myNav").style.width = "0%";
		}
	</script>


</body>
</html>
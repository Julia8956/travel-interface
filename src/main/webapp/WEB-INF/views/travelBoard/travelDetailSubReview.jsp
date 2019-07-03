<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	
	#reviewBtnArea {
		text-align: right;
		margin-bottom: 1em;
	}
	.button.is-info, .tag.is-danger {
		border-radius: 10px;
	}
	
	.reviewTableArea {
		width: 100%;
	}
	#reviewTableArea {
		width: 100%;
	}
	#reviewTable {
		width: 100%;
	}
	#reviewTable th {
		background: rgb(198, 151, 217);
		color: white;
		padding: 0.5em;
		text-align: center !important;
		border: 1px solid rgb(198, 151, 217);
	}
	#reviewTable td {
		padding: 0.5em;
		text-align: center !important;
		border: 1px solid lightgray;
	}
	
	.paging {
		width: 70%;
		margin: 1.5em;
	}
	.pagination-list {
		justify-content: center !important;
	}
	.button {
		border-radius: 10px; 
	}
	
	.reviewContentArea{
		padding: 1em;
	}
	
</style>
<body>
	<!-- 서브메뉴 본문(구매리뷰) -->
	<section class="section" id="detailSub" style="padding-top: 0;">
		<div id="detailSubContent" align="center">
			<div id="reviewBtnArea">
				<c:choose>
					<c:when test="${ !empty loginUser && detailTb.buyStatus eq 'Y' }">
						<a class="button is-info" data-target="#myModal" onclick="reviewForm()">리뷰작성</a>
					</c:when>
				</c:choose>
				
			</div>
			
			<div id="reviewTableArea">
				
				<table id="reviewTable">
					<tr>
						<th>No</th>
						<th>평점</th>
						<th>리뷰</th>
						<th>작성자</th>
					</tr>
				</table>
			</div>
			
			<div class="paging" align="center">
				<nav class="pagination is-rounded" role="navigation" aria-label="pagination">
					<ul class="pagination-list">
						<li><a class="pagination-previous">이전</a></li>
						<li><a class="pagination-link" aria-label="Goto page 1">1</a></li>
						<li><span class="pagination-ellipsis">…</span></li>
						<li><a class="pagination-link" aria-label="Goto page 45">45</a></li>
						<li><a class="pagination-link is-current"
							aria-label="Page 46" aria-current="page">46</a></li>
						<li><a class="pagination-link" aria-label="Goto page 47">47</a></li>
						<li><span class="pagination-ellipsis">…</span></li>
						<li><a class="pagination-link" aria-label="Goto page 86">86</a></li>
						<li><a class="pagination-next">다음</a></li>
					</ul>
				</nav>
			</div>
			
		</div>
	</section>
	
	<!-- 리뷰용 모달 -->
	<div class="modal" id="myModal">
	    <div class="modal-background"></div>
	    <div class="modal-card">
	    
			<header class="modal-card-head">
				<p class="modal-card-title"><i class="fas fa-sticky-note"></i>&nbsp;구매리뷰 작성하기</p>
				<button class="cancel delete"></button>
			</header>
		
			<section class="modal-card-body">
				<div class="starArea" align="center">
					<span class="title is-5">별점 : </span>
					<a class="starImg" score="1"><i class="far fa-star"></i></a>
					<a class="starImg" score="2"><i class="far fa-star"></i></a>
					<a class="starImg" score="3"><i class="far fa-star"></i></a>
					<a class="starImg" score="4"><i class="far fa-star"></i></a>
					<a class="starImg" score="5"><i class="far fa-star"></i></a>
				</div>
				
				<div class="reviewContentArea" align="center">
					<textarea rows="10" cols="50" placeholder="리뷰 내용을 작성해주세요." style="resize: none" name="reviewContent"></textarea>
				</div>
			</section>
		
			<footer class="modal-card-foot" style="justify-content: center">
				<a class="button is-primary" id="insertReview">리뷰작성</a>
				<a class="button cancel">취소하기</a>
			</footer>
		
	    </div>
	</div>
	
	
<script>

	function reviewForm() {
		$('#myModal').toggleClass('is-active').removeAttr('style');
		
		var score = Number(0);
		
		//리뷰 별점매기기
		$(".starImg").click(function() {
			$(this).parent().children().children().attr('data-prefix', 'far');
			
			$(this).prevAll().children().attr('data-prefix', 'fas');
			$(this).children().attr('data-prefix', 'fas');
			
			score = Number($(this).attr("score"));
			console.log( "선택한 별점 : " + score );
		});
		
		$("#insertReview").click(function() {
			$.ajax({
				url : "insertReview.tb",
				data : {score : score, reviewContent : reviewContent},
				success : function(data) {
					alert("리뷰작성 처리");
					$('#myModal').removeClass('is-active');
				}
			});
		});
		
		
		$(".cancel").click(function(){
			$('#myModal').removeClass('is-active');
        });
	}
	
	function deleteReview() {
		$.ajax({
			url : "deliteReview.tb",
			data : {},
			success : function(data) {
				alert("리뷰삭제");
			}
		})
	}
	
	$(document).ready(function() {
		var trvId = ${ detailTb.trvId };
		
		$.ajax({
			url : "selectTourReview.tb",
			data : {trvId : trvId, currentPage : 1},
			success : function(trList) {
				
				var table = $("#reviewTable > tbody");
				var review;
				
				for (var key in trList) {
					review = "<tr><td>" + key + "</td><td>" + trList[key].grade + "</td><td>" + trList[key].reviewContent;
					if(trList[key].writeStatus = 'Y') {
						review += '<a class="tag is-danger" onclick="deleteReview()">리뷰삭제</a></td>';
					}else {
						review += "</td>";
					}
				}
			}
		});
	});
	
	
</script>

</body>
</html>
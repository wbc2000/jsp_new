<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:set var="pageTitle" value="${board.name} 게시물 리스트" />
<%@ include file="../part/head.jspf"%>

<section class="section section-article-write px-4">
	<div class="container mx-auto">

		<div class="card bordered shadow-lg">
			<div class="card-title">
				<a href="javascript:history.back();" class="cursor-pointer">
					<i class="fas fa-chevron-left"></i>
				</a>
				<span>${board.name} 게시물 리스트</span>
			</div>

			<div class="px-4 py-4">
				<c:if test="${param.searchKeyword != null && param.searchKeyword != ''}">
					<div class="badge badge-primary">
						검색어 타입
					</div>
					<span>${param.searchKeywordTypeCode}</span>
					
					<br />
				
					<div class="badge badge-primary">
						검색어
					</div>
					<span>${param.searchKeyword}</span>
					
					<br />
				</c:if>
			
				<div class="badge badge-primary">
					전체게시물 개수
				</div>
				<span>${totalItemsCount}</span>
			</div>

			<hr />
			
			<div class="btns px-4 py-4">
				<a class="btn btn-link" href="../article/write?boardId=${boardId}">글쓰기</a>
			</div>

			<hr />

			<div class="px-4">
				<c:forEach items="${articles}" var="article">
					<c:set var="detailUri" value="../article/detail?id=${article.id}" />

					<div class="py-4">
						<div class="grid gap-3" style="grid-template-columns: 100px 1fr;">
							<a href="${detailUri}">
								<img class="rounded-full w-full" src="https://i.pravatar.cc/200?img=37" alt="">
							</a>
							<a href="${detailUri}" class="hover:underline cursor-pointer">
								<span class="badge badge-outline">제목</span>
								<div class="line-clamp-3">${article.titleForPrint}</div>
							</a>
						</div>

						<div class="mt-3 grid sm:grid-cols-2 lg:grid-cols-4 gap-3">
							<a href="${detailUri}" class="hover:underline">
								<span class="badge badge-primary">번호</span>
								<span>${article.id}</span>
							</a>
							<a href="${detailUri}" class="cursor-pointer hover:underline">
								<span class="badge badge-accent">작성자</span>
								<span>${article.extra__writerName}</span>
							</a>
							<a href="${detailUri}" class="hover:underline">
								<span class="badge">등록날짜</span>
								<span class="text-gray-600 text-light">${article.regDate}</span>
							</a>
							<a href="${detailUri}" class="hover:underline">
								<span class="badge">수정날짜</span>
								<span class="text-gray-600 text-light">${article.updateDate}</span>
							</a>
						</div>

						<a href="${detailUri}" class="block mt-3 hover:underline cursor-pointer col-span-1 sm:col-span-2 xl:col-span-3">
							<span class="badge badge-outline">본문</span>

							<div class="mt-2">
								<img class="rounded" src="https://picsum.photos/id/237/300/300" alt="" />
							</div>

							<div class="line-clamp-3">${article.bodySummaryForPrint}</div>
						</a>
					</div>

					<div class="btns mt-3">
						<c:if test="${article.extra__actorCanModify}">
							<a href="../article/modify?id=${article.id}" class="btn btn-link">
								<span>
									<i class="fas fa-edit"></i>
								</span>
								<span>수정</span>
							</a>
						</c:if>
						<c:if test="${article.extra__actorCanDelete}">
							<a onclick="if ( !confirm('정말로 삭제하시겠습니까?') ) return false;" href="../article/doDelete?id=${article.id}" class="btn btn-link">
								<span>
									<i class="fas fa-trash-alt"></i>
								</span>
								<span>삭제</span>
							</a>
						</c:if>
					</div>

					<hr />
				</c:forEach>

				<div class="page-menu hidden md:flex">
					<c:set var="baseUri" value="?boardId=${boardId}" />
					<c:set var="baseUri" value="${baseUri}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
					<c:set var="baseUri" value="${baseUri}&searchKeyword=${param.searchKeyword}" />

					<c:set var="pageMenuArmSize" value="7" />
					<c:set var="startPage" value="${page - pageMenuArmSize >= 1 ? page - pageMenuArmSize : 1}" />
					<c:set var="endPage" value="${page + pageMenuArmSize <= totalPage ? page + pageMenuArmSize : totalPage}" />

					<div class="btn-group">
						<c:if test="${startPage > 1}">
							<a class="btn btn-sm" href="${baseUri}&page=1">1</a>
							<c:if test="${startPage > 2}">
								<button class="btn btn-sm btn-disabled">...</button>
							</c:if>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
							<c:set var="aClassStr" value="${i == page ? 'btn-active' : ''}" />
							<a class="${aClassStr} btn btn-sm" href="${baseUri}&page=${i}">${i}</a>
						</c:forEach>

						<c:if test="${endPage < totalPage}">
							<c:if test="${endPage < totalPage - 1}">
								<button class="btn btn-sm btn-disabled">...</button>
							</c:if>
							<a class="btn btn-sm" href="${baseUri}&page=${totalPage}">${totalPage}</a>
						</c:if>
					</div>
				</div>
				
				<div class="page-menu flex md:hidden">
					<c:set var="baseUri" value="?boardId=${boardId}" />
					<c:set var="baseUri" value="${baseUri}&searchKeywordTypeCode=${param.searchKeywordTypeCode}" />
					<c:set var="baseUri" value="${baseUri}&searchKeyword=${param.searchKeyword}" />

					<c:set var="pageMenuArmSize" value="2" />
					<c:set var="startPage" value="${page - pageMenuArmSize >= 1 ? page - pageMenuArmSize : 1}" />
					<c:set var="endPage" value="${page + pageMenuArmSize <= totalPage ? page + pageMenuArmSize : totalPage}" />

					<div class="btn-group">
						<c:if test="${startPage > 1}">
							<a class="btn btn-xs" href="${baseUri}&page=1">1</a>
							<c:if test="${startPage > 2}">
								<button class="btn btn-disabled btn-xs">...</button>
							</c:if>
						</c:if>

						<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
							<c:set var="aClassStr" value="${i == page ? 'btn-active' : ''}" />
							<a class="${aClassStr} btn btn-xs" href="${baseUri}&page=${i}">${i}</a>
						</c:forEach>

						<c:if test="${endPage < totalPage}">
							<c:if test="${endPage < totalPage - 1}">
								<button class="btn btn-disabled btn-xs">...</button>
							</c:if>
							<a class="btn btn-xs" href="${baseUri}&page=${totalPage}">${totalPage}</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<%@ include file="../part/foot.jspf"%>
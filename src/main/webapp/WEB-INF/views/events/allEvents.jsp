<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link
	href="${pageContext.request.contextPath}/resources/css/footer_header.css"
	rel="stylesheet" media="screen">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Insert title here</title>

<style>
a:link {
	color: #000;
} /* unvisited link  */
a:visited {
	color: #000;
} /* visited link    */
a:hover {
	color: #000;
} /* mouse over link */
a:active {
	color: #000;
} /* selected link   */
.pagination li a {
	color: #000;
	
}
.pagination li a:active {
	color: red;
	
}
.pagination li a:hover {
	color: red;
	
}


#paginationUl {
 margin-left:40%;
}

#paginationContainer {
	position: absolute;
	bottom: 100px;
	width:100%;
}
</style>

</head>
<body>
	<jsp:include page="../fragments/header.jsp" />


	<div class="container">
		<h1>All movies</h1>
		<hr>
		<div class="row">
			<c:forEach var="event" items="${events}">
				<div class="col-sm-3 text-center">
					<a href="events/${event.id}"> <img class="img-responsive"
						src="${pageContext.request.contextPath}/resources/images/${event.imagePath}"
						alt="Image">
					</a> <a href="events/${event.id}"><b>${event.name}</b></a>
				</div>
			</c:forEach>
		</div>
		
	</div>
	<div id="paginationContainer" class="container">
			<ul class="pagination" id="paginationUl">
				<c:choose>
					<c:when test="${param.page != 1}">
						<li><a
							href="${pageContext.request.contextPath}/movies?page=1">Begin</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="" class="disabled">Begin</a></li>
					</c:otherwise>
				</c:choose>


				<c:forEach var="i" begin="1" end="${pageCountToDisplay}">
					<c:if test="${param.page - (pageCountToDisplay-i+1) > 0}">
						<li><a
							href="${pageContext.request.contextPath}/movies?page=${param.page-(pageCountToDisplay-i+1)}">${param.page-(pageCountToDisplay-i+1)}</a>
						</li>
					</c:if>
				</c:forEach>
				<li class="active"><a
					href="${pageContext.request.contextPath}/movies?page=${param.page}">${param.page}</a></li>
				<c:forEach var="i" begin="1" end="${param.page+1}">
					<c:if test="${param.page + i <= numOfPages}">
						<li><a
							href="${pageContext.request.contextPath}/movies?page=${param.page+i}">${param.page+i}</a></li>
					</c:if>
				</c:forEach>




				<c:choose>
					<c:when test="${param.page < numOfPages}">
						<li><a
							href="${pageContext.request.contextPath}/movies?page=${numOfPages}">End</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="" class="disabled">End</a></li>
					</c:otherwise>
				</c:choose>
			</ul>
		</div>
	<jsp:include page="../fragments/footer.jsp" />
</body>
</html>
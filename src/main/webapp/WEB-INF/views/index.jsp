<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link
	href="${pageContext.request.contextPath}/resources/css/footer_header.css"
	rel="stylesheet" media="screen">

<link href="${pageContext.request.contextPath}/resources/css/index.css"
	rel="stylesheet" media="screen">
<%-- 	<link href="${pageContext.request.contextPath}/resources/css/footer.css"
	rel="stylesheet" media="screen"> --%>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>Home</title>


</head>
<body>
	<jsp:include page="fragments/header.jsp" />
	<div id="myCarousel" class="carousel slide" data-ride="carousel">
		<!-- Indicators -->
		<ol class="carousel-indicators">
			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
			<li data-target="#myCarousel" data-slide-to="1"></li>
		</ol>

		<!-- Wrapper for slides -->
		<div class="carousel-inner" role="listbox">
			<div class="item active">
				<img src="https://placehold.it/1200x400?text=IMAGE" alt="Image">
				<div class="carousel-caption">
					<h3>Sell $</h3>
					<p>Money Money.</p>
				</div>
			</div>

			<div class="item">
				<img src="https://placehold.it/1200x400?text=Another Image Maybe"
					alt="Image">
				<div class="carousel-caption">
					<h3>More Sell $</h3>
					<p>Lorem ipsum...</p>
				</div>
			</div>
		</div>

		<!-- Left and right controls -->
		<a class="left carousel-control" href="#myCarousel" role="button"
			data-slide="prev"> <span class="glyphicon glyphicon-chevron-left"
			aria-hidden="true"></span> <span class="sr-only">Previous</span>
		</a> <a class="right carousel-control" href="#myCarousel" role="button"
			data-slide="next"> <span
			class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
			<span class="sr-only">Next</span>
		</a>
	</div>
	<br>
	<br>

	<div class="container">
		<h1>Today in the cinema</h1>
		<hr>
		<div class="row">
			<c:forEach var="event" items="${events}">
				<div class="col-sm-3 text-center" id="singleEvent">
					<a href="events/${event.id}"> <img class="img-responsive"
						src="${pageContext.request.contextPath}/resources/images/${event.imagePath}"
						alt="Image">
					</a> <a href="events/${event.id}"><b>${event.name}</b></a>
				</div>
			</c:forEach>
		</div>

	</div>
	<jsp:include page="//WEB-INF/views/fragments/footer.jsp" />
</body>
</html>

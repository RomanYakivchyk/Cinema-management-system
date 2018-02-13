<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/resources/css/header.css"
	rel="stylesheet" media="screen">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Event</title>
<style>
#eventViewContainer {
	padding-top: 40px;
}

#eventViewImage {
	display: block;
	margin: auto;
	height: 340px; 
	width:250px;
}

#eventViewImageContaner {
	margin-top: 20px;
}
</style>
</head>
<body>

	<jsp:include page="../fragments/header.jsp" />


	<div class="container-fluid" id="eventViewContainer">


		<div class="row">
			<div class="col-sm-3">
				<div id="eventViewImageContaner">
					<img id = "eventViewImage"
						src="${pageContext.request.contextPath}/resources/images/${event.imagePath}"
						alt="img" id="eventViewImage" class="img-rounded"/>
					<p class="text-center">Rating: ${event.rating}</p>
				</div>
			</div>
			<div class="col-sm-6">
				<h1 style="font-size: 55px">${event.name}</h1>
				<br>
				<c:if test="${not empty event.minAge}">
					<h4>
						<b>Age:</b>
						${event.minAge}+
					</h4>
				</c:if>
				<h4>
					<b>Year:</b> ${event.year}
				</h4>
				<h4>
					<b>Directed by</b>: ${event.directedBy}
				</h4>
				<h4>
					<b>Language:</b> ${event.language}
				</h4>
				<h4>
					<b>Genre:</b>
					<c:forEach items="${event.genres}" var="item">
						<c:out value="${item}" />
						<c:out value=" " />
					</c:forEach>
				</h4>
				<h4>
					<b>Duration:</b> ${event.durationMin}
				</h4>
				<h4>
					<b>Country:</b> ${event.country}
				</h4>
				<h4>
					<b>Actors:</b>
					<c:forEach items="${event.actors}" var="item">
						<c:out value="${item}" />
						<c:out value=" " />
					</c:forEach>
				</h4>
				<h4>${event.description}</h4>
				<hr>
				<br> <br> <br>
				<h2>Comments:</h2>
			</div>
			<div class="col-sm-3">
				<h3 class="text-center">Schedule</h3>
				<table class="table table-hover">
					<tr>
						<th>Start</th>
						<th>End</th>
						<th>Auditorium</th>
					</tr>
					<c:forEach items="${event.dateAndAuditoriums}" var="item">
						<tr>
							<td><c:out value="${item.startTime}" /></td>
							<td><c:out value="${item.endTime}" /></td>
							<td><c:out value="${item.auditoriumName}" /></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</div>

	</div>
</body>
</html>
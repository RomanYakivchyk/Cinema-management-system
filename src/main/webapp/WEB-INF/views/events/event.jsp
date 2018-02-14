<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link
	href="${pageContext.request.contextPath}/resources/css/footer_header.css"
	rel="stylesheet" media="screen">

<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>Event</title>
<style>
#eventContainer {
	padding-top: 40px;
}

#eventViewImageContaner {
	padding-top: 25px;
	margin: auto;
}

#eventViewImage {
	margin: auto;
}

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
</style>
</head>
<body>

	<jsp:include page="../fragments/header.jsp" />


	<div class="container-fluid" id="eventContainer">


		<div class="row">
			<div class="col-sm-3">
				<div id="eventViewImageContaner">
					<img id="eventViewImage" class="img-responsive img-rounded"
						src="${pageContext.request.contextPath}/resources/images/${event.imagePath}"
						alt="img" id="eventViewImage" />
					<p class="text-center">Rating: ${event.rating}</p>
				</div>
			</div>
			<div class="col-sm-6">
				<h1 style="font-size: 55px">${event.name}</h1>
				<br>
				<c:if test="${not empty event.minAge and event.minAge != 0}">
					<h4>
						<b>Age:</b> ${event.minAge}+
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
					<c:forEach items="${event.genres}" var="item" varStatus="loop">
						${item}
						<c:if test="${!loop.last}">, </c:if>
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
					<c:forEach items="${event.actors}" var="item" varStatus="loop">
						${item}
						<c:if test="${!loop.last}">, </c:if>
					</c:forEach>
				</h4>
				<h4>${event.description}</h4>
				<hr>
				<br> <br> <br>
				<h2>Comments:</h2>
			</div>
			<div class="col-sm-3 text-center">
				<h3>Movie schedule</h3>

				<br> <select id="getFname" onchange="admSelectCheck(this);">
					<option id="today" value="today">Today</option>
					<option id="toworrow" value="tomorrow">Tomorrow</option>
					<option id="week" value="week">For a week</option>
				</select> <br> <br>
				<p>Click on the session time to select places</p>

<!-- TODO -->
				<div id="TodayEvents" style="display: block;">
					<c:forEach items="${event.dateAndAuditoriums}" var="item">
						<h2>
							<a style="color: red;" href="">${item.startTime.hour}:${item.startTime.hour}</a>
						</h2>
					</c:forEach>
				</div>

				<div id="TomorrowEvents" style="display: none;">
					<c:forEach items="${event.dateAndAuditoriums}" var="item">
						<h2>
							<a style="color: red;" href="">${item.startTime.hour}:${item.startTime.hour}</a>
						</h2>
					</c:forEach>
				</div>
				<div id="WeekEvents" style="display: none;">
					<c:forEach items="${event.dateAndAuditoriums}" var="item">
						<h2>
							<a style="color: red;" href="">${item.startTime.hour}:${item.startTime.hour}</a>
						</h2>
					</c:forEach>
				</div>


				<%-- <table class="table table-hover">
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
				</table> --%>
			</div>
		</div>

	</div>
	<jsp:include page="..//fragments/footer.jsp" />
</body>
<script>
	function admSelectCheck(nameSelect) {
		if ("today" == nameSelect.value) {
			document.getElementById("TodayEvents").style.display = "block";
			document.getElementById("TomorrowEvents").style.display = "none";
			document.getElementById("WeekEvents").style.display = "none";
		} else if ("tomorrow" == nameSelect.value) {
			document.getElementById("TodayEvents").style.display = "none";
			document.getElementById("TomorrowEvents").style.display = "block";
			document.getElementById("WeekEvents").style.display = "none";
		} else if ("week" == nameSelect.value) {
			document.getElementById("TodayEvents").style.display = "none";
			document.getElementById("TomorrowEvents").style.display = "none";
			document.getElementById("WeekEvents").style.display = "block";
		}

	}
</script>
</html>
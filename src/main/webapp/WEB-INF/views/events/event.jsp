<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
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

#selectDate {
	margin: auto;
	width: 60%;
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
						<b>Age:</b><span data-toggle="popover" data-trigger="hover"
							data-placement="top"
							data-content="Over ${ event.minAge} years old">
							${event.minAge}+</span>
					</h4>
				</c:if>
				<!-- data-toggle="popover" data-trigger="hover" data-placement="top" data-content="Over ${ event.minAge} years old" -->
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

				<br>
				<div class="form-group" id="selectDate">
					<select class="form-control input-lg text-center" id="getEventsFor">
						<!-- onchange="admSelectCheck(this);" -->
						<option value="select">Select day</option>
						<option value="today">Today</option>
						<option value="tomorrow">Tomorrow</option>
						<option value="week">For a week</option>
					</select>
				</div>
				<br> <br>
				<p>Click on the session time to select places</p>

				<!-- TODO -->
				<div id="today" class="scheduledEvents" style="display:none;">
					<c:forEach items="${todayEvents}" var="item">
						<h2>
							<a style="color: red;"
								href="${event.id}/${item.startTime}/${item.auditorium.name}/select_place"><tags:localDateTime
									date="${item.startTime}" pattern="HH:mm" /> </a>
						</h2>
						<span class="label label-default">${item.auditorium.name}
							hall</span>
					</c:forEach>
				</div>

				<div id="tomorrow" class="scheduledEvents" style="display:none;">
					<c:forEach items="${tomorrowEvents}" var="item">
						<h2>
							<a style="color: red;"
								href="${event.id}/${item.startTime}/${item.auditorium.name}/select_place"><tags:localDateTime
									date="${item.startTime}" pattern="HH:mm" /></a>
						</h2>
						<span class="label label-default">${item.auditorium.name}
							hall</span>
					</c:forEach>
				</div>
				<div id="week" class="scheduledEvents" style="display:none;">
					<c:forEach items="${weekEvents}" var="item">
						<h2>
							<a style="color: red;"
								href="${event.id}/${item.startTime}/${item.auditorium.name}/select_place"><tags:localDateTime
									date="${item.startTime}" pattern="HH:mm" /></a>
						</h2>
						<span class="label label-default">${item.auditorium.name}
							hall</span>
						<span class="label label-default"> <tags:localDateTime
								date="${item.startTime}" pattern="dd.MM" />
						</span>
					</c:forEach>
				</div>
			</div>
		</div>

	</div>
	<jsp:include page="..//fragments/footer.jsp" />
</body>

<script>
	$(function() {
		$('#getEventsFor').change(function() {
			$('.scheduledEvents').hide();
			$('#' + $(this).val()).show();
		});
	});
	$(function() {
		$('#getEventsFor').val('select');
	});
</script>

<script>
	$(document).ready(function() {
		$('[data-toggle="popover"]').popover();
	});
</script>
</html>

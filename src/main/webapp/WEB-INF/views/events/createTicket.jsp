<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tags" tagdir="/WEB-INF/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
</style>
<title>Ticket</title>
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
					<div class="panel-heading">
						<p class="text-center">After you buy a ticket you will be able
							to download it</p>
					</div>

				</div>
			</div>
			<div class="col-sm-6">
				<br> <br>
				<h4>
					<i>Your tickets are booked for 10 minutes</i>
				</h4>
				<hr>
				<small>Place</small>
				<h3 style="margin-top: 0">
					<b>Lviv, str. Naukova 22, ${eda.auditorium.name} hall</b>
				</h3>
				<small>Time</small>
				<h3 style="margin-top: 0">
					<b> <tags:localDateTime date="${eda.startTime}"
							pattern="yyyy-MM-dd HH:MM" /></b>
				</h3>
				<br> <small>Event(technology)</small>
				<h3 style="margin-top: 0">
					<b>${event.name}(${event.technology.name})</b>
				</h3>
				<hr>
				<h4>
					<i>You will get the tickets on the following contact</i>
				</h4>
				<br>
				<div class="row">
					<div class="col-sm-4">
						<label for="buyerName">Name</label> <input placeholder="Your name"
							class="form-control" id="buyerName">
					</div>
					<div class="col-sm-4">
						<label for="buyerName">Mail</label> <input placeholder="Your mail"
							class="form-control" id="buyerMail">
					</div>
					<div class="col-sm-4">
						<label for="buyerName">Phone number</label> <input
							placeholder="Your phone number" class="form-control"
							id="buyerPhoneNumber">
					</div>
				</div>
				<hr>
				<div class="text-center">
					<button class="btn btn-default">Buy tickets</button>
				</div>

			</div>
			<div class="col-sm-3">
				<br>
				<h3>Selected places</h3>
				<br>
				<table class="table">
					<tr>
						<th>Row</th>
						<th>Seat</th>
						<th>Price</th>
					</tr>
					<c:forEach var="item" items="${bookedSeats}">
						<tr>
							<td>${item.row }</td>
							<td>${item.seat }</td>
							<td>${event.basePrice }</td>
						</tr>
					</c:forEach>

				</table>
			</div>
		</div>
	</div>
	<jsp:include page="..//fragments/footer.jsp" />
</body>
</html>
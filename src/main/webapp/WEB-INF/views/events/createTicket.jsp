<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
							to download it on your phone</p>
					</div>

				</div>
			</div>
			<div class="col-sm-6">
				<h3>Event: ${event.name}</h3>
				<br> <br>
				<h2>Lviv, str. Naukova 22, hall "${eda.auditorium.name}"</h2>
				<hr>
			</div>
			<div class="col-sm-3">
				<table>
					<tr>
						<th>Row</th>
						<th>Seat</th>
						<th>Price</th>
						<th></th>
					</tr>
					<c:forEach var = "item" items = "${bookedSeats}">
					<tr>
						<td>${item.row }</td>
						<td>${item.seat }</td>
						<td>${event.basePrice }</td>
						<td>delete</td>
					</tr>
					</c:forEach>

				</table>
			</div>
		</div>
		<jsp:include page="..//fragments/footer.jsp" />
</body>
</html>
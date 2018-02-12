<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">


<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Event</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-sm-4">
				<div>
					<img
						src="${pageContext.request.contextPath}/resources/images/${event.imagePath}"
						alt="img" width="100" height="100" class="img-rounded"/>
				</div>
			</div>
			<div class="col-sm-4" >
				<div>Name: ${event.name}</div>
				<br>
				<div>base price: ${event.basePrice}</div>
				<br>
				<div>Rating: ${event.rating}</div>
			</div>
			<div class="col-sm-4">
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
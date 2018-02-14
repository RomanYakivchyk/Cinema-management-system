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
	<jsp:include page="../fragments/footer.jsp" />
</body>
</html>
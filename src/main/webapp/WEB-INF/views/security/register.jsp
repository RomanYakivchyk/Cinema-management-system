<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/_bootstrap-datetimepicker.css"
	rel="stylesheet" media="screen">
<link href="${pageContext.request.contextPath}/resources/css/footer.css"
	rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/header.css"
	rel="stylesheet" media="screen">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"
	charset="UTF-8"></script>
<!-- Moment JS -->
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/moment.js"
	charset="UTF-8"></script>
<!-- Bootstrap -->
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap.js"
	charset="UTF-8"></script>
<!-- Latest compiled JavaScript -->
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-datetimepicker.js"
	charset="UTF-8"></script>



<style>
form {
	margin: 0px 10px;
}

h2 {
	margin-top: 2px;
	margin-bottom: 2px;
}

.container {
	max-width: 380px;
	margin-top: 40px;
}

.divider {
	text-align: center;
	margin-top: 20px;
	margin-bottom: 5px;
}

.divider hr {
	margin: 7px 0px;
	width: 35%;
}

.left {
	float: left;
}

.right {
	float: right;
}
</style>

</head>
<body>
	<jsp:include page="..//fragments/header.jsp" />

	<div class="container">
		<div class="row">
			<div class="panel panel-primary">
				<div class="panel-body">
					<%--@elvariable id="user" type="com.spring.domain.User"--%>
					<form:form method="POST" action="/registration"
						modelAttribute="user" class="form-signin">
						<div class="form-group">
							<h2>Create account</h2>
						</div>
						<div class="form-group">
							<label class="control-label" for="firstName">First name</label> <input
								id="firstName" name="firstName" type="text" maxlength="50"
								class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="lastName">Last name</label> <input
								id="lastName" name="lastName" type="text" maxlength="50"
								class="form-control">
						</div>

						<div class="form-group">
							<label class="control-label" for="birthday">Birthday</label>
							<div class='input-group date' id='birthdaypicker'>
								<span class="input-group-addon"> <span
									class="glyphicon glyphicon-calendar"></span>
								</span> <input name="birthday" class="form-control" readonly />
							</div>
						</div>

						<div class="form-group">
							<label class="control-label" for="email">Email</label> <input
								id="email" name="email" type="email" maxlength="50"
								class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="username">Username</label> <input
								id="username" name="username" type="text" maxlength="50"
								class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="password">Password</label> <input
								id="password" name="password" type="password" maxlength="25"
								class="form-control" placeholder="at least 8 characters"
								length="40">
						</div>
						<div class="form-group">
							<label class="control-label" for="passwordConfirm">Password
								again</label> <input id="passwordConfirm" name="passwordConfirm"
								type="password" maxlength="25" class="form-control"
								placeholder="repeat a password" length="40">
						</div>
						<div class="form-group">
							<button id="submit" type="submit" class="btn btn-info btn-block">Create
								your account</button>
						</div>
					</form:form>
					<hr>
					<p>
						Already have an account? <a
							href="${pageContext.request.contextPath}/login">Sign in</a>
					</p>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="..//fragments/footer.jsp" />

	<script type="text/javascript">
		$(function() {
			$('#birthdaypicker').datetimepicker({
				format : 'YYYY-MM-DD',
				useCurrent : false,
				ignoreReadonly : true
			});
		});
	</script>
</body>
</html>
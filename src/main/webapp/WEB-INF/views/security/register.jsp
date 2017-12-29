<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

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
	<div class="container">
		<div class="row">
			<div class="panel panel-primary">
				<div class="panel-body">
					<form method="POST" action="#" role="form">
						<div class="form-group">
							<h2>Create account</h2>
						</div>
						<div class="form-group">
							<label class="control-label" for="firstName">First name</label> <input
								id="firstName" type="text" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="lastName">Last name</label> <input
								id="lastName" type="text" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="birthday">Birthday</label> <input
								id="birthday" type="date" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="email">Email</label> <input
								id="email" type="email" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="username">Username</label> <input
								id="username" type="text" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="password">Password</label> <input
								id="password" type="password" maxlength="25"
								class="form-control" placeholder="at least 6 characters"
								length="40">
						</div>
						<div class="form-group">
							<label class="control-label" for="passwordAgain">Password
								again</label> <input id="passwordAgain" type="password" maxlength="25"
								class="form-control">
						</div>
						<div class="form-group">
							<button id="submit" type="submit" class="btn btn-info btn-block">Create
								your account</button>
						</div>
					</form>
					<hr>
					<p>
						Already have an account? <a href="${pageContext.request.contextPath}/login">Sign
							in</a>
					</p>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script defer src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>Login Page</title>
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

#newAcc {
	text-align: center;
}
</style>
</head>
<body onload='document.loginForm.username.focus();'>
	<div class="container">
		<div class="row">
			<div class="panel panel-primary">
				<div class="panel-body">
					<form name='loginForm' method="POST"
						action="${contextPath}/login" class="form-signin">
						<div class="form-group">
							<h2>Log in</h2>
						</div>
						<c:if test="${not empty error}">
							<div class="alert alert-danger">${error}</div>
						</c:if>
						<c:if test="${not empty msg}">
							<div class="alert alert-danger">${msg}</div>
						</c:if>
						<div class="form-group">
							<label class="control-label" for="username">Username</label> <input
								id="username" name="username" type="text" maxlength="50"
								class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="password">Password</label> <input
								id="password" name="password" type="password" maxlength="25"
								class="form-control">
						</div>
						<div class="form-group">
							<button id="submit" type="submit" class="btn btn-info btn-block">Log
								in</button>
						</div>
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</form>
					<hr>
					<p id="newAcc">
						<a href="${contextPath}/registration">Create new account</a>
					</p>
				</div>
			</div>
		</div>
	</div>

</body>
</html>
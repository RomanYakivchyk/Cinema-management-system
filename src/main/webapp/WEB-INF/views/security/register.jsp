<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

<script defer src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script defer src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<title>Registration</title>
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
					<%--@elvariable id="user" type="com.spring.domain.User"--%>
					<form:form method="POST" action="/registration" modelAttribute="user"  class="form-signin">
						<div class="form-group">
							<h2>Create account</h2>
						</div>
						<div class="form-group">
							<label class="control-label" for="firstName">First name</label> <input
								id="firstName" name="firstName" type="text" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="lastName">Last name</label> <input
								id="lastName" name="lastName" type="text" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="birthday">Birthday</label> <input
								id="birthday" name="birthday" type="date" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="email">Email</label> <input
								id="email" name="email" type="email" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="username">Username</label> <input
								id="username" name="username" type="text" maxlength="50" class="form-control">
						</div>
						<div class="form-group">
							<label class="control-label" for="password">Password</label> <input
								id="password" name="password" type="password" maxlength="25"
								class="form-control" placeholder="at least 8 characters"
								length="40">
						</div>
						<div class="form-group">
							<label class="control-label" for="passwordConfirm">Password
								again</label> <input id="passwordConfirm" name="passwordConfirm" type="password" maxlength="25"
								class="form-control">
						</div>
						<div class="form-group">
							<button id="submit" type="submit" class="btn btn-info btn-block">Create
								your account</button>
						</div>
					</form:form>
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
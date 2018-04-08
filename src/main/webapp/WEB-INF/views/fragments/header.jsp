<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse"
				data-target="#myNavbar">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand acitve"
				href="${pageContext.request.contextPath}/">Logo</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav">
				<li><a href="#">Schedule</a></li>
				<li><a href="${pageContext.request.contextPath}/movies?page=1">Movies</a></li>
				<li><a href="#">Contacts</a></li>
			</ul>
		</div>
	</div>
</nav>


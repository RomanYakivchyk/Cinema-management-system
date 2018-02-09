<%--@elvariable id="auditoriums" type="java.util.List"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/_bootstrap-datetimepicker.css"
	rel="stylesheet" media="screen">

<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-imageupload.css"
	rel="stylesheet">
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

<!-- for number picker -->
<link
	href="${pageContext.request.contextPath}/resources/bootstrap/css/jquery.bootstrap-touchspin.css"
	rel="stylesheet" media="screen">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery.bootstrap-touchspin.js"></script>
<!-- imageupload -->
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-imageupload.js"></script>

<script type="text/javascript">
	// todo names of auditoriums are hardcoded !!! remake some day
	function addMoreRows() {

		var table = document.getElementById("addedRows");
		var rowCount = table.rows.length;
		var row = table.insertRow(rowCount);
		var path = "dateAndAuditoriums[" + rowCount + "]";

		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);

		cell1.innerHTML = '<div class="input-group date form_datetime">'
				+ '<input name="' + path + ".startTime" + '" type="text" class="form-control" value="" />'
				+ '<span class="input-group-addon">'
				+ '<span class="glyphicon glyphicon-calendar"></span>'
				+ '</span></div>';

		cell2.innerHTML = '<div class="input-group date form_datetime">'
				+ '<input name="' + path + ".endTime" + '" type="text" class="form-control" value="" />'
				+ '<span class="input-group-addon">'
				+ '<span class="glyphicon glyphicon-calendar"></span>'
				+ '</span></div>';
		//TODO hardcoded auditorium names
		cell3.innerHTML = '<select name="' + path + ".auditoriumName" + '" title="Auditorium" class="form-control" >'
				+ '<option value="None">Select</option>'
				+ '<option value="Red">Red</option>'
				+ '<option value="Blue">Blue</option>' + '</select>';

		cell4.innerHTML = '<input type="button" value="Delete" class="btn btn-danger" onclick="removeRow(this)"/>';
	}

	function removeRow(obj) {
		var index = obj.parentNode.parentNode.rowIndex;
		var table = document.getElementById("addedRows");
		table.deleteRow(index);
	}
</script>
<style>
.container {
	max-width: 800px;
	margin-top: 40px;
}

textarea {
	resize: none;
}
</style>
</head>
<body>
	<div class="container">
		<div class="panel panel-default">
			<c:choose>
				<c:when test="${event['new']}">
					<div class="panel-heading">
						<h1>Create event</h1>
					</div>
				</c:when>
				<c:otherwise>
					<div class="panel-heading">
						<h1>Update event</h1>
					</div>
				</c:otherwise>
			</c:choose>
			<div class="panel-body">
				<%--@elvariable id="event" type="com.spring.domain.Event"--%>
				<form:form method="POST"
					action="${pageContext.request.contextPath}/admin/events?${_csrf.parameterName}=${_csrf.token}"
					enctype="multipart/form-data" modelAttribute="event">
					<form:hidden path="id" />

					<div class="form-group">
						<label>Name</label>
						<div>
							<form:input path="name" type="text" id="name"
								class="form-control" />
							<form:errors path="name" />
						</div>
					</div>
					<div class="form-group">
						<label>Base price</label>
						<div>
							<form:input path="basePrice" id="basePrice" class="form-control" />
							<form:errors path="basePrice" />
						</div>
					</div>


					<div class="imageupload panel panel-default">
						<div class="panel-heading clearfix">
							<h3 class="panel-title pull-left">Upload Image</h3>
							<div class="btn-group pull-right">
								<button type="button" class="btn btn-default active">File</button>
								<button type="button" class="btn btn-default">URL</button>
							</div>
						</div>
						<div class="file-tab panel-body">
							<label class="btn btn-default btn-file"> <span>Browse</span>
								<!-- The file is stored here. --> <input type="file"
								name="image">
							</label>
							<button type="button" class="btn btn-default">Remove</button>
						</div>
						<div class="url-tab panel-body">
							<div class="input-group">
								<input type="text" class="form-control hasclear"
									placeholder="Image URL">
								<div class="input-group-btn">
									<button type="button" class="btn btn-default">Submit</button>
								</div>
							</div>
							<button type="button" class="btn btn-default">Remove</button>
							<!-- The URL is stored here. -->
							<input type="hidden" name="image-url">
						</div>
					</div>


					<div class="form-group">
						<label>Rating</label>
						<div>
							<c:forEach var="rating" items="${eventRatings}">
								<div class="radio-inline">
									<form:radiobutton path="rating" value="${rating}" />
									${rating.name}
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="form-group">
						<label>Country</label>
						<div>
							<form:input path="country" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label>Year</label>
						<div class='input-group date' id='yearpicker'>
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
							<form:input path="year" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label>Genre</label>
						<div class="row">
							<div class="col-md-4">
								<c:forEach begin="0" end="${fn:length(genres)/3}" var="item"
									items="${genres}" varStatus="loop">
									<div class="checkbox">
										<label><form:checkbox class="form-check-input"
												path="genres" value="${item}" />${item}</label>
									</div>
								</c:forEach>
							</div>
							<div class="col-md-4">
								<c:forEach begin="${(fn:length(genres)/3) + 1}"
									end="${(fn:length(genres)/3)*2}" var="item" items="${genres}"
									varStatus="loop">
									<div class="checkbox">
										<label><form:checkbox class="form-check-input"
												path="genres" value="${item}" />${item}</label>
									</div>
								</c:forEach>
							</div>
							<div class="col-md-4">
								<c:forEach begin="${((fn:length(genres)/3)*2)+1}" var="item"
									items="${genres}" varStatus="loop">
									<div class="checkbox">
										<label><form:checkbox class="form-check-input"
												path="genres" value="${item}" />${item}</label>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label>Language</label>
						<div>
							<form:input path="language" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label>Actors</label>
						<div>
							<form:textarea path="actors" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label>Directed by</label>
						<div>
							<form:input path="directedBy" class="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label>Description</label>
						<div>
							<form:textarea path="description" class="form-control" rows="5" />
						</div>
					</div>
					<div class="form-group ">
						<label>Duration</label>
						<div>
							<form:input path="durationMin" class="form-control" value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">Technology</label>
						<div>
							<c:forEach var="technology" items="${technologies}">
								<div class="radio-inline">
									<form:radiobutton path="technology" value="${technology}" />
									${technology.name}
								</div>
							</c:forEach>
						</div>
					</div>
					<div id="ageButtonContainer" class="form-group">
						<button id="ageBtn" class="btn btn-default btn-md">Add
							age restriction</button>
					</div>
					<div id="age" class="form-group"></div>
					<br>
					<table id="addedRows" class="table">
						<tr>
							<th>Start</th>
							<th>End</th>
							<th>Auditorium</th>
							<th></th>
						</tr>
						<c:forEach items="${event.dateAndAuditoriums}" var="item"
							varStatus="vs">
							<tr>
								<td>
									<div class='input-group date form_datetime'>
										<form:input class="form-control"
											path="dateAndAuditoriums[${vs.index}].startTime"
											value="${item.startTime}" />
										<span class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</td>
								<td>
									<div class='input-group date form_datetime'>
										<form:input path="dateAndAuditoriums[${vs.index}].endTime"
											value="${item.endTime}" class="form-control" />
										<span class="input-group-addon"> <span
											class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</td>
								<td><form:select
										path="dateAndAuditoriums[${vs.index}].auditoriumName"
										class="form-control">
										<form:option value="None" label="Select" />
										<c:forEach items="${auditoriums}" var="aud">
											<form:option value="${aud.name}" label="${aud.name}" />
										</c:forEach>
									</form:select></td>
								<td><input type="button" class="btn btn-danger"
									value="Delete" onclick="removeRow(this)" />
							</tr>
						</c:forEach>
					</table>
					<div>
						<input type="button" class="btn btn-default"
							onclick="addMoreRows();" value="Add date" />
					</div>
					<br>
					<hr>
					<div class="text-center">
						<c:choose>
							<c:when test="${event['new']}">
								<button type="submit" class="btn btn-info">Create</button>
							</c:when>
							<c:otherwise>
								<button type="submit" class="btn btn-info">Update</button>
							</c:otherwise>
						</c:choose>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#yearpicker').datetimepicker({
				format : 'YYYY'
			});
		});
	</script>
	<script>
		$(function() {
			$(document)
					.on(
							'click',
							'#ageBtn',
							function() {
								$("#ageBtn").remove();
								$("#age")
										.append(
												'<label>Age from:</label> <div><input name="minAge"' +
                            'type="text" class="form-control"/></div><button style="margin-top:2px" class="btn btn-default btn-sm" type="button" id="removeAgeBtn">remove</button>');
							});

		});
	</script>
	<script>
		$("input[name='durationMin']").TouchSpin({
			step : 5,
			initval : 20,
			min : 20,
			max : 1440
		});
	</script>
	<script>
		$(function() {
			$(document).on('mouseenter', 'input[name="minAge"]', function() {
				var $this = $(this);
				$this.TouchSpin({
					initval : 4,
					min : 4,
					max : 21
				}); // You should probably check whether datapicker is already attached before binding it.
			});
		});
	</script>
	<script>
		$(function() {
			$(document)
					.on(
							'click',
							'#removeAgeBtn',
							function() {
								$("#age").html("");
								$("#ageButtonContainer")
										.append(
												'<button id="ageBtn" class="btn btn-default">Add age restriction</button>');
							});
		});
	</script>
	<script type="text/javascript">
		$(function() {
			$(document).on('mouseenter', '.form_datetime', function() {
				$(this).datetimepicker({
					format : 'YYYY-MM-DD HH:mm'
				});
			});
		});
	</script>
	<script type="text/javascript">
		$(function() {
			$('.form_datetime').datetimepicker({
				format : 'YYYY-MM-DD HH:mm'
			});
		});
	</script>
	<script>
		$('.imageupload').imageupload({
			allowedFormats : [ "jpg", "jpeg", "png", "gif" ],
			previewWidth : 250,
			previewHeight : 250,
			maxFileSizeKb : 5120
		});
	</script>
</body>
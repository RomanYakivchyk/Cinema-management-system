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
		var path = "dateAndAuditoriums[" + (rowCount - 1) + "]";

		var cell1 = row.insertCell(0);
		var cell2 = row.insertCell(1);
		var cell3 = row.insertCell(2);
		var cell4 = row.insertCell(3);

		var startDateDiv = document.createElement('div');
		startDateDiv.className = 'input-group date form_datetime';

		var startDateInput = document.createElement('input');
		startDateInput.name = path + ".startTime";
		startDateInput.type = "text";
		startDateInput.className = "form-control";
		startDateInput.value = "";
		startDateInput.readOnly = "true";

		var startDateInputSpan = document.createElement('span');
		startDateInputSpan.className = "input-group-addon";

		var startDateIconSpan = document.createElement('span');
		startDateIconSpan.className = "glyphicon glyphicon-calendar";

		startDateInputSpan.appendChild(startDateIconSpan);
		startDateDiv.appendChild(startDateInput);
		startDateDiv.appendChild(startDateInputSpan);
		cell1.appendChild(startDateDiv);

		var endDateDiv = document.createElement('div');
		endDateDiv.className = 'input-group date form_datetime';

		var endDateInput = document.createElement('input');
		endDateInput.name = path + ".endTime";
		endDateInput.type = "text";
		endDateInput.className = "form-control";
		endDateInput.value = "";
		endDateInput.readOnly = "true";

		var endDateInputSpan = document.createElement('span');
		endDateInputSpan.className = "input-group-addon";

		var endDateIconSpan = document.createElement('span');
		endDateIconSpan.className = "glyphicon glyphicon-calendar";

		endDateInputSpan.appendChild(endDateIconSpan);
		endDateDiv.appendChild(endDateInput);
		endDateDiv.appendChild(endDateInputSpan);
		cell2.appendChild(endDateDiv);

		var auditoriums;
		var xhr = new XMLHttpRequest();
		xhr.open('GET', '${pageContext.request.contextPath}/getAllAuditoriums',
				false);
		xhr.onload = function() {
			if (xhr.status === 200) {
				auditoriums = JSON.parse(xhr.responseText);
			} else {
				alert('Request failed.  Returned status of ' + xhr.status);
			}
		};
		xhr.send();

		var selectAud = document.createElement("select");
		selectAud.className = "form-control";
		selectAud.name = path + ".auditorium.id";
		selectAud.title = "Auditorium";
		for (var i = 0; i < auditoriums.length; i++) {
			var option = document.createElement("option");
			option.value = auditoriums[i].id;
			option.text = auditoriums[i].name;
			selectAud.appendChild(option);
		}
		cell3.appendChild(selectAud);

		cell4.innerHTML = '<input type="button" value="Delete" class="btn btn-danger" onclick="removeRow(this)"/>';
	}

	function removeRow(obj) {
		var index = obj.parentNode.parentNode.rowIndex;
		var table = document.getElementById("addedRows");
		table.rows[index].innerHTML = "";
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

.empty {
	border: 1px solid red;
}

.form_datetime {
	width: 100%;
}
</style>
</head>
<body>
	<div class="container">
		<div class="panel panel-default">
			<c:choose>
				<c:when test="${empty event.id}">
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
				<form:form method="POST"
					action="${pageContext.request.contextPath}/admin/events?${_csrf.parameterName}=${_csrf.token}"
					enctype="multipart/form-data" modelAttribute="event">
					<form:hidden path="id" />

					<div class="form-group">
						<label>Name</label>
						<div>
							<form:input path="name" type="text" id="name"
								class="form-control requiredField" />

						</div>
					</div>
					<div class="form-group">
						<label>Base price</label>
						<div>
							<form:input path="basePrice" id="basePrice"
								class="form-control requiredField" />
						</div>
					</div>


					<div class="imageupload panel panel-default">
						<div class="panel-heading clearfix">
							<h3 class="panel-title pull-left">
								Upload Image <b>(only 320 X 240px)</b>
							</h3>
						</div>
						<div class="file-tab panel-body">
							<label class="btn btn-default btn-file"> <span>Browse</span>
								<input type="file" name="image">
							</label>
							<button type="button" class="btn btn-default">Remove</button>
						</div>
					</div>

					<div>
						<form:hidden path="imagePath" />
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
							<form:input path="country" class="form-control requiredField" />
						</div>
					</div>
					<div class="form-group">
						<label>Year</label>
						<div class='input-group date' id='yearpicker'>
							<span class="input-group-addon"> <span
								class="glyphicon glyphicon-calendar"></span>
							</span>
							<form:input path="year" class="form-control requiredField"
								readonly="true" />
						</div>
					</div>
					<div class="form-group">
						<label>Genre</label>
						<div class="row" id="genres">
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
							<form:input path="language" class="form-control requiredField" />
						</div>
					</div>
					<div class="form-group">
						<label>Actors</label>
						<div>
							<form:textarea path="actors" class="form-control requiredField" />
						</div>
					</div>
					<div class="form-group">
						<label>Directed by</label>
						<div>
							<form:input path="directedBy" class="form-control requiredField" />
						</div>
					</div>
					<div class="form-group">
						<label>Description</label>
						<div>
							<form:textarea path="description"
								class="form-control requiredField" rows="5" />
						</div>
					</div>
					<div class="form-group ">
						<label>Duration</label>
						<div>
							<form:input path="durationMin" class="form-control requiredField"
								value="" />
						</div>
					</div>
					<div class="form-group">
						<label class="control-label">Technology</label>
						<div>
							<form:select path="technology" class="form-control">
								<c:forEach items="${technologies}" var="t">
									<form:option value="${t}" label="${t.name}" />
								</c:forEach>
							</form:select>
						</div>
					</div>
					<div class="form-group ">
						<label>Age</label>
						<div>
							<form:input path="minAge" class="form-control" value="" />
						</div>
					</div>
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
								<form:hidden path="dateAndAuditoriums[${vs.index}].id"
									id="eda_id" />
								<td>
									<div class='input-group date form_datetime'>
										<form:input class="form-control"
											path="dateAndAuditoriums[${vs.index}].startTime"
											value="${item.startTime}" readonly="true" />
									</div>
								</td>
								<td>
									<div class='input-group date form_datetime'>
										<form:input path="dateAndAuditoriums[${vs.index}].endTime"
											value="${item.endTime}" class="form-control" readonly="true" />
									</div>
								</td>
								<td><form:select
										path="dateAndAuditoriums[${vs.index}].auditorium.id"
										class="form-control">
										<form:option value="${item.auditorium.id}"
											label="${item.auditorium.name}" />
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
							<c:when test="${empty event.id}">
								<button type="submit" class="btn btn-info createUpdateEvent">Create</button>
							</c:when>
							<c:otherwise>
								<button type="submit" class="btn btn-info createUpdateEvent">Update</button>
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
				format : 'YYYY',
				useCurrent : false,
				ignoreReadonly : true,
				showTodayButton : true
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
		$("input[name='basePrice']").TouchSpin({
			step : 5,
			initval : 100,
			min : 0,
			max : 1000
		});
	</script>
	<script>
		$("input[name='minAge']").TouchSpin();
	</script>

	<script type="text/javascript">
		$(function() {
			$(document).on('mouseenter', '.form_datetime', function() {
				$(this).datetimepicker({
					format : 'YYYY-MM-DD HH:mm',
					useCurrent : false,
					ignoreReadonly : true,
					showTodayButton : true
				});
			});
		});
	</script>
	<script type="text/javascript">
		$(function() {
			$('.form_datetime').datetimepicker({
				format : 'YYYY-MM-DD HH:mm',
				useCurrent : false,
				ignoreReadonly : true,
				showTodayButton : true
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

	<script>
		$(function() {
			$('.createUpdateEvent').click(function(e) {
				var isValid = true;
				$(".requiredField").each(function() {
					var element = $(this);
					if (element.val() == "") {
						isValid = false;
						$(this).addClass('empty');
						e.preventDefault();
					} else {
						$(this).removeClass('empty');
					}
				});

				if ($('input[name="genres"]:checked').length == 0) {
					isValid = false;
					$("#genres").addClass('empty');
					e.preventDefault();
				} else {
					$("#genres").removeClass('empty');
				}
				if (!isValid) {
					alert("Fill in all highlighted fields!");
				}

			});
		});
	</script>
</body>

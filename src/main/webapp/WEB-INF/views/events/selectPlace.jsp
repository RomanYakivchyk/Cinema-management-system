<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

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
<title>Insert title here</title>
<style>
.cell {
	position: relative;
	background-color: red;
	margin: 2px;
	border-radius: 4px;
	background-color: red;
	display: inline-block;
}

#wrapper {
	margin-left: auto;
	margin-right: auto;
	width: 960px;
}

#seatTable td {
	display: inline-block;
}

.cell .tooltiptext {
	visibility: hidden;
	width: 120px;
	background-color: black;
	color: #fff;
	text-align: center;
	border-radius: 6px;
	padding: 5px 0;
	position: absolute;
	z-index: 1;
	bottom: 110%;
	left: 50%;
	margin-left: -60px;
}

.cell .tooltiptext::after {
	content: "";
	position: absolute;
	top: 100%;
	left: 50%;
	margin-left: -5px;
	border-width: 5px;
	border-style: solid;
	border-color: black transparent transparent transparent;
}

.cell:hover .tooltiptext {
	visibility: visible;
}

.glyphicon {
	font-size: 34px;
}

#seatTable {
	margin: 0px auto;
}

.unavailable {
	background-color: grey;
}

.booked {
	background-color: orange;
}
</style>
</head>
<body>
	<jsp:include page="../fragments/header.jsp" />

	<div class="container">
		<div id="wrapper">
			<table id="seatTable"></table>
		</div>
		<br> <br>
		<div>
			<table class="table" id="selectedSeats">

			</table>
		</div>
		<div class="text-center">

			<button id="submitPlaces">Submit</button>
		</div>
	</div>
	<jsp:include page="..//fragments/footer.jsp" />
	<script>
		$(document)
				.ready(
						function(event) {
							var seatsArray;
							var xhr = new XMLHttpRequest();
							xhr
									.open(
											'GET',
											'${pageContext.request.contextPath}/${eda.id}/getSeats',
											false);
							xhr.onload = function() {
								if (xhr.status === 200) {
									seatsArray = JSON.parse(xhr.responseText);
								} else {
									alert('Request failed.  Returned status of '
											+ xhr.status);
								}
							};
							xhr.send();
							var table = document.getElementById("seatTable");
							var row;
							var currSeat;
							var createNewRow = true;
							for (var i = 0; i < seatsArray.length; i++) {

								currSeat = seatsArray[i];
								if (createNewRow) {
									row = table.insertRow(currSeat.row);
								}
								var cell = row.insertCell(currSeat.seat);
								var div = document.createElement("div");

								div.id = currSeat.id;
								div.className = "cell";

								if (!currSeat.isFree) {
									div.classList.add("unavailable");
								}
								var tooltip = document.createElement("span");
								tooltip.className = "tooltiptext";
								tooltip.innerHTML = "Row: "
										+ (currSeat.row + 1) + " Seat: "
										+ (currSeat.seat + 1);
								var personIcon = document.createElement("span");
								personIcon.classList.add("glyphicon");
								personIcon.classList.add("glyphicon-user");
								div.appendChild(tooltip);
								div.appendChild(personIcon);
								cell.appendChild(div);

								if ((i + 1) < seatsArray.length
										&& currSeat.row != seatsArray[i + 1].row) {
									createNewRow = true;
								} else {
									createNewRow = false;
								}
							}

							$(".cell").hover(function() {
								$(this).css('cursor', 'pointer');
							});

							$(".cell").click(function() {
								if (!$(this).hasClass("unavailable")) {
									if ($(this).hasClass("booked")) {
										$(this).removeClass("booked");
									} else {
										$(this).addClass("booked");
									}

									//
									/*
									var trNumber = $(
										"#selectedSeats")
										.find("tr").length;
									if (trNumber == 0 $("#seatTable").filter(function(item){
									return item.classList.contains("booked");
									}).length > 0) {
									$("#selectedSeats")
											.append(
													"<tr><th>Row</th><th>Seat</th><th>Price</th><th></th></tr>")
									}
									
									
									var rowCount = table.rows.length;
									var row = table.insertRow(rowCount);

									var cell1 = row.insertCell(0);
									var cell2 = row.insertCell(1);
									var cell3 = row.insertCell(2);
									var cell4 = row.insertCell(3); */
									//
								}
							});

							$("#submitPlaces")
									.click(
											function() {
												var bookedSeatsIdArray = $(
														"#seatTable").find(
														".booked").map(
														function() {
															return this.id;
														}).get();
												
												
												
												
												
												$.ajax({
													type : "POST",
													url : "${pageContext.request.contextPath}/events/${event.id}/${eda.id}/bookSeats",
													data : JSON.stringify(bookedSeatsIdArray),
													contentType : "application/json; charset=utf-8",	
												});
												
												

											
												
												window.location.href = "${pageContext.request.contextPath}/events/${event.id}/${eda.id}/verify";

												/* 	$
															.ajax({
																type : "POST",
																url : "${pageContext.request.contextPath}/events/${event.id}/${eda.id}/verify",
																
																data : JSON
																		.stringify(bookedSeatsIdArray),
																contentType : "application/json; charset=utf-8",
																dataType : "html",
																success : function(
																		response) {
																	$('html').html(response);
																},
																failure : function(
																		errMsg) {
																	alert(errMsg);
																}
															}); */

											});

						});
	</script>
</body>
</html>
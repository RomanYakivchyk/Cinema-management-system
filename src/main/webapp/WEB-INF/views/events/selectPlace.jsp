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
<title>Select places</title>
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
	margin-top: 80px;
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
	<div>
		<div style="background-color: #a0a0a0">
			<h2 style="margin-top: 0; padding: 10px">
				<b>Select places for the event: ${event.name}</b><span
					id="backToEvent"
					class="pull-right pointer glyphicon glyphicon-remove"></span>
			</h2>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-9">
				<h1 class="text-center">screen</h1>
				<br> <br>
				<div>
					<!--  id="wrapper" -->
					<table id="seatTable"></table>
				</div>
				<br> <br>
				<div class="text-center">
					<button class="btn btn-default" style="display: none; color: red"
						id="submitPlaces">Next</button>
				</div>
			</div>
			<div class="col-sm-3" id="selectedPlaces">
				<h2>Selected places</h2>
				<table id="selectedSeats" class="table">
					<tr id="headTr">
						<th>Row</th>
						<th>Seat</th>
						<th>Price</th>
						<th></th>
					</tr>
				</table>
				<div id="tip">
					<h3>
						<i>Select at least one seat to continue</i>
					</h3>
				</div>
			</div>
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
									row = table.insertRow(currSeat.row-1);
								}
								var cell = row.insertCell(currSeat.seat-1);
								var div = document.createElement("div");

								div.id = currSeat.id + "_" + (currSeat.row )
										+ "_" + (currSeat.seat );
								div.className = "cell";

								if (!currSeat.isFree) {
									div.classList.add("unavailable");
								}
								var tooltip = document.createElement("span");
								tooltip.className = "tooltiptext";
								tooltip.innerHTML = "Row: "
										+ (currSeat.row) + " Seat: "
										+ (currSeat.seat);
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

							$(".cell, .pointer").hover(function() {
								$(this).css('cursor', 'pointer');
							});

							$("#backToEvent")
									.click(
											function() {
												window.location = "${pageContext.request.contextPath}/events/${event.id}";
											});

							$(".cell")
									.click(
											function() {

												if (!$(this).hasClass(
														"unavailable")) {

													var cellIdArray = this.id
															.split("_");
													var currRow = cellIdArray[1];
													var currSeat = cellIdArray[2];

													if ($(this).hasClass(
															"booked")) {
														$(this).removeClass(
																"booked");

														$(
																"#tr_"
																		+ currRow
																		+ "_"
																		+ currSeat)
																.remove();
													} else {
														$(this).addClass(
																"booked");

														$("#tip").hide();
														$("#submitPlaces")
																.show();
														$("#selectedSeats")
																.append(
																		"<tr id="+"tr_"+currRow+"_"+currSeat+"><td>"
																				+ currRow
																				+ "</td><td>"
																				+ currSeat
																				+ "</td><td class='basePriceTd'>${event.basePrice}</td><td><span style='font-size:18px;' class='pointer removeSeat glyphicon glyphicon-trash'></span></td></tr>");
														var rowCount = $('#selectedSeats tr').length;
														if (rowCount > 2) {
															$("#removeAllTr")
																	.remove();
															$("#selectedSeats")
																	.append(
																			"<tr id='removeAllTr'><td>Remove All</td><td></td><td></td><td><span style='font-size:18px; color:red;' class='pointer removeAllSeats glyphicon glyphicon-trash'></span></td></tr>");
														}

													}
													postRemoveBooking();
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
												
												
												
												var encodedArray = btoa(JSON.stringify(bookedSeatsIdArray));
												window.location.href = "${pageContext.request.contextPath}/events/${event.id}/${eda.id}/verify/"+encodedArray;

											/* 	$
														.ajax({
															type : "POST",
															url : "${pageContext.request.contextPath}/events/${event.id}/${eda.id}/bookSeats",
															data : JSON.stringify(bookedSeatsIdArray),
															contentType : "application/json; charset=utf-8",
															success : function(
																	response) {
																$('html').html(response);
															}
														}); */
/* 
												window.location.href = "${pageContext.request.contextPath}/events/${event.id}/${eda.id}/verify"; */

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

		$(document.body).on(
				'click',
				'.removeSeat',
				function() {
					var parentId = $(this).parent().parent().attr("id");
					$("#" + parentId).remove();
					var row = parentId.split("_")[1];
					var seat = parentId.split("_")[2];
					$(".cell").each(
							function() {
								if (this.id.split("_")[1] == row
										&& this.id.split("_")[2] == seat) {
									$(this).removeClass("booked");
								}
							});

					postRemoveBooking();

				});

		$(document.body).on('click', '.removeAllSeats', function() {
			$(".cell").each(function() {
				if ($(this).hasClass("booked")) {
					$(this).removeClass("booked");
				}
			});

			$("#selectedSeats tr").each(function() {
				if ($(this).index() > 0) {
					$(this).remove();
				}

			});
			postRemoveBooking();

		});

		$(document.body).on('mouseenter', '.removeSeat, .removeAllSeats',
				function() {
					$(this).css('cursor', 'pointer');
				});

		var postRemoveBooking = function() {
			var total = 0;
			$(".basePriceTd").each(function() {
				total += parseFloat($(this).text());
			});

			$("#totalPrice").remove();
			$("#selectedPlaces").append(
					"<h3 id='totalPrice'>Total: " + total + "</h3>");
			var rowCount = $('#selectedSeats tr').length;

			if (rowCount < 4) {
				$("#removeAllTr").remove();
			}
			if (rowCount < 2) {
				$("#tip").show();
				$("#totalPrice").hide();
				$("#submitPlaces").hide();
			}
		}
	</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<title>Insert title here</title>
<style>
.cell {
	background-color: red;
	margin: 6px;
	border-radius: 4px;
}

.glyphicon {
	font-size: 46px;
}

#seatTable {
	width: 50%;
	margin: 0px auto;
	float: none;
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
	<div class="container">

		<table id="seatTable"></table>

		<br> <br>
		<div class="price">
			<table id="selectedSeats">
			</table>
		</div>
		<div>
			<button id="submitPlaces">Submit</button>
		</div>
	</div>
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
								div.id = (currSeat.row + 1) + "_"
										+ (currSeat.seat + 1) + "_" + $
								{
									event.basePrice
								}
								;
								div.className = "cell";
								if (!currSeat.isFree) {
									div.classList.add("unavailable");
								}
								div.innerHTML = "<span class='glyphicon glyphicon-user'></span>";
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
								/* 	$(this).attr("data-toggle", "tooltip");

									var id = this.id.split("_");
									var row = id[0];
									var seat = id[1];

									$(this).attr("title", "seat: " + seat); */

							});
						});
	</script>
	<script>
		$(document).ready(function() {

			$(".cell").click(function() {
				if (!$(this).hasClass("unavailable")) {
					if ($(this).hasClass("booked")) {
						$(this).removeClass("booked");
					} else {
						$(this).addClass("booked");
					}

				}
			});

			$("#submitPlaces").click(function() {

				//TODO

			});

		});
	</script>
	<!-- 	<script>
		$(document).ready(function() {
			$("[data-toggle='tooltip']").tooltip();
		});
	</script> -->
</body>
</html>
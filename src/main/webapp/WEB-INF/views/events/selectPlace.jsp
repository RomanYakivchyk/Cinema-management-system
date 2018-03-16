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

		<div style="display: none" id="rowNumber">${eda.auditorium.rowNumber}</div>
		<div style="display: none" id="seatsInRow">${eda.auditorium.seatsInEachRow}</div>

		<br> <br>
		<div class="price"></div>
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

							var rows = document.getElementById("rowNumber").innerHTML;
							var seats = document.getElementById("seatsInRow").innerHTML;
							for (var r = 0; r < rows; r++) {
								var row = table.insertRow(r);
								for (var s = 0; s < seats; s++) {
									var cell = row.insertCell(s);
									var div = document.createElement("div");
									div.id = (r + 1) + "_" + (s + 1);
									div.className = "cell";
									for (var i = 0; i < seatsArray.length; i++) {
										if (seatsArray[i].row == r
												&& seatsArray[i].seat == s) {
											if (!seatsArray[i].isFree) {
												div.classList
														.add("unavailable");

											}
										}
									}

									div.innerHTML = "<span class='glyphicon glyphicon-user'></span>";
									cell.appendChild(div);

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
			
			
			$("#submitPlaces").click(function(){
				
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
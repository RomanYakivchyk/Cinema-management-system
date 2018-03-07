<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!-- jQuery library -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"
	charset="UTF-8"></script>
<title>Insert title here</title>
<style>
.cell {
background-color: red;
}
</style>
</head>
<body>
	<table id="seatTable"></table>
	<div style="display: none" id="rowNumber">${eda.auditorium.rowNumber}</div>
	<div style="display: none" id="seatsInRow">${eda.auditorium.seatsInEachRow}</div>
	<script>
		$(document).ready(function(event) {
			var seats;
			var xhr = new XMLHttpRequest();
			xhr.open('GET',
					'${pageContext.request.contextPath}/${eda.id}/getSeats',
					false);
			xhr.onload = function() {
				if (xhr.status === 200) {
					seats = JSON.parse(xhr.responseText);
				} else {
					alert('Request failed.  Returned status of ' + xhr.status);
				}
			};
			xhr.send();
			console.log(seats.length);
			var table = document.getElementById("seatTable");
			
			var rows = document.getElementById("rowNumber").innerHTML;
			console.log(rows);
			var seats = document.getElementById("seatsInRow").innerHTML;
			console.log(seats);
			for (var r = 0; r < rows; r++) {
				var row = table.insertRow(r);
				for (var s = 0; s < seats; s++) {
					var cell = row.insertCell(s);
					var div = document.createElement("div");
					div.id = (r+1) + "_" + (s+1);
					div.className="cell";
					div.innerHTML = "XX";
					cell.appendChild(div);
					
				}
			}

			//do work
		});
	</script>
</body>
</html>
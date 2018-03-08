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

.booked {
	background-color: green;
}

.unavailable {
	background-color: grey;
}
</style>
</head>
<body>
	<table id="seatTable"></table>
	<div style="display: none" id="rowNumber">${eda.auditorium.rowNumber}</div>
	<div style="display: none" id="seatsInRow">${eda.auditorium.seatsInEachRow}</div>
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
									for(var i=0;i<seatsArray.length;i++){
										if(seatsArray[i].row ==r && seatsArray[i].seat ==s){
											if(!seatsArray[i].isFree){
												div.classList.add("unavailable");
											}
										}
									}

									div.innerHTML = "XX";
									cell.appendChild(div);

								}
							}

							//do work
						});
	</script>
</body>
</html>
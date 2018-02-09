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
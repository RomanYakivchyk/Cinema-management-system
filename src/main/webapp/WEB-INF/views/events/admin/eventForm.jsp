<%--@elvariable id="auditoriums" type="java.util.List"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
    <link href="${pageContext.request.contextPath}/resources/bootstrap/css/bootstrap-datetimepicker.min.css"
          rel="stylesheet" media="screen">
    <%-- for footer--%>
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" charset="UTF-8"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-datetimepicker.js"
            charset="UTF-8"></script>
    <!-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap/js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>    -->


    <script defer type="text/javascript">
        var counter = ${event.dateAndAuditoriums.size()};

        // todo names of auditoriums are hardcoded !!! remake some day
        function addMoreRows() {

            var path = "dateAndAuditoriums[" + counter + "]";
            var table = document.getElementById("addedRows");
            var rowCount = table.rows.length;
            var row = table.insertRow(rowCount);

            var cell1 = row.insertCell(0);
            var cell2 = row.insertCell(1);
            var cell3 = row.insertCell(2);
            var cell4 = row.insertCell(3);

            cell1.innerHTML =
                '<div class="input-group date form_datetime" data-date-format="yyyy-mm-ddThh:mm">' +
                '<input name="' + path + ".startTime" + '" type="text" class="form-control "   value="" />' +
                '<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>' +
                '<span class="input-group-addon">' +
                '<span class="glyphicon glyphicon-calendar"></span>' +
                '</span></div>';

            cell2.innerHTML =
                '<div class="input-group date form_datetime" data-date-format="yyyy-mm-ddThh:mm">' +
                '<input name="' + path + ".endTime" + '" type="text" class="form-control " value="" />' +
                '<span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>' +
                '<span class="input-group-addon">' +
                '<span class="glyphicon glyphicon-calendar"></span>' +
                '</span></div>';

            cell3.innerHTML =
                '<select name="' + path + ".auditoriumName" + '" title="Auditorium" class="form-control" >' +
                '<option value="None">Select</option>' +
                '<option value="Red">Red</option>' +
                '<option value="Blue">Blue</option>' +
                '</select>';


            cell4.innerHTML = '<input type="button" value="Delete" class="btn btn-danger" onclick="removeRow(this)"/>';

            counter++;
        }

        function removeRow(obj) {
            var index = obj.parentNode.parentNode.rowIndex;
            var table = document.getElementById("addedRows");
            table.deleteRow(index);
        }

    </script>
    <style>
        body {
            padding: 0;
            margin: 0;
            display: flex;
            min-height: 100vh;
            flex-direction: column;
        }

        #addedRows {
            flex: 1;
            padding: 1em;
        }


    </style>
</head>
<body>

<div class="container">
    <div>
        <c:choose>
            <c:when test="${event['new']}">
                <h1>Add event</h1>
            </c:when>
            <c:otherwise>
                <h1>Update event</h1>
            </c:otherwise>
        </c:choose>

        <div>
            <%--@elvariable id="event" type="com.spring.domain.Event"--%>
            <form:form method="POST"
                       action="${pageContext.request.contextPath}/admin/events"
                       modelAttribute="event" class="form-horizontal">

                <form:hidden path="id"/>

                <div class="form-group">
                    <label>Name</label>
                    <div>
                        <form:input path="name" type="text" id="name" placeholder="Name"
                                    class="form-control"/>
                        <form:errors path="name"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>Base price</label>
                    <div>
                        <form:input path="basePrice" id="basePrice"
                                    placeholder="Base price" class="form-control"/>
                        <form:errors path="basePrice"/>
                    </div>
                </div>

                <div class="form-group">
                    <label>Rating</label>
                    <div>
                        <div class="radio-inline">
                            <form:radiobutton path="rating" value="LOW"/>
                            Low
                        </div>
                        <div class="radio-inline">
                            <form:radiobutton path="rating" value="LOW"/>
                            Medium
                        </div>
                        <div class="radio-inline">
                            <form:radiobutton path="rating" value="LOW"/>
                            High
                        </div>
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
                            <td>

                                <div class='input-group date form_datetime' data-date-format="yyyy-mm-ddThh:mm">
                                    <input name="dateAndAuditoriums[${vs.index}].startTime"
                                           type="text" value="${item.startTime}"
                                           title="Start date" class="form-control"/>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon">
			                        <span class="glyphicon glyphicon-calendar"></span>
			                    </span>
                                </div>


                            </td>
                            <td>


                                <div class="input-group date form_datetime" data-date-format="yyyy-mm-ddThh:mm">
                                    <input name="dateAndAuditoriums[${vs.index}].endTime"
                                           type="text" value="${item.endTime}"
                                           title="End date" class="form-control"/>
                                    <span class="input-group-addon"><span
                                            class="glyphicon glyphicon-remove"></span></span>
                                    <span class="input-group-addon">
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
                                </div>


                            </td>
                            <td><select
                                    name="dateAndAuditoriums[${vs.index}].auditoriumName"
                                    title="Auditorium" class="form-control">
                                <option value="None">Select</option>
                                    <%--@elvariable id="auditoriums" type="java.util.List"--%>
                                <c:forEach items="${auditoriums}" var="aud">
                                    <option value="${aud.name}${aud.name == item.auditoriumName ? '" selected="selected': ''}">${aud.name}</option>
                                </c:forEach>
                            </select></td>
                            <td><input type="button" class="btn btn-danger" value="Delete"
                                       onclick="removeRow(this)"/>
                        </tr>
                    </c:forEach>
                </table>

                <div>
                    <input type="button" class="btn btn-default"
                           onclick="addMoreRows();" value="Add"/>
                </div>


                <div>
                    <div>
                        <c:choose>
                            <c:when test="${event['new']}">
                                <button type="submit" class="btn btn-info">Create</button>
                            </c:when>
                            <c:otherwise>
                                <button type="submit" class="btn btn-info">Update</button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function () {
        $(document).on('mouseenter', '.form_datetime', function () {
            var $this = $(this);
            $this.datetimepicker({
                    todayBtn: true,
                    autoclose: true
                }
            ); // You should probably check whether datapicker is already attached before binding it.
        });
    });
</script>
<jsp:include page="footer.jsp"/>
</body>
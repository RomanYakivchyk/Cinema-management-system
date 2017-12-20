<%--@elvariable id="auditoriums" type="java.util.List"--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<head>
    <style>
        table {
            font-family: arial, sans-serif;
            border-collapse: collapse;
            width: 100%;
        }

        td, th {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        tr:nth-child(even) {
            background-color: #dddddd;
        }
    </style>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript">
        var counter = ${event.dateAndAuditoriums.size()};


        <%--var concatOptions = '';--%>
        <%--var audList = ${auditoriums};--%>
        <%--window.alert(${auditoriums});--%>
        <%--for (var i in audList) {--%>
        <%--// concatOptions += '<option value="' + audList[i] + '" label="' + audList[i] + '"></option>';--%>
        <%--writeln(i);--%>
        <%--writeln(audList[i]);--%>
        <%--}--%>
// todo names of auditoriums are hardcoded !!! remake some day
        function addMoreRows(form) {
            var path = "dateAndAuditoriums[" + counter + "]";
            var recRow =
                '<tr id="counter' + counter + '">' +
                '<td><input name="' + path + ".startTime" + '" type="datetime-local"/></td>' +
                '<td><input name="' + path + ".endTime" + '" type="datetime-local"/></td>' +
                '<td><select name="' + path + ".auditoriumName" + '" title="Auditorium">' +
                '<option value="NONE" label="-Select-"></option>' +
                '<option value="RED" label="RED"></option>' +
                '<option value="BLUE" label="BLUE"></option>' +
                '</select></td>' +
                '<td><input type="button" value="Delete"  onclick="removeRow(' + counter + ')"</td>' +
                '</tr>';

            counter++;

            $('#addedRows').append(recRow);
        }

        function removeRow(removeNum) {
            $('#counter' + removeNum).remove();
        }
    </script>
</head>
<body>
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
        <form:form method="POST" action="/admin/events" modelAttribute="event">

            <form:hidden path="id"/>

            <div>
                <label>Name</label>
                <div>
                    <form:input path="name" type="text"
                                id="name" placeholder="Name"/>
                    <form:errors path="name"/>
                </div>
            </div>

            <div>
                <label>Base price</label>
                <div>
                    <form:input path="basePrice"
                                id="basePrice" placeholder="Base price"/>
                    <form:errors path="basePrice"/>
                </div>
            </div>

            <div>
                <label>Rating</label>
                <div>
                    <label>
                        <form:radiobutton path="rating" value="LOW"/> Low
                    </label>
                    <label>
                        <form:radiobutton path="rating" value="MED"/> Medium
                    </label>
                    <label>
                        <form:radiobutton path="rating" value="HIGH"/> High
                    </label>
                    <br/>
                    <form:errors path="rating"/>
                </div>
            </div>
            <hr>

            <table id="addedRows" rules="all">
                <tr>
                    <th>Start</th>
                    <th>End</th>
                    <th>Auditorium</th>
                    <th></th>
                </tr>
                <c:forEach items="${event.dateAndAuditoriums}" var="item" varStatus="vs">
                    <tr id="counter${vs.index}">
                        <td><input name="dateAndAuditoriums[${vs.index}].startTime" type="datetime-local"
                                   value="${item.startTime}" title="Start date"/></td>
                        <td><input name="dateAndAuditoriums[${vs.index}].endTime" type="datetime-local"
                                   value="${item.endTime}" title="End date"/></td>
                        <td><select name="dateAndAuditoriums[${vs.index}].auditoriumName" title="Auditorium">
                            <option value="NONE" label="-Select-"></option>
                                <%--@elvariable id="auditoriums" type="java.util.List"--%>
                            <c:forEach items="${auditoriums}" var="aud">
                                <option label="${aud.name}" value="${aud.name}${aud.name == item.auditoriumName ? '" selected="selected': ''}">
                                </option>
                            </c:forEach>
                        </select></td>
                        <td><input type="button" value="Delete" onclick="removeRow(${vs.index})"/>
                    </tr>
                </c:forEach>
            </table>

            <div><input type="button" onclick="addMoreRows(this.form);" value="Add"/></div>


            <div>
                <div>
                    <c:choose>
                        <c:when test="${event['new']}">
                            <button type="submit">Create</button>
                        </c:when>
                        <c:otherwise>
                            <button type="submit">Update</button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </form:form>
    </div>
</div>
</body>
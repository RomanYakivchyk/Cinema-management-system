<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
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

    <title>All Events</title>
</head>
<body>
<h1>All Events</h1>
<spring:url value="/events/add" var="addUrl"/>
<button class="btn btn-danger"
        onclick="location.href='${addUrl}'">Add Event
</button>
<table>
    <tr>
        <th>#ID</th>
        <th>Name</th>
        <th>Base Price</th>
        <th>Rating</th>
    </tr>
    <c:forEach var="event" items="${events}">
        <tr>
            <td>${event.id}</td>
            <td>${event.name}</td>
            <td>${event.basePrice}</td>
            <td>${event.rating}</td>
            <td>
                <spring:url value="/events/${event.id}" var="eventUrl"/>
                <spring:url value="/events/${event.id}/delete" var="deleteUrl"/>
                <spring:url value="/events/${event.id}/update" var="updateUrl"/>

                <button class="btn btn-info"
                        onclick="location.href='${eventUrl}'">Show
                </button>
                <button class="btn btn-primary"
                        onclick="location.href='${updateUrl}'">Update
                </button>
                <button class="btn btn-danger"
                        onclick="this.disabled=true; location.href='${deleteUrl}'">Delete
                </button>
            </td>
        </tr>
    </c:forEach>
</table>

</body>
</html>

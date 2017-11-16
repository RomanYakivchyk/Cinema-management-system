<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html >
<head>
    <title>Title</title>
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
</head>
<body>
<div>
    <h1>Event</h1>
    <br>
    <div>Name: ${event.name}</div>
    <br>
    <div>base price: ${event.basePrice}</div>
    <br>
    <div>Rating: ${event.rating}</div>
    <br>
    <table>
        <tr>
            <th>Start</th>
            <th>End</th>
            <th>Auditorium</th>
        </tr>
        <c:forEach items="${event.dateAndAuditoriums}" var="item">
            <tr>
                <td><c:out value="${item.startTime}"/></td>
                <td><c:out value="${item.endTime}"/></td>
                <td><c:out value="${item.auditoriumName}"/></td>
            </tr>
        </c:forEach>
    </table>
</div>
</body>


<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">

    <!-- jQuery library -->
    <script
            src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

    <!-- Latest compiled JavaScript -->
    <script
            src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <%-- for footer--%>
    <link href="${pageContext.request.contextPath}/resources/css/footer.css" rel="stylesheet">
    
    <title>All Events</title>
</head>
<body>
<div class="container">
    <h1>All Events</h1>
    <spring:url value="events/add" var="addUrl"/>
    <button class="btn btn-danger" onclick="location.href='${addUrl}'">Add
        Event
    </button>
    <table class="table table-striped">
        <tr>
            <th>#ID</th>
            <th>Name</th>
            <th>Base Price</th>
            <th>Rating</th>
            <th></th>
        </tr>
        <%--@elvariable id="events" type="java.util.List"--%>
        <c:forEach var="event" items="${events}">
            <tr>
                <td>${event.id}</td>
                <td>${event.name}</td>
                <td>${event.basePrice}</td>
                <td>${event.rating}</td>
                <td><spring:url value="events/${event.id}" var="eventUrl"/> <spring:url
                        value="events/${event.id}/delete" var="deleteUrl"/> <spring:url
                        value="events/${event.id}/update" var="updateUrl"/>

                    <button class="btn btn-info" onclick="location.href='${eventUrl}'">Show
                    </button>
                    <button class="btn btn-primary"
                            onclick="location.href='${updateUrl}'">Update
                    </button>
                    <button class="btn btn-danger"
                            onclick="location.href='${deleteUrl}'">Delete
                    </button>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<jsp:include page="//WEB-INF/views/fragments/footer.jsp"/>
</body>
</html>

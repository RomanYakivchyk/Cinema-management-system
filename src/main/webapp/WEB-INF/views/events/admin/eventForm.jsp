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
  

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js" charset="UTF-8"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/bootstrap/js/bootstrap-datetimepicker.js"
            charset="UTF-8"></script>
    <!-- <script type="text/javascript" src="${pageContext.request.contextPath}/resources/bootstrap/js/locales/bootstrap-datetimepicker.fr.js" charset="UTF-8"></script>    -->
 <!-- for number picker -->
 <link href="${pageContext.request.contextPath}/resources/bootstrap/css/jquery.bootstrap-touchspin.css"
          rel="stylesheet" media="screen">
  <script type="text/javascript"
            src="${pageContext.request.contextPath}/resources/bootstrap/js/jquery.bootstrap-touchspin.js"></script>

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
    .container{
    max-width: 800px;
	margin-top: 40px;
    }
    </style>
</head>
<body>
<div class="container">
<div class="panel panel-default">
        <c:choose>
            <c:when test="${event['new']}">
                <div class="panel-heading"><h1>Create event</h1></div>
            </c:when>
            <c:otherwise>
                <div class="panel-heading"><h1>Update event</h1></div>
            </c:otherwise>
        </c:choose>     
        <div class="panel-body">
            <%--@elvariable id="event" type="com.spring.domain.Event"--%>
            <form:form method="POST"
                       action="${pageContext.request.contextPath}/admin/events"
                       modelAttribute="event" >

                <form:hidden path="id"/>
                <div class="form-group">
                    <label>Name</label>
                    <div>
                        <form:input path="name" type="text" id="name" 
                                    class="form-control"/>
                        <form:errors path="name"/>
                    </div>
				</div>

                <div class="form-group">
                    <label>Base price</label>
                    <div>
                        <form:input path="basePrice" id="basePrice"
                                     class="form-control"/>
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
                
                 <%-- <div class="form-group">
                    <label>upload image</label>
                    <div>
                        <form:input path="basePrice" id="basePrice"
                                    placeholder="Base price" class="form-control"/>
                        <form:errors path="basePrice"/>
                    </div>
                </div> --%>
           
                 <div class="form-group">
                    <label>Country</label>
                    <div>
                        <input name="country" type="text" class="form-control"/>
                    </div>
                </div>
            
                 
                 <div class="form-group"  data-date-format="yyyy">
                    <label>Year</label>
                     <div>
                        <input name="year" class="form-control year-picker" type="text"/>
           			  </div>
                </div>
                <div class="form-group">   	
                         <label>Genre</label>  
												 <div class="row">   	
												<div class="col-md-4">
												    <c:forEach begin="0" end="${fn:length(genres)/3}" var="item" items="${genres}" varStatus="loop">
												        <div class="checkbox">	
														<label><form:checkbox class="form-check-input" path="genres" value="${item}"/>${item}</label>
													</div>
												    </c:forEach>
												</div>
												<div class="col-md-4">
												    <c:forEach begin="${(fn:length(genres)/3) + 1}" end="${(fn:length(genres)/3)*2}" var="item" items="${genres}" varStatus="loop">
												         <div class="checkbox">	
															<label><form:checkbox class="form-check-input" path="genres" value="${item}"/>${item}</label>
														</div>
												    </c:forEach>
												</div>
												<div class="col-md-4">
												    <c:forEach begin="${((fn:length(genres)/3)*2)+1}" var="item" items="${genres}" varStatus="loop">
												         <div class="checkbox">	
															<label><form:checkbox class="form-check-input" path="genres" value="${item}"/>${item}</label>
														</div>
												    </c:forEach>
												</div>
												              </div>
												                      </div>        
                 
                 <div class="form-group">
                    <label>Language</label>
                    <div>
                        <input name="language" type="text" class="form-control"/>
                    </div>
                    </div>
           
                 <div class="form-group">
                    <label>Directed by</label>
                    <div>
                        <input name="directedBy" type="text" class="form-control"/>
                    </div>
               
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <div>
                        <textarea name="descripton" class="form-control" rows="3" required></textarea>
                    </div>
                </div>
                  <div class="form-group ">
                    <label>Duration</label>
                    <div>
                        <input name="duration" type="text" class="form-control" value=""/>
                        <script>
    $("input[name='duration']").TouchSpin({
      step:5,
      initval:20,
      min:20,
      max:1440
    });
</script>
                    </div>
                </div>
 				<div class="form-group">
                    <label>Technology</label>
                    <div>
                         <c:forEach var="item" items="${technologies}">
                        <div class="radio-inline">
                            <form:radiobutton path="technology"/>
                            ${item.name}
                            </div>
                            </c:forEach>
                     </div>
                </div>
                
                <script>
                $(function () {
                    $(document).on('click', '#ageBtn', function () {
    	$("#ageBtn").remove();
        $("#age").append('<label>Age from:</label> <div><input name="minAge"'+
        		'type="text" class="form-control"/></div><button class="btn btn-default btn-sm" type="button" id="removeAgeBtn">remove</button>');
    });
    
   
});


</script>
	<div id = "ageButtonContainer" class="form-group">
<button id="ageBtn" class="btn btn-default btn-md">Add age restriction</button>
               </div> 
                <div id="age" class="form-group">
                </div>
                     <script>			
				    $(function () {
				        $(document).on('mouseenter', 'input[name="minAge"]', function () {
				            var $this = $(this);
				            $this.TouchSpin({
				            	 initval:0,
							      min:0,
							      max:21
				                }
				            ); // You should probably check whether datapicker is already attached before binding it.
				        });
				    });
				</script>
            <script>  
            $(function () {
                $(document).on('click', '#removeAgeBtn', function () {
                	 $("#age").html("");
            	    	$("#ageButtonContainer").append('<button id="ageBtn" class="btn btn-default">Add age restriction</button>'); 
                });
            });
            </script>
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
</body>
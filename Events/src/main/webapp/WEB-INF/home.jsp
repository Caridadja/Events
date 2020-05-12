<%@ page language="java" contentType="text/html; utf8"
    pageEncoding="utf8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="utf8">
<title>Home</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<body class="text-info bg-dark">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
<div class="collapse navbar-collapse">
<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
  <li class="nav-item">
        <a class="nav-link" href="/logout">Logout</a>
      </li>
     </ul>
     </div>
</nav>
<div class="container bg-light mt-5 px-5 py-5 rounded-lg shadow-lg">
<h1>Welcome, <c:out value="${user.first_name}"/></h1>
<h2>Events in your state</h2>
<c:if test="${in_state.size() == 0}"><h5>There are currently no events in your area</h5></c:if>
<table class="table table-striped">
	<thead>
		<tr>
		<th scope="col">Name</th>
		<th scope="col">Date</th>
		<th scope="col">Location</th>
		<th scope="col">Host</th>
		<th scope="col">Action/Status</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${in_state.size() > 0}">
	<c:forEach items="${in_state}" var="event">
	<tr>
	<th scope="row"><a href="/event/${event.id}"><c:out value="${event.name}"/></a></th>
	<td><fmt:formatDate pattern ="MMMM dd, yyyy" value ="${event.date}"/></td>
	<td><c:out value="${event.location}"/>, <c:out value="${event.state}"/></td>
	<td><c:out value="${event.host.first_name}"/> <c:out value="${event.host.last_name}"/></td>
	<c:choose>
	<c:when test="${user.id == event.host.id}">
	<td> <b>Attending</b> | <a href="/event/${event.id}/edit">Edit</a> | <a href="/event/${event.id}/delete">Delete</a></td>
	</c:when>
	<c:otherwise>
		<c:set var="attendance" value="${false}"/>
		<c:forEach items="${event.getAttendees()}" var="check">
			<c:if test="${check == user}">
				<c:set var="attendance" value="${true}"/>
			</c:if>
		</c:forEach>
		<c:choose>
			<c:when test="${attendance == false}">
				<td><a href="/event/${event.id}/join">Join</a></td>
			</c:when>
			<c:otherwise>
				<td><b>Attending</b> | <a href="/event/${event.id}/cancel">Cancel</a></td>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
</c:if>
	</tbody>
</table>
<h2>Events outside your state</h2>
<table class="table table-striped">
	<thead>
		<tr>
		<th scope="col">Name</th>
		<th scope="col">Date</th>
		<th scope="col">Location</th>
		<th scope="col">Host</th>
		<th scope="col">Action/Status</th>
		</tr>
	</thead>
	<tbody>
	<c:if test="${out_state.size() > 0}">
	<c:forEach items="${out_state}" var="event">
	<tr>
	<th scope="row"><a href="/event/${event.id}"><c:out value="${event.name}"/></a></th>
	<td><fmt:formatDate pattern ="MMMM dd, yyyy" value ="${event.date}"/></td>
	<td><c:out value="${event.location}"/>, <c:out value="${event.state}"/></td>
	<td><c:out value="${event.host.first_name}"/> <c:out value="${event.host.last_name}"/></td>
	<c:choose>
	<c:when test="${user.id == event.host.id}">
	<td> <b>Attending</b> | <a href="/event/${event.id}/edit">Edit</a> | <a href="/event/${event.id}/delete">Delete</a></td>
	</c:when>
	<c:otherwise>
		<c:set var="attendance" value="${false}"/>
		<c:forEach items="${event.getAttendees()}" var="check">
			<c:if test="${check == user}">
				<c:set var="attendance" value="${true}"/>
			</c:if>
		</c:forEach>
		<c:choose>
			<c:when test="${attendance == false}">
				<td><a href="/event/${event.id}/join">Join</a></td>
			</c:when>
			<c:otherwise>
				<td><b>Attending</b> | <a href="/event/${event.id}/cancel">Cancel</a></td>
			</c:otherwise>
		</c:choose>
	</c:otherwise>
	</c:choose>
	</tr>
	</c:forEach>
</c:if>
	</tbody>
</table>
<h3>Create an Event</h3>
			<form:form method="POST" action="/addevent" modelAttribute="event">
				<div class="form-group form-inline">
					<form:input class="form-control" type="text" path="name" placeholder="Event name"/>
					<form:input class="form-control mx-1" type="date" path="date" placeholder="Date"/>
					<form:input class="form-control" type="text" path="location" placeholder="City"/>
					<form:select class="form-control mx-1" path="state">
						<c:forEach items="${states}" var="state">
							<form:option value="${state}"><c:out value="${state}"/></form:option>
						</c:forEach>
					</form:select>
				<form:hidden path="host" value="${user.id}"/>
				<button type="submit" class="btn btn-info">Create</button>
				</div>
			</form:form>
			<form:errors path="event.*"/>
			</div>
</body>
</html>
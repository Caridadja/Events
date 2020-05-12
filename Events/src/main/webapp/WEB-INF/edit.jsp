<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Edit <c:out value="${event.name}"/></title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<body class="bg-dark text-info">
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="collapse navbar-collapse">
  <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
      <li class="nav-item active">
        <a class="nav-link" href="/home">Home</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="/logout">Logout</a>
      </li>
     </ul>
  </div>
</nav>
<div class="container bg-light mt-5 p-5">
<div class="row justify-content-md-center" align="center">
<div class="container-fluid" align="center">
<h1><c:out value="${event.name}"/></h1>
<h3>Edit Event</h3><br>
</div>
			<form:form method="POST" action="/${event.id}/update" modelAttribute="event">
			<input type="hidden" name="_method" value="put">
			<div class="form-group">
					<form:label path="name">Name</form:label>
					<form:input type="text" path="name" class="form-control"/>
			</div>
			<div class="form-group">
					<form:label path="date">Date</form:label>
					<form:input  type="date" path="date" class="form-control"/>
			</div>
			<div class="form-group">
					<form:label path="location">Location</form:label>
					<div class="form-inline">
					<form:input type="text" path="location" class="form-control"/>
					<form:select path="state" class="form-control mx-1">
						<c:forEach items="${states}" var="state">
							<form:option value="${state}"><c:out value="${state}"/></form:option>
						</c:forEach>
					</form:select>
					</div>
			</div>
				<form:hidden path="host" value="${host.id}"/>
				<input class="btn btn-info" type="submit" value="Edit"/>
			</form:form>
			<form:errors path="event.*"/>
			</div>
			</div>
</body>
</html>
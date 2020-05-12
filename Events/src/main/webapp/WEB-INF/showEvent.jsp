<%@ page language="java" contentType="text/html; charset=utf8"
    pageEncoding="utf8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>  
<!DOCTYPE html>
<html>
<head>
<style>
.message-box{
display: inline-block;
height: 250px;
width: 31rem;
overflow: auto;
outline: 1px solid black;
}
.rightpanel{
display: inline-block;
width: 35rem;
margin: 2rem 2rem;
}
.txtbox {
	width: 31rem;
	height: 200px;
	display: block;
	float: right;
}
.new-col{
margin: 2rem 5rem;
}
.customButton{
margin-right: 6rem;
margin-bottom: 2rem;
}
input {
    padding: 0 0 11rem 0;
}
</style>
<meta charset="utf8">
<title><c:out value="${event.name}"/></title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
</head>
<body class="bg-dark">
    
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
<div class="container bg-light mt-5 rounded text-info">
	<div class="row">
		<div class="col">
<h1><c:out value="${event.name}"/></h1>
<h3>Host: <c:out value="${event.host.first_name}"/> <c:out value="${event.host.last_name}"/></h3>
<h3>Date: <fmt:formatDate pattern="MMMM dd, yyyy" value="${event.date}"/></h3>
<h3>Location: <c:out value="${event.location}"/></h3>
<h3>Attendees: <c:out value="${event.getAttendees().size()}"/></h3>
</div>
<div class="rightpanel">
<div class="message-box">
        <c:forEach items="${messages}" var="msg">
<p>${msg.user.first_name} says: ${msg.message}</p>
<hr>
</c:forEach>
</div>
      </div>
      </div>
      </div>
      <form:form method="POST" action="/addmessage" modelAttribute="newMessage">
      <div class="container bg-light rounded">
      <div class="row">
      <div class="col new-col">
<form:input class= "txtbox" path="message" type="textarea" placeholder="Write a new comment..."/>
<form:hidden path="user" value="${user.id}"/>
<form:hidden path="event" value="${event.id}"/>
</div>
</div>
<div class="row justify-content-end">
<input class="customButton btn btn-info" type="submit"/>
</div>
</div>
</form:form>
</body>
</html>
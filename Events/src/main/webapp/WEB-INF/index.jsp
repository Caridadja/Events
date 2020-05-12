<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
            
<!DOCTYPE html>
<html>
<head>
	<style>
		.color{
			color:red;
		}
	</style>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<body class="bg-dark text-info">
	<div class="container-fluid">
	<div class="row bg-white">
		<div class="col" align="center">
			<h1>Event Reviewer</h1>
		</div>
	</div>
	<div class="row justify-content-around mt-5">
	<div class="col-xs-4 h-50 px-5 py-5 bg-white rounded-lg shadow-lg">
    <h1>Login</h1>
    <p class="color"><c:out value="${error}" /></p>
    <form method="post" action="/login">
        	<div class="form-group">
            <label for="email">Email</label>
            <input class="form-control" type="text" id="email" name="logEmail" aria-describedBy="emailHelp"/>
            </div>
            <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" class="form-control"/>
            </div>

        <button type="submit" class="btn btn-info">Login</button>
    </form>    
    </div>
    <div class="col-xs-4 px-5 py-5 bg-white rounded-lg shadow-lg">
    <h1>Register</h1> 
    <p class="color"><form:errors path="user.*"/></p>
    
    <form:form method="POST" action="/registration" modelAttribute="user">
    	<div class="form-group">
            <form:label path="email">Email</form:label>
            <form:input type="email" path="email" class="form-control" aria-describedBy="emailHelp"/>
            <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>       
            </div>
        <div class="form-group">
            <form:label path="password">Password</form:label>
            <form:password path="password" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="pwConfirmation">Password Confirmation</form:label>
            <form:password path="pwConfirmation" class="form-control"/>
       </div>
     	<div class="form-group">
            <form:label path="first_name">First Name</form:label>
            <form:input type="text" path="first_name" class="form-control"/>
        </div>
        <div class="form-group">
            <form:label path="last_name">Last Name</form:label>
            <form:input type="text" path="last_name" class="form-control"/>
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
        <button type="submit" class="btn btn-info">Register</button>
    </form:form> 
    </div>
    </div>
    </div>
</body>
</html>
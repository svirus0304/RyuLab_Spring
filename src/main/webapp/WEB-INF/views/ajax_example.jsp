<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<html>
<head>
	<title>Home</title>
	<script src="//code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

<script>
	function ajax_call()
	{
		$.get(
			"/spring/test",
			{
				param1 : "123",
				param2 : "456"
			},
			function ( response ) {
				console.log(response.now_date);
				$("#test").html(response);
			}
		);
	}
</script>

<div id="test">
	HELLO plusystem
</div>
<input type="button" value="ajax 호출" onclick="ajax_call();">


</body>
</html>

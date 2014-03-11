<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<title>test</title>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
</head>

<body>
	<h1>Async test</h1>
	<div id="result"></div>

	<script>
		var previousValue,
			failCounter = 0,
			checkStatus = function() {
			$.ajax({
				url: "${g.createLink(controller: "async", action: "longTermStatus")}",
				type: "GET",
				dataType: "json",
				success: function(data) {
					$('#result').html(data.successCount);
					if (data.done) {
						alert("done");
					} else {
						//Endless loop protection
						failCounter = previousValue === data.successCount ? failCounter + 1 : 0;
						previousValue = data.successCount;
						if (failCounter > 2) {
							alert("Error");
						} else {
							setTimeout(checkStatus, 2000);
						}
					}
				}
			});
		};

		$(document).ready(function() {
			$.ajax({
				url: "${g.createLink(controller: "async", action: "longTerm")}",
				type: "GET",
				success: function() {
					checkStatus();
				}
			});
		});
	</script>
</body>
</html>
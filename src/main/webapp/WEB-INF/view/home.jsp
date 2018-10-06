<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>
<html>
<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

    <title>Bike Warehouse</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- custom stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/landing.css">

    <!-- Bootstrap css and modernizr min script -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js" type="text/javascript" async></script>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
</head>
<body>

    <div id="home-header">

            <!-- creating URL to bikes -->
     		<c:url var="bikesList" value="${Mappings.BIKES}"/>
     		<h1>Welcome to Bike Warehouse</h1>
            <a href="${bikesList}" class="btn btn-lg btn-success">Browse bikes catalogue</a>

        </div>

    <ul class="slideshow">
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
    </ul>

</body>
</html>
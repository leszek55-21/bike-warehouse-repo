<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>

<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

	<title>Bike Warehouse | Registered Success</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- custom stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" type="text/css" />

    <!-- font awesome icons-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

</head>

<body>

    <!-- including navbar -->
    <%@ include file="partials/navbar.jsp"%>

    <!-- JUMBOTRON -->
    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <h1 class="display-4">User registered successfully!</h1>
        <p class="lead">You can now login to your account</p>
      </div>
    </div>

     <!-- "Login with new user" button as link to login page -->
    <div style="padding: 10px;">
        <a href="${pageContext.request.contextPath}${Mappings.LOGIN}" role="button"
           class="btn ntn-large btn-outline-success">Login with new user
        </a>
    </div>

    <!-- including navbar -->
    <%@ include file="partials/footer.jsp"%>

    <!-- bootstrap and jquery scripts -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>

</html>
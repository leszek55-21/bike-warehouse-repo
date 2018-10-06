<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>

<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

    <title>Bike Warehouse | Login</title>

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
        <h1 class="display-4">Welcome to Bike Warehouse</h1>
        <p class="lead">Login to get access to more features. You will be able to comment and see more...</p>
      </div>
    </div>

    <!-- Place for messages: error, alert etc ... -->

    <!-- Check for login error, if NOT null display "Invalid..." -->
    <c:if test="${param.error != null}">
        <div class="alert alert-danger col-xs-offset-1 col-xs-10">
            Invalid username or password.
        </div>
    </c:if>

    <!-- Check for logout-->
    <c:if test="${param.logout != null}">
        <div class="alert alert-warning col-xs-offset-1 col-xs-10">
            You have been logged out.
        </div>
    </c:if>

    <!-- login box -->
    <div class="offset-lg-4">
        <div id="loginbox" class="card border-success mb-3 d-inline-flex p-2">
            <div class="panel-heading" style="background: #28a745;">
                <div class="card-header" style="color: white;">
                    <h4 class="card-title">Sign In</h4>
                </div>
            </div>
            <div class="card-body">
                    <!-- Login Form -->
                    <form action="${pageContext.request.contextPath}/authenticateTheUser"
                          method="POST" class="form-horizontal">

                        <!-- User name -->
                        <div style="margin-bottom: 25px" class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="far fa-user"></i></span>
                            </div>
                            <input type="text" name="username" placeholder="username" class="form-control">
                        </div>

                        <!-- Password -->
                        <div style="margin-bottom: 25px" class="input-group mb-3">
                            <div class="input-group-prepend">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                            </div>
                            <input type="password" name="password" placeholder="password" class="form-control" >
                        </div>

                        <!-- Login/Submit Button -->
                        <div style="margin-top: 10px" class="form-group">
                            <button type="submit" class="btn btn-outline-success">Login</button>
                        </div>
                        <hr>

                        <!-- Register link as button -->
                        <div style="margin-top: 10px" class="form-group">
                            <a href="${pageContext.request.contextPath}/register/showRegistrationForm"
                               class="btn btn-outline-primary" role="button"
                               aria-pressed="true">
                               Register for free!
                           </a>
                        </div>

                        <!-- adding tokens manually -->
                        <input type="hidden"
                               name="${_csrf.parameterName}"
                               value="${_csrf.token}" />
                    </form>
            </div>
        </div>
    </div>

    <!-- including footer -->
    <%@ include file="partials/footer.jsp"%>

    <!-- bootstrap and jquery scripts -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>
</html>
<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>

<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

    <title>Bike Warehouse | Register</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- custom styleshhet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" type="text/css" />

    <!-- font awesome icons-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

    <!-- styling error messages from registration form -->
    <style>
        .error {color:red}
    </style>
</head>

<body>

    <!-- including navbar -->
    <%@ include file="partials/navbar.jsp"%>

    <!-- JUMBOTRON -->
    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <h1 class="display-4">Welcome to Bike Warehouse</h1>
        <p class="lead">Register to Bike Warehouse. Account is free!</p>
      </div>
    </div>

    <!-- Place for messages: error, alert etc ... -->
    <!-- Check for registration error -->
    <c:if test="${registrationError != null}">
        <div class="alert alert-danger col-xs-offset-1 col-xs-10">
            ${registrationError}
        </div>
    </c:if>

    <!-- registration box -->
    <div class="offset-lg-4">
        <div id="registerBox" class="card border-info mb-3 d-inline-flex p-2">
            <div class="panel-heading" style="background: #17a2b8;">
                <div class="card-header" style="color: white;">
                    <h4 class="card-title">Register</h4>
                </div>
            </div>

            <div class="card-body">

                <!-- Registration Form -->
                <form:form action="${pageContext.request.contextPath}/register/processRegistrationForm"
                           modelAttribute="crmUser"
                           class="form-horizontal">

                    <!-- User name -->
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="far fa-user"></i></span>
                        </div>
                        <form:input path="userName" placeholder="username (*)" class="form-control"
                                    style="margin-right: 5px;"/>
                    </div>
                    <form:errors path="userName" cssClass="error"/>

                    <!-- Password -->
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-key"></i></span>
                        </div>
                        <form:password path="password" placeholder="password (*)" class="form-control"
                                       style="margin-right: 5px;"/>
                    </div>
                    <form:errors path="password" cssClass="error" />

                    <!-- Confirm Password -->
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-key"></i></span>
                        </div>
                        <form:password path="matchingPassword" placeholder="confirm password (*)"
                                       class="form-control" style="margin-right: 5px;"/>
                    </div>
                    <form:errors path="matchingPassword" cssClass="error" />


                    <!-- First name -->
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="far fa-user"></i></span>
                        </div>
                        <form:input path="firstName" placeholder="first name (*)" class="form-control"
                                    style="margin-right: 5px;"/>
                    </div>
                    <form:errors path="firstName" cssClass="error" />

                    <!-- Last name -->
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="far fa-user"></i></span>
                        </div>
                        <form:input path="lastName" placeholder="last name (*)" class="form-control"
                                    style="margin-right: 5px;"/>
                    </div>
                    <form:errors path="lastName" cssClass="error" />

                    <!-- Email -->
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text"><i class="fas fa-at"></i></span>
                        </div>
                        <form:input path="email" placeholder="email (*)" class="form-control"
                                    style="margin-right: 5px;"/>
                    </div>
                    <form:errors path="email" cssClass="error" />

                    <!-- Register Button -->
                    <div style="margin-top: 25px" class="form-group">
                        <button type="submit" class="btn btn-outline-info">Register</button>
                    </div>

                </form:form>
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
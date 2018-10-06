<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>

<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

	<title>Bike Warehouse | User Profile</title>

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

    <!-- when user not found by username displays jumbotron with proper messagess
        otherwise displays different jumbotron and details about found user -->
    <c:choose>
        <c:when test="${not empty noUser}">
            <!-- JUMBOTRON -->
            <div class="jumbotron jumbotron-fluid">
              <div class="container">
                <h1 class="display-4">
                    <i class="fas fa-user-alt-slash"></i>We didn't found such user
                </h1>
                <p class="lead">User doesn't exist in our database</p>
              </div>
            </div>
            <div class="alert alert-danger col-xs-offset-1 col-xs-10">
                <c:out value="${noUser}"/>
            </div>
        </c:when>
        <c:otherwise>
            <!-- JUMBOTRON -->
            <div class="jumbotron jumbotron-fluid">
              <div class="container">
                <h1 class="display-4">
                    <i class="far fa-user"></i>Welcome to <c:out value="${user.userName}"/>'s profile
                </h1>
                <p class="lead">Below you will find more information about this user</p>
              </div>
            </div>

            <!-- CARD -->
            <div style="padding: 10px;">
                <div class="card">
                  <div class="card-header">
                    <h4>Main information about user: <c:out value="${user.userName}"/></h4>
                  </div>

                  <!-- displaying user info user object send from UserController userProfile method -->
                  <ul class="list-group list-group-flush">
                    <li class="h5 list-group-item">First name: <c:out value="${user.firstName}"/></li>
                    <li class="h5 list-group-item">Last name: <c:out value="${user.lastName}"/></li>
                    <li class="h5 list-group-item">Email address: <c:out value="${user.email}"/></li>
                    <li class="h5 list-group-item">
                        Roles in bike warehouse:
                        <c:forEach var="role" items="${user.roles}">
                            <c:out value="${fn:substring(role.name, 5, fn:length(role.name))} "></c:out>
                        </c:forEach>
                    </li>
                    <li class="h5 list-group-item">

                        <!-- displaying users comments from oldest to newest -->
                        Comments by <c:out value="${user.userName}"/>:

                        <!-- iteraing over users comments collection -->
                        <c:forEach var="comment" items="${user.comments}">

                            <!-- using function from custom taglib - formats date nicely
                                 asigning variable "date" to function result -->
                            <c:set var="date" scope="session" value="${ct:formatDate(comment.createdAt)}"/>
                            <h6 class="list-group-item">
                                <c:out value="${date}"/>
                                <c:out value="${user.userName}"/> wrote:
                                <strong><em>"<c:out value="${comment.content}"/>"</em></strong> to
                                <c:choose>
                                    <c:when test="${comment.bike ne null}">

                                        <!-- if comment has a bike displaying bike brand and model as link to this bike -->
                                        <a href="${pageContext.request.contextPath}/${Mappings.VIEW_BIKE}?id=${comment.bike.id}">
                                            <c:out value="${comment.bike.brand}"/> <c:out value="${comment.bike.model}"/>
                                        </a>
                                    </c:when>
                                    <c:otherwise>

                                       <!-- no bike for such comment means the bike was deleted, so "Deleted Bike" display -->
                                       Deleted Bike
                                    </c:otherwise>
                                </c:choose>
                            </h6>
                        </c:forEach>
                    </li>
                  </ul>
                </div>
            </div>

        </c:otherwise>
    </c:choose>


    <!-- including footer -->
    <%@ include file="partials/footer.jsp"%>

    <!-- bootstrap and jquery scripts -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

</body>

</html>










<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>

<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

	<title>Bike Warehouse | Admin</title>

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


<!-- setting "loggedUser" variable for logged in user name, it was already done in navbar
     but here I do it again for better code understanding -->
<security:authentication property="principal.username" var="loggedUser" />

<body>

    <!-- including navbar -->
    <%@ include file="partials/navbar.jsp"%>

    <!-- JUMBOTRON -->
    <div align="center">
        <div class="jumbotron">

            <!-- welcome message and searching users advice -->
            <div class="pull-left">
                <h1>
                    <i class="fas fa-user-ninja"></i>
                    Hello
                    <c:out value="${loggedUser}"/>
                    Welcome to admin panel
                </h1>
                <h4>Search for users. Type in username, first name, last name or email</h4>
            </div>

            <!-- searching form -->
            <div class="form-inline" style="align: center";>
                <div class="form-group">
                    <span class="nav-link">
                          <form:form action="${pageContext.request.contextPath}${Mappings.SYSTEMS}/${Mappings.SHOW_USERS}"
                                      method="POST">
                              <input type="text" name="searchString" class="form-control"
                                     placeholder="Search..." value="${searchString}"/>
                              <input type="submit" value="Search" class="btn btn-success my-2 my-sm-0"/>
                          </form:form>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- checking if "deleteError" parameter exist, if yes displays it's content
         parameter is from UserController deleteUser method-->
    <c:if test="${param.deleteError ne null}">
        <div class="alert alert-danger col-xs-offset-1 col-xs-10">
            <c:out value="${param.deleteError}"/>
        </div>
    </c:if>

    <!-- checking if "deleteSuccess" parameter exist, if yes displays it's content
         parameter is from UserController deleteUser method-->
    <c:if test="${param.deleteSuccess ne null}">
        <div class="alert alert-success col-xs-offset-1 col-xs-10">
            <c:out value="${param.deleteSuccess}"/>
        </div>
    </c:if>

    <!-- checking if "adminAdded" parameter exist, if yes displays it's content
         parameter is from UserController makeAnAdmin method-->
    <c:if test="${param.adminAdded ne null}">
        <div class="alert alert-success col-xs-offset-1 col-xs-10">
            <c:out value="${param.adminAdded}"/>
        </div>
    </c:if>

    <!-- checking if "alreadyAdmin" parameter exist, if yes displays it's content
         parameter is from UserController makeAnAdmin method-->
    <c:if test="${param.alreadyAdmin ne null}">
        <div class="alert alert-danger col-xs-offset-1 col-xs-10">
            <c:out value="${param.alreadyAdmin}"/>
        </div>
    </c:if>

    <!-- USERS TABLE -->
    <div style="padding: 2px;">
        <div class="table-responsive-xs">
            <table class="table table-hover table-dark table-bordered table-striped">

                <!-- Table caption -->
                <caption style="caption-side: top"><h3>  Users</h3></caption>

                <!-- Table head -->
                <thead class="thead-green">
                    <tr class="bg-success">
                        <th scope="col" class="bg-success text-center">User ID</th>
                        <th scope="col" class="bg-success text-center">Username</th>
                        <th scope="col" class="bg-success text-center">User First Name</th>
                        <th scope="col" class="bg-success text-center">User Last name</th>
                        <th scope="col" class="bg-success text-center">User Email</th>
                        <th scope="col" class="bg-success text-center">User Roles</th>
                        <th scope="col" class="bg-success text-center">Delete User</th>
                        <th scope="col" class="bg-success text-center">Give Admin role</th>
                    </tr>
                </thead>

                <!-- if param emptyBikesList exist adding message "no results found"
                     attribute comes from UserController showSearchedUsers method -->
                <c:if test="${emptyUsersList}">
                     <div class="alert alert-warning col-xs-offset-1 col-xs-10"
                          style="margin-top: 15px;">
                          No results found
                     </div>
                </c:if>

                <!-- Table body -->
                <tbody>
                    <c:forEach var="user" items="${users}">

                        <!-- creating URL for deleting user with "id" param which is users id. -->
                        <c:url var="deleteUrl" value="${Mappings.SYSTEMS}/${Mappings.DELETE_USER}">
                            <c:param name="id" value="${user.id}"/>
                        </c:url>

                        <!-- creating URL for making user an admin with "userId" param -->
                        <c:url var="makeAnAdminUrl" value="${Mappings.SYSTEMS}/${Mappings.MAKE_AN_ADMIN}">
                            <c:param name="userId" value="${user.id}"/>
                        </c:url>

                        <!-- creating URL for user profile "username" param which is users userName. -->
                        <c:url var="userProfileUrl" value="/${Mappings.USER_PROFILE}">
                            <c:param name="username" value="${user.userName}"/>
                        </c:url>

                        <!-- for each user we create below -->
                        <tr>
                            <td class="text-center"><c:out value="${user.id}"></c:out></td>
                            <td class="text-center">
                                <a href="${userProfileUrl}"><c:out value="${user.userName}"></c:out></a>
                            </td>
                            <td class="text-center"><c:out value="${user.firstName}"></c:out></td>
                            <td class="text-center"><c:out value="${user.lastName}"></c:out></td>
                            <td class="text-center"><c:out value="${user.email}"></c:out></td>
                            <td class="text-center">

                                <!-- iterating roles for user and renders them in pretty way, without "ROLE_" -->
                                <c:forEach var="role" items="${user.roles}">
                                    <c:out value="${fn:substring(role.name, 5, fn:length(role.name))} "></c:out>
                                </c:forEach>
                            </td>
                            <td class="text-center">

                                <!-- user cannot delete himself but he can delete other users even admins -->
                                <!-- use conditions from td below to forbid deleting admins -->
                                <c:choose>
                                    <c:when test="${user.userName ne loggedUser}">
                                       <!-- condition checks if user.userName is NOT EQUAL to username of currently
                                       logged in user. If is not equal shows Delete User button with
                                       linking to deleteUrl created before -->
                                       <a href="${deleteUrl}" role="button" class="btn btn-outline-danger"
                                          onclick="if (!(confirm('Are you sure you want to delete this user?'))) return false">
                                          <i class="fas fa-user-minus"></i> Delete User
                                       </a>
                                    </c:when>
                                    <c:otherwise>
                                       <!-- if user.userName is EQUAL to username displays a button without href -->
                                       <button role="button" class="btn btn-outline-secondary"
                                               data-toggle="tooltip" title="You can't delete yourself">
                                           <i class="fas fa-user-minus"></i> Delete User
                                       </button>
                                    </c:otherwise>
                                </c:choose>

                            </td>


                            <!-- checking if user is admin already -->
                            <td class="text-center">
                               <c:choose>
                                 <c:when test = "${not ct:contains(user.roles, adminRole)}">

                                   <!-- checking if user.roles NOT CONTAINS "adminRole" - which is an attribute
                                   from UserController show users, or showSearchedUsers
                                   if true showing "Make An Admin" button linked to "makeAnAdminUrl"
                                   created before-->
                                   <a href="${makeAnAdminUrl}"
                                      role="button" class="btn btn-outline-success"
                                      onclick="if (!(confirm('Are you sure you want to make this user an Admin?'))) return false">
                                      <i class="fas fa-user-ninja"></i> Make An Admin
                                   </a>
                                 </c:when>
                                 <c:otherwise>

                                    <!-- if user.roles CONTAINS "adminrole" showing button without href -->
                                    <button role="button" class="btn btn-outline-secondary"
                                            data-toggle="tooltip" title="User is admin already">
                                        <i class="fas fa-user-ninja"></i> Make An Admin
                                    </button>
                                 </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
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










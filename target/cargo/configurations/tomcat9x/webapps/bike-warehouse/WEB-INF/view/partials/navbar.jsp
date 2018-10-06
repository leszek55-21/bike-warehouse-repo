
<!-- NAVBAR -->
<nav class="navbar navbar-expand-md navbar-dark bg-dark">

  <!-- START button -->
  <a class="navbar-brand" href="${pageContext.request.contextPath}">Start</a>

  <!-- HAMBURGER button - appear on xm and sm page view -->
  <button class="navbar-toggler" type="button" data-toggle="collapse"
          data-target=".navbar-collapse" aria-controls="navbarSupportedContent"
          aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
  </button>

  <!-- navbar content - it will collapse into hamburger button on smaller devices -->
  <div class="collapse navbar-collapse" id="navbarSupportedContent">

    <!-- List with "Admin Panel", "Bike Catalogue", "Contact" - left side of navbar -->
    <ul class="navbar-nav mr-auto">

      <!-- "Admin Panel" link - access only for users with role od ADMIN-->
      <li class="nav-item active">
        <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
            <c:url var="usersLink" value="${Mappings.SYSTEMS}/${Mappings.SHOW_USERS}"/>
            <a href="${usersLink}" class="nav-link">Admin Panel</a>
        </security:authorize>
      </li>

      <!-- "Bike Catalogue" link -->
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/${Mappings.BIKES}">
            Bike Catalogue
        </a>
      </li>

      <!-- "Contact" link -->
      <li class="nav-item active">
        <a class="nav-link" href="${pageContext.request.contextPath}/${Mappings.CONTACT}">
            Contact
        </a>
      </li>
    </ul>

    <!-- setting up boolean "isAnonymous" variable -->
    <security:authorize access="isAnonymous()" var="isAnonymous"/>

    <!-- right side of navbar with "Login", "Register", "My Profile", "Logout" -->
    <span class="nav-link" style="padding-left: 0px;">

        <!-- checking if there is no logged in user -->

        <!-- there is no logged in user -->
        <c:if test="${isAnonymous}">

            <!-- display list with content below -->
            <ul class="navbar-nav">

                <!-- display form with "Login" button (will renders login page) -->
                <li class="nav-item active" id="loginBtn">
                    <form:form action="${pageContext.request.contextPath}${Mappings.LOGIN}"
                               method="GET">
                        <input class="btn btn-outline-success my-2 my-sm-0"
                               type="submit" value="Login" />
                    </form:form>
                </li>

                <!-- display link to Register page as a "Register" button-->
                <li class="nav-item active">
                    <a href="${pageContext.request.contextPath}${Mappings.REGISTER}${Mappings.SHOW_REGISTRATION_FORM}"
                       class="btn btn-outline-info my-2 my-sm-0" role="button" aria-pressed="true">
                       Register New User
                    </a>
                </li>
            </ul>
        </c:if>

        <!-- there is a logged in user -->
        <c:if test="${not isAnonymous}">

            <!-- setting up variable "loggedUser" equal to the username of logged in user -->
            <security:authentication property="principal.username" var="loggedUser"/>

            <!-- list with "My profile" and "Logout" buttons -->
            <ul class="navbar-nav">

                <!-- "My profile" button with icon and "My profile" tooltip -->
                <li class="nav-item active" id="myProfileBtn">

                    <!-- creating url for "My profile" with "username" parameter -->
                    <c:url var="userProfile" value="${Mappings.USER_PROFILE}">
                        <c:param name="username" value="${loggedUser}"/>
                    </c:url>
                    <a href="${pageContext.request.contextPath}/${userProfile}"
                       class="btn btn-outline-primary"
                       data-toggle="tooltip" title="My profile">
                        <i class="far fa-user"></i>
                    </a>
                </li>

                <!-- "Logout" button - access only for users with role of USER-->
                <security:authorize access="hasRole('${UserRoleNames.USER}')">
                    <li class="nav-item active" style="align: center";>
                        <form:form action="${pageContext.request.contextPath}${Mappings.LOGOUT}"
                                   method="POST">
                            <input class="btn btn-outline-warning my-2 my-sm-0"
                                   type="submit" value="Logout" />
                        </form:form>
                    </li>
                </security:authorize>
            </ul>
        </c:if>
    </span>
  </div>
</nav>


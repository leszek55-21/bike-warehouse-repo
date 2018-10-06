<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>
<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

    <title>Bike Warehouse | View Bike</title>
    <!-- Required meta tags -->

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- custom css-->
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

        <!-- Displaying details depending on quantity in stock and date (inStockFrom) -->
        <c:choose>
            <c:when test="${bike.quantityInStock > 0}">
                <!-- when quantityInStock > 0 check if dateLaterThanNow param is true -->
                <c:choose>
                    <c:when test="${dateLaterThanNow}">

                        <!-- CASE 1 -->

                        <!-- displayed will be: "brand" "model" will cost only "price" -->
                        <h1 class="display-5">
                            <c:out value="${bike.brand}"/> <c:out value="${bike.model}"/>
                            will cost only
                            <c:out value="${bike.price}"/>$US
                        </h1>
                        <p class="lead">

                            <!-- displayed will be: we will have it in stock on "inStockFrom"
                                 We will have "quantityInStock" bikes available.
                                 Bike type is: "type"-->
                            We will have it in stock on:
                            <c:out value="${bike.inStockFrom}"/>.
                            We will have
                            <c:out value="${bike.quantityInStock}"/>
                            bikes available.
                            Bike type is:
                            "<c:out value="${bike.type}"/>"
                        </p>
                    </c:when>
                    <c:otherwise>
                        <!-- CASE 2 -->

                        <!-- displayed will be: "brand" "model" available for only "price" -->
                        <h1 class="display-5">
                            <c:out value="${bike.brand}"/> <c:out value="${bike.model}"/>
                            available for only
                            <c:out value="${bike.price}"/>$US
                        </h1>

                        <!-- displayed will be: In our stock from: "inStockFrom".
                             We still have "quantityInStock" bikes available
                             bike type is: "type"-->
                        <p class="lead">
                            In our stock from:
                            <c:out value="${bike.inStockFrom}"/>.
                            We still have
                            <c:out value="${bike.quantityInStock}"/>
                            bikes available.
                            Bike type is:
                            "<c:out value="${bike.type}"/>"
                        </p>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>

                <!-- CASE 3 -->

                <!-- displayed will be: "brand" "model" is currently out of stock. Our price is:
                     "price" Bike type is "type" -->
                <h1 class="display-5">
                    <c:out value="${bike.brand}"/> <c:out value="${bike.model}"/>
                    is currently out of stock. Our price is:
                    <c:out value="${bike.price}"/>$US
                </h1>
                <p class="lead">
                    Bike type is:
                    <c:out value="${bike.type}"/>
                </p>
            </c:otherwise>
        </c:choose>

      </div>
    </div>

    <!-- flash messages adding/deleting comment -->

    <!-- showing param commentAdded if it is not null, param is CommentController
         postComment method -->
    <c:if test="${param.commentAdded ne null}">
        <div class="alert alert-success col-xs-offset-1 col-xs-10">
            <c:out value="${param.commentAdded}"/>
        </div>
    </c:if>

    <!-- showing param commentDeleted if it is not null, param is CommentController
             deleteComment method -->
    <c:if test="${param.commentDeleted ne null}">
        <div class="alert alert-warning col-xs-offset-1 col-xs-10">
            <c:out value="${param.commentDeleted}"/>
        </div>
    </c:if>

    <!-- creating editUrl with id (bike id) and type (bike type) params -->
    <c:url var="editUrl" value="${Mappings.ADD_BIKE}">
        <c:param name="id" value="${bike.id}"/>

        <!-- param for autoselecting bike type in edit dropdown -->
        <c:param name="type" value="${bike.type}"/>
    </c:url>

    <!-- securing edit button - only for admins -->
    <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
        <a href="${editUrl}" role="button" class="btn btn-warning"
            style="margin-bottom: 20px; margin-left:15px;">
            <i class="fas fa-edit"></i> Edit Bike
        </a>
    </security:authorize>

    <div style="padding: 10px;">
        <div class="row">
            <div class="col-md-8">

                <!-- left side image and description -->
                <div id="cardBikeView" class="card">
                  <div id="imgHeader" class="card-header">
                    <img src="${bike.imageUrl}" class="img-responsive img-thumbnail">
                  </div>
                  <div class="card-body">
                    <h3 class="card-title"><c:out value="${bike.brand} ${bike.model}"/> details:</h3>
                    <hr id="hrBikeDetails">
                    <c:out value="${bike.details}"/>
                  </div>
                </div>

            </div>

            <!-- right side (or bottom) on smaller devices - comments section -->
            <div class="col-md-4">
                <h2>Comments:</h2>

                <!-- url for comment form action -->
                <c:url var="commentUrl" value="${Mappings.POST_COMMENT}">
                    <c:param name="bikeId" value="${bike.id}"/>

                    <!-- param for current user id -->
                    <c:param name="userId" value="${user.id}"/>
                </c:url>

                <!-- setting boolean variable if user is logged in -->
                <security:authorize access="isAuthenticated()" var="loggedIn"/>
                <c:if test="${loggedIn eq false}">
                   <div class="alert alert-info col-xs-offset-1 col-xs-10"
                        style="margin-bottom: 5px; margin-top:5px;">
                       <p>Please <a href="${pageContext.request.contextPath}${Mappings.LOGIN}">Log in</a> to post comment</p>
                   </div>
                </c:if>

                <security:authorize access="hasRole('${UserRoleNames.USER}')">

                    <!-- url for user profile -->
                    <c:url var="loggedProfile" value="${Mappings.USER_PROFILE}">
                        <c:param name="username" value="${loggedUser}"/>
                    </c:url>

                    <!-- getting logged in user name -->
                    <security:authentication property="principal.username" var="loggedUser"/>

                    <span class="h6">You will be posting comment as:
                        <a href="${loggedProfile}">
                            <strong><c:out value="${loggedUser}"/></strong>
                        </a>
                    </span>

                    <!-- adding comment form -->
                    <form:form method="POST" class="form-inline" action="${commentUrl}"
                               id="addComment">
                        <div class="input-group">

                            <!-- comment text area -->
                            <input type="textarea" class="form-control" name="commentContent"
                                   required pattern=".*\S+.*" placeholder="write a comment..."
                                   id="commentInput" maxlength="300"
                                   oninvalid="this.setCustomValidity('You cannot post empty comment')"
                                   oninput="this.setCustomValidity('')"/>

                            <div class="input-group-append">
                                <button class="btn btn-outline-success">
                                    <strong><i class="far fa-paper-plane"> Post</i></strong>
                                </button>
                            </div>
                        </div>
                    </form:form>
                </security:authorize>

                <!-- displaying that there is no comments for this bike yet -->
                <c:if test="${empty bike.comments}">
                    <div class="alert alert-info col-xs-offset-1 col-xs-10"
                         style="margin-top: 10px;">
                        <p>This bike has no comments yet</p>
                    </div>
                </c:if>

                <!-- displaying comments -->
                <!-- iterating over (reversed in bikeController viewBike method) maps key set  - WOW:)-->
                <!-- here displaying comments from newest to oldest -->
                <c:forEach var="comment" items="${commentsAndPastTimeMapRev.keySet()}">

                    <c:set var = "commentAuthor" value = "${comment.user.userName}"/>

                    <!-- url for deleting comment -->
                    <c:url var="deleteCommentUrl" value="${Mappings.DELETE_COMMENT}">
                        <c:param name="commentId" value="${comment.id}"/>
                        <c:param name="commentAuthor" value="${commentAuthor}"/>
                    </c:url>

                    <!-- url for user profile -->
                    <c:url var="userProfile" value="${Mappings.USER_PROFILE}">
                        <c:param name="username" value="${commentAuthor}"/>
                    </c:url>

                    <div id="commentBox" class="card card-white">
                        <div class="card-header">
                            <span class="text-muted">

                                <!-- using function from custom taglib -->
                                <c:set var="date" scope="session" value="${ct:formatDate(comment.createdAt)}"/>

                                <!-- showing comment date from model attr commentsAndPastTimeMap
                                     key is "comment" -->
                                <span data-toggle="tooltip" data-placement="bottom"
                                     title='<c:out value="${date}"/>'>
                                    <i class="far fa-comment"></i>
                                    <c:out value="${commentsAndPastTimeMapRev[comment]}"/>
                                </span>

                                <!-- checking who is logged in, if comment author, displayed will be "you"
                                     if someone else, displayed will be his username with link to profile -->
                                <strong>
                                    <c:choose>
                                        <c:when test="${comment.user ne null}">
                                            <c:choose>
                                                <c:when test="${loggedUser eq commentAuthor}">
                                                    <strong>you</strong>
                                                </c:when>
                                                <c:otherwise>
                                                   <a href="${userProfile}">
                                                       <c:out value="${commentAuthor}"></c:out>
                                                   </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                           Deleted User
                                        </c:otherwise>
                                    </c:choose>
                                </strong>
                                wrote:
                            </span>
                        </div>

                        <!-- displaying comment content - text -->
                        <div class="card-body">
                            <p><c:out value="${comment.content}"></c:out></p>

                             <security:authorize access="isAuthenticated()">
                                <!-- access only for logged in users -->
                                <c:choose>
                                    <c:when test="${commentAuthor == loggedUser}">

                                        <!-- logged in user sees delete button next to his comments -->
                                        <security:authorize access="hasRole('${UserRoleNames.USER}')">
                                             <hr>
                                             <a href="${deleteCommentUrl}"
                                                role="button" class="btn btn-sm btn-outline-danger"
                                                onclick="if (!(confirm('Are you sure you want to delete this comment?'))) return false">
                                                <i class="fas fa-minus-circle"></i> Delete comment
                                             </a>
                                        </security:authorize>
                                    </c:when>
                                    <c:otherwise>
                                        <!-- admin sees delete button next to all comments -->
                                        <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
                                             <hr>
                                             <a href="${deleteCommentUrl}"
                                                role="button" class="btn btn-sm btn-outline-danger"
                                                onclick="if (!(confirm('Are you sure you want to delete this comment?'))) return false">
                                                <i class="fas fa-minus-circle"></i> Delete comment
                                             </a>
                                        </security:authorize>
                                    </c:otherwise>
                                </c:choose>
                            </security:authorize>
                        </div>
                    </div>
                </c:forEach>
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
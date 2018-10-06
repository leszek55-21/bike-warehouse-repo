<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>
<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

    <title>Bike Warehouse | Bikes</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- jQuery & fancybox script and css - creating picturs preview -->
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/fancybox/jquery.easing-1.3.pack.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/fancybox/jquery.fancybox-1.3.4.css" type="text/css" media="screen" />

    <!-- custom stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" type="text/css" />

    <!-- font awesome icons-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

</head>
<body>
    <%@ include file="partials/navbar.jsp"%>

    <div align="center">

        <!-- JUMBOTRON -->
        <div class="jumbotron">
            <!-- welcome messages -->
            <div class="pull-left">
                <h1><i class="fas fa-bicycle"></i> Welcome to Bike Warehouse</h1>
                <h4>Greatest place to find a bike of your dreams!</h4>
            </div>

            <!-- searching and sorting bikes section -->
            <div class="form-inline" style="align: center";>
              <div class="form-group">
                  <span class="nav-link">

                      <!-- searching form -->
                      <form:form method="POST" action="${Mappings.BIKES}" id="sortForm">
                         <input type="text" name="searchString" class="form-control"
                                placeholder="Search..." value="${searchString}"/>
                         <input type="submit" value="Search" class="btn btn-success my-2 my-sm-0"/>
                      </form:form>
                  </span>
                  <span class="nav-link">

                      <!-- sorting dropdown -->
                      <select class="droplist form-control" name="sortString" form="sortForm" onchange='this.form.submit()'>
                        <option value="${SortingStrings.EMPTY}" disabled="true" selected>Sort by...</option>
                        <div class="dropdown-divider"></div>
                        <option value="${SortingStrings.BRAND_ASCENDING}"
                                ${param.sortString == 'brandAsc' ? 'selected' : ''}>Brand A-Z</option>
                        <option value="${SortingStrings.BRAND_DESCENDING}"
                                ${param.sortString == 'brandDesc' ? 'selected' : ''}>Brand Z-A</option>
                        <option value="${SortingStrings.PRICE_ASCENDING}"
                                ${param.sortString == 'priceAsc' ? 'selected' : ''}>Price - lowest first</option>
                        <option value="${SortingStrings.PRICE_DESCENDING}"
                                ${param.sortString == 'priceDesc' ? 'selected' : ''}>Price - highest first</option>
                        <option value="${SortingStrings.QUANTITY_DESCENDING}"
                                ${param.sortString == 'quantityDesc' ? 'selected' : ''}>Quantity biggest -> lowest</option>
                        <option value="${SortingStrings.QUANTITY_ASCENDING}"
                                ${param.sortString == 'quantityAsc' ? 'selected' : ''}>Quantity lowest -> biggest</option>
                        <option value="${SortingStrings.ADDED_DESCENDING}"
                                ${param.sortString == 'addedDesc' ? 'selected' : ''}>New added</option>
                        <option value="${SortingStrings.ADDED_ASCENDING}"
                                ${param.sortString == 'addedAsc' ? 'selected' : ''}>Oldest</option>
                      </select>
                  </span>
              </div>
            </div>


            <!-- table summary - access only for admins-->
            <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
                <div class="pull-left">
                   <span class="badge badge-secondary"><h6><strong>Quantity of bikes in table is: <mark>${sumAll}</mark></strong></h6></span>
                   <span class="badge badge-secondary"><h6><strong>Value of bikes in table is: <mark>${valueAll} USD</mark></strong></h6></span>
                   <span class="badge badge-secondary"><h6><strong>Different brands in table: <mark>${diffBrands}</mark></strong></h6></span>
                </div>
            </security:authorize>
        </div>

        <!-- INFO MESSAGES SECTION(flash messages) -->

        <!-- if param deleteSuccess exist displaying alert div "Bike succesfully deleted"
             param is from BikeController deleteBike method -->
        <c:if test="${param.deleteSuccess}">
            <div class="alert alert-info col-xs-offset-1 col-xs-10">
                Bike succesfully deleted
            </div>
        </c:if>

        <!-- if param "addOrEditSuccess" exist chooseing from 2 options below
             param is from BikeController processBike method -->
        <c:if test="${param.addOrEditSuccess}">
           <c:choose>
               <c:when test="${not empty param.newAdded}">

                   <!-- if param "newAdded" IS NOT empty, display this param
                        param is from BikeController processBike method -->
                   <div class="alert alert-success col-xs-offset-1 col-xs-10">
                       <c:out value="${param.newAdded} "/>
                   </div>
               </c:when>
               <c:when test="${not empty param.edited}">

                   <!-- if param "edited" IS NOT empty, display this param
                        param is from BikeController processBike method -->
                   <div class="alert alert-success col-xs-offset-1 col-xs-10">
                       <c:out value="${param.edited} "/>
                   </div>
               </c:when>
           </c:choose>
        </c:if>

        <!-- BIKES TABLE -->
        <div style="padding: 2px;">
            <div class="table-responsive-xs">
                <table  class="table table-hover table-dark table-bordered table-striped">

                     <!-- table caption -->
                     <caption style="caption-side: top">
                         <div class="container" style="margin-left: 5px;">

                            <!-- adding 'new bike' button - only for admins-->
                            <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
                                <c:url var="addUrl" value="${Mappings.ADD_BIKE}"/>
                                <h2>
                                    <a href="${addUrl}" role="button" class="btn btn-success">
                                        <i class="fas fa-plus"></i> Add Bike
                                    </a>
                                </h2>
                            </security:authorize>
                        </div>
                     </caption>

                     <!-- table head -->
                     <thead class="thead-green">
                        <tr class="bg-success">
                            <th scope="col" class="bg-success text-center">Id</th>
                            <th scope="col" class="bg-success text-center">Thumbnail</th>
                            <th scope="col" class="bg-success text-center">Brand</th>
                            <th scope="col" class="bg-success text-center">Model</th>
                            <th scope="col" class="bg-success text-center">Type</th>
                            <th scope="col" class="bg-success text-center">Quantity in stock</th>
                            <th scope="col" class="bg-success text-center">Price (USD)</th>
                            <th scope="col" class="bg-success text-center">In stock since</th>
                            <th scope="col" class="bg-success text-center">Show</th>

                            <!-- restricted acces for "Edit" and "Delete" buttons - for admins only -->
                            <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
                                <th scope="col" class="bg-success text-center">Edit</th>
                                <th scope="col" class="bg-success text-center">Delete</th>
                            </security:authorize>
                        </tr>
                     </thead>

                         <!-- if param emptyBikesList exist adding message "no results found"
                              param is from BikeController searchBikes method -->
                         <c:if test="${emptyBikesList}">
                             <div class="alert alert-warning col-xs-offset-1 col-xs-10"
                                  style="margin-top: 15px;">
                                  No results found
                             </div>
                         </c:if>

                     <!-- table body -->
                     <tbody>
                        <!-- looping for each item from bikes, which is from BikeController
                             bikes or showBikes methods -->
                        <c:forEach var="bike" items="${bikes}">

                            <!-- creating edit URl with param "id" which is bikes id and type - bikes type -->
                            <c:url var="editUrl" value="${Mappings.ADD_BIKE}">
                                <c:param name="id" value="${bike.id}"/>

                                <!-- param for autoselecting bike type in edit dropdown -->
                                <c:param name="type" value="${bike.type}"/>
                            </c:url>

                            <!-- creating view URl with param "id" which is bikes id -->
                            <c:url var="viewUrl" value="${Mappings.VIEW_BIKE}">
                                <c:param name="id" value="${bike.id}"/>
                            </c:url>

                            <!-- creating delete URl with param "id" which is bikes id -->
                            <c:url var="deleteUrl" value="${Mappings.DELETE_BIKE}">
                                <c:param name="id" value="${bike.id}"/>
                            </c:url>

                            <tr>
                                <!-- populating cells for each row -->
                                <td class="text-center"><c:out value="${bike.id}"></c:out></td>
                                <td class="text-center">
                                    <a id="single_image" href="${bike.imageUrl}">
                                        <img src="${bike.imageUrl}" alt="" height="60" width="60"/>
                                    </a>
                                </td>
                                <td scope="row" class="text-center"><a href="${viewUrl}"><c:out value="${bike.brand}"></c:out></a></td>
                                <td class="text-center"><c:out value="${bike.model}"></c:out></td>
                                <td class="text-center"><c:out value="${bike.type}"></c:out></td>
                                <td class="text-center"><c:out value="${bike.quantityInStock}"></c:out></td>
                                <td class="text-center"><c:out value="${bike.price}"></c:out></td>
                                <td class="text-center"><c:out value="${bike.inStockFrom}"></c:out></td>
                                <td class="text-center">
                                    <a href="${viewUrl}" role="button" class="btn btn-outline-info">
                                        <i class="fas fa-book-open"></i> Show
                                    </a>
                                </td>

                                <!-- securing access to "Edit" and "Delete" buttons - only for admins -->
                                <security:authorize access="hasRole('${UserRoleNames.ADMIN}')">
                                <td class="text-center ">
                                    <a href="${editUrl}" role="button" class="btn btn-outline-warning">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                </td>
                                <td class="text-center">
                                    <a href="${deleteUrl}" role="button" class="btn btn-outline-danger"
                                        onclick="if (!(confirm('Are you sure you want to delete this bike?'))) return false">
                                        <i class="fas fa-trash-alt"></i> Delete
                                    </a>
                                </td>
                                </security:authorize>
                            </tr>
                        </c:forEach>
                     </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- including footer -->
    <%@ include file="partials/footer.jsp"%>

    <!-- fancybox script for showing bikes pictures -->
    <script type="text/javascript">
        $(document).ready(function() {

            /* Using custom settings */

            $("a#single_image").fancybox();
        });
    </script>

    <!-- Temporary commented out
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    -->

</body>
</html>
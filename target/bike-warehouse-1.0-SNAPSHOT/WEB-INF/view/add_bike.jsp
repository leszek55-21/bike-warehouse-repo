<!-- including a jsp file with taglibs and pageimports -->
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

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- Custom stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" type="text/css" />

    <!-- font awesome icons-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

    <!-- required scripts and css for datepicker -->
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

    <!-- styling error messages from adding bike form -->
    <style>
        .error {color:red}
    </style>

    <!-- datepicker -->
    <script>
        $(function () {
            $("#datepicker").datepicker(
            {
                showAnim: 'drop',
                dateFormat: 'dd.mm.yy'
            });
        });
    </script>
</head>
<body>

    <!-- including navbar -->
    <%@ include file="partials/navbar.jsp"%>

    <!-- JUMBOTRON -->
    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <h1 class="display-4">Welcome to Bike Warehouse</h1>
        <p class="lead" style="text-align: left;">Use this processing form to add new bike, or update existing one</p>
      </div>
    </div>

    <!-- DETAILS card below jumbotron above form -->
    <div class="card">
      <div class="card-body">
        <h2>Details</h2>
      </div>
    </div>

    <!-- page content:
         left side form for adding/editing bike,
         right side picture previev  - will be move down on smaller devices -->
    <div class="row">

        <!-- ON LEFT: form for adding/editing bike -->
        <div class="col-sm-6" align="center" id="formBox">
            <form:form method="POST" modelAttribute="${AttributeNames.BIKE}">

              <!-- first line input for "Id"(disabled), "Brand" and Model -->
              <div class="form-row">
                  <div class="form-group col-md-2">
                      <label for="bikeId">ID</label>
                      <form:input path="id" id="bikeId" disabled="true" class="form-control"/>
                  </div>
                  <div class="form-group col-md-5">
                      <label for="bikeBrand">Brand</label>
                      <form:input path="brand" id="bikeBrand" class="form-control"/>
                      <form:errors path="brand" cssClass="error" />
                  </div>
                  <div class="form-group col-md-5">
                      <label for="bikeModel">Model</label>
                      <form:input path="model" id="bikeModel" class="form-control"/>
                      <form:errors path="model" cssClass="error" />
                  </div>
              </div>

              <hr>

              <!-- second line input for "Type"(dropdown)
                   and "in stock from" (datepicker) -->
              <div class="form-row">
                  <div class="form-group col-md-6">
                      <label for="dropdown">Type</label>
                      <form:select path="type" id="dropdown" class="form-control">
                          <option value="" disabled="true" selected>Type</option>
                          <option value="road bike">Road Bike</option>
                          <option value="mountain bike">Mountain Bike</option>
                          <option value="kids bike">Kids Bike</option>
                          <option value="other">Other</option>
                      </form:select>
                      <form:errors path="type" cssClass="error" />
                  </div>
                  <div class="form-group col-md-6">
                      <label for="datepicker">In stock from</label>
                      <form:input type="text" id="datepicker" path="inStockFrom"
                                  class="form-control"/>
                  </div>
              </div>

              <hr>

              <!-- third line input for "image URL" -->
              <div class="form-group">
                  <label for="imageUrl">Imager URL</label>
                  <form:input path="imageUrl" id="imageUrl"
                              onfocus="this.value=''"
                              class="form-control"/>
              </div>

              <hr>

              <!-- fourth line input for "Details" (text area) -->
              <div class="form-group">
                  <label for="bikeDetails">Details</label>
                  <form:textarea path="details" class="form-control" rows="4"/>
                  <form:errors path="details" cssClass="error" />
              </div>

              <hr>

              <!-- fifth line input for "Price $US" and "Quantity in stock" -->
              <div class="form-row">
                  <div class="form-group col-md-6">
                      <label for="bikePrice">Price $US</label>
                      <form:input path="price" type="number" id="bikePrice"
                                  step="0.01" class="form-control"/>
                      <form:errors path="price" cssClass="error" />
                  </div>
                  <div class="form-group col-md-6">
                      <label for="bikeQuantity">Quantity in Stock</label>
                      <form:input path="quantityInStock" id="bikeQuantity" type="number"
                                  class="form-control"/>
                      <form:errors path="quantityInStock" cssClass="error" />
                  </div>
              </div>

              <!-- sixth line buttons "Submit", "Reset", "Quit" -->
              <div class="form-row" style="border: 3px solid green; padding-top:15px;">
                  <div class="form-group col-md-4">
                      <input type="submit" value="Submit" class="btn btn-success"/>
                  </div>

                  <div class="form-group col-md-4">
                      <input type="reset" value="Reset" class="btn btn-warning">
                  </div>

                  <div class="form-group col-md-4">
                      <a href="${pageContext.request.contextPath}/${Mappings.BIKES}" role="button" class="btn btn-danger">
                          Quit
                      </a>
                  </div>
              </div>
            </form:form>
        </div>

        <!-- ON RIGHT: "Image Preview" - will go down on smaller devices-->
        <div class="col-sm-6" style="padding-top:15px;">
            <div class="form-group">
                <label for="img">Image Preview</label>
                <img src="" class="img-fluid img-thumbnail" id="img"/>
            </div>
        </div>
    </div>

    <!-- including footer -->
    <%@ include file="partials/footer.jsp"%>

    <!-- bootstrap and jquery scripts -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- script for autoselecting proper bike type when edit page loads -->
    <script type="text/javascript">
        $(document).ready(function() {
           // set select options with jquery and EL
           $("#dropdown").val("${param.type}");

           // set preview image src to value of imgUrl input value
           var src = $('#imageUrl').val();
           $("#img").attr("src", src);

           // set preview image src to value of imgUrl input value
           $("#imageUrl").blur(function(){
                 var inputVal = $(this).val();
                 $("#img").attr("src", inputVal);
            });

           // removing type param from URL
           var uri = window.location.toString();
               if (uri.indexOf("?") > 0) {
                   var clean_uri = uri.substring(0, uri.indexOf("&"));
                   window.history.replaceState({}, document.title, clean_uri);
               }
        });
    </script>
</body>
</html>
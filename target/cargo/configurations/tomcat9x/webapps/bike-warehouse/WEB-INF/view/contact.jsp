<!-- including a jsp file with taglibs and pageimports -->
<%@ include file="partials/taglibsAndPageImports.jsp"%>

<!DOCTYPE html>

<html>
<head>

    <!-- title icon -->
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/bike.jpg" />

    <title>Bike Warehouse | Contact</title>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">

    <!-- css custom styling-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css" type="text/css" />

    <!-- font awesome icons-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">

    <!-- google maps script-->
    <script src="http://maps.google.com/maps/api/js?sensor=false" type="text/javascript"></script>

    <style>*{margin:0;}</style>
</head>
<body>

     <!-- including navbar -->
    <%@ include file="partials/navbar.jsp"%>

    <!-- JUMBOTRON -->
    <div class="jumbotron jumbotron-fluid">
      <div class="container">
        <h1 class="display-4">Welcome to Bike Warehouse</h1>
        <p class="lead" style="text-align: left;">See main info about our company below</p>
      </div>
    </div>

    <!-- page content -->
    <div style="padding: 10px;">
        <div class="row">

            <!-- left side with address and about us info -->
            <div class="col-md-6">
                <div class="card">
                  <div class="card-header">
                    <h4 class="card-title">Bike Warehouse</h4>
                  </div>
                  <div class="card-body">
                    <h5 class="card-title">Contact</h5>

                    <div class="card border-info mb-3">
                      <div class="card-header">Address</div>
                      <div class="card-body text-info">
                        <h6 class="card-text">Bike Warehouse</h6>
                        <h6 class="card-text">Miru 23</h6>
                        <h6 class="card-text">Hanga Roa</h6>
                        <h6 class="card-text">Region de Valparaiso</h6>
                        <h6 class="card-text">Isla de Pascua - Easter Island</h6>
                        <h6 class="card-text">Chile</h6>
                        <p class="card-text">email: bikewarhouse@rapanui.com</p>
                        <p class="card-text">tel: +6788 547 345</p>
                        <p class="card-text"><strong>Please place your orders by phone, or email only. You can also visit us directly</strong></p>
                      </div>
                    </div>

                    <hr>
                    <h5 class="card-title">About us</h5>
                    <p class="card-text">
                        Lorem ipsum: But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, and expound the actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires to obtain pain of itself, because it is pain, but because occasionally circumstances occur in which toil and pain can procure him some great pleasure. To take a trivial example, which of us ever undertakes labo
                    </p>
                  </div>
                </div>
            </div>

            <!-- right side with google maps container -->
            <div class="col-md-6">
                <div id="map" style="width: 100%; height: 400px;"></div>
            </div>
        </div>
    </div>

    <!-- including footer -->
    <%@ include file="partials/footer.jsp"%>

    <!-- bootstrap and jquery scripts -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <!-- google maps script -->
    <script type="text/javascript">

       var locations = [
            ['Moai', -27.143982, -109.330648, 1],
            ['Bike Warehouse', -27.157767, -109.424882, 2]
       ];

       var map = new google.maps.Map(document.getElementById('map'), {
            zoom: 15,
            center: new google.maps.LatLng(-27.157767, -109.424882),
            mapTypeId: google.maps.MapTypeId.ROADMAP
       });

       var infowindow = new google.maps.InfoWindow();

       var marker, i;

       for (i = 0; i < locations.length; i++) {

            marker = new google.maps.Marker({
            position: new google.maps.LatLng(locations[i][1], locations[i][2]),
            map: map
       });

       google.maps.event.addListener(marker, 'click', (function(marker, i) {
            return function() {
                infowindow.setContent(locations[i][0]);
                infowindow.open(map, marker);
            }
            })(marker, i));
       }

    </script>
</body>
</html>
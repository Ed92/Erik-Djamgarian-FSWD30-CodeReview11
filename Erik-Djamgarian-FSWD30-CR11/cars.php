<?php
 ob_start();
 session_start();
 require_once 'dbconnect.php';
 // if session is not set this will redirect to login page
 if( !isset($_SESSION['user']) ) {
  header("Location: index.php");
  exit;
 }
  // select logged-in users detail
 $res = mysqli_query($conn, "SELECT * FROM users WHERE user_id=".$_SESSION['user']);
 $userRow = mysqli_fetch_array($res, MYSQLI_ASSOC);
?>

<!DOCTYPE html>
<html>
<head>
<title>Welcome - <?php echo $userRow['user_name']; ?></title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="css/style.css">
</head>
<body>

  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <a class="navbar-brand" href="home.php"><span class="glyphicon glyphicon-road"></span></a>
      </div>
      <ul class="nav navbar-nav">
        <li><a href="home.php">Home</a></li>
        <li><a href="cars.php">Cars</a></li>
        <li><a href="office.php">Offices</a></li>
        <li><a href="contact.php">Contact</a></li>
      </ul>
    </div>
  </nav>




        <?php
        $servername = "localhost";
        $username = "root";
        $password = "";
        $database = "cr11_erik_djamgarian_php_car_rental";
        // Create connection
        $conn = mysqli_connect($servername, $username, $password, $database);
        // Check connection
        if (!$conn) {
            die("Connection failed: " . mysqli_connect_error());
        }
        echo "<div class='container'>Connected</div>";
        $sql = "SELECT car_model, car_tank, seats, car_location, return_station, fk_office_id FROM cars ";
        $result = mysqli_query($conn, $sql);
        if ($result->num_rows > 0) {
            echo "<div class='abs container'>
        <table class='table'>
          <tr>
            <th>Cars</th>
            <th>Nr. of seats</th>
            <th>Horsepower</th>
            <th>Currently at</th>
            <th>to return at</th>
            <th>Current location</th>
          </tr>";
            // output data of each row
            while($row = $result->fetch_assoc()) {
                echo "<tr>
                  <td>" . $row["car_model"] . "</td>
                  <td>" . $row["seats"] . "</td>
                  <td>" . $row["car_tank"] . "</td>
                  <td>" . $row["fk_office_id"] . "</td>
                  <td>" . $row["return_station"] . "</td>
                  <td>" . $row["car_location"]."</td>
                </tr>";
            }
            echo "</table></div>";
        } else {
            echo "0 results";
        }
        if('fk_office_id' === NULL){
        echo "<td>' Currently in use '</td>";
        }
        mysqli_close($conn);
        ?>

        <div class="container">
    <?php echo $userRow['user_name']; ?>

              <a  href="logout.php?logout">Sign Out</a>
            </div>
</body>
</html>
<?php ob_end_flush(); ?>
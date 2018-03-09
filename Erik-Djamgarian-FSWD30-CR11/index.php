<?php
 ob_start();
 session_start();
 require_once 'dbconnect.php';
 // it will never let you open index(login) page if session is set
if ( isset($_SESSION['user'])!="" ) {
  header("Location: home.php");
  exit;
 }
 $error = false;
 if( isset($_POST['btn-login']) ) {
  // prevent sql injections/ clear user invalid inputs
  $email = trim($_POST['email']);
  $email = strip_tags($email);
  $email = htmlspecialchars($email);
  $pass = trim($_POST['pass']);
  $pass = strip_tags($pass);
  $pass = htmlspecialchars($pass);
  // prevent sql injections / clear user invalid inputs
  if(empty($email)){
   $error = true;
   $emailError = "Please enter your email address.";
  } else if ( !filter_var($email,FILTER_VALIDATE_EMAIL) ) {
   $error = true;
   $emailError = "Please enter a valid email address.";
  }
  if(empty($pass)){
   $error = true;
   $passError = "Please enter your password.";
  }
  // if there's no error, continue to login
  if (!$error) {
   $password = hash('sha256', $pass); // password hashing using SHA256
   $res=mysqli_query($conn, "SELECT user_id, user_name, user_pass FROM users WHERE user_email='$email'");
   $row=mysqli_fetch_array($res, MYSQLI_ASSOC);
   $count = mysqli_num_rows($res); // if uname/pass correct it returns must be 1 row
   if( $count == 1 && $row['user_pass']==$password ) {
        $_SESSION['user'] = $row['user_id'];
        header("Location: home.php");
   } else {
    $errMSG = "Incorrect Credentials, please try again...";
   }
  }
 }
 ?>
<!DOCTYPE html>
<html>
<head>
<title>Login & Registration System</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
  <div class="container">


      <form method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>" autocomplete="off">
                     <h2>Welcome!</h2>
             <hr />
                         <?php
   if ( isset($errMSG) ) {
echo $errMSG; ?>
                <?php
                 }
                    ?>

             <input type="email" name="email" class="form-control" placeholder="Your Email" value="<?php echo $email; ?>" maxlength="40" />
                          <span class="text-danger"><?php echo $emailError; ?></span>
<br />

             <input type="password" name="pass" class="form-control" placeholder="Your Password" maxlength="15" />

            <span class="text-danger"><?php echo $passError; ?></span>
             <hr />
             <button class="btn" type="submit" name="btn-login">Log in</button>

             <hr />
             <a href="register.php">Register.</a>


    </form>
      </div>
    </div>
      </div>
  </body>
  </html>
<?php ob_end_flush(); ?>
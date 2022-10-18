<?php 
include('dbcon.php');
include('session.php'); 

$result=mysqli_query($con, "select * from Accounts where User_id='$session_id'")or die('Error In Session');
$row=mysqli_fetch_array($result);

 ?>
 <form action="upload.php" method="post" enctype="multipart/form-data">
                    Select image to upload:
                    <input type="file" name="fileToUpload" id="fileToUpload">
                    <input type="submit" value="Upload Image" name="submit">
                </form>

<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div class="form-wrapper"> 
    <center><h3>Welcome: <?php echo $row['Username']; ?> </h3></center>
	 <div class="reminder">
    <p><a href="logout.php">Log out</a></p>
  </div>
</div>

</body>
</html>

<?php
$con = mysqli_connect("172.16.0.2","root","abc123","3204_db");

// Check connection
if (mysqli_connect_errno())
  {
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
  }
?>

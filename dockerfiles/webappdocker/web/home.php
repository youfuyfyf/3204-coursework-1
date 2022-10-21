<?php 
include('dbcon.php');
include('session.php'); 

 ?>

<html>
<head>
<link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
<div class="form-wrapper"> 
    <center><h3>Hello <?php$session_id?></h3></center>
	 <div class="reminder">
    <hr>
   <table border="3" cellspacing="0" cellpadding="10">
        <tbody>
           <tr>
              <th>IP</th>
              <th>Username</th>
              <th>Password</th>
           </tr>
    <?php
    $username = $_GET['username'];
    $sql ="SELECT * FROM `SSH Credentials` WHERE Accounts_User_id='$username'";
		$result = mysqli_query($con, $sql);
		$queryResult = mysqli_num_rows($result);
    if($queryResult > 0){
        while($row = mysqli_fetch_assoc($result)){
          echo "<tr><td>".$row["IP_Address"]."</td>";
          echo "<td>".$row["Username"]."</td>";
          echo "<td>".$row["Password"]."</td>";
        }
      }
    ?>
    </table>
    <hr>
    <p><a href="logout.php">Log out</a></p>
  </div>
</div>

</body>
</html>

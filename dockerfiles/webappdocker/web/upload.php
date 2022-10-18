
<!DOCTYPE html>
<html>
<?php session_start(); ?>
<?php include('dbcon.php'); ?>
<body>
</body>
</html>

<?php

$target_path = "uploads/";
//Here we set the target path that will save the file in to.
$target_path = $target_path . basename($_FILES['fileToUpload']['name']);
// here wll move the desired file from the tmp directory to the target path
if (move_uploaded_file($_FILES['fileToUpload']['tmp_name'], $target_path)) {
    echo "the file " . basename($_FILES['fileToUpload']['name']) . " has been uploaded! ";
} else {
     echo "there was an error uploading the file ,please try again!";
}
?>


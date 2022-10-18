<!DOCTYPE html>
<html>
<?php include('dbcon.php'); ?>
<body>

<form action="upload.php" method="post" enctype="multipart/form-data">
  Select image to upload:
  <input type="file" name="fileToUpload" id="fileToUpload">
  <input type="submit" value="Upload Image" name="submit">
</form>

</body>
</html>

<?php

$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
// here wll move the desired file from the tmp directory to the target path
if (move_uploaded_file($_FILES['uploadedfile']['tmp_name'], $target_path)) {
    echo "the file " . basename($_FILES['uploadedfile']['name']) . " has been uploaded! ";
} else {
     echo "there was an error uploading the file ,please try again!";
}

// Check if image file is a actual image or fake image
if(isset($_POST["submit"])) {
  $check = getimagesize($_FILES["fileToUpload"]["tmp_name"]);
  if($check !== false) {
    echo "File is an image - " . $check["mime"] . ".";
    $uploadOk = 1;
  } else {
    echo "File is not an image.";
    $uploadOk = 0;
  }
}
?>

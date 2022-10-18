<form enctype="multipart/form-data" action="upload.php" method="POST">
<input type="hidden" name="MAX_FILE_SIZE" value="100000" />
Choose a file to upload: <input name="uploadedfile" type="file" /><br />
<input type="submit" value="Upload File" />
</form>

<?php
$target_path="uploads/";
//Here we set the target path that will save the file in to.
$target_path = $target_path.basename($_FILES['uploadedfile']['name']);
// here wll move the desired file from the tmp directory to the target path
if(move_uploaded_file($_FILES['uploadedfile']['tmp_name'],$target_path)){
echo "the file " . basename($_FILES['uploadedfile']['name']) . " has been uploaded! ";
}else {
echo "there was an error uploading the file ,please try again!";
}
?>

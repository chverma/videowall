

<?php
$target_dir = __DIR__ . "/uploads/";
$target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);

echo "Target file: " . $target_file;

$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));
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

// Check if file already exists
/*if (file_exists($target_file)) {
    echo "Sorry, file already exists.";
    $uploadOk = 0;
}
*/

// Check file size
/*if ($_FILES["fileToUpload"]["size"] > 500000) {
    echo "Sorry, your file is too large.";
    $uploadOk = 0;
}
*/

// Allow certain file formats
if($imageFileType != "jpg" && $imageFileType != "png" && $imageFileType != "jpeg"
&& $imageFileType != "gif" ) {
    echo "Sorry, only JPG, JPEG, PNG & GIF files are allowed.";
    $uploadOk = 0;
}


// Check if $uploadOk is set to 0 by an error
if ($uploadOk == 0) {
    echo "Sorry, your file was not uploaded.";
// if everything is ok, try to upload file
} else {

	// SOLS JPEG ***
	$im = imagecreatefromjpeg($_FILES["fileToUpload"]["tmp_name"]);
	$sizeX = imagesx($im);
	$sizeY = imagesy($im);

	// Screen size: 1280 * 1024
	// 3 files 4 cols (0..2,0..3)
	$rows = 3;
	$cols = 4;
	$incY = $sizeY/$rows;
	$incX = $sizeX/$cols;

	echo "<p> Image Size: " . $sizeX . " x " . $sizeY ." </p>"; 
	echo "<p> Image Size crop: " . $incX . " x " . $incY ." </p>"; 
	for ( $row=0; $row<$rows; $row++){	
		$yi = $incY*$row;
		$yf = $yi + $incY;
		for ( $col=0; $col<$cols; $col++){
			$xi = $incX*$col;
			$xf = $xi + $incX;

			//echo  "<p> " . $xi . " " . $yi . " " . $xf . " " . $yf . "</p>";
			$imP = imagecrop($im, ['x' => $xi, 'y' => $yi, 'width' => $incX, 'height' => $incY]);
			//imagecopyresampled(dst_image, src_image, dst_x, dst_y, src_x, src_y, dst_w, dst_h, src_w, src_h)
			//imagecopyresampled($imP, $im, 0, 0, $xi, $yi, $incX, $incY, $xf, $yf);

			$filename = $target_dir . "img-r".$row."c".$col.".jpg";
			$imP = imagescale($imP, 1280, 1024, IMG_BILINEAR_FIXED);
			imagejpeg($imP,$filename,90);
			chmod($filename, 0754);
		}
	}
	


	/*
   if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        echo "The file ". basename( $_FILES["fileToUpload"]["name"]). " has been uploaded.";
    } else {
        echo "Sorry, there was an error uploading your file.";
    }
    */
}
?>


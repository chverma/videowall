
<!DOCTYPE html>
<html>
<head>
	<?php header("Refresh:5"); ?>
</head>

<body>

<?php
	$row = $_GET['row'];
	$col = $_GET['col'];
?>


<?php 
	//echo "<h1> My PhotoWall";
	//echo '( ' . $row . ', ' . $col .' )'; 
	//echo "</h1>";
?>


<?php
	if ( isset($_GET['row']) ) {
		$imagefile = '/uploads/img-r' . $row . 'c' . $col . '.jpg';
		echo "<img src='$imagefile' width='100%'>";
	}
	else {
		echo "<form method = 'get' action = 'tile.php'>
			What's your position?
			<input type='text' name='row' id='row' />
			<input type='text' name='col' id='col' />
			<input type='submit' />
		    </form>";
	}

?>

</body>
</html>


<!DOCTYPE html>
<html>
<head>
	<?//php header("Refresh:1"); ?>
</head>

<body>

<?php
	$row = $_GET['row'];
	$col = $_GET['col'];
?>


<?php 
//	echo "<h1> My PhotoWall";
//	echo '( ' . $row . ', ' . $col .' )'; 
//	echo "</h1>";
?>




<?php
	$imagefile = '/img/fila-' . $row . '-col-'. $col . '.jpg';
//	echo $imagefile;
	echo "<img src='$imagefile' width='100%'>";
?>

</body>
</html>

<?php header("Content-type: text/html; charset=utf-8");

	$database = "zepsom_zeps";
	$username="zepsom_trksft";
	$password = "tr3ks0ft";
	
	mysql_connect($localhost, $username, $password) or die ("Erreur C: " . mysql_error());
	mysql_query("SET NAMES 'utf8'") or die ("Erreur N: " . mysql_error());
	mysql_select_db($database) or die ("Erreur S: " . mysql_error());

	$querySQL = "delete from activity";
	$result = mysql_query($querySQL) or die ("Erreur 1: " . mysql_error());
	$querySQL = "insert into activity select * from activityx";
	$result = mysql_query($querySQL) or die ("Erreur 2: " . mysql_error());
	
	$querySQL = "delete from users";
	$result = mysql_query($querySQL) or die ("Erreur 3: " . mysql_error());
	$querySQL = "insert into users select * from usersx";
	$result = mysql_query($querySQL) or die ("Erreur 4: " . mysql_error());

	@mysql_close();

	echo "<br/><br/>OK";
	
?>
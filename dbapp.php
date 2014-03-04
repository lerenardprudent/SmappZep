<?php header("Content-type: text/html; charset=utf-8");

	function fix_apos($needle, $replace, $haystack)
	{
		for ($i=0; $i < strlen($haystack); $i++)
		{
			if ($haystack["$i"] == $needle)
			{
				$haystack = substr_replace($haystack, $replace, $i, strlen($needle));
				$i++;
			}
		}
		return $haystack;
	}

	$retvar = "-app-er-";
	$pvarx = "";
	if (isset($_POST['pvar'])) { $pvarx = $_POST['pvar']; } elseif(isset($_GET['pvar'])) { $pvarx = $_GET['pvar']; }
	if($pvarx != "")
	{
		$database = "zepsom_saut";
		$username="root";
		$password = "tr3ks0ft";
		
		@mysql_connect($localhost, $username) or die ("-er-sql-" . mysql_error());
		@mysql_query("SET NAMES 'utf8'");
		@mysql_select_db($database) or die ("-er-sql-" . mysql_error());
		

	 	$pvarx = stripslashes(fix_apos("'", "''", $pvarx));
		$pvarx = explode("~", $pvarx);
		//$pvarx[0] = mode
		//$pvarx[1] = ipcnr
		//$pvarx[2] = filenr
		//$pvarx[3] = fname
		//$pvarx[4] = lname
		//$pvarx[5] = pnew
		//$pvarx[6] = status
		//$pvarx[7] = flag1
		//$pvarx[8] = flag2
		//$pvarx[9] = flag3
		//$pvarx[10] = flag4
		//$pvarx[11] = sdate
		//$pvarx[12] = edate
		//$pvarx[13] = supers
		//$pvarx[14] = navig
		//$pvarx[15] = evts
		//$pvarx[16] = answ
		$whr = "";
		$querySQL = "";
		
		if ($pvarx[0] == "lay" && $pvarx[1] == "l")			//load layout
		{
			$querySQL = "select id, layouts from apps where appid = '" .$pvarx[2]. "' and docid = '" .$pvarx[3]. "'";
			$result = @mysql_query($querySQL);
			if($result)
			{
				if(mysql_num_rows($result) == 1)
				{
					$retvar = "-lay-l-ok-";
					while ($row = mysql_fetch_array($result))
					{
						$retvar .= $row['layouts'];			//. "~" .$row['filenr'].
					}
				}
			}	
		}
		elseif ($pvarx[0] == "lay" && $pvarx[1] == "s")			//save layout
		{
			$querySQL = "select id from apps where appid = '" .$pvarx[2]. "' and docid = '" .$pvarx[3]. "'";
			$result = @mysql_query($querySQL);
			if($result)
			{
				if(mysql_num_rows($result) > 0)
				{
					$querySQL = "update apps set layouts = '" .$pvarx[4]. "' where appid = '" .$pvarx[2]. "' and docid = '" .$pvarx[3]. "'";
				}
				else
				{
					$querySQL = "insert into apps (appid, docid, layouts) values('" .$pvarx[2]. "', '" .$pvarx[3]. "', '" .$pvarx[4]. "')";
				}
				$result = @mysql_query($querySQL);
				if($result)
				{
					$retvar = "-lay-s-ok-";
				}
			}
		}
		elseif ($pvarx[0] == "win" && $pvarx[1] == "l")			//load windows props
		{
			$querySQL = "select wins from apps where appid = '" .$pvarx[2]. "' and docid = '" .$pvarx[3]. "'";
			$result = @mysql_query($querySQL);
			if($result)
			{
				if(mysql_num_rows($result) > 0)
				{
					$retvar = "-win-l-ok-";
					while ($row = mysql_fetch_array($result))
					{
						$retvar .= $row['wins'];
					}
				}
			}	
		}
	}
	echo $retvar;
	@mysql_close();
?>
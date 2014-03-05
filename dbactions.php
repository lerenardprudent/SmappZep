<?php header("Content-type: text/html; charset=utf-8");


//SELECT field1, field2 FROM table_name WHERE DATEDIFF( now( ) , datefield ) >=8
//SELECT NOW() + INTERVAL 2 YEAR
//select date(tstamp), sum(value) from your_table group by date(tstamp);


	function rep_chars($needle, $replace, $haystack)
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

	function fn100($par)		//login
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		$querySQL = "select id, fname, lname, alias, type, idusr, cust6, cust7 from " .$userstbl. " where alias='" .$par[1]. "' and pword='" .$par[2]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			if(mysql_num_rows($result) == 1)
			{
				while ($row = mysql_fetch_array($result))
				{
					$retv = "-ok-fn100-" .$row['id']. "¦" .$row['fname']. "¦" .$row['lname']. "¦" .$row['type']. "¦" .$row['idusr']. "¦" .$row['cust6']. "¦" .$row['cust7'];
				}
			}
			else
			{
				$retv = "-er-fn100-";
			}
		}
		else
		{
			$retv = "-er-fn100-";
		}
		return $retv;	
	}

	
	//------------------------------------------------------------------------------------users
	
	
	function fn101($par)		//load current user (_curuser) - quest with user confirmation
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";

		$querySQL = "select id, idusr, idusraux, fname, lname, phase, step, status, xgroup from " .$userstbl. " where idusr='" .$par[2]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			if(mysql_num_rows($result) == 1)
			{
				while ($row = mysql_fetch_array($result))
				{
					$retv = "-ok-fn101-" .$row['id']. "¦" .$row['idusr']. "¦" .$row['idusraux']. "¦" .$row['fname']. "¦" .$row['lname']. "¦" .$row['phase']. "¦" .$row['step']. "¦" .$row['status'];
				}
			}
			else
			{
				$retv = "-er-fn101-";
			}
		}
		else
		{
			$retv = "-er-fn101-";
		}
		return $retv;	
	}

	function fn102($par)		//load users list (filtered)
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "") { $whr = filteruser($par[3]); }
		if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
		
		$querySQL = "select id from " .$userstbl. " " .$whr;
		$result = @mysql_query($querySQL) or die ("-er-sql-" . mysql_error());
		if ($result) { $trows = mysql_num_rows($result); }
		$querySQL = "select id, idusr, idusraux, fname, lname, type, phase, step, status, hzone1, hzone2, hzone3, xgroup, cust6, cust7 from " .$userstbl. " " .$whr. " order by " .$srt. " limit " .$par[1]. ", " . $par[2];
		$result = @mysql_query($querySQL) or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn102-" . $trows;
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. "|" .$row['id']. "¦" .$row['xgroup']. "¦" .$row['fname']. "¦" .$row['lname']. "¦" .$row['idusr']. "¦" .$row['idusraux']. "¦" .$row['type']. "¦" .$row['phase']. "¦" .$row['step']. "¦" .$row['status']. "¦" .$row['hzone1']. "¦" .$row['hzone2']. "¦" .$row['hzone3']. "¦" .$row['cust6']. "¦" .$row['cust7'];
			}
		}
		else
		{
			$retv = "-er-fn102-";
		}
		return $retv;	
	}
	
	function filteruser($par)
	{
		global $userstbl;
		$wr = "";
		
		$flt = explode("·", $par);
		
		if ($flt[55] != "---")
		{
			$chklst = explode("  ", $flt[55]);
			$lc = count($chklst);
			if ($lc > 1)
			{
				for ($j = 0; $j < $lc; $j++)
				{
					$chklst[$j] = "checklist like '%" .trim($chklst[$j]). "%'";
				}
				$chklst = "(" . implode(" and ", $chklst) . ")";
			}
			else
			{
				$chklst = "checklist like '%" .$flt[55]. "%'";
			}
		}
		else
		{
			$chklst = "";
		}
		
		if ($flt[62] != "---")
		{
			$qfind = explode(",", $flt[62]);
			$lc = count($qfind);
			if ($lc > 1)
			{
				for ($j = 0; $j < $lc; $j++)
				{
					$qfind[$j] = "comments like '%" .trim($qfind[$j]). "%'";
				}
				$qfind = "(" . implode(" or ", $qfind) . ")";
			}
			else
			{
				$qfind = "(idusr = '".$flt[62]."' or fname like '%".$flt[62]."%' or lname like '%".$flt[62]."%' or hphone like '%".$flt[62]."%' or cphone like '%".$flt[62]."%' or comments like '%".$flt[62]."%' or cust8 like '%".$flt[62]."%' )";
			}
		}
		else
		{
			$qfind = "";
		}
		
		$var = array("type='PAR'", "type='POT'", "type='REC'", "type='INT'", "type='PRE'", "type='SUP'", "type='ADM'", "type='AUT'", "phase='".$flt[8]."'", "xgroup='".$flt[9]."'", "step='INI'", "step='REC'", "step='AUT'", "step='INT'", "step='AUT'", "step='ACQ'", "step='AUT'", "step='FIN'", "status='ACT'", "status='COM'", "status='ARE'", "status='NRE'", "status='NIW'", "status='ABA'", "status='DEC'", "status='DHZ'", "status='DAI'", "status='ANN'", "status='AUT'", "status='AUT'", "status='AUT'", "status='AUT'", "status='AUT'", "status='AUT'", "sex='H'", "sex='F'", "birth >= '".$flt[36]."'", "birth <= '".$flt[37]."'", "matrim='CEL'", "matrim='CDF'", "matrim='MAR'", "matrim='SEP'", "matrim='DIV'", "matrim='VEU'", "revcode = '".$flt[44]."'", "rev = '".$flt[45]."'", "educ='1'", "educ='2'", "educ='3'", "educ='4'", "educ='5'", "educ='6'", "hzone1='".$flt[52]."'", "hzone2='".$flt[53]."'", "hzone3='".$flt[54]."'", $chklst, $flt[56], $flt[57], $flt[58], $flt[59], $flt[60], $flt[61], $qfind, "(cust1 >= '".$flt[63]."' or cust2 >= '".$flt[63]."')", "(cust1 <= '".$flt[64]."' or cust2 <= '".$flt[64]."')");
		$exp = NULL;
		for ($i = 0; $i <= 7; $i += 1)		//type
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }

		$exp = NULL;
		for ($i = 8; $i <= 9; $i += 1)		//phase, xgroup (cohorte)
		{
			if ($flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if (count($exp) > 1)
		{
			$wr[] = "(" . implode(" and ", $exp) . ")";
		}
		elseif ($flt[8] != "---" && $flt[8] != "")
		{
			$wr[] = $var[8];
		}
		elseif ($flt[9] != "---" && $flt[9] != "")
		{
			$wr[] = $var[9];
		}
		$exp = NULL;
		for ($i = 10; $i <= 17; $i += 1)		//step
		{
			if ($flt[$i] != 0 && $flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if(count($exp) > 0){ $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		for ($i = 18; $i <= 33; $i += 1)		//status
		{
			if ($flt[$i] != 0 && $flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if(count($exp) > 0){ $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		for ($i = 34; $i <= 35; $i += 1)		//sex
		{
			if ($flt[$i] != 0 && $flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if(count($exp) > 0){ $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		for ($i = 36; $i <= 37; $i += 1)		//birth
		{
			if ($flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if(count($exp) > 0){ $wr[] = "(" . implode(" and ", $exp) . ")"; }
		$exp = NULL;
		for ($i = 38; $i <= 43; $i += 1)		//matrim
		{
			if ($flt[$i] != 0 && $flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if(count($exp) > 0){ $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		$i = 44;		//rev code
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 45;		//revenue (temp)
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		/*
		for ($i = 44; $i <= 45; $i += 1)		//revenue
		{
			if ($flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" and ", $exp) . ")"; }
		*/
		$exp = NULL;
		for ($i = 46; $i <= 51; $i += 1)		//education
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		for ($i = 52; $i <= 54; $i += 1)		//zone1, zone2, zone3
		{
			if ($flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" and ", $exp) . ")"; }
		$exp = NULL;
		$i = 55;		//documents
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 62;		//quick find
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		for ($i = 63; $i <= 64; $i += 1)		//interview
		{
			if ($flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" and ", $exp) . ")"; }
		$exp = NULL;
		if ($wr != "") { $wr = "where " . implode(" and ", $wr); } else { $wr = "where id!=0"; }

		$wx = "";
		if ($flt[56] != 0)
		{
			$wx = " and cust8 != ''";
			if ($flt[58] != "---")
			{
				$wx = $wx . " and cust8 like '%" .$var[58]. "%'"; 
			}
			elseif($flt[59] != "---")
			{
				$wx = $wx . " and (cust8 like '%" .$var[59]. "%' or cust8 like '%" .$var[59]. "_" .$flt[8]. "%')";
				//if ($flt[8] != "---")
				//{
				//	$wx = $wx . " and cust8 like '%" .$var[59]. "_" .$flt[8]. "%'";
				//}
				//else
				//{
					//$wx = $wx . " and cust8 like '%" .$var[59]. "%'";
				//}
			}
			/*
			if ($flt[60] != "---")
			{
				$wx = $wx . " and activity.dstart >='" .$var[60]. "'"; 
			}
			if ($flt[61] != "---")
			{
				$wx = $wx . " and activity.dend <='" .$var[61]. "'"; 
			}
			$wx = $wx . ")";
			*/
		}
		elseif ($flt[57] != 0)
		{
			$wx = " and cust8 = ''";
		}
		
		$wr = $wr . $wx;
		//echo $wr ."<br/>";
		return $wr;
	}

	function fn103($par)		//load user record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$querySQL = "select * from " .$userstbl. " where id='" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn103-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. $row['id']. "¦" .$row['fname']. "¦" .$row['lname']. "¦" .$row['idusr']. "¦" .$row['idusraux']. "¦" .$row['alias']. "¦" .$row['pword']. "¦" .$row['type']. "¦" .$row['status']. "¦" .$row['lang']. "¦" .$row['birth']. "¦" .$row['sex']. "¦" .$row['matrim']. "¦" .$row['educ']. "¦" .$row['prof']. "¦" .$row['profcode']. "¦" .$row['rev']. "¦" .$row['revcode']. "¦" .$row['hphone']. "¦" .$row['hfax']. "¦" .$row['cphone']. "¦" .$row['haval1f']. "¦" .$row['haval1t']. "¦" .$row['haval2f']. "¦" .$row['haval2t']. "¦" .$row['haval3f']. "¦" .$row['haval3t']. "¦" .$row['hemail']. "¦" .$row['haddress']. "¦" .$row['haddressx']. "¦" .$row['hcity']. "¦" .$row['hstate']. "¦" .$row['hcountry']. "¦" .$row['hpostal']. "¦" .$row['hdate']. "¦" .$row['hlat']. "¦" .$row['hlng']. "¦" .$row['hzone1']. "¦" .$row['hzone2']. "¦"  .$row['hzone3']. "¦" .$row['workplace']. "¦" .$row['wposition']. "¦" .$row['wdate']. "¦" .$row['wphone']. "¦" .$row['wfax']. "¦" .$row['waval1f']. "¦" .$row['waval1t']. "¦" .$row['wemail']. "¦" .$row['waddress']. "¦" .$row['waddressx']. "¦" .$row['wcity']. "¦" .$row['wstate']. "¦" .$row['wcountry']. "¦" .$row['wpostal']. "¦" .$row['wlat']. "¦" .$row['wlng']. "¦" .$row['wzone1']. "¦" .$row['wzone2'].  "¦" .$row['wzone3']. "¦" .$row['social']. "¦" .$row['xcontact1']. "¦" .$row['xcontact2']. "¦" .$row['xcontact3']. "¦" .$row['cust1']. "¦" .$row['cust2']. "¦" .$row['cust3']. "¦" .$row['cust4']. "¦" .$row['cust5']. "¦" .$row['cust6']. "¦" .$row['cust7']. "¦" .$row['cust8']. "¦" .$row['cust9']. "¦" .$row['checklist']. "¦" .$row['phase']. "¦" .$row['step']. "¦" .$row['xgroup']. "¦" .$row['dateedit']. "¦" .$row['comments'];
			}
		}
		else
		{
			$retv = "-er-fn103-" . mysql_error();
		}
		return $retv;	
	}
	
	function fn104($par)		//save user record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		$id = $par[1];
		$z1 = $par[38];
		$z2 = $par[39];
		$z3 = $par[40];
		$z4 = $par[57];
		$z5 = $par[58];
		$z6 = $par[59];
		
		if ($par[34] != "" && $par[34] != "")
		{
			$querySQL = "select * from pczone where pc='" .$par[34]. "'";
			$resultc = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if (mysql_num_rows($resultc) == 1)
			{
				while ($row = mysql_fetch_array($resultc))
				{
					$z1 = $row['zone1'];
					$z2 = $row['zone2'];
					$z3 = $row['zone3'];
				}
			}
		}
		
		if ($par[54] != "" && $par[54] != "")
		{
			$querySQL = "select * from pczone where pc='" .$par[54]. "'";
			$resultc = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if (mysql_num_rows($resultc) == 1)
			{
				while ($row = mysql_fetch_array($resultc))
				{
					$z4 = $row['zone1'];
					$z5 = $row['zone2'];
					$z6 = $row['zone3'];
				}
			}
		}
		
		$querySQL = "fname='" .$par[2]. "', lname='" .$par[3]. "', idusr='" .$par[4]. "', idusraux='" .$par[5]. "', alias='" .$par[6]. "', pword='" .$par[7]. "', type='" .$par[8]. "', status='" .$par[9]. "', lang='" .$par[10]. "', birth='" .$par[11]. "', sex='" .$par[12]. "', matrim='" .$par[13]. "', educ='" .$par[14]. "', prof='" .$par[15]. "', profcode='" .$par[16]. "', rev='" .$par[17]. "', revcode='" .$par[18]. "', hphone='" .$par[19]. "', hfax='" .$par[20]. "', cphone='" .$par[21]. "', haval1f='" .$par[22]. "', haval1t='" .$par[23]. "', haval2f='" .$par[24]. "', haval2t='" .$par[25]. "', haval3f='" .$par[26]. "', haval3t='" .$par[27]. "', hemail='" .$par[28]. "', haddress='" .$par[29]. "', haddressx='" .$par[30]. "', hcity='" .$par[31]. "', hstate='" .$par[32]. "', hcountry='" .$par[33]. "', hpostal='" .$par[34]. "', hdate='" .$par[35]. "', hlat='" .$par[36]. "', hlng='" .$par[37]. "', hzone1='" .$z1. "', hzone2='" .$z2. "', hzone3='" .$z3. "', workplace='" .$par[41]. "', wposition='" .$par[42]. "', wdate='" .$par[43]. "', wphone='" .$par[44]. "', wfax='" .$par[45]. "', waval1f='" .$par[46]. "', waval1t='" .$par[47]. "', wemail='" .$par[48]. "', waddress='" .$par[49]. "', waddressx='" .$par[50]. "', wcity='" .$par[51]. "', wstate='" .$par[52]. "', wcountry='" .$par[53]. "', wpostal='" .$par[54]. "', wlat='" .$par[55]. "', wlng='" .$par[56]. "', wzone1='" .$z4. "', wzone2='" .$z5. "', wzone3='" .$z6. "', social='" .$par[60]. "', xcontact1='" .$par[61]. "', xcontact2='" .$par[62]. "', xcontact3='" .$par[63]. "', cust1='" .$par[64]. "', cust2='" .$par[65]. "', cust3='" .$par[66]. "', cust4='" .$par[67]. "', cust5='" .$par[68]. "', cust6='" .$par[69]. "', cust7='" .$par[70]. "', cust8='" .$par[71]. "', cust9='" .$par[72]. "', checklist='" .$par[73]. "', phase='" .$par[74]. "', step='" .$par[75]. "', xgroup='" .$par[76]. "', dateedit='" .date("Y-m-d", $td). "', comments='" .$par[78]. "'";
		if ($id == "")			//insert
		{
			$querySQL = "insert into " .$userstbl. " set id='NULL', " . $querySQL;
		}
		else
		{
			$querySQL = "update " .$userstbl. " set " . $querySQL . " where id='" .$id. "'";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			if ($id == "") { $id = mysql_insert_id(); }
			$retv = "-ok-fn104-" . $id;
		}
		else
		{
			$retv = "-er-fn104-" . mysql_error();
			return $retv;
		}
		
		$querySQL = "update activity set nameparti = '" .$par[2]. " " .$par[3]. "' where idparti = '" .$par[4]. "'";
		$resultn = @mysql_query($querySQL);
		
		if ($par[29] != "")			//update home address
		{	
			if ($par[35] == "")
			{
				$ds = "0000-00-00";
			}
			else 
			{
				$ds = $par[35];
				$querySQL = "delete from address where idu ='" .$id. "' and type='R' and date='0000-00-00' and address='" .$par[29]. "'";
				$resultd = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			}
			$querySQL = "select id from address where idu ='" .$id. "' and type='R' and date='" .$ds. "'"; 
			$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($resulth) { $hrows = mysql_num_rows($resulth); }
			$querySQL = "address='" .$par[29]. "', addressx='" .$par[30]. "', city='" .$par[31]. "', state='" .$par[32]. "', country='" .$par[33]. "', postal='" .$par[34]. "', date='" .$ds. "', lat='" .$par[36]. "', lng='" .$par[37]. "', zone1='" .$z1. "', zone2='" .$z2. "', zone3='" .$z3. "', revcode = '" .$par[18]. "', dateedit='" .date("Y-m-d", $td). "'";
			if ($hrows == 0)
			{
				$querySQL = "insert into address set id='NULL', type='R', idu = '" .$id. "', idusr = '".$par[4]. "', " . $querySQL;
			}
			else
			{
				$querySQL = "update address set " .$querySQL. " where idu='" .$id. "' and type='R' and date='" .$ds. "'";
			}
			$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		}
		
		
		if ($par[49] != "")			//update work address
		{	
			if ($par[43] == "")
			{
				$ds = "0000-00-00";
			}
			else 
			{
				$ds = $par[43];
				$querySQL = "delete from address where idu ='" .$id. "' and type='T' and date='0000-00-00' and address='" .$par[49]. "'";
				$resultd = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			}
			$querySQL = "select id from address where idu ='" .$id. "' and type='T' and date='" .$ds. "'"; 
			$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($resulth) { $hrows = mysql_num_rows($resulth); }
			$querySQL = "address = '" .$par[49]. "', addressx = '" .$par[50]. "', city = '" .$par[51]. "', state = '" .$par[52]. "', country = '" .$par[53]. "', postal = '" .$par[54]. "', lat = '" .$par[55]. "', lng = '" .$par[56]. "', zone1 = '" .$z4. "', zone2 = '" .$z5. "', zone3 = '" .$z6. "', date = '" .$ds. "', dateedit='" .date("Y-m-d", $td). "'";
			if ($hrows == 0)
			{
				$querySQL = "insert into address set id='NULL', type='T', idu = '" .$id. "', idusr = '".$par[4]. "', " . $querySQL;
			}
			else
			{
				$querySQL = "update address set " .$querySQL. " where idu='" .$id. "' and type='T' and date='" .$ds. "'";
			}
			$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		}
		return $retv;	
	}
	
	function fn105($par)		//delete user record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$id = $par[1];
		if ($id != 0 && $id != "")
		{
			$querySQL = "delete from " .$userstbl. " where id = '" .$id. "'";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				$retv = "-ok-fn105-" . $id;
			}
			else
			{
				$retv = "-er-fn105-" . mysql_error();
			}
		}
		return $retv;	
	}	

	function fn110($par)		//lookup user
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "" && $par[3] != "---") 
		{ 
			//$whr = "where idusr like '%" .$flt[1]. "%' or concat_ws(' ',fname,lname) = '" .$flt[1]. "' or fname like '%" .$flt[1]. "%' or lname like '%" .$flt[1]. "%' or hphone like '%" .$flt[1]. "%'" ;
			$whr = "where idusr like '%" .$par[3]. "%' or concat_ws(' ',fname,lname) like '" .$par[3]. "%' or fname like '%" .$par[3]. "%' or lname like '%" .$par[3]. "%'" ;
		}
		else
		{
			$retv = "-ok-fn110-";
			return $retv;
		}
		$querySQL = "select count(*) from " .$userstbl. " " .$whr;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$trows = $row['count(*)'];
			}
		}
		$querySQL = "select id, idusr, fname, lname, hphone, xgroup, cust6, cust7 from " .$userstbl. " " .$whr. " limit " .$par[1]. ", " . $par[2];
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn110-" . $trows;
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. "|" .$row['id']. "¦" .$row['idusr']. "¦" .$row['fname']. "¦" .$row['lname']. "¦" .$row['hphone']. "¦" .$row['xgroup']. "¦" .$row['cust6']. "¦" .$row['cust7'];
			}
		}
		else
		{
			$retv = "-er-fn110-";
		}
		return $retv;	
	}
	
	function fn111($par)		//lookup user's responsables
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		$querySQL = "select distinct idusr, nameusr, pphase from activity where idp='" .$par[1]. "' order by pphase desc";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$a = "";
			$retv = "-ok-fn111-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. "|" .$row['nameusr']. "¦" .$row['idusr']. "¦" .$row['pphase'];
				$a = $a . $row['idusr'] . " ";
			}
			if ($a == " ") { $a = ""; }
			$querySQL = "update " .$userstbl. " set cust8='" .$a. "' where id='" .$par[1]. "'";
			$resultx = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		}
		else
		{
			$retv = "-er-fn111-" . $querySQL;
		}
		return $retv;	
	}
	
	function fn112($par)		//get last user id
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		if ($par[1] != "PAR" && $par[1] != "POT")
		{
			$querySQL = "select idusr from " .$userstbl. " where type = '" .$par[1]. "' order by idusr desc limit 1" ;
		}
		else
		{
			$querySQL = "select idusr from " .$userstbl. " where (type='PAR' or type='POT') order by cast(idusr as unsigned) desc limit 1";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn112-";
			if (mysql_num_rows($result) == 0)
			{
				if ($par[1] == "PAR" || $par[1] == "POT")
				{
					$retv = $retv. "|0";
				}
				else
				{
					$retv = $retv. "|" . $par[1] . "0";
				}
			}
			else
			{
				while ($row = mysql_fetch_array($result))
				{
					$retv = $retv. "|" .$row['idusr'];
				}
			}
		}
		else
		{
			$retv = "-er-fn112-";
		}
		return $retv;	
	}
	
	function fn120($par)			//user actions - assign to resp, tasks from filtered list
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		backupactions();
		backupusers();
		
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		if ($par[1] != "") { $whr = filteruser($par[1]); }
		$querySQL = "select id, idusr, fname, lname, type, xgroup, cust8 from " .$userstbl. " " .$whr;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$pid = $row['id'];
				$pidusr = $row['idusr'];
				$pname = $row['fname']. " " .$row['lname'];
				$ptype = $row['type'];
				$pxgroup = $row['xgroup'];
				$a = trim($row['cust8']);
				$f = $par[3]. "_" .$par[11];
				$querySQLx = "insert into activity set id='NULL', idu='" .$par[2]. "', idp='" .$pid. "', idusr='" .$par[3]. "', idparti='" .$pidusr. "', nameusr='" .$par[4]. "', nameparti='" .$pname. "', activity='" .$par[5]. "', status='" .$par[6]. "', mode='SYS', code='" .$par[7]. "', ptype='" .$ptype. "', pxgroup='" .$pxgroup. "', pphase='" .$par[11]. "', pstep='" .$par[12]. "', pstatus='" .$par[13]. "', description='" .$par[10]. "', dstart='" .$par[8]. "', dend='" .$par[9]. "', cust7='" .$par[14]. "', cust8='" .$par[15]. "', location='Résidence'";
				$resultx = @mysql_query($querySQLx);		// or die ("-er-sql-" . mysql_error());
				if (strrpos($a, $f) === FALSE)
				{
					$a = $a . " " .$f;
					$querySQLu = "update " .$userstbl. " set  phase='" .$par[11]. "', step='" .$par[12]. "', status='" .$par[13]. "', cust8='" .$a. "' where id='" .$pid. "'";
				}
				else
				{
					$querySQLu = "update " .$userstbl. " set  phase='" .$par[11]. "', step='" .$par[12]. "', status='" .$par[13]. "' where id='" .$pid. "'";
				}
				$resultu = @mysql_query($querySQLu);		// or die ("-er-sql-" . mysql_error());
			}
			$retv = "-ok-fn120-";
		}
		else
		{
			$retv = "-er-fn120-";
		}
		return $retv;	
	}
	
	function fn121($par)			//user actions - assign to resp, tasks from selected items
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		if ($par[1] != "") 
		{ 
			$wr = explode("·", $par[1]);
			for ($i = 0; $i < count($wr); $i += 1)
			{
				$wr[$i] = "id='" .$wr[$i]. "'";
			}
			$whr = "where " . implode(" or ", $wr);		
		}
		$querySQL = "select id, idusr, fname, lname, type, xgroup, cust8 from " .$userstbl. " " .$whr;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$pid = $row['id'];
				$pidusr = $row['idusr'];
				$pname = $row['fname']. " " .$row['lname'];
				$ptype = $row['type'];
				$pxgroup = $row['xgroup'];
				$a = trim($row['cust8']);
				$f = $par[3]. "_" .$par[11];

				$querySQLx = "insert into activity set id='NULL', idu='" .$par[2]. "', idp='" .$pid. "', idusr='" .$par[3]. "', idparti='" .$pidusr. "', nameusr='" .$par[4]. "', nameparti='" .$pname. "', activity='" .$par[5]. "', status='" .$par[6]. "', mode='SYS', code='" .$par[7]. "', ptype='" .$ptype. "', pxgroup='" .$pxgroup. "', pphase='" .$par[11]. "', pstep='" .$par[12]. "', pstatus='" .$par[13]. "', description='" .$par[10]. "', dstart='" .$par[8]. "', dend='" .$par[9]. "', cust7='" .$par[14]. "', cust8='" .$par[15]. "'";			//date("Y-m-d", $td)
				$resultx = @mysql_query($querySQLx);		// or die ("-er-sql-" . mysql_error());
				if (strrpos($a, $f) === FALSE)
				{
					$a = $a . " " .$f;
					$querySQLu = "update " .$userstbl. " set  phase='" .$par[11]. "', step='" .$par[12]. "', status='" .$par[13]. "', cust8='" .$a. "' where id='" .$pid. "'";
				}
				else
				{
					$querySQLu = "update " .$userstbl. " set  phase='" .$par[11]. "', step='" .$par[12]. "', status='" .$par[13]. "' where id='" .$pid. "'";
				}
				$resultu = @mysql_query($querySQLu);		// or die ("-er-sql-" . mysql_error());
			}
			$retv = "-ok-fn121-";
		}
		else
		{
			$retv = "-er-fn121-";
		}
		return $retv;	
	}
	
	function fn122($par)			//update user from activity
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		for ($i = 2; $i <= 5; $i += 1)
		{
			if ($par[$i] == "---") { $par[$i] = ""; }
		}
		$querySQL = "select id, idusr, fname, lname, type, xgroup, cust8 from " .$userstbl. " where id='" .$par[1]. "'" ;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$pid = $row['id'];
				$pidusr = $row['idusr'];
				$a = trim($row['cust8']);
				$f = $par[8]. "_" .$par[3];
				if (strrpos($a, $f) === FALSE)
				{
					//$a = $a . " " .$par[8];
					$a = $a . " " .$f;
					$querySQLx = "update " .$userstbl. " set type='" .$par[2]. "', phase='" .$par[3]. "', step='" .$par[4]. "', status='" .$par[5]. "', fname='" .$par[6]. "', lname='" .$par[7]. "', cust8='" .$a. "' where id='" .$par[1]. "'" ;
				}
				else
				{
					$querySQLx = "update " .$userstbl. " set type='" .$par[2]. "', phase='" .$par[3]. "', step='" .$par[4]. "', status='" .$par[5]. "', fname='" .$par[6]. "', lname='" .$par[7]. "' where id='" .$par[1]. "'" ;
				}
				$resultx = @mysql_query($querySQLx);		// or die ("-er-sql-" . mysql_error());
			}
			$retv = "-ok-fn122-" . $par[1];
		}
		else
		{
			$retv = "-er-fn122-";	// . mysql_error();
		}
		return $retv;	
	}
	
	function fn123($par)			//update user from questionnaire
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		for ($i = 2; $i <= 5; $i += 1)
		{
			if ($par[$i] == "---") { $par[$i] = ""; }
		}
		$querySQL = "update " .$userstbl. " set type='" .$par[2]. "', phase='" .$par[3]. "', step='" .$par[4]. "', status='" .$par[5]. "' where id='" .$par[1]. "'" ;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn123-" . $par[1];
		}
		else
		{
			$retv = "-er-fn123-";	// . mysql_error();
		}
		return $retv;	
	}

	function fn130($par)		//load last interview activity for user record edit by interviewers (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
	
		$querySQL = "select id, dstart, location, cust0, cust1, cust3, cust4, cust7, cust8 from activity where idu='" .$par[1]. "' and idp='" .$par[2]. "' and pstep = '" .$par[3]. "' and  pstatus = '" .$par[4]. "' and  pphase = '" .$par[5]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$trows = mysql_num_rows($result);
			if ($trows == 1)
			{
				$retv = "-ok-fn130-";
				while ($row = mysql_fetch_array($result))
				{
					$retv = $retv. "|" .$row['location']. "¦" .$row['cust0']. "¦" .$row['cust1']. "¦" .$row['cust3']. "¦" .$row['cust4']. "¦" .$row['cust7']. "¦" .$row['cust8'];
				}
			}
			else
			{
				$retv = "-er-fn130-";
			}
		}
		else
		{
			$retv = "-er-fn130-";
		}
		return $retv;	
	}

	function fn131($par)		//save last interview activity  + user changes for user record edit by interviewers (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		$pus = explode("|", $par[1]);
		$ppa = explode("|", $par[2]);
		$paa = explode("|", $par[3]);
		$id = $ppa[1];
		$z1 = $ppa[38];
		$z2 = $ppa[39];
		$z3 = $ppa[40];
		
		if ($ppa[34] != "" && $ppa[34] != "---")
		{
			$querySQL = "select * from pczone where pc='" .$ppa[34]. "'";
			$resultc = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if (mysql_num_rows($resultc) == 1)
			{
				while ($row = mysql_fetch_array($resultc))
				{
					$z1 = $row['zone1'];
					$z2 = $row['zone2'];
					$z3 = $row['zone3'];
				}
			}
		}
		
		$dd = explode("-",$paa[0]);
		$dd[0] = $dd[0] + 2;
		$dd = implode("-", $dd);
		$querySQL = "fname='" .$ppa[2]. "', lname='" .$ppa[3]. "', status='" .$ppa[9]. "', hphone='" .$ppa[19]. "', wphone='" .$ppa[44]. "', cphone='" .$ppa[21]. "', hemail='" .$ppa[28]. "', haddress='" .$ppa[29]. "', haddressx='" .$ppa[30]. "', hcity='" .$ppa[31]. "', hstate='" .$ppa[32]. "', hcountry='" .$ppa[33]. "', hpostal='" .$ppa[34]. "', hdate='" .$ppa[35]. "', hlat='" .$ppa[36]. "', hlng='" .$ppa[37]. "', hzone1='" .$z1. "', hzone2='" .$z2. "', hzone3='" .$z3. "', social='" .$ppa[60]. "', xcontact1='" .$ppa[61]. "', xcontact2='" .$ppa[62]. "', xcontact3='" .$ppa[63]. "', cust1='" .$paa[0]. "', cust2='" .$dd. "', cust4='" .$ppa[67]. "', checklist='" .$ppa[73]. "', phase='" .$ppa[74]. "', step='" .$ppa[75]. "', xgroup='" .$ppa[76]. "', dateedit='" .date("Y-m-d", $td). "', comments='" .$ppa[78]. "'";
		$querySQL = "update " .$userstbl. " set " . $querySQL . " where id='" .$id. "'";
		$resultu = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if ($resultu)
		{
			//update parti name in activity
			$querySQLn = "update activity set nameparti = '" .$ppa[2]. " " .$ppa[3]. "' where idparti = '" .$ppa[4]. "'";
			$resultn = @mysql_query($querySQLn);		// or die ("-er-sql-" . mysql_error());
		
			//update home address history
			if ($ppa[29] != "")
			{	
				if ($ppa[35] == "")
				{
					$ds = "0000-00-00";
				}
				else 
				{
					$ds = $ppa[35];
					$querySQL = "delete from address where idu ='" .$id. "' and type='R' and date='0000-00-00' and address='" .$ppa[29]. "'";
					$resultd = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
				}
				
				$querySQL = "select id from address where idu ='" .$id. "' and type='R' and date='" .$ds. "'"; 
				$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
				if($resulth) { $hrows = mysql_num_rows($resulth); }
				
				$querySQL = "address='" .$ppa[29]. "', addressx='" .$ppa[30]. "', city='" .$ppa[31]. "', state='" .$ppa[32]. "', country='" .$ppa[33]. "', postal='" .$ppa[34]. "', date='" .$ds. "', lat='" .$ppa[36]. "', lng='" .$ppa[37]. "', zone1='" .$ppa[38]. "', zone2='" .$ppa[39]. "', zone3='" .$ppa[40]. "', revcode = '" .$ppa[18]. "', dateedit='" .date("Y-m-d", $td). "'";
				if ($hrows == 0)
				{
					$querySQL = "insert into address set id='NULL', type='R', idu = '" .$id. "', idusr = '".$ppa[4]. "', " . $querySQL;
				}
				else
				{
					$querySQL = "update address set " .$querySQL. " where idu='" .$id. "' and type='R' and date='" .$ds. "'";
				}
				$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			}
			
			//create activity
			$querySQL = "update activity set pstatus='" .$ppa[9]. "', location='" .$paa[1]. "', cust0='" .$paa[2]. "', cust3='" .$paa[4]. "' where idu = '" .$pus[0]. "' and idp = '" .$id. "' and pphase='" .$ppa[74]. "' and pstep='INT'";
			$resulta = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());

			$retv = "-ok-fn131-";
		}
		else
		{
			$retv = "-er-fn131-";
		}
		return $retv;	
	}
	
	function fn150($par)			//users export to csv from filtered list
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "") { $whr = filteruser($par[3]); }
		if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
		$querySQL = "select * from " .$userstbl. " " .$whr. " order by " .$srt;		//id, idusr, idusraux, fname, lname, type, phase, step, status, hzone1, hzone2, hzone3, xgroup 
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			if ($par[7] == 1)
			{
				csvusr1($result, $par[6]);
			}
			elseif ($par[7] == 2)
			{
				csvusr2($result, $par[6]);
			}
			elseif ($par[7] == 3)
			{
				csvusr3($result, $par[6]);
			}
			$retv = "-ok-fn150-";
		}
		else
		{
			$retv = "-er-fn150-";
		}
		return $retv;	
	}

	function fn151($par)			//users export to csv from selection
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "") 
		{ 
			$wr = explode("·", $par[3]);
			for ($i = 0; $i < count($wr); $i += 1)
			{
				$wr[$i] = "id='" .$wr[$i]. "'";
			}
			$whr = "where " . implode(" or ", $wr);		
		}
		if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
		$querySQL = "select * from " .$userstbl. " " .$whr. " order by " .$srt;		//id, idusr, idusraux, fname, lname, type, phase, step, status, hzone1, hzone2, hzone3, xgroup
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			if ($par[7] == 1)
			{
				csvusr1($result, $par[6]);
			}
			elseif ($par[7] == 2)
			{
				csvusr2($result, $par[6]);
			}
			elseif ($par[7] == 3)
			{
				csvusr3($result, $par[6]);
			}
			$retv = "-ok-fn151-";
		}
		else
		{
			$retv = "-er-fn151-";
		}
		return $retv;	
	}

	function csvusr1($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "#\tCohorte\tPrénom\tNom\tID Usager\tNo. employé\tType\tTemps\tÉtape\tStatut\tQuartier\tS/R\tA/D\n";
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['id']. "\t" .$row['xgroup']. "\t" .$row['fname']. "\t" .$row['lname']. "\t" .$row['idusr']. "\t" .$row['idusraux']. "\t" .$row['type']. "\t" .$row['phase']. "\t" .$row['step']. "\t" .$row['status']. "\t" .$row['hzone1']. "\t" .$row['hzone2']. "\t" .$row['hzone3']. "\n";
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function csvusr2($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "#\tCohorte\tPrénom\tNom\tID Usager\tNo. employé\tType\tTemps\tÉtape\tStatut\tQuartier\tS/R\tA/D\n";
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['id']. "\t" .$row['xgroup']. "\t" .$row['fname']. "\t" .$row['lname']. "\t" .$row['idusr']. "\t" .$row['idusraux']. "\t" .$row['type']. "\t" .$row['phase']. "\t" .$row['step']. "\t" .$row['status']. "\t" .$row['hzone1']. "\t" .$row['hzone2']. "\t" .$row['hzone3']. "\n";
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function csvusr3($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "#\tCohorte\tPrénom\tNom\tID Usager\tNo. employé\tType\n";
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['id']. "\t" .$row['xgroup']. "\t" .$row['fname']. "\t" .$row['lname']. "\t" .$row['idusr']. "\t" .$row['idusraux']. "\t" .$row['type']. "\n";
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function fn160($par)			//users export to html from filtered list
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[8] >= 1 && $par[8] <= 5)
		{
			if ($par[3] != "") { $whr = filteruser($par[3]); }
			if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
			$querySQL = "select * from " .$userstbl. " " .$whr. " order by " .$srt;
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				if ($par[8] == 1)
				{
					htmusr1($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 2)
				{
					htmusr2($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 3)
				{
					htmusr3($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 4)
				{
					htmusr4($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 5)
				{
					htmusr6($result, $par[6], $par[7]);
				}
				$retv = "-ok-fn160-";
			}
			else
			{
				$retv = "-er-fn160-";
			}
			return $retv;
		}
		else if ($par[8] >= 6)
		{
			if ($par[8] == 6)
			{
				$querySQL = "select idusr, fname, lname from users where type = 'INT' or type = 'ADM' order by idusr";
				$result = @mysql_query($querySQL) or die ("-er-sql-" . mysql_error());
				if($result)
				{
					htmusr7($result, $par[6], $par[7]);
					$retv = "-ok-fn160-";
				}
				else
				{
					$retv = "-er-fn160-";
				}
			}
			else
			{
				$retv = "-er-fn160-";
			}
			return $retv;
		}
	}

	function fn161($par)			//users export to html from selection
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[8] >= 1 && $par[8] <= 5)
		{
			if ($par[3] != "") 
			{ 
				$wr = explode("·", $par[3]);
				for ($i = 0; $i < count($wr); $i += 1)
				{
					$wr[$i] = "id='" .$wr[$i]. "'";
				}
				$whr = "where " . implode(" or ", $wr);		
			}
			if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
			$querySQL = "select * from " .$userstbl. " " .$whr. " order by " .$srt;
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				if ($par[8] == 1)
				{
					htmusr1($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 2)
				{
					htmusr2($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 3)
				{
					htmusr3($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 4)
				{
					htmusr4($result, $par[6], $par[7]);
				}
				elseif ($par[8] == 5)
				{
					htmusr6($result, $par[6], $par[7]);
				}
				$retv = "-ok-fn161-";
			}
			else
			{
				$retv = "-er-fn161-";
			}
			return $retv;
		}
		else if ($par[8] >= 6)
		{
			if ($par[8] == 6)
			{
				$retv = "-er-fn161-";
			}
			return $retv;
		}
		return $retv;
	}
	
	function htmusr1($res, $fi, $ti)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>Liste usagers</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ table-layout:fixed; width:1000px; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:14px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'> <div class='title'>" .$ti. "</div>";
		fwrite($fh, $strdata);
		$i = 0;
		while ($row = mysql_fetch_array($res))
		{
			if ($i == 0)
			{
				$strdata = "<br/><br/><table><tr><td width='5%' style='color:#ff0000'>ID</td><td width='5%' style='color:#ff0000'>COHO</td><td width='14%' style='color:#ff0000'>PRÉNOM</td><td width='14%' style='color:#ff0000'>NOM</td><td width='9%' style='color:#ff0000'>USAGER ID</td><td width='10%' style='color:#ff0000'>DOSSIER</td><td width='7%' style='color:#ff0000'>TYPE</td><td width='7%' style='color:#ff0000'>PHASE</td><td width='7%' style='color:#ff0000'>ÉTAPE</td><td width='6%' style='color:#ff0000'>STATUT</td><td width='5%' style='color:#ff0000'>QUA</td><td width='6%' style='color:#ff0000'>S/R</td><td width='5%' style='color:#ff0000'>A/D</td></tr>";
				fwrite($fh, $strdata);
			}
			//5,5,14,14,9,10,7,7,7,6,5,6,5
			$strdata = "<tr><td width='5%'>" .$row['id']. "</td><td width='5%'>" .$row['xgroup']. "</td><td width='14%'>" .$row['fname']. "</td><td width='14%'>" .$row['lname']. "</td><td width='9%'>" .$row['idusr']. "</td><td width='10%'>" .$row['idusraux']. "</td><td width='7%'>" .$row['type']. "</td><td width='7%'>" .$row['phase']. "</td><td width='7%'>" .$row['step']. "</td><td width='6%'>" .$row['status']. "</td><td width='5%'>" .$row['hzone1']. "</td><td width='6%'>" .$row['hzone2']. "</td><td width='5%'>" .$row['hzone3']. "</td></tr>";
			fwrite($fh, $strdata);
			$i = $i + 1;
			if ($i == 32)
			{
				$i = 0;
				$strdata = "</table><div class='page-break'></div>";
				fwrite($fh, $strdata);
			}
		}
		if ($i != 0) { $strdata = "</table></body></html>"; } else { $strdata = "</body></html>"; }
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function htmusr2($res, $fi, $ti)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>Liste recrutement</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ table-layout:fixed; width:1020px; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:16px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:1px; border-color:#ff0000; padding:1px 8px 1px 8px; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px} .addr{ padding:4px; }</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'><br/>";
		fwrite($fh, $strdata);
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		$i = 1;
		while ($row = mysql_fetch_array($res))
		{
			$strdata = "<div class='title' style=' width:1000px; font-size:18px;'><br/>Recruteur : " .$ti. "</div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<div class='title' style=' width:1000px; font-size:20px; color:#cc0000;'>Attribution des visites à domicile&nbsp;&nbsp;-&nbsp;&nbsp;" .$i. "<br/><span style='font-size:12px;'>" .date("Y-m-d", $td). "</span></div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<div style='width:1000px; border-style:solid; border-width:1px; border-color:#ff0000; padding:10px;'>ID participant potentiel : <b>" .$row['idusr']. "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Cohorte : <b>" .$row['xgroup']. "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Phase : <b>" .$row['phase']. "</b></div><br>";
			fwrite($fh, $strdata);
			$strdata = "<div style='width:1000px; border-style:solid; border-width:1px; border-color:#ff0000; padding:10px;'>Adresse initiale (A00) : <b>" .$row['haddress']. " " .$row['haddressx']. ", " .$row['hcity']. " " .$row['hpostal']. "</b><br/>Quartier : <b>" .$row['hzone1']. "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Secteur recensement : <b>" .$row['hzone2']. "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Aire de diffusion : <b>" .$row['hzone3']. "</b></div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<table style='border-width:0px'><tr><td align='center'><div class='addr'><b>A06</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A05</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A04</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A00</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A01</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A02</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A03</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td></tr></table><br/>";
			fwrite($fh, $strdata);
			$strdata = "<table style='border-width:0px'><tr><td align='center'><div class='addr'><b>A07</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A08</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A09</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A10</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A11</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A12</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td><td align='center'><div class='addr'><b>A13</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Visité<br/><br/><b>1&nbsp;&nbsp;2&nbsp;&nbsp;3&nbsp;&nbsp;4&nbsp;&nbsp;5&nbsp;&nbsp;6</b></div></td></tr></table><br/>";
			fwrite($fh, $strdata);
			$strdata = "<div style='width:1000px; padding:0px 10px 0px 24px; font-size:14px; color:#cc0000;'><b>Légende :</b> 1-Absent (ABS) | 2-Refus (REF) | 3-Non-éligible (NEL) | 4-Inexistent (INE) | 5-Chevauchement (CHE) | 6-Recruté (REC)</div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<table style='border-width:0px; height:350px;'><tr><td valign='center' colspan='2'>Nom du participant (prénom, nom) :</td></tr><tr><td valign='center'>Genre : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Homme</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Femme</b></td><td valign='center' >Langue : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Français</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>English</b></td></tr><tr><td valign='center' colspan='2'>Date de naissance (AAAA-MM-JJ) : </td></tr><tr><td valign='center' colspan='2'>Adresse :</td></tr><tr><td valign='center'>Code postal :</td><td valign='center'>Habite depuis (AAAA-MM-JJ) :</td></tr><tr><td valign='center'>Téléphone :</td><td valign='center'>Cellulaire :</td></tr><tr><td valign='center' colspan='2'>Courriel :</td></tr></table><br/>";		
			fwrite($fh, $strdata);
			$strdata = "<div style='width:1000px; padding:0px 10px 0px 24px; font-size:14px; color:#cc0000;'><b>Attention :</b> Prennez note de l'<b>ADRESSE POSTALE</b> si differente de l'adresse civile.</div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<table style='border-width:0px; height:200px;'><tr><td valign='center' colspan='3'>Nom de l'interviewer (prénom, nom) :</td></tr><tr><td valign='center' colspan='2'>Date d'entrevue (AAAA-MM-JJ) :</td><td valign='center'>Heure d'entrevue (00:00) :</td></tr><tr><td valign='center' colspan='3'>Lieu d'entrevue : &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Résidence</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Douglas (# local) :</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>Autre :</b><br/>&nbsp;</td></tr></table><br/>";	
			fwrite($fh, $strdata);
			$strdata = "<div style='width:1000px; border-style:solid; border-width:1px; border-color:#ff0000; padding:10px;'>Commentaires : <br/>&nbsp;<br/>&nbsp;<br/>&nbsp;<br/>&nbsp;<br/>&nbsp;<br/>&nbsp;</div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<div style='width:1000px; border-style:none; padding:10px; color:#cc0000;'>Date de la visite (AAAA-MM-JJ) : </div><br/>";
			fwrite($fh, $strdata);
			$strdata = "<div class='page-break'></div>";
			fwrite($fh, $strdata);
			$i = $i + 1;
		}
		$strdata = "</body></html>";
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function htmusr3($res, $fi, $ti)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		//$strdata = "<html><head><title>Liste usagers</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ table-layout:fixed; width:100%; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:14px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'> <div class='title'>" .$ti. "</div>";
		$strdata = "<html><head><title>Liste usagers</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ width:100%; border-style:none; border-width:0px; border-color:#ff0000; font-family:arial,sans-serif; font-size:12px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ height:16px; border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'> <div class='title'>" .$ti. "</div>";
		fwrite($fh, $strdata);
		$i = 0;
		while ($row = mysql_fetch_array($res))
		{
			if ($i == 0)
			{
				$strdata = "<br/><br/><table>";
				fwrite($fh, $strdata);
			}
			$strdata = "<tr><td colspan='9' style='border-style:none;'><span style='color:#ff0000'>&nbsp;<br/>Participant&nbsp;:&nbsp;<b>" .$row['fname']. "&nbsp;" .$row['lname']. "</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;prévue&nbsp;: <b>" .$row['cust2']. "</b></span></td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td>" .$row['xgroup']. "</td><td>" .$row['idusr']. "</td><td>" .$row['type']. "</td><td>" .$row['phase']. "</td><td>" .$row['step']. "</td><td>" .$row['status']. "</td><td>" .$row['hzone1']. "</td><td>" .$row['hzone2']. "</td><td>" .$row['hzone3']. "</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>" .$row['haddress']. " " .$row['haddressx']. ", " .$row['hcity']. ", " .$row['hstate']. ", " .$row['hpostal']. "</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='3'>" .$row['hphone']. "&nbsp;</td><td colspan='3'>" .$row['cphone']. "&nbsp;<td colspan='3'>" .$row['hemail']. "&nbsp;</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>Contact 1 : " .$row['xcontact1']. "</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>Contact 2 : " .$row['xcontact2']. "</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>Contact 3 : " .$row['xcontact3']. "</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='5'>" .$row['comments']. "</td><td colspan='4'>Commentaires : <br/>&nbsp;<br/>&nbsp;</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>Documents signés :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>RECH</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>RAMQ</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>AREC</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>SDIAG</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>AUT</b> :</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>Diagnostique :&nbsp;</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='3'>Date interview :&nbsp;&nbsp;&nbsp;</td><td colspan='4'>Place :&nbsp;</td><td>Km :&nbsp;</td><td>Hrs :&nbsp;</td></tr>";
			fwrite($fh, $strdata);
			$strdata = "<tr><td colspan='9'>Statut :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>COM</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>ABA</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>ARE</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>DEC</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>DHZ</b></td></tr>";
			fwrite($fh, $strdata);
			
			
			$i = $i + 1;
			if ($i == 3)
			{
				$strdata = "<tr><td colspan='9' style='font-size:10px; border-style:none;'>&nbsp;<br/>Légende : &nbsp; COM - complété &nbsp; ABA - abandoné &nbsp; ARE - à retracer &nbsp; DEC - décèdé</b> &nbsp; DHZ - démenagé hors-zone</td></tr>";
				fwrite($fh, $strdata);
				$i = 0;
				$strdata = "</table><div class='page-break'></div>";
				fwrite($fh, $strdata);
			}
		}
		if ($i != 0) { $strdata = "</table></body></html>"; } else { $strdata = "</body></html>"; }
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function htmusr4($res, $fi, $ti)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>Adresses visitées</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ width:100%; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:12px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'> <div class='title'>" .$ti. "</div>";
		fwrite($fh, $strdata);
		$i = 0;
		while ($row = mysql_fetch_array($res))
		{
			if ($i == 0)
			{
				$strdata = "<br/><br/><table><tr><td style='color:#ff0000'>ID&nbsp;PARTI.</td><td style='color:#ff0000'>ADRESSE</td><td style='color:#ff0000'>A0</td><td style='color:#ff0000'>A1</td><td style='color:#ff0000'>A2</td><td style='color:#ff0000'>A3</td><td style='color:#ff0000'>A4</td><td style='color:#ff0000'>A5</td><td style='color:#ff0000'>A6</td><td style='color:#ff0000'>A7</td><td style='color:#ff0000'>A8</td><td style='color:#ff0000'>A9</td><td style='color:#ff0000'>A10</td><td style='color:#ff0000'>A11</td><td style='color:#ff0000'>A12</td><td style='color:#ff0000'>A13</td><td style='color:#ff0000'>QUART.</td><td style='color:#ff0000'>S/D</td><td style='color:#ff0000'>A/R</td></tr>";
				fwrite($fh, $strdata);
			}
			$querySQL = "select * from addressvis where idu='" .$row['id']. "'";
			$resultx = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if ($resultx)
			{
				while ($rowx = mysql_fetch_array($resultx))
				{
					$strdata = "<tr><td>" .$rowx[idusr]. "</td><td>" .$rowx[address]. "</td><td>" .$rowx[a0]. "</td><td>" .$rowx[a1]. "</td><td>" .$rowx[a2]. "</td><td>" .$rowx[a3]. "</td><td>" .$rowx[a4]. "</td><td>" .$rowx[a5]. "</td><td>" .$rowx[a6]. "</td><td>" .$rowx[a7]. "</td><td>" .$rowx[a8]. "</td><td>" .$rowx[a9]. "</td><td>" .$rowx[a10]. "</td><td>" .$rowx[a11]. "</td><td>" .$rowx[a12]. "</td><td>" .$rowx[a13]. "</td><td>" .$rowx[zone1]. "</td><td>" .$rowx[zone2]. "</td><td>" .$rowx[zone3]. "</td></tr>";
			fwrite($fh, $strdata);
					$i = $i + 1;
				}
			}
			if ($i == 24)
			{
				$i = 0;
				$strdata = "</table><div class='page-break'></div>";
				fwrite($fh, $strdata);
			}
		}
		if ($i != 0) { $strdata = "</table></body></html>"; } else { $strdata = "</body></html>"; }
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function htmusr6($res, $fi, $ti)
	{
		$i = 0;
		$trows = mysql_num_rows($res) - 1;
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<!doctype html>
		<html lang='en'>
		<head>
			<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
			<title>AVERY</title>
			<style type='text/css'>
				@media print{ .page-break { display:block; page-break-before:always; }}
				body {margin:0px; padding:0px;}
				table { border-style:solid; border-width:1px; border-color:#ffffff; border-collapse:collapse; padding:0mm; margin:13mm 5mm 12mm 5mm; font-family:'Trebuchet MS', 'Helvetica', 'Arial', 'Verdana', 'sans-serif'; font-size:12px; page-break-after:always; }
				th, td { padding:0mm; margin:0mm; border-style:solid; border-width:1px; border-color:#ffffff; }
				div { max-width:63.5mm; width:63.5mm; min-height:23.7mm; height:23.7mm; left:0mm; top:0mm; padding:0mm 5mm; margin:0mm; display:table-cell; vertical-align:middle; overlay:hidden; }
			</style>
		</head>
		<body>";
		fwrite($fh, $strdata); 
		while ($row = mysql_fetch_array($res))
		{
			if ($i%30 == 0) 
			{
				$strdata = "<table>";
				fwrite($fh, $strdata); 
			}
			if ($i%3 == 0) 
			{
				$strdata = " <tr>";
				fwrite($fh, $strdata); 
			}
			$strdata = "<td><div><b>" .trim($row['fname']). " " .trim($row['lname']). "</b><br/>" .trim($row['haddress']). "<br/>" .trim($row['hcity']). ", " .trim($row['hstate']). "<br/>" .$row['hpostal']. "</div></td>";
			fwrite($fh, $strdata);
			
			if ($i%3 == 2 || $i == $trows)
			{
				$strdata = "</tr> ";
				fwrite($fh, $strdata);
			}
			if ($i%30 == 29 || $i == $trows)
			{
				$strdata = "</table>";
				fwrite($fh, $strdata);
			}
			//echo $i . "<br/>";
			$i += 1;
		}
		$strdata = "</body>";
		fwrite($fh, $strdata);
		fclose($fh);
	}	
	
	function htmusr7($res, $fi, $ti)
	{
		$sta = array("COM","ACT","ARE","NIW","ABA","DEC","DHZ","DAI","ANN");
		$itw = array();
		while ($row = mysql_fetch_array($res))
		{
			array_push( $itw, array($row['idusr'], $row['fname'], $row['lname']) ); 
		}
		
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head>
			<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
			<style type='text/css'>
				:root { -webkit-print-color-adjust: exact; }
				body {margin:0px 0px 0px 60px; padding:0px; }
				table { border-style:solid; border-width:1px; border-color:#c0c0c0; border-collapse:collapse; padding:5mm; margin:15mm 5mm 15mm 5mm; font - family:'Helvetica', 'Arial', 'Verdana', 'sans-serif'; font-size:13px; page-break-after:always; }
				th, td { padding:1.5mm 2mm 1.5mm 2mm; margin:0mm; border-style:solid; border-width:1px; border-color:#c0c0c0; vertical-align:middle; text-align:right; }
				div { padding:2mm; margin:0mm; border-style:solid; border-width:1px; border-color:#c0c0c0; font-family:'Helvetica', 'Arial', 'Verdana', 'sans-serif'; font-size:16px; }
			</style>
			</head><body>
			<table>
			<tr><td colspan='11' style='background-image:url(media/douglaslogo.png); background-repeat:no-repeat; background-position:right; background-color:#dd0000; color:#ffffff; font-size:20px; text-align:left; padding:5mm 3mm 5mm 10mm'><b>Suivi des statuts de dossier : T-03</b><br/><span style='font-size:11px;'><b>DATE : " .date('Y-m-d'). "</b></span></td></tr>
			<tr><td style='text-align:left;'><b>Interviewer</b></td><td><b>COM</b></td><td><b>ACT</b></td><td><b>ARE</b></td><td><b>NIW</b></td><td><b>ABA</b></td><td><b>DEC</b></td><td><b>DHZ</b></td><td><b>DAI</b></td><td><b>ANN</b></td><td style='color:#dd0000'><b>Total</b></td></tr>";
		fwrite($fh, $strdata);
		
		$totv = array(0, 0, 0, 0, 0, 0, 0, 0, 0);
		for ($i = 0; $i < count($itw); $i++)
		{
			$strdata = "<tr>";
			$strdata .= "<td style='text-align:left;'>" . $itw[$i][0] . "&nbsp;&nbsp;&nbsp;" .$itw[$i][1] . " " .$itw[$i][2]. "</td>";
			$totu = 0;
			for ($j = 0; $j < count($sta); $j++)
			{
				$querySQLx = "select id from activity where idusr = '" . $itw[$i][0] . "' and (pstep = 'INT' or pstep = 'FIN') and pstatus = '" .$sta[$j]. "' and pphase = 'T-03'";
				file_put_contents("debug_out", $querySQLx);
				//$querySQLx = "select id from users where (step = 'INT' or step = 'FIN') and phase = 'T-03' and status = '" .$sta[$j]. "' and cust8 like '" . $itw[$i][0] . "%'";
				$resultx = @mysql_query($querySQLx) or die ("-er-sql-" . mysql_error());
				$trows = mysql_num_rows($resultx);
				$totu += $trows;
				$totv[$j] +=  $trows;
				$strdata .= "<td>" . $trows . "</td>";
			}
			$strdata .= "<td style='color:#dd0000'><b>" . $totu . "</b></td>";
			$strdata .= "</tr>";
			if($totu > 0){ fwrite($fh, $strdata); }
		}
		$strdata = "<tr><td style='text-align:left; color:#dd0000;'><b>Total</b></td><td style='color:#dd0000'><b>".$totv[0]."</b></td><td style='color:#dd0000'><b>".$totv[1]."</b></td><td style='color:#dd0000'><b>".$totv[2]."</b></td><td style='color:#dd0000'><b>".$totv[3]."</b></td><td style='color:#dd0000'><b>".$totv[4]."</b></td><td style='color:#dd0000'><b>".$totv[5]."</b></td><td style='color:#dd0000'><b>".$totv[6]."</b></td><td style='color:#dd0000'><b>".$totv[7]."</b></td><td style='color:#dd0000'><b>".$totv[8]."</b></td><td style='background-image:url(media/bgdiag.png);'></td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td colspan='11' style='background-color:#dd0000; color:#ffffff; font-size:11px; text-align:left; padding:1mm 1mm 1mm 10mm'><b>Legende :</b> COM-complété&nbsp;&nbsp;ACT-active&nbsp;&nbsp;ARE-à retracer&nbsp;&nbsp;NIW-non interviewé&nbsp;&nbsp;ABA-abandoné<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;DEC-décèdé&nbsp;&nbsp;DHZ-déménagé hors-zone&nbsp;&nbsp;DAI-déménagé adr. inconnue&nbsp;&nbsp;ANN-annulé</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "</table></body></html>";
		fwrite($fh, $strdata);
		fclose($fh);
	}	
		
		

	function fn170($par)			//list addesses
	{
		global $userstbl;
		$retv = "-er-sql-";
		$trows = 0;
		
		$querySQL = "select count(*) from address where idu = '" .$par[3]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$trows = $row['count(*)'];
			}
		}
		$querySQL = "select id, idu, type, dateedit, date, address, addressx, city, state, country, postal from address where idu = '" .$par[3]. "' order by type, date desc limit " .$par[1]. ", " . $par[2];
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn170-" . $trows;
			while ($row = mysql_fetch_array($result))
			{
				$add = $row['address'];
				if ($row['addressx'] != "") { $add = $add . ", " . $row['addressx']; }
				if ($row['city'] != "") { $add = $add . ", " . $row['city']; }
				if ($row['state'] != "") { $add = $add . ", " . $row['state']; }
				if ($row['country'] != "") { $add = $add . ", " . $row['country']; }
				$retv = $retv. "|" .$row['id']. "¦" .$row['idu']. "¦" .$row['type']. "¦" .$row['dateedit']. "¦"  .$row['date']. "¦" .$add. "¦" .$row['postal'];
			}
		}
		else
		{
			$retv = "-er-fn170-";
		}
		return $retv;	
	}
	
	function fn171($par)			//export addesses to csv
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		
		return $retv;
	}
	
	function fn175($par)			//user actions - reasign interviewer
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		backupusers();
		backupactions();
		$querySQL = "select id, idusr, fname, lname from users where idusr = '" . $par[2] . "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());	
		$retv = "-er-fn175-";
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$uid = $row['id'];
				$usrid = $row['idusr'];
				$ufname = $row['fname'];
				$ulname = $row['lname'];
			}
			$uname = $ufname . " " . $ulname;
			$querySQLx = "update users set cust8 = concat('" .$par[2]. "', substring(cust8,7)) where cust8 like '" .$par[1]. "%' and phase = 'T-04' and type = 'PAR' and (status = 'ACT' or status = 'ARE')";
			$resultx = @mysql_query($querySQLx);		// or die ("-er-sql-" . mysql_error());
			if($resultx)
			{
				$querySQLz = "update activity set idu = '" .$uid. "', idusr = '" .$usrid. "', nameusr = '" .$uname. "' where idusr = '" .$par[1]. "' and pphase = 'T-03' and (pstatus = 'ACT' or pstatus = 'ARE')";
				$resultz = @mysql_query($querySQLz);		// or die ("-er-sql-" . mysql_error());
				if($resultz)
				{
					$retv = "-ok-fn175-";
				}
			}
		}
		return $retv;
	}
	
	function fn177($par)			//recruitment planning html
	{
		global $userstbl;
		$retv = "-er-sql-";
		if ($par[2] != "") { $whr = filteruser($par[2]); }

		//$whr = "type='PAR' and step='REC' and status='COM'";
		//$td = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
		
		$z = array("LAC", "LAS", "PSC", "VER");
		$lz = count($z);
		//$b = array("0000-00-00", "0000-00-00", "0000-00-00");
		$b = array("15-30", "31-44", "45-150");
		$lb = count($b);
		$s = array("H", "F");
		$ls = count($s);
		$r = array("1" , "2" , "3");
		$lr = count($r);
		$vv = "";
		for ($i = 0; $i < $lz; $i++)
		{
			for ($j = 0; $j < $lb; $j++)
			{
				for ($k = 0; $k < $ls; $k++)
				{
					for ($l = 0; $l < $lr; $l++)
					{
						$agl = explode("-", $b[$j]);
						$agl[0] = (2013 - $agl[0]) . "-12-31";
						$agl[1] = (2013 - $agl[1]) . "-01-01";
						$querySQL = "select id from " .$userstbl. " " .$whr. " and hzone1='" .$z[$i]. "' and birth<='" .$agl[0]. "' and birth>='" .$agl[1]. "' and sex='" .$s[$k]. "' and revcode='" .$r[$l]. "'";
						$result = @mysql_query($querySQL);		 //or die ("err: " . mysql_error());
						$v = mysql_num_rows($result);
						$vv .= "|" . $v;
					}
				}
			}
		}
		$vv = substr($vv, 1);
		htmusr5($vv, $par[1]);
		$retv = "-ok-fn177-";
		return $retv;
	}
	
	function htmusr5($v, $fi)		//planning html
	{
		$td = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
		$vvals = explode("|", $v);
		$rvals = "17,2,13,31,7,12,10,4,2,19,2,25,6,10,18,9,9,15,10,7,6,26,11,8,18,9,9,32,11,7,13,16,6,25,22,16,7,18,13,16,23,25,9,12,14,12,21,25,9,11,13,14,8,30,9,27,8,12,36,10,9,23,22,17,13,18,7,27,12,9,17,18";
		$rvals = explode(",", $rvals);
		$rl = count($rvals);
		$totval = 0;
		for ($i = 0; $i < $rl; $i++)
		{
			$totval += $vvals[$i];
			$pct = number_format(($vvals[$i] / $rvals[$i])*100, 0);
			$rvals[$i] = "<table width='100%' style='border-style:none; border-spacing:0px; border-collapse:collapse; font-size:12px'><tr><td style='border-style:none; border-collapse:collapse;'>" .$vvals[$i]." / ".$rvals[$i]. "</td> <td style='border-style:none; border-collapse:collapse;'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td> <td align=right style='border-style:none; border-collapse:collapse;'>" .$pct. "%</td></tr></table>";
			//$totvals[i] = $vvals[$i]
		}
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>PLANIFICATION RECRUTEMENT</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} maintable{ width:500px; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:12px; color:#606060; border-spacing:0px; border-collapse:collapse; }  .maintd{ border-style:solid; border-width:1px 1px 1px 1px; border-color:#ff0000; border-collapse:collapse; padding:1px 8px 1px 8px; font-size:12px;} .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'> <div class='title'>PLANIFICATION RECRUTEMENT</div>";
		fwrite($fh, $strdata);
		$strdata = "<br/><table class='maintable'><tr><td class='maintd' style='color:#ff0000'><b>QUART</b></td><td class='maintd' style='color:#ff0000'><b>AGE</b></td><td class='maintd' style='color:#ff0000'><b>SEX</b></td><td class='maintd' style='color:#ff0000'><b>R1</b></td><td class='maintd' style='color:#ff0000'><b>R2</b></td><td class='maintd' style='color:#ff0000'><b>R3</b></td><td class='maintd' style='color:#ff0000'><b>TOTAL</b></td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='6'>LAC</td><td class='maintd' style='color:#ff0000' rowspan='2'>15-30</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[0]. "</td><td class='maintd'>" .$rvals[1]. "</td><td class='maintd'>" .$rvals[2]. "</td><td class='maintd'>" .($vvals[0]+$vvals[1]+$vvals[2]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[3]. "</td><td class='maintd'>" .$rvals[4]. "</td><td class='maintd'>" .$rvals[5]. "</td><td class='maintd'>" .($vvals[3]+$vvals[4]+$vvals[5]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>31-45</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[6]. "</td><td class='maintd'>" .$rvals[7]. "</td><td class='maintd'>" .$rvals[8]. "</td><td class='maintd'>" .($vvals[0]+$vvals[1]+$vvals[2]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[9]. "</td><td class='maintd'>" .$rvals[10]. "</td><td class='maintd'>" .$rvals[11]. "</td><td class='maintd'>" .($vvals[9]+$vvals[10]+$vvals[11]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>45+</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[12]. "</td><td class='maintd'>" .$rvals[13]. "</td><td class='maintd'>" .$rvals[14]. "</td><td class='maintd'>" .($vvals[12]+$vvals[13]+$vvals[14]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[15]. "</td><td class='maintd'>" .$rvals[16]. "</td><td class='maintd'>" .$rvals[17]. "</td><td class='maintd'>" .($vvals[15]+$vvals[16]+$vvals[17]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='6'>LAS</td><td class='maintd' style='color:#ff0000' rowspan='2'>15-30</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[18]. "</td><td class='maintd'>" .$rvals[19]. "</td><td class='maintd'>" .$rvals[20]. "</td><td class='maintd'>" .($vvals[18]+$vvals[19]+$vvals[20]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[21]. "</td><td class='maintd'>" .$rvals[22]. "</td><td class='maintd'>" .$rvals[23]. "</td><td class='maintd'>" .($vvals[21]+$vvals[22]+$vvals[23]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>31-45</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[24]. "</td><td class='maintd'>" .$rvals[25]. "</td><td class='maintd'>" .$rvals[26]. "</td><td class='maintd'>" .($vvals[24]+$vvals[25]+$vvals[26]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[27]. "</td><td class='maintd'>" .$rvals[28]. "</td><td class='maintd'>" .$rvals[29]. "</td><td class='maintd'>" .($vvals[27]+$vvals[28]+$vvals[29]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>45+</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[30]. "</td><td class='maintd'>" .$rvals[31]. "</td><td class='maintd'>" .$rvals[32]. "</td><td class='maintd'>" .($vvals[30]+$vvals[31]+$vvals[32]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[33]. "</td><td class='maintd'>" .$rvals[34]. "</td><td class='maintd'>" .$rvals[35]. "</td><td class='maintd'>" .($vvals[33]+$vvals[34]+$vvals[35]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='6'>PSC</td><td class='maintd' style='color:#ff0000' rowspan='2'>15-30</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[36]. "</td><td class='maintd'>" .$rvals[37]. "</td><td class='maintd'>" .$rvals[38]. "</td><td class='maintd'>" .($vvals[36]+$vvals[37]+$vvals[38]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[39]. "</td><td class='maintd'>" .$rvals[40]. "</td><td class='maintd'>" .$rvals[41]. "</td><td class='maintd'>" .($vvals[39]+$vvals[40]+$vvals[41]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>31-45</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[42]. "</td><td class='maintd'>" .$rvals[43]. "</td><td class='maintd'>" .$rvals[44]. "</td><td class='maintd'>" .($vvals[42]+$vvals[43]+$vvals[44]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[45]. "</td><td class='maintd'>" .$rvals[46]. "</td><td class='maintd'>" .$rvals[47]. "</td><td class='maintd'>" .($vvals[45]+$vvals[46]+$vvals[47]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>45+</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[48]. "</td><td class='maintd'>" .$rvals[49]. "</td><td class='maintd'>" .$rvals[50]. "</td><td class='maintd'>" .($vvals[48]+$vvals[49]+$vvals[50]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[51]. "</td><td class='maintd'>" .$rvals[52]. "</td><td class='maintd'>" .$rvals[53]. "</td><td class='maintd'>" .($vvals[51]+$vvals[52]+$vvals[53]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='6'>VER</td><td class='maintd' style='color:#ff0000' rowspan='2'>15-30</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[54]. "</td><td class='maintd'>" .$rvals[55]. "</td><td class='maintd'>" .$rvals[56]. "</td><td class='maintd'>" .($vvals[54]+$vvals[55]+$vvals[56]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[57]. "</td><td class='maintd'>" .$rvals[58]. "</td><td class='maintd'>" .$rvals[59]. "</td><td class='maintd'>" .($vvals[57]+$vvals[58]+$vvals[59]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>31-45</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[60]. "</td><td class='maintd'>" .$rvals[61]. "</td><td class='maintd'>" .$rvals[62]. "</td><td class='maintd'>" .($vvals[60]+$vvals[61]+$vvals[62]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[63]. "</td><td class='maintd'>" .$rvals[64]. "</td><td class='maintd'>" .$rvals[65]. "</td><td class='maintd'>" .($vvals[63]+$vvals[64]+$vvals[65]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000' rowspan='2'>45+</td><td class='maintd' style='color:#ff0000'>H</td><td class='maintd'>" .$rvals[66]. "</td><td class='maintd'>" .$rvals[67]. "</td><td class='maintd'>" .$rvals[68]. "</td><td class='maintd'>" .($vvals[66]+$vvals[67]+$vvals[68]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>F</td><td class='maintd'>" .$rvals[69]. "</td><td class='maintd'>" .$rvals[70]. "</td><td class='maintd'>" .$rvals[71]. "</td><td class='maintd'>" .($vvals[69]+$vvals[70]+$vvals[71]). "</td></tr>";
		fwrite($fh, $strdata);
		$strdata = "<tr><td class='maintd' style='color:#ff0000'>&nbsp;</td><td class='maintd' style='color:#ff0000'>&nbsp;</td><td class='maintd' style='color:#ff0000'>&nbsp;</td><td class='maintd'>&nbsp;</td><td class='maintd'>&nbsp;</td><td class='maintd'>&nbsp;</td><td class='maintd'>" .$totval. "</td></tr>";
		fwrite($fh, $strdata);
		
		$strdata = "</table></body></html>";
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function fn180($par)			//save visited addresses
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		if ($par[3] != "") { $add = explode("·", $par[3]); } else { return "-ok-fn180-"; }
		$td = mktime(0, 0, 0, date('m'), date('d'), date('Y'));
		$trows = 0;
		$querySQL = "select id from addressvis where idu = '" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if ($result) { $trows = mysql_num_rows($result); }
		if ($trows == 1)
		{
			$querySQL = "update addressvis set a6='" .$add[0]. "', a5='" .$add[1]. "', a4='" .$add[2]. "', a0='" .$add[3]. "', a1='" .$add[4]. "', a2='" .$add[5]. "', a3='" .$add[6]. "', a7='" .$add[7]. "', a8='" .$add[8]. "', a9='" .$add[9]. "', a10='" .$add[10]. "', a11='" .$add[11]. "', a12='" .$add[12]. "', a13='" .$add[13]. "', dateedit='" .date("Y-m-d", $td). "' where idu='" .$par[1]. "'";
		}
		else
		{
			$querySQL = "insert into addressvis set id='NULL', idu='" .$par[1]. "', idusr='" .$par[2]. "', a6='" .$add[0]. "', a5='" .$add[1]. "', a4='" .$add[2]. "', a0='" .$add[3]. "', a1='" .$add[4]. "', a2='" .$add[5]. "', a3='" .$add[6]. "', a7='" .$add[7]. "', a8='" .$add[8]. "', a9='" .$add[9]. "', a10='" .$add[10]. "', a11='" .$add[11]. "', a12='" .$add[12]. "', a13='" .$add[13]. "', dateedit='" .date("Y-m-d", $td). "'";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn180-";
		}
		else
		{
			$retv = "-er-fn180-";
		}
		return $retv;
	}
	
	function fn181($par)			//list visited addresses
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		$querySQL = "select * from addressvis where idu='" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$a = "";
			while ($row = mysql_fetch_array($result))
			{
				$a = "|" .$row['a6']. "|" .$row['a5']. "|" .$row['a4']. "|" .$row['a0']. "|" .$row['a1']. "|" .$row['a2']. "|" .$row['a3']. "|" .$row['a7']. "|" .$row['a8']. "|" .$row['a9']. "|" .$row['a10']. "|" .$row['a11']. "|" .$row['a12']. "|" .$row['a13']. "|" .$row['address']. "|" .$row['lat']. "|" .$row['lng']. "|" .$row['zone1']. "|" .$row['zone2']. "|" .$row['zone3'];
			}
			$retv = "-ok-fn181-" . $a;
		}
		else
		{
			$retv = "-er-fn181-" . mysql_error();
		}
		return $retv;
	}
	
	function fn182($par)			//load mailing addresses
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		$querySQL = "select * from addressmail where idu = '" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if ($result)
		{
			$retv = "-ok-fn182-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. $row['id']. "¦" .$row['idu']."¦" .$row['address']."¦" .$row['addressx']. "¦" .$row['city']. "¦"  .$row['state']. "¦" .$row['country']. "¦" .$row['postal'];
			}
		}
		else
		{
			$retv = "-er-fn182-" . mysql_error();
		}
		return $retv;	
	}
	
	function fn183($par)			//save mailing addresses
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		
		$querySQL = "select id from addressmail where idu = '" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if ($result) { $trows = mysql_num_rows($result); }
		if ($trows == 1)
		{
			$querySQL = "update addressmail set address='" .$par[2]. "', addressx='" .$par[3]. "', city='" .$par[4]. "', state='" .$par[5]. "', country='" .$par[6]. "', postal='" .$par[7]. "' where idu = '" .$par[1]. "'";
		}
		else
		{
			$querySQL = "insert into addressmail set id='NULL', idu='" .$par[1]. "', address='" .$par[2]. "', addressx='" .$par[3]. "', city='" .$par[4]. "', state='" .$par[5]. "', country='" .$par[6]. "', postal='" .$par[7]. "'";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn183-";
		}
		else
		{
			$retv = "-er-fn183-";
		}
		return $retv;
	}
	
	//---------------------------------------------------------------------------------activities
	
	
	function fn202($par)		//load activities list (filtered)
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "") { $whr = filteractivity($par[3]); }
		if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
		$querySQL = "select count(*) from activity " .$whr;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$trows = $row['count(*)'];
			}
		}
		$querySQL = "select id, idu, idp, idusr, idparti, nameusr, nameparti, activity, status, mode, code, description, dstart, dend, ptype, pphase, pstep, pstatus, pxgroup, cust7, cust8 from activity " .$whr. " order by " .$srt. " limit " .$par[1]. ", " . $par[2];
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn202-" . $trows;
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. "|" .$row['id']. "¦" .$row['activity']. "¦" .$row['status']. "¦" .$row['mode']. "¦" .$row['code']. "¦" .$row['description']. "¦" .$row['dstart']. "¦" .$row['dend']. "¦" .$row['idu']. "¦" .$row['idusr']. "¦" .$row['nameusr']. "¦" .$row['idp']. "¦" .$row['idparti']. "¦" .$row['nameparti']. "¦" .$row['ptype']. "¦" .$row['pphase']. "¦" .$row['pstep']. "¦" .$row['pstatus']. "¦" .$row['pxgroup']. "¦" .$row['cust7']. "¦" .$row['cust8'];
			}
		}
		else
		{
			$retv = "-er-fn202-";		// . $querySQL;
		}
		return $retv;	
	}
	
	function filteractivity($par)
	{
		global $userstbl;
		$wr = "";
		
		$flt = explode("·", $par);
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		$tw = $td + (7 * 24 * 3600);
		
		if ($flt[44] != "---")
		{
			$qfind = explode(",", $flt[44]);
			$lc = count($qfind);
			if ($lc > 1)
			{
				for ($j = 0; $j < $lc; $j++)
				{
					$qfind[$j] = "comments like '%" .trim($qfind[$j]). "%'";
				}
				$qfind = "(" . implode(" or ", $qfind) . ")";
			}
			else
			{
				$qfind = "(idusr = '".$flt[44]."' or idparti = '".$flt[44]."' or nameusr like '%".$flt[44]."%' or nameparti like '%".$flt[44]."%' or comments like '%".$flt[44]."%')";
			}
		}
		else
		{
			$qfind = "";
		}

		
		//$var = array("activity='TAC'", "activity='EVT'", "dstart='" .date("Y-m-d", $td). "'", "dstart>='" .date("Y-m-d", $td). "' and dstart<='" .date("Y-m-d", $tw). "'", "status='CUR'", "status='PLA'", "status='FIN'", "status='ANN'", "dstart>='".$flt[8]."'", "dend<='".$flt[9]."'", "mode='USR'", "mode='SYS'", "code='".$flt[12]."'", "description='".$flt[13]."'", "pphase='".$flt[14]."'", "pxgroup='".$flt[15]."'", "pstep='INI'", "pstep='REC'", "pstep='AUT'", "pstep='INT'", "pstep='AUT'", "pstep='ACQ'", "pstep='AUT'", "pstep='FIN'", "pstatus='ACT'", "pstatus='COM'", "pstatus='ARE'", "pstatus='NRE'", "pstatus='NIW'", "pstatus='ABA'", "pstatus='DEC'", "pstatus='DHZ'", "pstatus='DAI'", "pstatus='ANN'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "((cust0 > '0.00' and cust2 != '') and (cust3 > '0.00' and cust5 != ''))", "((cust0 > '0.00' and cust2 = '') or (cust3 > '0.00' and cust5 = ''))", "cust2>='".$flt[42]."' or cust5>='".$flt[42]."'", "cust2<='".$flt[43]."' or cust5<='".$flt[43]."'", $qfind);
		$var = array("activity='TAC'", "activity='EVT'", "dstart='" .date("Y-m-d", $td). "'", "dstart>='" .date("Y-m-d", $td). "' and dstart<='" .date("Y-m-d", $tw). "'", "status='CUR'", "status='PLA'", "status='FIN'", "status='ANN'", "dstart>='".$flt[8]."'", "dend<='".$flt[9]."'", "mode='USR'", "mode='SYS'", "code='".$flt[12]."'", "description='".$flt[13]."'", "pphase='".$flt[14]."'", "pxgroup='".$flt[15]."'", "pstep='INI'", "pstep='REC'", "pstep='AUT'", "pstep='INT'", "pstep='AUT'", "pstep='ACQ'", "pstep='AUT'", "pstep='FIN'", "pstatus='ACT'", "pstatus='COM'", "pstatus='ARE'", "pstatus='NRE'", "pstatus='NIW'", "pstatus='ABA'", "pstatus='DEC'", "pstatus='DHZ'", "pstatus='DAI'", "pstatus='ANN'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstatus='AUT'", "pstep='FIN'", "pstep != 'FIN' and (cust2 != '' or cust5 != '')", "(cust2>='".$flt[42]."' or cust5>='".$flt[42]."')", "(cust2<='".$flt[43]."' or cust5<='".$flt[43]."')", $qfind);
		$exp = NULL;
		for ($i = 0; $i <= 1; $i += 1)		//activity type
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		$i = 2;		//to do today
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 3;		//to do this week
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 4;		//current
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 5;		//planned
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 6;		//finalized
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 7;		//canceled
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 8;		//start
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 9;		//end
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		for ($i = 10; $i <= 11; $i += 1)		//activity mode
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		$i = 12;		//code
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 13;		//description
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		
		$exp = NULL;
		for ($i = 14; $i <= 15; $i += 1)		//phase, xgroup (cohorte)
		{
			if ($flt[$i] != "---") { $exp[] = $var[$i]; }
		}
		if (count($exp) > 1)
		{
			$wr[] = "(" . implode(" and ", $exp) . ")";
		}
		elseif ($flt[14] != "---" && $flt[14] != "")
		{
			$wr[] = $var[14];
		}
		elseif ($flt[15] != "---" && $flt[15] != "")
		{
			$wr[] = $var[15];
		}
				
		$exp = NULL;
		for ($i = 16; $i <= 23; $i += 1)		//parti step
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		for ($i = 24; $i <= 39; $i += 1)		//parti status
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		$i = 40;		//paid
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 41;		//not paid
		{
			if ($flt[$i] != 0) { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 42;		//start payment
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 43;		//end payment
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 44;		//quick search
		{
			if ($flt[$i] != "---") { $wr[] = $var[$i]; }
		}
		if ($wr != "") { $wr = "where " . implode(" and ", $wr); } else { $wr = "where id!=0"; }
		return $wr;
	}
	
	function fn203($par)		//load activity record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$querySQL = "select * from activity where id='" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn203-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. $row['id']. "¦" .$row['idu']."¦" .$row['idp']."¦" .$row['idusr']. "¦" .$row['idparti']. "¦"  .$row['nameusr']. "¦" .$row['nameparti']. "¦"  .$row['activity']. "¦"  .$row['status']. "¦" .$row['mode']. "¦" .$row['code']. "¦" .$row['ptype']. "¦" .$row['pphase']. "¦" .$row['pstep']. "¦" .$row['pstatus']. "¦" .$row['description']. "¦" .$row['dstart']. "¦" .$row['tstart']. "¦" .$row['dend']. "¦" .$row['tend']. "¦" .$row['location']. "¦" .$row['cust0']. "¦" .$row['cust1']. "¦" .$row['cust2']. "¦" .$row['cust3']. "¦" .$row['cust4']. "¦" .$row['cust5']. "¦" .$row['cust6']. "¦" .$row['cust7']. "¦" .$row['cust8']. "¦" .$row['pxgroup']. "¦" .$row['comments'];
			}
		}
		else
		{
			$retv = "-er-fn203-" . mysql_error();
		}
		return $retv;	
	}
	
	function fn204($par)		//save activity record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$id = $par[1];
		$querySQL = "idu='" .$par[2]. "', idp='" .$par[3]. "', idusr='" .$par[4]. "', idparti='" .$par[5]. "', nameusr='" .$par[6]. "', nameparti='" .$par[7]. "', activity='" .$par[8]. "', status='" .$par[9]. "', mode='" .$par[10]. "', code='" .$par[11]. "', ptype='" .$par[12]. "', pphase='" .$par[13]. "', pstep='" .$par[14]. "', pstatus='" .$par[15]. "', description='" .$par[16]. "', dstart='" .$par[17]. "', tstart='" .$par[18]. "', dend='" .$par[19]. "', tend='" .$par[20]. "', location='" .$par[21]. "', cust0='" .$par[22]. "', cust1='" .$par[23]. "', cust2='" .$par[24]. "', cust3='" .$par[25]. "', cust4='" .$par[26]. "', cust5='" .$par[27]. "', cust6='" .$par[28]. "', cust7='" .$par[29]. "', cust8='" .$par[30]. "', pxgroup='" .$par[31]. "', comments='" .$par[32]. "'";
		if ($id == "")			//insert
		{
			$querySQL = "insert into activity set id='NULL', " . $querySQL;
		}
		else
		{
			$querySQL = "update activity set " . $querySQL .  " where id = '" .$id. "'";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		
		if($result)
		{
			if ($id != "")
			{
				//if ($par[14] == "REC" && $par[15] == "COM" && $par[16] == "RECRUTEMENT")			//CUSTOM: if action updated to recruited (completed), sync related records if any (same idparty, diff. id user) !!!
				if ($par[14] == "REC")			//CUSTOM: if action updated sync related records if any (same idparty, diff. id user) !!!
				{
					$what = "nameparti='" .$par[7]. "', ptype='" .$par[12]. "', pstatus='" .$par[15]. "', description='" .$par[16]. "', dstart='" .$par[17]. "', tstart='" .$par[18]. "', dend='" .$par[19]. "', tend='" .$par[20]. "', location='" .$par[21]. "', cust0='" .$par[22]. "', cust1='" .$par[23]. "', cust2='" .$par[24]. "', cust3='" .$par[25]. "', cust4='" .$par[26]. "', cust5='" .$par[27]. "', cust6='" .$par[28]. "', cust7='" .$par[29]. "', cust8='" .$par[30]. "', comments='" .$par[32]. "'";
					//$querySQLx = "update activity set " . $what .  " where id!='" .$id. "' and idp='" .$par[3]. "' and pphase='" .$par[13]. "' and pstep='REC' and pstatus!='COM'";
					$querySQLx = "update activity set " . $what .  " where id!='" .$id. "' and idp='" .$par[3]. "' and pphase='" .$par[13]. "' and pstep='REC'";
					$resultx = @mysql_query($querySQLx);		// or die ("-er-sql-" . mysql_error());
				}
			}
			else
			{
				if ($par[14] == "INT" && $par[16] == "ASSIGNÉ INTERVIEWER")			//CUSTOM: update recrutement assigne to recrutement completed on assign interviewer
				{
					$what = "ptype='PAR', nameparti='" .$par[7]. "', pstatus='COM', description='RECRUTEMENT'";
					$querySQLx = "update activity set " . $what .  " where idparti='" .$par[5]. "' and pphase='" .$par[13]. "' and pstep='REC' and pstatus='ACT'";
					$resultx = @mysql_query($querySQLx);		// or die ("-er-sql-" . mysql_error());
				}
			}
		}
		
		if($result)
		{
			$retv = "-ok-fn204-" . $id;
		}
		else
		{
			$retv = "-er-fn204-";
		}
		return $retv;	
	}
	
	function fn205($par)		//delete activity record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$id = $par[1];
		if ($id != 0 && $id != "")
		{
			$querySQL = "delete from activity where id = '" .$id. "'";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				$retv = "-ok-fn205-" . $id;
			}
			else
			{
				$retv = "-er-fn205-" . mysql_error();
			}
		}
		return $retv;	
	}	
	
	function fn250($par)			//activities export to csv from filtered list
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "") { $whr = filteractivity($par[3]); }
		$retv = "-er-fn250-";
		if ($par[7] == 1)
		{
			if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
			$querySQL = "select id, activity, status, code, idusr, nameusr, idparti, nameparti, ptype, pxgroup, pphase, pstep, pstatus, dstart, dend, cust0, cust1, cust2, cust3, cust4, cust5 from activity " .$whr. " order by " .$srt;
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact1($result, $par[6]);
				$retv = "-ok-fn250-";
			}
		}
		elseif ($par[7] == 2)
		{
			$querySQL = "select id, activity, status, code, idusr, nameusr, idparti, nameparti, ptype, pxgroup, pphase, pstep, pstatus, dstart, dend, cust0, cust1, cust2, cust3, cust4, cust5 from activity " .$whr. " order by idusr";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact2($result, $par[6]);
				$retv = "-ok-fn250-";
			}
		}
		elseif ($par[7] == 3)
		{
			$querySQL = "select id, activity, status, code, idusr, nameusr, idparti, nameparti, ptype, pxgroup, pphase, pstep, pstatus, dstart, dend, cust0, cust1, cust2, cust3, cust4, cust5 from activity " .$whr. " order by idusr";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact2($result, $par[6]);
				$retv = "-ok-fn250-";
			}
		}
		return $retv;	
	}

	function fn251($par)			//activities export to csv from selection
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		$retv = "-er-fn251-";		
		if ($par[3] != "") 
		{ 
			$wr = explode("·", $par[3]);
			for ($i = 0; $i < count($wr); $i += 1)
			{
				$wr[$i] = "id='" .$wr[$i]. "'";
			}
			$whr = "where " . implode(" or ", $wr);		
		}
		
		if ($par[7] == 1)
		{
			if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
			$querySQL = "select * from activity " .$whr. " order by " .$srt;
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact1($result, $par[6]);
				$retv = "-ok-fn251-";
			}
		}
		elseif ($par[7] == 2)
		{
			$querySQL = "select * from activity " .$whr. " order by idusr";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact2($result, $par[6]);
				$retv = "-ok-fn251-";
			}
			$querySQL = "select idusr, nameusr, sum(cust1) as total from activity " .$whr. " group by idusr order by idusr";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact2t($result, $par[6]);
				$retv = "-ok-fn251-";
			}
		}
		elseif ($par[7] == 3)
		{
			$querySQL = "select * from activity " .$whr. " order by idusr";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact3($result, $par[6]);
				$retv = "-ok-fn251-";
			}
			$querySQL = "select idusr, nameusr, sum(cust4) as total from activity " .$whr. " group by idusr order by idusr";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				csvact3t($result, $par[6]);
				$retv = "-ok-fn251-";
			}
		}
		return $retv;	
	}

	function csvact1($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "#\tActivité\tÉtat\tCode\tID Resp.\tNom responsable\tID Parti.\tNom participant\tType parti.\tCohorte\tTemps\tÉtape\tStatut\tDebut\tFin\n"; 
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['id']. "\t" .$row['activity']. "\t" .$row['status']. "\t" .$row['code']. "\t" .$row['idusr']. "\t" .$row['nameusr']. "\t" .$row['idparti']. "\t" .$row['nameparti']. "\t" .$row['ptype']. "\t" .$row['pxgroup']. "\t" .$row['pphase']. "\t" .$row['pstep']. "\t" .$row['pstatus']. "\t" .$row['dstart']. "\t" .$row['dend']. "\n"; 
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function csvact2($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "#\tID Resp.\tNom responsable\tID Parti.\tNom participant\tTemps\tDebut\tFin\tKm.\tCoût Km.\tPayé le\n"; 
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['id']. "\t" .$row['idusr']. "\t" .$row['nameusr']. "\t" .$row['idparti']. "\t" .$row['nameparti']. "\t" .$row['pphase']. "\t" .$row['dstart']. "\t" .$row['dend']. "\t" .$row['cust0']. "\t" .$row['cust1']. "\t" .$row['cust2']. "\n"; 
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function csvact2t($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'a');	 //or die("can't open file");
		$strdata = "\n\n\n--------------------------------------------------------------------------------------------------------------------\nID Resp.\tNom responsable\tMontant total Km.\n"; 
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['idusr']. "\t" .$row['nameusr']. "\t" .$row['total']. "\n"; 
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function csvact3($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "#\tID Resp.\tNom responsable\tID Parti.\tNom participant\tTemps\tDebut\tFin\tHrs.\tCoût Hrs.\tPayé le\n"; 
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['id']. "\t" .$row['idusr']. "\t" .$row['nameusr']. "\t" .$row['idparti']. "\t" .$row['nameparti']. "\t" .$row['pphase']. "\t" .$row['dstart']. "\t" .$row['dend']. "\t" .$row['cust3']. "\t" .$row['cust4']. "\t" .$row['cust5']. "\n"; 
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function csvact3t($res, $fi)
	{
		$strdata = "";
		$fh = fopen($fi, 'a');	 //or die("can't open file");
		$strdata = "\n\n\n--------------------------------------------------------------------------------------------------------------------\nID Resp.\tNom responsable\tMontant total Hre.\n"; 
		fwrite($fh, $strdata);
		while ($row = mysql_fetch_array($res))
		{
			$strdata = $row['idusr']. "\t" .$row['nameusr']. "\t" .$row['total']. "\n"; 
			fwrite($fh, $strdata);
		}
		fclose($fh);
	}

	function fn260($par)			//activities export to html from filtered list
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		$usrarr = array();
		
		$retv = "-er-fn260-";
		
		//$querySQL = "update activity set activity.cust6=(select idusraux from users where activity.idusr=users.idusr) where activity.idusr like 'INT%'";
		//$querySQL = "update activity set activity.cust6='xxx' where activity.idusr like 'INT%'";
		$querySQL = "select idusr, idusraux, fname, lname from users where idusr like 'INT%' || idusr like 'ADM%' order by idusr";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		while ($row = mysql_fetch_array($result))
		{
			array_push($usrarr, $row[0]."|".$row[1]."|".$row[2]." ".$row[3]);
		}
		for ($i = 0; $i < count($usrarr); $i += 1)
		{
			$usrarr[$i] = explode("|", $usrarr[$i]);
		}
		//fn260¦0¦16¦0·0·0·0·0·0·0·0·---·---·0·0·---·---·T-03·C-01·0·0·0·1·0·0·0·0·0·1·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·---¦id¦¦actlist.htm¦---¦2
		
		if ($par[3] != "") { $whr = filteractivity($par[3]); }
		
		if ($par[8] == 1)
		{
			if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
			$querySQL = "select * from activity " .$whr. " order by " .$srt;
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				htmact1($result, $par[6], $par[7]);
				$retv = "-ok-fn260-";
			}
		}
		elseif ($par[8] == 2)
		{
			$querySQL = "select * from activity " .$whr. " order by idusr, id";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				htmact2($result, $par[6], $par[7], $usrarr);
				$retv = "-ok-fn260-";
			}
		}
		elseif ($par[8] == 3)
		{
			$querySQL = "select * from activity " .$whr. " order by idusr, id";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				htmact3($result, $par[6], $par[7], $usrarr);
				$retv = "-ok-fn260-";
			}
		}
		return $retv;	
	}

	function fn261($par)			//activities export to html from selection
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		$usrarr = array();
		
		$retv = "-er-fn261-";
		
		//$querySQL = "update activity set activity.cust6=(select idusraux from users where activity.idusr=users.idusr) where activity.idusr like 'INT%'";
		//$querySQL = "update activity set activity.cust6='xxx' where activity.idusr like 'INT%'";
		$querySQL = "select idusr, idusraux, fname, lname from users where idusr like 'INT%' || idusr like 'ADM%' order by idusr";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		while ($row = mysql_fetch_array($result))
		{
			array_push($usrarr, $row[0]."|".$row[1]."|".$row[2]." ".$row[3]);
		}
		for ($i = 0; $i < count($usrarr); $i += 1)
		{
			$usrarr[$i] = explode("|", $usrarr[$i]);
		}
		
		
		//fn260¦0¦16¦0·0·0·0·0·0·0·0·---·---·0·0·---·---·T-03·C-01·0·0·0·1·0·0·0·0·0·1·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·---¦id¦¦actlist.htm¦---¦2
		
		if ($par[3] != "") 
		{ 
			$wr = explode("·", $par[3]);
			for ($i = 0; $i < count($wr); $i += 1)
			{
				$wr[$i] = "id='" .$wr[$i]. "'";
			}
			$whr = "where " . implode(" or ", $wr);		
		}
		
		if ($par[8] == 1)
		{
		
			if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
			$querySQL = "select * from activity " .$whr. " order by " .$srt;
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				htmact1($result, $par[6], $par[7]);
				$retv = "-ok-fn261-";
			}
		}
		elseif ($par[8] == 2)
		{
			$querySQL = "select * from activity " .$whr. " order by idusr, id";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				htmact2($result, $par[6], $par[7], $usrarr);
				$retv = "-ok-fn261-";
			}
		}
		elseif ($par[8] == 3)
		{
			$querySQL = "select * from activity " .$whr. " order by idusr, id";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				htmact3($result, $par[6], $par[7], $usrarr);
				$retv = "-ok-fn261-";
			}
		}
		return $retv;	
	}
	
	function htmact1($res, $fi, $ti)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>Liste des activités</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ width:100%; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:12px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .red {color:#ff0000; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'> <div class='title'>" .$ti. "</div>";
		fwrite($fh, $strdata);
		$i = 0;
		while ($row = mysql_fetch_array($res))
		{
			if ($i == 0)
			{
				$strdata = "<br/><br/><table><tr><td class='red'>#</td><td class='red'>Activité</td><td class='red'>État</td><td class='red'>Code</td><td class='red'>ID Resp.</td><td class='red'>Nom&nbsp;responsable</td><td class='red'>ID Parti.</td><td class='red'>Nom&nbsp;participant</td><td class='red'>Type</td><td class='red'>Coho.</td><td class='red'>Temps</td><td class='red'>Étape</td><td class='red'>Statut</td><td class='red'>Date&nbsp;debut&nbsp;&nbsp;</td><td class='red'>Date&nbsp;fin&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>";
				fwrite($fh, $strdata);
			}
			$strdata = "<tr><td>" .$row['id']. "</td><td>" .$row['activity']. "</td><td>" .$row['status']. "</td><td>" .$row['code']. "</td><td>" .$row['idusr']. "</td><td>" .$row['nameusr']. "</td><td>" .$row['idparti']. "</td><td>" .$row['nameparti']. "</td><td>" .$row['ptype']. "</td><td>" .$row['pxgroup']. "</td><td>" .$row['pphase']. "</td><td>" .$row['pstep']. "</td><td>" .$row['pstatus']. "</td><td>" .$row['dstart']. "</td><td>" .$row['dend']. "</td></tr>";
			fwrite($fh, $strdata);
			$i = $i + 1;
			if ($i == 20)
			{
				$i = 0;
				$strdata = "</table><div class='page-break'></div>";
				fwrite($fh, $strdata);
			}
		}
		if ($i != 0) { $strdata = "</table></body></html>"; } else { $strdata = "</body></html>"; }
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function htmact2($res, $fi, $ti, $ua)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>Liste des activités</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ width:100%; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:12px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .red {color:#ff0000; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'>";
		fwrite($fh, $strdata);
		$i = 0;
		$idu = "";
		$tota = 0;
		$totb = 0;
		while ($row = mysql_fetch_array($res))
		{
			if ($idu != $row['idusr'])
			{
				if ($i != 0)
				{
					$strdata = "<tr><td colspan='4' align='right'><b>Total</b></td><td align='right'><b>" . $tota. "</b></td><td align='right'><b>$ " . number_format($totb,2) . "</b></td><td></td></tr>";		//total here
					fwrite($fh, $strdata);
					$tota = 0;
					$totb = 0;
					$strdata = "</table><div class='red'><br/>Signature du superviseur:________________________________<br/><br/><br/></div><div class='page-break'></div>";
					fwrite($fh, $strdata);
				}
				if ($i == 0)
				{
					$strdata = "<div class='title'> " .$ti. "</div><br/><br/>";
					fwrite($fh, $strdata);
				}
				$i += 1;
				for ($j = 0; $j < count($ua); $j += 1)
				{
					if ($ua[$j][0] == $row['idusr'])
					{
						$strdata = "<div class='title'> " .$ua[$j][2]. "&nbsp;&nbsp;&nbsp;&nbsp;ID : " .$ua[$j][0]. "&nbsp;&nbsp;&nbsp;&nbsp;N° employé : " .$ua[$j][1]. "</div>";
						fwrite($fh, $strdata);
						break;
					}
				}
				//$strdata = "<br/><br/><table><tr><td class='red'>#</td><td class='red'>Activité</td><td class='red'>ID Resp.</td><td class='red'>Nom&nbsp;responsable</td><td class='red'>ID&nbsp;Parti.</td><td class='red'>Coho.</td><td class='red'>Temps</td><td class='red'>Étape</td><td class='red'>Statut</td><td class='red'>Date&nbsp;activ.</td><td class='red'>Km.</td><td class='red'>Coût</td><td class='red'>Payé&nbsp;le</td><td class='red'>Hrs.</td><td class='red'>Coût</td><td class='red'>Payé&nbsp;le</td></tr>";
				//$strdata = "<br/><table><tr><td class='red'>#</td><td class='red'>N° employé</td><td class='red'>Nom&nbsp;responsable</td><td class='red'>ID&nbsp;Parti.</td><td class='red'>Temps</td><td class='red'>Date&nbsp;activ.</td><td class='red' align='right'>Km.</td><td class='red' align='right'>Coût Km.</td><td class='red'>Payé&nbsp;le</td></tr>";
				$strdata = "<br/><table><tr><td class='red'>#</td><td class='red'>ID&nbsp;Parti.</td><td class='red'>Temps</td><td class='red'>Date&nbsp;activ.</td><td class='red' align='right'>Km.</td><td class='red' align='right'>Coût Km.</td><td class='red'>Payé&nbsp;le</td></tr>";
				fwrite($fh, $strdata);
			}
			//$strdata = "<tr><td>" .$row['id']. "</td><td><b>" .$row['cust6']. "</b></td><td><b>" .$row['nameusr']. "</b></td><td>" .$row['idparti']. "</td><td>" .$row['pphase']. "</td><td>" .$row['dend']. "</td><td align='right'><b>" .$row['cust0']. "</b></td><td align='right'><b>$ " .number_format($row['cust1'],2). "</b></td><td>" .$row['cust2']. "</td></tr>";
			$strdata = "<tr><td>" .$row['id']. "</td><td>" .$row['idparti']. "</td><td>" .$row['pphase']. "</td><td>" .$row['dend']. "</td><td align='right'><b>" .$row['cust0']. "</b></td><td align='right'><b>$ " .number_format($row['cust1'],2). "</b></td><td>" .$row['cust2']. "</td></tr>";
			fwrite($fh, $strdata);
			$idu = $row['idusr'];
			$tota += $row['cust0'];
			$totb += $row['cust1'];
		}
		$strdata = "<tr><td colspan='4' align='right'><b>Total</b></td><td align='right'><b>" . $tota. "</b></td><td align='right'><b>$ " . number_format($totb,2) . "</b></td><td></td></tr>";		//total here
		fwrite($fh, $strdata);
		$strdata = "</table><div class='red'><br/>Signature du superviseur:________________________________<br/><br/><br/></div>";
		fwrite($fh, $strdata);
		//if ($i != 0) { $strdata = "</table></body></html>"; } else { $strdata = "</body></html>"; }
		$strdata = "</body></html>";
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	function htmact3($res, $fi, $ti, $ua)
	{
		$fh = fopen($fi, 'w');	 //or die("can't open file");
		$strdata = "<html><head><title>Liste des activités</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><style>@media all{.page-break { display:none; }} @media print{ .page-break { display:block; page-break-before:always; }} table{ width:100%; border-style:solid; border-width:1px; border-color:#ff0000; font-family:arial,sans-serif; font-size:12px; color:#606060; border-spacing:0px; border-collapse:collapse; }  td{ border-style:solid; border-width:0px 0px 1px 0px; border-color:#ff0000; padding:1px 8px 1px 8px; } .red {color:#ff0000; } .title{ font-weight:bold; padding:0px 0px 4px 6px; margin:0px}</style></head> <body style='margin:8px; font-family:arial,sans-serif; font-size:16px; color:#606060;'>";
		fwrite($fh, $strdata);
		$i = 0;
		$idu = "";
		$tota = 0;
		$totb = 0;
		while ($row = mysql_fetch_array($res))
		{
			if ($idu != $row['idusr'])
			{
				if ($i != 0)
				{
					//$strdata = "<tr><td colspan='6' align='right'><b>Total</b></td><td align='right'><b>" . number_format($tota,2) . "</b></td><td></td></tr>";		//total here
					$strdata = "<tr><td colspan='4' align='right'><b>Total</b></td><td align='right'><b>" . number_format($tota,2) . "</b></td><td></td></tr>";		//total here
					fwrite($fh, $strdata);
					$tota = 0;
					$totb = 0;
					$strdata = "</table><div class='red'><br/>Signature du superviseur:________________________________<br/><br/><br/></div><div class='page-break'></div>";
					fwrite($fh, $strdata);
				}
				if ($i == 0)
				{
					$strdata = "<div class='title'> " .$ti. "</div><br/><br/>";
					fwrite($fh, $strdata);
				}
				$i += 1;
				for ($j = 0; $j < count($ua); $j += 1)
				{
					if ($ua[$j][0] == $row['idusr'])
					{
						$strdata = "<div class='title'> " .$ua[$j][2]. "&nbsp;&nbsp;&nbsp;&nbsp;ID : " .$ua[$j][0]. "&nbsp;&nbsp;&nbsp;&nbsp;N° employé : " .$ua[$j][1]. "</div>";
						fwrite($fh, $strdata);
						break;
					}
				}
				//$i += 1;
				//$strdata = "<div class='title'> " .$ti. "</div>";
				//fwrite($fh, $strdata);
				//$strdata = "<br/><table><tr><td class='red'>#</td><td class='red'>N° employé</td><td class='red'>Nom&nbsp;responsable</td><td class='red'>ID&nbsp;Parti.</td><td class='red'>Temps</td><td class='red'>Date&nbsp;activ.</td><td class='red' align='right'>Temps</td><td class='red'>Payé&nbsp;le</td></tr>";
				$strdata = "<br/><table><tr><td class='red'>#</td><td class='red'>ID&nbsp;Parti.</td><td class='red'>Temps</td><td class='red'>Date&nbsp;activ.</td><td class='red' align='right'>Temps</td><td class='red'>Payé&nbsp;le</td></tr>";
				fwrite($fh, $strdata);
			}
			//$strdata = "<tr><td>" .$row['id']. "</td><td><b>" .$row['cust6']. "</b></td><td><b>" .$row['nameusr']. "</b></td><td>" .$row['idparti']. "</td><td>" .$row['pphase']. "</td><td>" .$row['dend']. "</td><td align='right'><b>" .number_format($row['cust3'],2). "</b></td><td>" .$row['cust5']. "</td></tr>";
			$strdata = "<tr><td>" .$row['id']. "</td><td>" .$row['idparti']. "</td><td>" .$row['pphase']. "</td><td>" .$row['dend']. "</td><td align='right'><b>" .number_format($row['cust3'],2). "</b></td><td>" .$row['cust5']. "</td></tr>";
			fwrite($fh, $strdata);
			$idu = $row['idusr'];
			$tota += $row['cust3'];
			$totb += $row['cust4'];
		}
		//$strdata = "<tr><td colspan='6' align='right'><b>Total</b></td><td align='right'><b>" . number_format($tota,2) . "</b></td><td></td></tr>";		//total here
		$strdata = "<tr><td colspan='4' align='right'><b>Total</b></td><td align='right'><b>" . number_format($tota,2) . "</b></td><td></td></tr>";		//total here
		fwrite($fh, $strdata);
		$strdata = "</table><div class='red'><br/>Signature du superviseur:________________________________<br/><br/><br/></div>";
		fwrite($fh, $strdata);
		$strdata = "</body></html>";
		fwrite($fh, $strdata);
		fclose($fh);
	}
	
	
	//---------------------------------------------------------------------------------assets
	
	
	function fn302($par)		//load assets list (filtered)
	{
		global $userstbl;
		$retv = "-er-sql-";
		$whr = "";
		$trows = 0;
		
		if ($par[3] != "") { $whr = filterasset($par[3]); }
		if ($par[4] != "") { $srt = $par[4] . " " . $par[5]; } else { $srt = "id"; }
		$querySQL = "select count(*) from assets " .$whr;
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			while ($row = mysql_fetch_array($result))
			{
				$trows = $row['count(*)'];
			}
		}
		$querySQL = "select id, type, sku, device, status, idu, idusr, assgeta, assgdelvon, sereta from assets " .$whr. " order by " .$srt. " limit " .$par[1]. ", " . $par[2];
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn302-" . $trows;
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. "|" .$row['id']. "¦" .$row['type']. "¦" .$row['sku']. "¦" .$row['device']. "¦" .$row['status']. "¦" .$row['assgdelvon']. "¦" .$row['assgeta']. "¦" .$row['idu']. "¦" .$row['idusr']. "¦" .$row['sereta'];
			}
		}
		else
		{
			$retv = "-er-fn302-";
		}
		return $retv;	
	}

	function filterasset($par)
	{
		global $userstbl;
		$wr = "";
		
		$flt = explode("·", $par);
		$var = array("status='INV'", "status='APA'", "status='LPA'", "status='SER'", "status='PVO'", "status='REB'", "(assgeta >= '".$flt[6]."' or sereta >= '".$flt[6]."')", "(assgeta <= '".$flt[7]."' or sereta <= '".$flt[7]."')", "(type='".$flt[8]."' or status='".$flt[8]."' or idusr='".$flt[8]."' or nameusr like '%".$flt[8]."%')");
		$exp = NULL;
		for ($i = 0; $i <= 5; $i += 1)		//type
		{
			if ($flt[$i] != 0) { $exp[] = $var[$i]; }
		}
		if (count($exp) > 0) { $wr[] = "(" . implode(" or ", $exp) . ")"; }
		$exp = NULL;
		$i = 6;		//eta
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 7;		//eta
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		$exp = NULL;
		$i = 8;		//quick find
		{
			if ($flt[$i] != "---" && $flt[$i] != "") { $wr[] = $var[$i]; }
		}
		$wr = "where " . implode(" and ", $wr);
		return $wr;
	}
	
	function fn303($par)		//load asset record (based on id)
	{
		//id, type, sku, serial, device, status, idu, idusr, nameusr, assgstart, assgend, assgeta, assgdelvon, assgdelvmode, reton, retmode, serreason, seron, serby, sereta, serdelvmode, sercount, repon, repdelvmode, discon, discreason, loston, lostrepby, lostrepto, puron, purcost
		global $userstbl;
		$retv = "-er-sql-";
		
		$querySQL = "select * from assets where id='" .$par[1]. "'";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn303-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. $row['id']. "¦" .$row['type']."¦" .$row['sku']."¦" .$row['serial']. "¦" .$row['device']. "¦"  .$row['status']. "¦" .$row['idu']. "¦"  .$row['idusr']. "¦"  .$row['nameusr']. "¦" .$row['assgstart']. "¦" .$row['assgend']. "¦" .$row['assgeta']. "¦" .$row['assgdelvon']. "¦" .$row['assgdelvmode']. "¦" .$row['reton']. "¦" .$row['retmode']. "¦" .$row['serreason']. "¦" .$row['seron']. "¦" .$row['serby']. "¦" .$row['sereta']. "¦" .$row['serdelvmode']. "¦" .$row['sercount']. "¦" .$row['repon']. "¦" .$row['repdelvmode']. "¦" .$row['discon']. "¦" .$row['discreason']. "¦" .$row['loston']. "¦" .$row['lostrepby']. "¦" .$row['lostrepto']. "¦" .$row['puron']. "¦" .$row['purcost'];
			}
		}
		else
		{
			$retv = "-er-fn303-" . mysql_error();
		}
		return $retv;	
	}

	function fn304($par)		//save asset record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$id = $par[1];
		$querySQL = "type='" .$par[2]. "', sku='" .$par[3]. "', serial='" .$par[4]. "', device='" .$par[5]. "', status='" .$par[6]. "', idu='" .$par[7]. "', idusr='" .$par[8]. "', nameusr='" .$par[9]. "', assgstart='" .$par[10]. "', assgend='" .$par[11]. "', assgeta='" .$par[12]. "', assgdelvon='" .$par[13]. "', assgdelvmode='" .$par[14]. "', reton='" .$par[15]. "', retmode='" .$par[16]. "', serreason='" .$par[17]. "', seron='" .$par[18]. "', serby='" .$par[19]. "', sereta='" .$par[20]. "', serdelvmode='" .$par[21]. "', sercount='" .$par[22]. "', repon='" .$par[23]. "', repdelvmode='" .$par[24]. "', discon='" .$par[25]. "', discreason='" .$par[26]. "', loston='" .$par[27]. "', lostrepby='" .$par[28]. "', lostrepto='" .$par[29]. "', puron='" .$par[30]. "', purcost='" .$par[31]. "'";
		if ($id == "")			//insert
		{
			$querySQL = "insert into assets set id='NULL', " . $querySQL;
		}
		else
		{
			$querySQL = "update assets set " . $querySQL .  "where id = '" .$id. "'";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn304-" . $id;
		}
		else
		{
			$retv = "-er-fn304-";
		}
		return $retv;	
	}
	
	function fn305($par)		//delete activity record (based on id)
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$id = $par[1];
		if ($id != 0 && $id != "")
		{
			$querySQL = "delete from assets where id = '" .$id. "'";
			$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
			if($result)
			{
				$retv = "-ok-fn305-" . $id;
			}
			else
			{
				$retv = "-er-fn305-" . mysql_error();
			}
		}
		return $retv;	
	}
	
	
	//---------------------------------------------------------------------------------questionnaire
	

	function fn401($par)			//save answers
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$td = mktime(0,0,0,date('m'),date('d'),date('Y'));
		$trows = 0;
		$querySQL = "select count(*) from answer where idq ='" .$par[1]. "' and idu ='" .$par[2]. "'"; 
		$resulth = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($resulth)
		{
			while ($row = mysql_fetch_array($resulth))
			{
				$trows = $row['count(*)'];
			}
		}
		if ($trows == 0)
		{
			$querySQL = "insert into answer set id='NULL', idq='" .$par[1]. "', idu='" .$par[2]. "', idusr='" .$par[3]. "', answ='" .$par[4]. "', nav='" .$par[5]. "', dateedit='" .date("Y-m-d", $td). "'";
		}
		else
		{
			$querySQL = "update answer set idusr='" .$par[3]. "', answ='" .$par[4]. "', nav='" .$par[5]. "', dateedit='" .date("Y-m-d", $td). "' where idq='" .$par[1]. "' and idu='" .$par[2]. "'";
		}
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn401-";
		}
		else
		{
			$retv = "-er-fn401-";
		}
		return $retv;
	}
	
	function fn402($par)			//load answers questionnaire
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$querySQL = "select answ, nav from answer where idq ='" .$par[1]. "' and idu ='" .$par[2]. "'"; 
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn402-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. $row['answ']. "¦" .$row['nav'];
			}
		}
		else
		{
			$retv = "-er-fn402-";		// . $querySQL;
		}
		return $retv;
	}
	
	function fn403($par)			//load answers response window
	{
		global $userstbl;
		$retv = "-er-sql-";
		
		$querySQL = "select answ, nav from answer where idq ='" .$par[1]. "' and idu ='" .$par[2]. "'"; 
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		if($result)
		{
			$retv = "-ok-fn403-";
			while ($row = mysql_fetch_array($result))
			{
				$retv = $retv. $row['answ']. "¦" .$row['nav'];
			}
		}
		else
		{
			$retv = "-er-fn403-";		// . $querySQL;
		}
		return $retv;
	}
	
	
	
	function fn500($par)			//write file to disc
	{
	
	}
	

	function backupactions()
	{
		$querySQL = "delete from activityx";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		$querySQL = "insert into activityx select * from activity";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
	}
	
	function backupusers()
	{
		$querySQL = "delete from usersx";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
		$querySQL = "insert into usersx select * from users";
		$result = @mysql_query($querySQL);		// or die ("-er-sql-" . mysql_error());
	}
	
	function test($tbl)
	{
		$result = mysql_query("SHOW COLUMNS FROM " . $tbl);
		//$count = 0;
		while ($row = mysql_fetch_row($result))
		{
			//$cnt = 0;
			foreach ($row as $item)
			{
				//if ($cnt == 0)
				//{
					$cnames[$count] = $item;
					//$cnt++;
					$count++;
				//}
			}
		}
		foreach($cnames as $c)
		{
			echo $c.",";
		}
	}
	
	function duprec ($table, $id)
	{
		$result = mysql_query("insert into " .$table. " (foo, bar, boo, far) select foo, bar, boo, far from " .$table. " where id = '" .$id. "'");
	}
	
	
	$userstbl = "users";		//usersgpmt, users, ...
	$retvar = "-er-post-";
	$pvarx = "";
	if(isset($_POST['pvar'])){$pvarx = $_POST['pvar'];}elseif(isset($_GET['pvar'])){$pvarx = $_GET['pvar'];}
	if($pvarx != "")
	{
		
		$database = "zepsom_zeps";
		$username="root";
		$password = "tr3ks0ft";
		
		@mysql_connect($localhost, $username);
		@mysql_query("SET NAMES 'utf8'");
		@mysql_select_db($database);
		
	 	$pvarx = stripslashes(rep_chars("'", "\'", $pvarx));
		$pvarx = explode("¦", $pvarx); 			//$pvarx[0] = function
		
		if ($pvarx[0] == "fn100")				//login
		{
			$retvar = fn100($pvarx);
		}
		elseif ($pvarx[0] == "fn101")			//load quest
		{
			$retvar = fn101($pvarx);
		}
		elseif ($pvarx[0] == "fn102")			//load user list
		{
			$retvar = fn102($pvarx);
		}
		elseif ($pvarx[0] == "fn103")			//load user record
		{
			$retvar = fn103($pvarx);
		}
		elseif ($pvarx[0] == "fn104")			//insert / update user record
		{
			$retvar = fn104($pvarx);
		}
		elseif ($pvarx[0] == "fn105")			//delete user record
		{
			$retvar = fn105($pvarx);
		}
		elseif ($pvarx[0] == "fn110")			//select user by name, id, phone
		{
			$retvar = fn110($pvarx);
		}
		elseif ($pvarx[0] == "fn111")			//related resps. from activities
		{
			$retvar = fn111($pvarx);
		}
		elseif ($pvarx[0] == "fn112")			//return max user id
		{
			$retvar = fn112($pvarx);
		}
		elseif ($pvarx[0] == "fn120")			//actions user - filter (assign to resp, tasks)
		{
			$retvar = fn120($pvarx);
		}
		elseif ($pvarx[0] == "fn121")			//actions user - selection (assign to resp, tasks)
		{
			$retvar = fn121($pvarx);
		}
		elseif ($pvarx[0] == "fn122")			//update user from activity
		{
			$retvar = fn122($pvarx);
		}
		elseif ($pvarx[0] == "fn123")			//update user from questionnaire
		{
			$retvar = fn123($pvarx);
		}
		elseif ($pvarx[0] == "fn130")			//load last interview activity for user record edit by interviewers (based on id)
		{
			$retvar = fn130($pvarx);
		}
		elseif ($pvarx[0] == "fn131")			//save last interview activity  + user changes for user record edit by interviewers
		{
			$retvar = fn131($pvarx);
		}
		elseif ($pvarx[0] == "fn150")			//user list to csv from filtered
		{
			$retvar = fn150($pvarx);
		}
		elseif ($pvarx[0] == "fn151")			//user list to csv from selection
		{
			$retvar = fn151($pvarx);
		}
		elseif ($pvarx[0] == "fn160")			//user list to html from filtered
		{
			$retvar = fn160($pvarx);
		}
		elseif ($pvarx[0] == "fn161")			//user list to html from selection
		{
			$retvar = fn161($pvarx);
		}
		elseif ($pvarx[0] == "fn170")			//list addresses
		{
			$retvar = fn170($pvarx);
		}
		elseif ($pvarx[0] == "fn171")			//export addresses to csv
		{
			$retvar = fn171($pvarx);
		}
		elseif ($pvarx[0] == "fn175")			//reassign interviewer
		{
			$retvar = fn175($pvarx);
		}
		elseif ($pvarx[0] == "fn177")			//recruitment plannng html
		{
			$retvar = fn177($pvarx);
		}
		elseif ($pvarx[0] == "fn180")			//save addresses visited
		{
			$retvar = fn180($pvarx);
		}
		elseif ($pvarx[0] == "fn181")			//get addresses visited record
		{
			$retvar = fn181($pvarx);
		}
		elseif ($pvarx[0] == "fn182")			//load mail address
		{
			$retvar = fn182($pvarx);
		}
		elseif ($pvarx[0] == "fn183")			//save mail address
		{
			$retvar = fn183($pvarx);
		}
		elseif ($pvarx[0] == "fn202")			//load activty list
		{
			$retvar = fn202($pvarx);
		}
		elseif ($pvarx[0] == "fn203")			//load activity record
		{
			$retvar = fn203($pvarx);
		}
		elseif ($pvarx[0] == "fn204")			//insert / update activity record
		{
			$retvar = fn204($pvarx);
		}
		elseif ($pvarx[0] == "fn205")			//delete activity record
		{
			$retvar = fn205($pvarx);
		}
		elseif ($pvarx[0] == "fn250")			//activity list to csv from filtered
		{
			$retvar = fn250($pvarx);
		}
		elseif ($pvarx[0] == "fn251")			//activity list to csv from selected
		{
			$retvar = fn251($pvarx);
		}
		elseif ($pvarx[0] == "fn260")			//activity list to html from filtered
		{
			$retvar = fn260($pvarx);
		}
		elseif ($pvarx[0] == "fn261")			//activity list to html from selected
		{
			$retvar = fn261($pvarx);
		}
		elseif ($pvarx[0] == "fn302")			//load assets list
		{
			$retvar = fn302($pvarx);
		}
		elseif ($pvarx[0] == "fn303")			//load activity record
		{
			$retvar = fn303($pvarx);
		}
		elseif ($pvarx[0] == "fn304")			//insert / update activity record
		{
			$retvar = fn304($pvarx);
		}
		elseif ($pvarx[0] == "fn305")			//delete activity record
		{
			$retvar = fn305($pvarx);
		}
		elseif ($pvarx[0] == "fn401")			//save answers
		{
			$retvar = fn401($pvarx);
		}
		elseif ($pvarx[0] == "fn402")			//load answers
		{
			$retvar = fn402($pvarx);
		}
		elseif ($pvarx[0] == "fn403")			//load answers
		{
			$retvar = fn403($pvarx);
		}
		
		@mysql_close();
	}
	echo $retvar;
?>
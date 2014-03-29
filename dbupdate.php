<?php header("Content-type: text/html; charset=utf-8");
set_time_limit(0);

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

function get_date_time( $date_or_time )
{
	if ($date_or_time == 'D') {
		return date("Y-m-d");
	}
		
	$localtime = localtime();
	$hour = $localtime[2];
	$min = $localtime[1];
	$timeStr = ( $hour < 10 ? '0' : '' ).$hour.":".($min < 10 ? '0' : '').$min;
	return $timeStr;
}

function update_coh1_dates()
{
  global $userstbl;
  global $addrstbl;
  
  /*$tmpTableName = 't1';
	$querySQL0 = "create temporary table ".$tmpTableName." as (select freshaddress.* from (select ".$addrstbl.".id as addrid, ma.idusr, ".$addrstbl.".address, ma.latestdate from ( select idusr, max(date) as latestdate from ".$addrstbl." group by idusr ) as ma join ".$addrstbl." on ma.idusr = ".$addrstbl.".idusr and ".$addrstbl.".date = ma.latestdate ) as freshaddress join ".$userstbl." on freshaddress.idusr = ".$userstbl.".idusr where ".$userstbl.".xgroup = 'C-01')";
	$result0 = @mysql_query($querySQL0 );
	if (!$result0) {
		echo "Sorry";
		return;
	}*/
			
	$data = file_get_contents("adresses_zepsom_t01-t02-t03.csv");
	$updateDate = $currDate = get_date_time('D');
	$lines = explode("\n", $data);
  $coh1count = 0;
  $coh2count = 0;
  $notfound = array();
  $num_users_updated = 0;
  $num_addrs_updated = 0;
  //$maxlines = 20;
  $prevLines = array();
  $lastId = "";
  $maxDate = "";
  
  echo count($lines)." lines<br>";
	for ($i = 2; $i <= count($lines) and (isset($maxlines) ? $i <= $maxlines+1 : true ); $i++) {
		$line = $lines[$i-1];
		if (strlen($line) > 0) {
			$tokens = explode(";", $line);
			$idusr = trim($tokens[0]);
			$querySQL = "select idusr, xgroup from ".$userstbl." where idusr = '".$idusr."'";
			$result = @mysql_query($querySQL );
			if ( $result and mysql_num_rows($result) == 1 ) {
        $row = mysql_fetch_array($result);
        if ( $row['xgroup'] == 'C-01' ) {
          $coh1count++;
          //$phase = trim($tokens[1]);
          //$addr = mysql_real_escape_string(trim($tokens[2]));
          //$ville = mysql_real_escape_string(trim($tokens[3]));
          //$codep = trim($tokens[4]);
          $date = trim($tokens[5]);
          
          if ( $idusr != $lastId ) {
            if ( count($prevLines) > 0 ) {
              process($i-1, $lastId, $maxDate, $prevLines);
              unset($prevLines);
              $prevLines = array();
            }
            $lastId = $idusr;
            $maxDate = "";
          }
          
          array_push($prevLines, $tokens );
          if ( $date > $maxDate ) {
            $maxDate = $date;
          }
          
          if ( $i == count($lines)-1 || (isset($maxlines) && $i == $maxlines+1 )) {
            process($i, $lastId, $maxDate, $prevLines);
          }        
          
          $querySQL1 = "select haddress, hcity, hpostal, hdate, dateedit from ".$userstbl." where idusr = '".$idusr."'";
          $result1 = @mysql_query($querySQL1 );
          $row = mysql_fetch_array($result1);
          /*
          $updateUserSQL = "update ".$userstbl." set hdate = '".$date."', dateedit = '".$updateDate."'";
          $updateAddr = false;
          $updateCity = false;
          $updatePostcode = false;
          if ( trim($addr) != "" && ( trim($row['haddress']) == "" or strpos(strtolower($row['haddress']), "nconn") !== false ) ) {
            $updateAddr = true;
            $updateUserSQL .= ", haddress = '".$addr."'";
            if ( trim($ville) != "" and ( trim($row['hcity']) == "" or strpos(strtolower($row['hcity']), "nconn" ) !== false or strpos(strtolower($row['hcity']), "hors") !== false ) ) {
              $updateCity = true;
              $updateUserSQL .= ", hcity = '".$ville."'";
            }
            if ( trim($codep) != "" and ( trim($row['hpostal']) == "" or strpos(strtolower($row['hpostal']), "nconn") !== false ) ) {
              $updatePostcode = true;
              $updateUserSQL .= ", hpostal = '".$codep."'";
            }
          }
          $updateUserSQL .= " where idusr = '".$idusr."' and hdate = '".$row['hdate']."' and haddress='".mysql_real_escape_string($row['haddress'])."' and hcity = '".mysql_real_escape_string($row['hcity'])."'";
          echo $i.": ".$updateUserSQL."<br/>";
          $resultUpdateUser = @mysql_query($updateUserSQL );
          if ( $resultUpdateUser ) {
            $num_users_updated += mysql_affected_rows();
          }
          else {
            echo "Problem updating user ".$idusr."!<br>";
          }
          
          $querySQL2 = "select * from ".$tmpTableName." where idusr = '".$idusr."'";
          $result2 = @mysql_query($querySQL2 );
          if ( $result2 ) {
            $row = mysql_fetch_array($result2);
            $updateAddrSQL = "update ".$addrstbl." set date = '".$date."', dateedit = '".$updateDate."'";
            if ( $updateAddr ) {
              $updateAddrSQL .= ", address = '".$addr."'";
              if ( $updateCity ) {
                $updateAddrSQL .= ", city = '".$ville."'";
              }
              if ( $updatePostcode ) {
                $updateAddrSQL .= ", postal = '".$codep."'";
              }
            }
            $updateAddrSQL .= " where idusr = '".$idusr."' and id = '".$row['addrid']."' and address = '".mysql_real_escape_string($row['address'])."' and date = '".$row['latestdate']."'";
            echo $updateAddrSQL."<br/>";
            $resultUpdateAddr = @mysql_query($updateAddrSQL );
            if ( $resultUpdateAddr ) {
              $num_addrs_updated += mysql_affected_rows();
            }
            else {
              echo "Problem updating addr ".$idusr."!<br>";
            }
          }
          */
        }
        else if ( $row['xgroup'] == 'C-02' ) {
          $coh2count++;
        }
        else {
          echo "?? ".$row['xgroup']."<br>";
        }
			}
      else {
        array_push($notfound, $idusr);
      }
		}
	}
  echo "C-01: ".$coh1count."<br>C-02: ".$coh2count."<br>Not found: ".implode(", ", $notfound)."<br>";
  echo "Users updated: ".$num_users_updated."<br>Addresses updated: ".$num_addrs_updated;
}

function squote($str)
{
  return "'".$str."'";
}

function process($line_no, $id, $mostRecentDate, $entries)
{
  global $userstbl;
  global $addrstbl;
  
  $getUserIdSQL = "select id from ".$userstbl." where idusr = ".squote($id);
  $resultIdu = @mysql_query( $getUserIdSQL );
  $idu = '';
  if ( $resultIdu && mysql_num_rows($resultIdu) == 1 ) {
    $row = mysql_fetch_array($resultIdu);
    $idu = squote($row['id']);
  }
  else die ("Merde" . mysql_error());
  
  $delAddrsSQL = "delete from ".$addrstbl." where idusr = '".$id."'";
  $insAddrsSQL = "insert into ".$addrstbl." (idusr, idu, postal, address, city, date, dateedit, zone1, zone2, zone3) values ";
  $dateedit = squote(get_date_time('D'));
  $emptyFlag = "===";
  $blank = squote($emptyFlag);
  $updateUserSQL = "update ".$userstbl." u left join pczone p on p.pc = ";
  $updateAddrZonesSQL = "update ".$addrstbl." a left join pczone p on a.postal = p.pc set a.zone1 = p.zone1, a.zone2=p.zone2, a.zone3 = p.zone3 where a.zone1 = ".$blank;
  $valuesStrs = array();
  for ($x = 0; $x < count($entries); $x++ ) {
    $idusr = squote(trim($entries[$x][0]));
    $postal = squote(trim($entries[$x][4]));
    $address = squote(trim(mysql_real_escape_string($entries[$x][2])));
    $city = squote(trim(mysql_real_escape_string($entries[$x][3])));
    $date = trim($entries[$x][5]);
    
    $values = array($idusr,
                    $idu,
                    $postal,
                    $address,
                    $city,
                    squote($date),
                    $dateedit,
                    $blank,
                    $blank,
                    $blank);
    array_push($valuesStrs, "(".implode(", ", $values).")");
    if ( $date == $mostRecentDate ) {
      $updateUserSQL .= $postal." set ".implode(", ", array("haddress=".$address, "hcity=".$city, "hpostal=".$postal, "hdate=".squote($date), "dateedit=".$dateedit, "u.hzone1=p.zone1", "u.hzone2=p.zone2", "u.hzone3=p.zone3" ) )." where idusr=".$idusr;
    }
  }
  $insAddrsSQL .= implode(", ", $valuesStrs);
  
  $num_rows_aff = 0;
  
  echo $line_no.": ".$updateUserSQL."...";
  $resultUpd = @mysql_query($updateUserSQL );
  if ( $resultUpd ) {
    $num_rows_aff = mysql_affected_rows();
    echo "Updated ".$num_rows_aff." user(s)";
  }
  else die ("Merde" . mysql_error());
  
  echo "<br>".$delAddrsSQL."...";
  $resultDel = @mysql_query($delAddrsSQL );
  if ( $resultDel ) {
    $num_rows_aff = mysql_affected_rows();
    echo "Deleted ".$num_rows_aff." address(es)";
  }
  else die ("Merde" . mysql_error());
  
  echo "<br>".$insAddrsSQL."...";
  $resultIns = @mysql_query($insAddrsSQL );
  if ( $resultIns ) {
    $num_rows_aff = mysql_affected_rows();
    echo "Added ".$num_rows_aff." address(es)";
  }
  else die ("Merde" . mysql_error());
  
  echo "<br>".$updateAddrZonesSQL."...";
  $resultUpd = @mysql_query($updateAddrZonesSQL );
  if ( $resultUpd ) {
    $num_rows_aff = mysql_affected_rows();
    echo "Updated ".$num_rows_aff." address zones";
  }
  else die ("Merde" . mysql_error());
  
  echo "<br>-------------------------------<br>";
}

	$debug_on = file_exists('.mode_test');
	$userstbl = "users";
  $addrstbl = "address";
  
	$retvar = "-er-post-";
	$pvarx = "";
	if(isset($_POST['pvar'])){$pvarx = $_POST['pvar'];}elseif(isset($_GET['pvar'])){$pvarx = $_GET['pvar'];}
	if($pvarx != "")
	{
		$database = "zepsom_zeps";
		$username="root";
		$password = "tr3ks0ft";
    $usernameServer ="zepsom_trksft";
		$passwordServer = "tr3ks0ft";
    $running_on_server = ( strpos( __FILE__, "public_html" ) > 0 );
    echo "On server? ".($running_on_server ? "YES" : "NO")."<br>";
		if ( $running_on_server ) {
       @mysql_connect($localhost, $usernameServer, $passwordServer);
    }
    else {
      @mysql_connect($localhost, $username);
    }
		@mysql_query("SET NAMES 'utf8'");
		@mysql_select_db($database);
		
	 	$pvarx = stripslashes(rep_chars("'", "\'", $pvarx));
		$pvarx = explode("¦", $pvarx); 			//$pvarx[0] = function
		
    if ($pvarx[0] == "up_c1_dates")
		{
      update_coh1_dates();
		}
    else {
      echo "Rien n'a été fait<br>";
    }
		
		@mysql_close();
	}
	else {
    echo "Aucun paramètre n'a été fourni<br>";
  }
?>
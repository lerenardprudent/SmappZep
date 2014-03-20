/*
var myfunc:String = "functionFromVariable";
function functionFromVariable() : void
{
     trace("I was ran from a string");
}
this[myfunc]();
*/


private function actkeydown(ob, k):void
{
	var v, v1;
	var obn = ob.name;
	if (k == 13)
	{
		switch(obn)
		{
			case "OBJ_INP_19":		//login
			case "OBJ_INP_20":
				dbloginuser(getobj(_wins[6], "INP", 19).xval, getobj(_wins[6], "INP", 20).xval);
				break;			
			case "OBJ_INP_83":		//find users
				dbfindrec("USR", getobj(_wins[9], "INP", 83).xval);
				dbloadlist("USR", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0]);
				break;
			case "OBJ_INP_291":		//find activity
				dbfindrec("ACT", getobj(_wins[13], "INP", 291).xval);
				dbloadlist("ACT", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1]);
				break;
			case "OBJ_INP_206":		//find asset
				dbfindrec("ASS", getobj(_wins[11], "INP", 206).xval);
				dbloadlist("ASS", _dbpage[2], _dbpagelen[2], _dbflt[2], _dbsort[2], _dbsortdir[2]);
				break;
				
			case "OBJ_INP_30":		//lookup quest. answers
				v = trim(getobj(_wins[8], "INP", 30).xval);
				//if ( isempty(v) ) { getobj(_wins[8], "INP", 29).xval = getobj(_wins[8], "INP", 31).xval = "";  return; }
				if ( isempty(v) ) { return; }
				_dblookuptg = [_wins[8], "QUEPAR"];
				_keepblock = true;
				pozwin(_wins[22], true, true, 0, 0, 1, 0)
				showwin(_wins[22], true, 1, 0);
				tofront(_wins[22]);
				dbloadlookup("USRLKP", v);
				break;
			case "OBJ_INP_228":		//lookup assets
				v = trim(getobj(_wins[12], "INP", 228).xval);
				//if ( isempty(v) ) { getobj(_wins[12], "INP", 227).xval = getobj(_wins[12], "INP", 229).xval = "";  return; }
				if ( isempty(v) ) { return; }
				_dblookuptg = [_wins[12], "ASSPAR"];
				pozwin(_wins[22], true, true, 0, 0, 1, 0)
				showwin(_wins[22], true, 1, 0);
				showblocker(true);
				dbloadlookup("USRLKP", v);
				break;
			case "OBJ_INP_312":		//lookup responsables activity
				v = trim(getobj(_wins[14], "INP", 312).xval);
				//if ( isempty(v) ) { getobj(_wins[14], "INP", 311).xval = getobj(_wins[14], "INP", 300).xval = "";  return; }
				if ( isempty(v) ) { return; }
				_dblookuptg = [_wins[14], "ACTRES"];
				pozwin(_wins[22], true, true, 0, 0, 1, 0)
				showwin(_wins[22], true, 1, 0);
				showblocker(true);
				dbloadlookup("USRLKP", v);
				break;
			case "OBJ_INP_328":		//lookup participants activity
				v = trim(getobj(_wins[14], "INP", 328).xval);
				//if ( isempty(v) ) { getobj(_wins[14], "INP", 327).xval = getobj(_wins[14], "INP", 301).xval = "";  return; }
				if ( isempty(v) ) {return; }
				_dblookuptg = [_wins[14], "ACTPAR"];
				pozwin(_wins[22], true, true, 0, 0, 1, 0)
				showwin(_wins[22], true, 1, 0);
				showblocker(true);
				dbloadlookup("USRLKP", v);
				break;
			case "OBJ_INP_420":		//lookup users filter
				v = trim(getobj(_wins[15], "INP", 420).xval);
				//if ( isempty(v) ) { getobj(_wins[15], "INP", 419).xval = getobj(_wins[15], "INP", 421).xval = "";  return; }
				if ( isempty(v) ) { return; }
				_dblookuptg = [_wins[15], "ACTRES"];
				pozwin(_wins[22], true, true, 0, 0, 1, 0)
				showwin(_wins[22], true, 1, 0);
				showblocker(true);
				dbloadlookup("USRLKP", v);
				break;
			case "OBJ_INP_520":		//lookup users filter
			case "OBJ_INP_525":		//lookup users filter
			case "OBJ_INP_540":		//lookup users filter
				if (obn == "OBJ_INP_520") { v = trim(getobj(_wins[19], "INP", 701).xval); v1 = 1; }
				else if (obn == "OBJ_INP_525") { v = trim(getobj(_wins[19], "INP", 706).xval); v1 = 2; }
				else if (obn == "OBJ_INP_540") { v = trim(getobj(_wins[19], "INP", 721).xval); v1 = 3; }
				if ( isempty(v) ) { return; }
				_dblookuptg = [_wins[19], "ACVRES" + v1];
				pozwin(_wins[22], true, true, 0, 0, 1, 0)
				showwin(_wins[22], true, 1, 0);
				showblocker(true);
				dbloadlookup("USRLKP", v);
				break;
			
			default:
				break;
		}
	}
}

private function objactionsclick(ob, ... parms):*			//object, object element (target)
{
	var win, obn, obi;
	win = ob.parent.parent;
	obn = ob.name.substr(4);
	obi = parseInt(obn.substr(4));
	if (obn.substr(0, 3) == "BTN")
	{
		if (obi < 1000) { obactbtn(ob, obn, win); } else { obactbtnq(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "IMG")
	{
		if (obi < 1000) { obactimg(ob, obn, win); } else { obactimgq(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "STP")
	{
		if (obi < 1000) { obactstp(ob, obn, win); } else { obactstpq(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "CAL")
	{
		if (obi < 1000) { obactcal(ob, obn, win); } else { obactcalq(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "TIM")
	{
		if (obi < 1000) { obacttim(ob, obn, win); } else { obacttimq(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "CHK")
	{
		if (obi < 1000) { obactchk(ob, obn, win); } else { obactchkq(ob, obn, win); }
	}
	else if (obn.substr(0, 3) == "RAD")
	{
		if (obi < 1000) { obactrad(ob, obn, win); } else { obactradq(ob, obn, win); }
	}
	return true;
}

private function obactstp(ob, obn, win):void
{
	var i, v, obtg;
	if (win == _wins[10])
	{
		if (obn == "STP_93") 
		{ 
			setfldsperms(win);
			if (removehtmltags(getobj(win, "BTN", 189).labtext) == "Ajouter") { clearTimeout(_timer); _timer = setTimeout(getnewuserid, 400, ob.xval); }		//on add new only
		}
	}
	else if (win == _wins[14])
	{
		if (obn == "STP_298")
		{
			v = getobj(win, "STP", 298).xval;
			if (isempty(v))
			{
				getobj(win, "STP", 303).xval = "";
				getobj(win, "STP", 304).xval = "";
				getobj(win, "STP", 305).xval = "";
			}
			else
			{
				if (v == "EVT")
				{
					getobj(win, "STP", 303).xval = "FIN";
				}
				else
				{
					getobj(win, "STP", 303).xval = "PLA";
				}
				getobj(win, "STP", 304).xval = "USR";
				getobj(win, "STP", 305).xval = "GEN";
			}
		}
		else if (obn == "STP_309")
		{
			v = getobj(win, "STP", 309).xval;
			if (v == "ASSIGNÉ RECRUTEUR")
			{			
				if (isempty(getobj(win, "INP", 310).xval)) {	getobj(win, "INP", 310).xval = "Résidence";	}
				getobj(win, "STP", 331).xval = "POT";				//type
				getobj(win, "STP", 333).xval = "REC";				//step
				getobj(win, "STP", 334).xval = "ACT";				//status
			}
			else if (v == "RECRUTEMENT")
			{			
				if (isempty(getobj(win, "INP", 310).xval)){	getobj(win, "INP", 310).xval = "Résidence";	}
				getobj(win, "STP", 331).xval = "PAR";				//type
				getobj(win, "STP", 333).xval = "REC";				//step
				getobj(win, "STP", 334).xval = "";				//status
			}
			else if (v == "ASSIGNÉ INTERVIEWER")
			{			
				if (isempty(getobj(win, "INP", 310).xval)){	getobj(win, "INP", 310).xval = "Résidence";	}
				getobj(win, "STP", 331).xval = "PAR";				//type
				getobj(win, "STP", 333).xval = "INT";				//step
				getobj(win, "STP", 334).xval = "ACT";				//status
			}
			else if (v == "INTERVIEW (QUESTIONNAIRE)")
			{			
				if (isempty(getobj(win, "INP", 310).xval)){	getobj(win, "INP", 310).xval = "Résidence";	}
				getobj(win, "STP", 331).xval = "PAR";				//type
				getobj(win, "STP", 333).xval = "INT";				//step
				getobj(win, "STP", 334).xval = "";				//status
			}
		}
		else if (obn == "STP_333")
		{
			v = getobj(win, "STP", 333).xval;
			if (v == "---")
			{
				getobj(win, "STP", 334).xval = "";
				disableobj(win, "STP", 334);
			}
			else if (v == "FIN")
			{
				getobj(win, "STP", 334).xval = "COM";
				//disableobj(win, "STP", 334);
			}
			else
			{
				enableobj(win, "STP", 334);
			}
		}
	}
	else if (win == _wins[15])
	{
		if (obn == "STP_418") 
		{
			if (isempty(getobj(win, "STP", 418).xval))
			{
				enableobj(win, "INP", 419);
				enableobj(win, "INP", 420);
			}
			else
			{
				disableobj(win, "INP", 419);
				disableobj(win, "INP", 420);
				getobj(win, "INP", 419).xval = "---";
				getobj(win, "INP", 420).xval = "---";
				getobj(win, "INP", 421).xval = "---";
			}
		}
	}
	else if (win == _wins[19])
	{
		if (obn == "STP_543") 
		{
			if (isempty(getobj(win, "STP", 724).xval))
			{
				getobj(win, "STP", 725).xval = "";
				getobj(win, "STP", 726).xval = "";
			}
			else
			{
				if (getobj(win, "STP", 724).xval == "EVT")
				{
					getobj(win, "STP", 725).xval = "FIN";
					getobj(win, "CAL", 731).xval = defdate();
				}
				else
				{
					getobj(win, "STP", 725).xval = "PLA";
				}
				getobj(win, "STP", 726).xval = "GEN";
				getobj(win, "CAL", 730).xval = defdate();
			}
		}
		else if (obn == "STP_551") 
		{
			if (isempty(getobj(win, "STP", 732).xval))
			{
					getobj(win, "STP", 734).xval = "";
					getobj(win, "STP", 735).xval = "";
			}
			else
			{
				if (getobj(win, "STP", 732).xval == "ASSIGNÉ RECRUTEUR")
				{
					getobj(win, "STP", 734).xval = "REC";
					getobj(win, "STP", 735).xval = "ACT";
				}
				else if (getobj(win, "STP", 732).xval == "RECRUTEMENT")
				{
					getobj(win, "STP", 734).xval = "REC";
					getobj(win, "STP", 735).xval = "";
				}
				else if (getobj(win, "STP", 732).xval == "ASSIGNÉ INTERVIEWER")
				{
					getobj(win, "STP", 734).xval = "INT";
					getobj(win, "STP", 735).xval = "ACT";
				}
				else if (getobj(win, "STP", 732).xval == "INTERVIEW (QUESTIONNAIRE)")
				{
					getobj(win, "STP", 734).xval = "INT";
					getobj(win, "STP", 735).xval = "";
				}
				else
				{
					getobj(win, "STP", 734).xval = "";
					getobj(win, "STP", 735).xval = "";
				}
			}
		}
	}
	else if (win == _wins[26])
	{
		if (obn == "STP_612") 
		{
			if (getobj(win, "STP", 612).xval == "COM")
			{
				getobj(win, "CAL", 615).xval = getobj(win, "CAL", 647).xval;
				getobj(win, "CAL", 616).xval = dateadd(getobj(win, "CAL", 647).xval, 730);
				//getobj(win, "INP", 655).xval = "INTERVIEW (QUESTIONNAIRE)";
			}
			else if (getobj(win, "STP", 612).xval == "ABA")
			{
				getobj(win, "CAL", 615).xval = getobj(win, "CAL", 647).xval;
				getobj(win, "CAL", 616).xval = "";
				//getobj(win, "INP", 655).xval = "INTERVIEW (QUESTIONNAIRE)";
			}
			else
			{
				getobj(win, "CAL", 615).xval = getobj(win, "CAL", 647).xval;
				getobj(win, "CAL", 616).xval = "";
				//getobj(win, "INP", 655).xval = "ASSIGNÉ INTERVIEWER";
			}
		}
	}
	else if (win == _wins[27])
	{
		if (obn == "STP_672") {
			var tempStp:fstp1 = getobj(_wins[27], "STP", 672);
			saveChecklistToTemp();
			_checklistTempsCourant = tempStp.xval;
			setChecklist(/*tempStp.xval*/);
		}
	}
}

private function getnewuserid():void
{
	var pfx, pv;
	pfx = arguments[0];
	pv = "fn112¦" + pfx;				//load answers	
	actdbpost(_apppath + "dbactions.php", pv);
}

private function obactstpq(ob, obn, win):void
{
	var i;	
	questbizrules(ob, obn, win);
}

private function obactcal(ob, obn, win):void
{
	var i;	
}

private function obactcalq(ob, obn, win):void
{
	var i;	
	questbizrules(ob, obn, win);
}

private function obacttim(ob, obn, win):void
{
	var i;	
}

private function obacttimq(ob, obn, win):void
{
	var i;	
	questbizrules(ob, obn, win);
}

private function obactchk(ob, obn, win):void
{
	var i, l, j, a, v, ox, yy, tout;	
	switch(obn)
	{
		case "CHK_349":		//filter users
		case "CHK_350":
			if (ob.xval == 1)
			{
				a = [["CHK", 351], ["CHK", 352], ["CHK", 353], ["CHK", 354], ["CHK", 355], ["CHK", 356]];
				for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = 0; }
				a = [["STP", 358], ["STP", 359], ["CHK", 361], ["CHK", 362], ["CHK", 363], ["CHK", 364], ["CHK", 365], ["CHK", 366], ["CHK", 367], ["CHK", 368], ["CHK", 370], ["CHK", 371], ["CHK", 372], ["CHK", 373], ["CHK", 374], ["CHK", 375], ["CHK", 376], ["CHK", 377], ["CHK", 378], ["CHK", 379], ["CHK", 380], ["CHK", 381], ["CHK", 382], ["CHK", 383], ["CHK", 384], ["CHK", 385], ["CHK", 387], ["CHK", 388], ["CAL", 389], ["CAL", 390], ["CHK", 391], ["CHK", 392], ["CHK", 393], ["CHK", 394], ["CHK", 395], ["CHK", 396], ["INP", 397], ["INP", 398], ["CHK", 400], ["CHK", 401], ["CHK", 402], ["CHK", 403], ["CHK", 404], ["CHK", 405], ["STP", 407], ["INP", 408], ["INP", 409], ["CAL", 411], ["CAL", 412], ["INP", 414], ["BTN", 415], ["RAD", 416], ["RAD", 417], ["STP", 418], ["INP", 419], ["INP", 420], ["WIS", 422], ["BTN", 423], ["CAL", 424], ["CAL", 425], ["INP", 426]];
				for (i = 0; i < a.length; ++i) { enableobj(win, a[i][0], a[i][1]); }
			}
			break;
		case "CHK_351":		//filter users
		case "CHK_352":
		case "CHK_353":
		case "CHK_354":
		case "CHK_355":
		case "CHK_356":
			if (ob.xval == 1)
			{
				a = [["CHK", 349], ["CHK", 350]];
				for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = 0; }
				a = [["STP", 358], ["STP", 359], ["CHK", 361], ["CHK", 362], ["CHK", 363], ["CHK", 364], ["CHK", 365], ["CHK", 366], ["CHK", 367], ["CHK", 368], ["CHK", 370], ["CHK", 371], ["CHK", 372], ["CHK", 373], ["CHK", 374], ["CHK", 375], ["CHK", 376], ["CHK", 377], ["CHK", 378], ["CHK", 379], ["CHK", 380], ["CHK", 381], ["CHK", 382], ["CHK", 383], ["CHK", 384], ["CHK", 385], ["CHK", 387], ["CHK", 388], ["CAL", 389], ["CAL", 390], ["CHK", 391], ["CHK", 392], ["CHK", 393], ["CHK", 394], ["CHK", 395], ["CHK", 396], ["INP", 397], ["INP", 398], ["CHK", 400], ["CHK", 401], ["CHK", 402], ["CHK", 403], ["CHK", 404], ["CHK", 405], ["STP", 407], ["INP", 408], ["INP", 409], ["CAL", 411], ["CAL", 412], ["INP", 414], ["BTN", 415], ["RAD", 416], ["RAD", 417], ["STP", 418], ["INP", 419], ["INP", 420], ["WIS", 422], ["BTN", 423], ["CAL", 424], ["CAL", 425], ["INP", 426]];
				for (i = 0; i < a.length; ++i)
				{
					if (a[i][0] == "CHK" || a[i][0] == "RAD")
					{
						getobj(win, a[i][0], a[i][1]).xval = 0;
					}
					else if (a[i][0] == "INP" || a[i][0] == "DDL" || a[i][0] == "STP" || a[i][0] == "TIM" || a[i][0] == "CAL")
					{
						getobj(win, a[i][0], a[i][1]).xval = "---";
					}
					disableobj(win, a[i][0], a[i][1]);
				}
			}
		default:
			break;
	}
}

private function obactchkq(ob, obn, win):void
{
	var i;	
	questbizrules(ob, obn, win);
}

private function obactrad(ob, obn, win):void
{
	var v;
	switch(obn)
	{
		case "RAD_112":
			getobj(win, "INP", 111).xval = "H";
			break;
		case "RAD_113":
			getobj(win, "INP", 111).xval = "F";
			break;
		case "RAD_436":			//filter activities
		case "RAD_437":
		case "RAD_438":
			getobj(win, "CAL", 442).xval = getobj(win, "CAL", 443).xval = "---";
			disableobj(win, "CAL", 442); disableobj(win, "CAL", 443);
			break;
		case "RAD_439":			//filter activities
		case "RAD_440":
		case "RAD_441":
			enableobj(win, "CAL", 442); enableobj(win, "CAL", 443);
			break;
		case "RAD_480":
			enableobj(win, "CAL", 482); enableobj(win, "CAL", 483);
			break;
		case "RAD_481":
			disableobj(win, "CAL", 482); disableobj(win, "CAL", 483);
			break;
		default:
			break;
	}
}

private function obactradq(ob, obn, win):void
{
	var v;
	questbizrules(ob, obn, win);
}

private function obactimg(ob, obn, win):void
{
	switch(obn)
	{
		case "IMG_45":		//close pop image
			win.visible = false;
			showblocker(false);
			break;
	}
}

private function obactimgq(ob, obn, win):void
{
	var v;
	questbizrules(ob, obn, win);
}

private function obactbtn(ob, obn, win):void
{
	var i, l, j, a, v, v1, v2, ww, ox, yy, tout, pv;
	switch(obn)
	{
		case "BTN_2":		//cancel alert
		case "BTN_5":
		case "BTN_9":
			showblocker(false);
			break
		case "BTN_4":		//confirm alert
		case "BTN_8":
			showblocker(false);
			actionalert();
			break;
		case "BTN_24":		//confirm lookup2form
			lookup2form(win);
		case "BTN_25":
			showwin(win, false, 1, 0);
			if (!_keepblock) { showblocker(false); }
			_keepblock = false;
			break;
		case "BTN_32":			//participants lookup
			v = trim(getobj(win, "INP", 30).xval);
			//if ( isempty(v) ) { getobj(win, "INP", 31).xval = getobj(win, "INP", 29).xval = "";  return; }
			if ( isempty(v) ) { return; }
			_dblookuptg = [win, "QUEPAR"];
			_keepblock = true;
			pozwin(_wins[22], true, true, 0, 0, 1, 0)
			showwin(_wins[22], true, 1, 0);
			tofront(_wins[22]);
			dbloadlookup("USRLKP", v);
			break;
		case "BTN_33":			//view current questionnaire reponses
			_curquest = "";
			try { v = getobj(win, "LST", 28).selrow; } catch (er) { }
			if (v != null){ _curquest = v[1];}
			if (_curquest != "" && !isempty(getobj(win, "INP", 31).xval))
			{
				v1 = getobj(win, "INP", 31).xval;
				if (!isempty(v1))					//participant id ok
				{
					pv = "fn403¦" + _curquest + "¦" + v1;				//load answers	
					actdbpost(_apppath + "dbactions.php", pv);
				}
			}
			break;
		case "BTN_34":					//load questionnaire
			_curquest = "";
			try { v = getobj(win, "LST", 28).selrow; } catch (er) { }
			if (v != null) { _curquest = v[1]; }
			if (_curquest != "" && !isempty(getobj(win, "INP", 31).xval))
			{
				dbloadquest("", getobj(win, "INP", 29).xval);
			}
			break;
		case "BTN_35":
			showwin(win, false, 1, 0);
			showblocker(false);
			getobj(_wins[4], "BTN", 46).xval = "U";
			break;
		case "BTN_46":		// menu questionnaire
			if (ob.xval == "D")
			{
				showblocker(true);
				showwin(_wins[8], true, 1, 0);
				tofront(_wins[8]);
				enableobj(_wins[8], "INP", 30);
				enableobj(_wins[8], "BTN", 32);
			}
			else if (ob.xval == "U")
			{
				showblocker(false);
				showwin(_wins[29], false, 1, 0);
			}
			break;
		case "BTN_47":		// menu users
			if (ob.xval == "D")
			{
				tofront(_wins[9]);
				showwin(_wins[9], true, 1, 0);
				setwinperms(_wins[9]);
			}
			else if (ob.xval == "U")
			{
				a = [9, 10, 15, 18, 19];
				for (i = 0; i < a.length; ++i)
				{
					if(_wins[a[i]].visible){ showwin(_wins[a[i]], false, 1, 0); }
				}
			}
			break;
		case "BTN_48":		// menu activities
			if (ob.xval == "D")
			{
				tofront(_wins[13]);
				showwin(_wins[13], true, 1, 0);
				setwinperms(_wins[13]);
			}
			else if (ob.xval == "U")
			{
				a = [13, 14, 16, 21];
				for (i = 0; i < a.length; ++i)
				{
					if(_wins[a[i]].visible){ showwin(_wins[a[i]], false, 1, 0); }
				}
			}
			break;
		case "BTN_49":		// menu assets
			if (ob.xval == "D")
			{
				tofront(_wins[11]);
				showwin(_wins[11], true, 1, 0);
				setwinperms(_wins[11]);
			}
			else if (ob.xval == "U")
			{
				a = [11, 12, 17, 20];
				for (i = 0; i < a.length; ++i)
				{
					if(_wins[a[i]].visible){ showwin(_wins[a[i]], false, 1, 0); }
				}
			}
			break;
		case "BTN_50":		// menu admin
			break;
		case "BTN_51":		// menu help
			if (ob.xval == "D")
			{
				tofront(_wins[7]);
				showwin(_wins[7], true, 1, 0);
			}
			else if (ob.xval == "U")
			{
				if(_wins[7].visible){ showwin(_wins[7], false, 1, 0); }
			}
			break;
		case "BTN_52":		// menu login
			if (_logged)	//logout
			{
				_logged = false;
				changelabtxt(ob, "Logout", "Login");
				for (i = 46; i <= 51; ++i) { getobj(_wins[4], "BTN", i).xval = "U"; getobj(_wins[4], "BTN", i).visible = false; }
				showblocker(false);
				for (i = 9; i <= 28; ++i)
				{ 
					if (_wins[i].visible) { showwin(_wins[i], false, 1, 0); }
				}
				ox = _main.getChildAt(1);
				if (ox != null)
				{
					TweenMax.to(ox, .3, { alpha:.6 } );
				}
			}
			else			//login
			{
				pozwin(_wins[6], true, true, 0, 0, false, 0);
				showwin(_wins[6], true, 0, 0);
				showblocker(true);
			}
			break;
		case "BTN_21":		//confirm login
			dbloginuser(getobj(win, "INP", 19).xval, getobj(win, "INP", 20).xval);
			break;
		case "BTN_22":		//cancel login
			showwin(_wins[6], false, 1, 0);
			showblocker(false);
			break;
			
		case "BTN_61":		//save / close mailing address win
			getobj(win, "INP", 55).xval = getobj(_wins[10], "INP", 96).xval;
			dbsaverecord("USRADDM");
		case "BTN_62":		//cancel login
			showwin(_wins[28], false, 1, 0);
			showblocker(false);
			break;
			
		case "BTN_63":			//sort users (list)
			dbsortlist("USR", "id", ob);
			break;
		case "BTN_64":
			dbsortlist("USR", "xgroup", ob);
			break;
		case "BTN_65":
			dbsortlist("USR", "fname", ob);
			break;
		case "BTN_66":
			dbsortlist("USR", "lname", ob);
			break;
		case "BTN_67":
			dbsortlist("USR", "idusr", ob);
			break;
		case "BTN_68":
			dbsortlist("USR", "idusraux", ob);
			break;
		case "BTN_69":
			dbsortlist("USR", "type", ob);
			break;
		case "BTN_70":
			dbsortlist("USR", "phase", ob);
			break;
		case "BTN_71":
			dbsortlist("USR", "step", ob);
			break;
		case "BTN_72":
			dbsortlist("USR", "status", ob);
			break;
		case "BTN_73":
			dbsortlist("USR", "hzone1", ob);
			break;
		case "BTN_74":
			dbsortlist("USR", "hzone2", ob);
			break;
		case "BTN_75":
			dbsortlist("USR", "hzone3", ob);
			break;
			
					
		case "BTN_84":			//find users (list)
			dbfindrec("USR", getobj(win, "INP", 83).xval);
			dbloadlist("USR", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0]);
			break;
		case "BTN_85":			//filter users (list)
			tofront(_wins[15]);
			scrollto(_wins[15], 0);
			pozwin(_wins[15], true, true, 0, 0, 1, 0)
			showwin(_wins[15], true, 1, 0);
			break;
		case "BTN_86":			//users actions
			resetform(_wins[19]);
			scrollto(_wins[19], 0);
			getobj(_wins[19], "LST", 688).xval = "1,Liste standard\r2,Liste recrutement\r3,Liste interviews\r4,Adresses visitées\r5,Étiquettes\r6,Statuts des dossiers";
			tofront(_wins[19]);
			pozwin(_wins[19], true, true, 0, 0, 1, 0)
			showwin(_wins[19], true, 1, 0);
			break;
		case "BTN_87":			//users new activity
			v = null;
			try { v = getobj(_wins[9], "LST", 79).selrow; } catch (er) { }
			if (v != null)
			{
				resetform(_wins[14]);
				getobj(_wins[14], "STP", 298).xval = "EVT";
				getobj(_wins[14], "STP", 303).xval = "FIN";
				getobj(_wins[14], "STP", 304).xval = "USR";
				getobj(_wins[14], "STP", 305).xval = "GEN";
				//getobj(_wins[14], "INP", 300).xval = _curuser[0];
				//getobj(_wins[14], "INP", 311).xval = _curuser[4];
				//getobj(_wins[14], "INP", 312).xval = _curuser[1] + " " + _curuser[2];
				getobj(_wins[14], "INP", 301).xval = v[0];
				getobj(_wins[14], "INP", 330).xval = v[1];
				getobj(_wins[14], "INP", 327).xval = v[4];
				if (v[2] == "" && v[3] == "")
				{
					getobj(_wins[14], "INP", 328).xval ="";
				}
				else
				{
					getobj(_wins[14], "INP", 328).xval = trim(v[2] + " " + v[3]);
				}
				getobj(_wins[14], "STP", 331).xval = v[6];
				getobj(_wins[14], "STP", 332).xval = v[7];
				getobj(_wins[14], "STP", 333).xval = v[8];
				getobj(_wins[14], "STP", 334).xval = v[9];
				getobj(_wins[14], "INP", 339).xval = v[13];
				getobj(_wins[14], "INP", 340).xval = v[14];
				getobj(_wins[14], "CAL", 322).xval = getobj(_wins[14], "CAL", 324).xval = defdate();
				tofront(_wins[13]);
				pozwin(_wins[13], true, true, 0, 0, 1, 0)
				showwin(_wins[13], true, 1, 0);
				scrollto(_wins[14], 0);
				tofront(_wins[14]);
				pozwin(_wins[14], true, true, 0, 0, 1, 0)
				showwin(_wins[14], true, 1, 0);
				getobj(_wins[4], "BTN", 48).xval = "D";
			}
			else
			{
				return;
			}
			break;
		case "BTN_88":			//users questionnaire
			v = null;
			try { v = getobj(_wins[9], "LST", 79).selrow; } catch (er) { }
			if (v != null)
			{
				showblocker(true);
				pozwin(_wins[8], true, true, 0, 0, 1, 0)
				showwin(_wins[8], true, 1, 0);
				tofront(_wins[8]);
				getobj(_wins[8], "INP", 31).xval = v[0];
				getobj(_wins[8], "INP", 29).xval = v[4];
				getobj(_wins[8], "INP", 30).xval = v[2] + " " + v[3];
				disableobj(_wins[8], "INP", 30);
				disableobj(_wins[8], "BTN", 32);
				getobj(_wins[4], "BTN", 46).xval = "D";
			}
			else
			{
				return;
			}
			break;
		case "BTN_90":			//users details (edit)
			if (_curuser[3] == "INT")
			{
				ww = _wins[26];
			}
			else
			{
				ww = _wins[10];
				getobj(ww, "BTN", 189).labtext = "Enregistrer";
			}
			v = null;
			try { v = getobj(_wins[9], "LST", 79).selrow; } catch (er) { }
			if (v != null)
			{
				dbloadrecord("USR", v[0]);
			}
			else
			{
				return;
			}
			scrollto(ww, 0);
			tofront(ww);
			pozwin(ww, true, true, 0, 0, 1, 0)
			showwin(ww, true, 1, 0);
			break;
		case "BTN_91":			//users details (new)
			ww = _wins[10];
			resetform(ww);
			if (_curuser[3] == "ADM" || _curuser[3] == "AUT")
			{
				enableobj(ww, "INP", 109); enableobj(ww, "INP", 110);
			}
			else
			{
				disableobj(ww, "INP", 109); disableobj(ww, "INP", 110);
			}
			getobj(ww, "BTN", 189).labtext = "Ajouter";
			scrollto(ww, 0);
			tofront(ww);
			pozwin(ww, true, true, 0, 0, 1, 0)
			showwin(ww, true, 1, 0);
			break;
		case "BTN_92":			//delete users (by id)
			v = null;
			try { v = getobj(_wins[9], "LST", 79).selrow; } catch (er) { }
			if (v != null)
			{
				_alertact = "USRDEL";
				alert(_wins[1], "Confirmez l'effacement.", "");
			}
			break;
		case "BTN_189":			//save / add (user edit win)
			getobj(win, "INP", 108).xval = defdate();
			dbsaverecord("USR");
			showwin(win, false, 1, 0);
			break;

		case "BTN_146":			//visited adresses (home)
			v = getobj(win, "INP", 96).xval;
			pozwin(_wins[24], true, true, 0, 0, 1, 0)
			showwin(_wins[24], true, 1, 0);
			showblocker(true);
			dbloadrecord("USRADDV", v);
			break;
		
		case "BTN_136":			//addresses history (home)
		case "BTN_160":			//addresses history (work)
			v = getobj(win, "INP", 96).xval;
			_dblookuptg = [win, "USRADDR"];
			pozwin(_wins[23], true, true, 0, 0, 1, 0)
			showwin(_wins[23], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRADDR", v);
			break;
			
		case "BTN_150":			//mailing address
			v = getobj(win, "INP", 96).xval;
			pozwin(_wins[28], true, true, 0, 0, 1, 0);
			showwin(_wins[28], true, 1, 0);
			showblocker(true);
			resetform(_wins[28]);
			dbloadrecord("USRADDM", v)
			break;
			
		case "BTN_181":			//signed documents lookup
			var tempUsager:fstp1 = getobj(_wins[10], "STP", 101);
			var tempVal:int = 0;
			if ( tempUsager.xval.match(/T-[0-9][0-9]/) != null ) {
				tempVal = parseInt(tempUsager.xval.substr(2));
			}
			if (tempVal > 0) {
				var tempStp:fstp1 = getobj(_wins[27], "STP", 672);
				var tempCourantUsager = tempUsager.vidx;
				tempStp.xval = 'T-0' + tempCourantUsager.toString();
				tempStp.xmax = tempCourantUsager;
				
				_lookuptg = [getobj(win, "INP", 180), getobj(_wins[27], "INP", 677)];
				v = _lookuptg[0].xval;
				var checklist:String = v;
				if ( checklist.length > 0 && checklist.indexOf(":") == -1 ) { // Has checklist format been updated?
					checklist = correctChecklist(checklist, tempUsager.xval);
					_lookuptg[0].xval = checklist;
				}
				_lookuptg[1].xval = _lookuptg[0].xval; // Copy over to temp holder
				//var checklistHolder:finp1 = getobj(_wins[10], "INP", 180);
				//var checklistStr = checklistHolder.xval;
				//var tmpChecklistHolder:finp1 = getobj(_wins[27], "INP", 674);
				//var tmpChecklistHolder:finp1 = getobj(_wins[27], "INP", 677);
				//tmpChecklistHolder.xval = checklistStr;
				_checklistTempsCourant = tempStp.xval;
				setChecklist(); // setChecklist(tempUsager.xval);
				pozwin(_wins[27], true, true, 0, 0, 1, 0);
				showwin(_wins[27], true, 1, 0);
				showblocker(true);
			}
			else {
				alert(_wins[0], "Veuillez saisir une valeur pour le champ «Temps» avant de procéder.", "");
			}
			break;
		case "BTN_415":			//signed documents lookp
			_lookuptg = [getobj(win, "INP", 414), getobj(_wins[27], "INP", 674)];
			_lookuptg[1].xval = ( _lookuptg[0].xval != '---' ? _lookuptg[0].xval : "" ); // Copy over to temp holder
			_checklistTempsCourant = 'T-01';
			getobj(_wins[27], "STP", 672).xval = _checklistTempsCourant;
			setChecklist();
			pozwin(_wins[27], true, true, 0, 0, 1, 0);
			showwin(_wins[27], true, 1, 0);
			showblocker(true);
			break;
		case "BTN_423":			//lookup users filter
			v = trim(getobj(win, "INP", 420).xval);
			//if ( isempty(v) ) { getobj(win, "INP", 419).xval = getobj(win, "INP", 421).xval = "";  return; }
			if ( isempty(v) ) { return; }
			_dblookuptg = [win, "ACTRES"];
			pozwin(_wins[22], true, true, 0, 0, 1, 0)
			showwin(_wins[22], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRLKP", v);
			break;
		case "BTN_427":			//reset filter (filter window)
			setwinperms(_wins[9]);
			break;
		case "BTN_428":			//apply users filter (filter window)
			if (getobj(win, "STP", 418).xval != "---") { getobj(win, "INP", 419).xval = getobj(win, "INP", 420).xval = getobj(win, "INP", 421).xval = "---"; }
			dbmakefilter("USR");
			_dbpage[0] = 0;
			dbloadlist("USR", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0]);
			break;
			
			
		case "BTN_190":			//sort assets (list)
			dbsortlist("ASS", "id", ob);
			break;
		case "BTN_191":
			dbsortlist("ASS", "type", ob);
			break;
		case "BTN_192":	
			dbsortlist("ASS", "sku", ob);
			break;
		case "BTN_193":
			dbsortlist("ASS", "serial", ob);
			break;
		case "BTN_194":
			dbsortlist("ASS", "device", ob);
			break;
		case "BTN_195":
			dbsortlist("ASS", "status", ob);
			break;
		case "BTN_196":
			dbsortlist("ASS", "assgeta", ob);
			break;
		case "BTN_197":
			dbsortlist("ASS", "sereta", ob);
			break;

		case "BTN_207":			//find asset (list)
			dbfindrec("ASS", getobj(win, "INP", 206).xval);
			dbloadlist("ASS", _dbpage[2], _dbpagelen[2], _dbflt[2], _dbsort[2], _dbsortdir[2]);
			break;
		case "BTN_208":			//filter assets (list)
			tofront(_wins[17]);
			pozwin(_wins[17], true, true, 0, 0, 1, 0)
			showwin(_wins[17], true, 1, 0);
			break;
		case "BTN_209":			//assets actions
			resetform(_wins[20]);
			getobj(_wins[20], "LST", 563).xval = "1,Liste standard\r2,Liste des attributions\r3,Liste service";
			tofront(_wins[20]);
			pozwin(_wins[20], true, true, 0, 0, 1, 0)
			showwin(_wins[20], true, 1, 0);
			break;
		case "BTN_210":			//assets details (edit)
		case "BTN_211":			//assets details (new)
			a = [["LAB",226],["INP",227],["INP",228],["INP",229],["BTN",230],["CAL",231],["CAL",232],["CAL",233],["CAL",234],["STP",235],["BTN",236],["CAL",237],["STP",238],["BTN",239],["LAB",240],["INP",241],["INP",242],["INP",243],["CAL",244],["STP",245],["CAL",246],["BTN",247],["CAL",248],["STP",249],["BTN",250],["LAB",251],["CAL",252],["INP",253],["BTN",254],["LAB",255],["CAL",256],["STP",257],["INP",258],["WIS",259],["BTN",260]];
			if (obn == "BTN_210")
			{
				v = null;
				try { v = getobj(_wins[11], "LST", 201).selrow; } catch (er) { }
				if (v != null)
				{
					dbloadrecord("ASS", v[0]);
					getobj(_wins[12], "BTN", 224).labtext = "Énregistrer";
					for (i = 0; i < a.length; ++i) { enableobj(_wins[12], a[i][0], a[i][1]); }
				}
				else
				{
					return;
				}
			}
			else
			{
				resetform(_wins[12]);
				getobj(_wins[12], "BTN", 224).labtext = "Ajouter";
				for (i = 0; i < a.length; ++i) { disableobj(_wins[12], a[i][0], a[i][1]); }
			}
			tofront(_wins[12]);
			scrollto(_wins[12], 0);
			pozwin(_wins[12], true, true, 0, 0, 1, 0)
			showwin(_wins[12], true, 1, 0);
			break;
		case "BTN_212":			//assets effacer (list)
			v = null;
			try { v = getobj(_wins[11], "LST", 201).selrow; } catch (er) { }
			if (v != null)
			{
				_alertact = "ASSDEL";
				alert(_wins[1], "Confirmez l'effacement.", "");
			}
			break;
		
			
		case "BTN_230":			//assets edit window lookup parti
			v = trim(getobj(win, "INP", 228).xval);
			//if ( isempty(v) ) { getobj(win, "INP", 227).xval = getobj(win, "INP", 229).xval = "";  return; }
			if ( isempty(v) ) { return; }
			_dblookuptg = [win, "ASSPAR"];
			pozwin(_wins[22], true, true, 0, 0, 1, 0)
			showwin(_wins[22], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRLKP", v);
			break;
		case "BTN_224":			//assets edit window save
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_236":			//assets edit window save - assign to parti
			a = [["CAL",237],["STP",238],["INP",241],["INP",242],["INP",243],["CAL",244],["STP",245],["CAL",246],["CAL",248],["STP",249],["CAL",252],["INP",253],["CAL",256],["STP",257],["INP",258]];
			for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = "---"; }
			getobj(win, "STP", 218).xval = "APA";
			if (!isempty(getobj(win, "CAL", 234).xval)) { getobj(win, "STP", 218).xval = "LPA"; }
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_239":			//assets edit window save - return by to parti
			a = [["INP",227],["INP",228],["INP",229],["CAL",231],["CAL",232],["CAL",233],["CAL",234],["STP",235],["INP",241],["INP",242],["INP",243],["CAL",244],["STP",245],["CAL",246],["CAL",248],["STP",249],["CAL",252],["INP",253],["CAL",256],["STP",257],["INP",258]];
			for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = "---"; }
			getobj(win, "STP", 218).xval = "INV";
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_247":			//assets edit window save - send to service
			a = [["INP",227],["INP",228],["INP",229],["CAL",231],["CAL",232],["CAL",233],["CAL",234],["STP",235],["CAL",237],["STP",238],["CAL",248],["STP",249],["CAL",252],["INP",253],["CAL",256],["STP",257],["INP",258]];
			for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = "---"; }
			getobj(win, "STP", 218).xval = "SER";
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_250":			//assets edit window save - retour from service
			a = [["INP",227],["INP",228],["INP",229],["CAL",231],["CAL",232],["CAL",233],["CAL",234],["STP",235],["CAL",237],["STP",238],["INP",241],["INP",242],["INP",243],["CAL",244],["STP",245],["CAL",246],["CAL",252],["INP",253],["CAL",256],["STP",257],["INP",258]];
			for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = "---"; }
			getobj(win, "STP", 218).xval = "INV";
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_254":			//assets edit window save - rebut
			a = [["INP",227],["INP",228],["INP",229],["CAL",231],["CAL",232],["CAL",233],["CAL",234],["STP",235],["CAL",237],["STP",238],["INP",241],["INP",242],["INP",243],["CAL",244],["STP",245],["CAL",246],["CAL",248],["STP",249],["CAL",256],["STP",257],["INP",258]];
			for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = "---"; }
			getobj(win, "STP", 218).xval = "REB";
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_260":			//assets edit window save - stolen/lost
			a = [["INP",227],["INP",228],["INP",229],["CAL",231],["CAL",232],["CAL",233],["CAL",234],["STP",235],["CAL",237],["STP",238],["INP",241],["INP",242],["INP",243],["CAL",244],["STP",245],["CAL",246],["CAL",248],["STP",249],["CAL",252],["INP",253]];
			for (i = 0; i < a.length; ++i) { getobj(win, a[i][0], a[i][1]).xval = "---"; }
			getobj(win, "STP", 218).xval = "PVO";
			dbsaverecord("ASS");
			showwin(win, false, 1, 0);
			break;
		case "BTN_225":			//assets edit window cancel
			showwin(win, false, 1, 0);
			break;

		case "BTN_498":			//reset filter assets
			setwinperms(_wins[11]);
			break;
		case "BTN_499":			//aply filter assets
			dbmakefilter("ASS");
			_dbpage[2] = 0;
			dbloadlist("ASS", _dbpage[2], _dbpagelen[2], _dbflt[2], _dbsort[2], _dbsortdir[2]);
			break;

			
		case "BTN_264":			//sort activities (list)
			dbsortlist("ACT", "id", ob);
			break;
		case "BTN_265":			//sort activities (list)
			dbsortlist("ACT", "activity", ob);
			break;
		case "BTN_266":			//sort activities (list)
			dbsortlist("ACT", "status", ob);
			break;
		case "BTN_267":			//sort activities (list)
			dbsortlist("ACT", "mode", ob);
			break;
		case "BTN_268":			//sort activities (list)
			dbsortlist("ACT", "code", ob);
			break;
		case "BTN_269":			//sort activities (list)
			dbsortlist("ACT", "description", ob);
			break;
		case "BTN_270":			//sort activities (list)
			dbsortlist("ACT", "dstart", ob);
			break;
		case "BTN_271":			//sort activities (list)
			dbsortlist("ACT", "dend", ob);
			break;
		case "BTN_272":			//sort activities (list)
			dbsortlist("ACT", "idusr", ob);
			break;
		case "BTN_273":			//sort activities (list)
			dbsortlist("ACT", "idparti", ob);
			break;
		case "BTN_274":			//sort activities (list)
			dbsortlist("ACT", "ptype", ob);
			break;
		case "BTN_275":			//sort activities (list)
			dbsortlist("ACT", "pphase", ob);
			break;
		case "BTN_276":			//sort activities (list)
			dbsortlist("ACT", "pstep", ob);
			break;
		case "BTN_277":			//sort activities (list)
			dbsortlist("ACT", "pstatus", ob);
			break;

		case "BTN_292":			//find activity (list)
			dbfindrec("ACT", getobj(win, "INP", 291).xval);
			dbloadlist("ACT", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1]);
			break;
		case "BTN_293":			//filter activities (list)
			tofront(_wins[16]);
			scrollto(_wins[16], 0);
			showwin(_wins[16], true, 1, 0);
			break;
		case "BTN_294":			//activities actions
			resetform(_wins[21]);
			getobj(_wins[21], "LST", 575).xval = "1,Liste standard\r2,Liste paiements Km.\r3,Liste paiements Hrs.";
			tofront(_wins[21]);
			//scrollto(_wins[21], 0);
			pozwin(_wins[21], true, true, 0, 0, 1, 0)
			showwin(_wins[21], true, 1, 0);
			break;
		case "BTN_295":			//activities details (edit)
		case "BTN_296":			//activities details (new)
			if (obn == "BTN_295")
			{
				v = null;
				try { v = getobj(_wins[13], "LST", 285).selrow; } catch (er) { }
				if (v != null)
				{
					dbloadrecord("ACT", v[0]);
					getobj(_wins[14], "BTN", 347).labtext = "Énregistrer";
				}
				else
				{
					return;
				}
			}
			else
			{
				resetform(_wins[14]);
				getobj(_wins[14], "BTN", 347).labtext = "Ajouter";
				_alertact = "ACTNEW";
				alert(_wins[1], "Utiliser l'activité séléctionnée?", "");
			}
			tofront(_wins[14]);
			scrollto(_wins[14], 0);
			pozwin(_wins[14], true, true, 0, 0, 1, 0)
			showwin(_wins[14], true, 1, 0);
			break
		case "BTN_297":			//activities delete (list)
			v = null;
			try { v = getobj(_wins[13], "LST", 285).selrow[0]; } catch (er) { }
			if (v != null)
			{
				_alertact = "ACTDEL";
				alert(_wins[1], "Confirmez l'effacement.", "");
			}
			break;
			
		case "BTN_317":			//calculate total cost km
			v = parseFloat(getobj(win, "INP", 314).xval) * parseFloat(getobj(win, "INP", 339).xval);
			getobj(win, "INP", 315).xval = v.toFixed(2);
			getobj(win, "CAL", 316).xval = defdate();
			break;
		case "BTN_321":			//calculate total cost hrs
			v = parseFloat(getobj(win, "INP", 318).xval) * parseFloat(getobj(win, "INP", 340).xval);
			getobj(win, "INP", 319).xval = v.toFixed(2);
			getobj(win, "CAL", 320).xval = defdate();
			break;
		case "BTN_313":			//activities lookup user
			v = trim(getobj(win, "INP", 312).xval);
			//if ( isempty(v) ) { getobj(win, "INP", 311).xval = getobj(win, "INP", 300).xval = "";  return; }
			if ( isempty(v) ) { return; }
			_dblookuptg = [win, "ACTRES"];
			pozwin(_wins[22], true, true, 0, 0, 1, 0)
			showwin(_wins[22], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRLKP", v);
			break;
		case "BTN_329":			//activities lookup parti
			v = trim(getobj(win, "INP", 328).xval);
			//if ( isempty(v) ) { getobj(win, "INP", 327).xval = getobj(win, "INP", 301).xval = "";  return; }
			if ( isempty(v) ) { return; }
			_dblookuptg = [win, "ACTPAR"];
			pozwin(_wins[22], true, true, 0, 0, 1, 0)
			showwin(_wins[22], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRLKP", v);
			break;
		case "BTN_347":			//activities edit window save
			v = parseFloat(getobj(win, "INP", 314).xval) * parseFloat(getobj(win, "INP", 339).xval);
			getobj(win, "INP", 315).xval = v.toFixed(2);
			v = parseFloat(getobj(win, "INP", 318).xval) * parseFloat(getobj(win, "INP", 340).xval);
			getobj(win, "INP", 319).xval = v.toFixed(2);
			if (validateform(win, 0))
			{
				dbsaverecord("ACT");
				showwin(win, false, 1, 0);
				_alertact = "USRUTD";
				alert(_wins[1], "Mettre à jour la fiche du PARTICIPANT / POTENTIEL?", "");
				showwin(_wins[14], false, 1, 0);
			}
			else
			{
				alert(_wins[0], "Remplisez correctement toutes les informations obligatoires.", "");
			}
			break;
		case "BTN_485":			//reset filter of activity
			setwinperms(_wins[13]);
			disableobj(win, "CAL", 482); disableobj(win, "CAL", 483);
			break;
		case "BTN_486":			//apply filter of activity
			dbmakefilter("ACT");
			_dbpage[1] = 0;
			dbloadlist("ACT", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1]);
			break;
		case "BTN_712":
			if ( getobj(_wins[25], "RAD", 664).xval == 0 ) { // Will check the filtered button by default
				getobj(_wins[25], "RAD", 663).xval = 1;
			}
			pozwin(_wins[25], true, true, 0, 0, 1, 0);
			showwin(_wins[25], true, 1, 0);
			showblocker(true);
			_acttarget = "USRACTGEOLOC";
			break;
		case "BTN_703":			//lookup users - user action win.
		case "BTN_708":			//lookup users - user action win.
		case "BTN_723":			//lookup users - user action win.
			if (obn == "BTN_703") { v = trim(getobj(win, "INP", 701).xval); v1 = 1; }
			else if (obn == "BTN_708"){v = trim(getobj(win, "INP", 706).xval); v1 = 2;}
			else if (obn == "BTN_723"){v = trim(getobj(win, "INP", 721).xval); v1 = 3;}
			//if ( isempty(v) ) { getobj(win, "INP", 720).xval = getobj(win, "INP", 722).xval = "";  return; }
			if ( isempty(v) ) { return; }
			_dblookuptg = [win, "ACVRES" + v1];
			pozwin(_wins[22], true, true, 0, 0, 1, 0)
			showwin(_wins[22], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRLKP", v);
			break;	
			
		case "BTN_709":			//user actions - interviewer reassignment
			var intervA:String = trim((getobj(_wins[19], "INP", 700) as finp1).xval);
			var intervB:String = trim((getobj(_wins[19], "INP", 705) as finp1).xval);
			if (intervA.substr(0, 3) != "INT" || intervB.substr(0,3) != "INT") {
				alert(_wins[0], "Veuillez choisir deux intervieweurs.", "");
				return;
			}
			else if ( intervA == intervB ) {
				alert(_wins[0], "Veuillez choisir deux intervieweurs différents.", "");
				return;
			}
			if ( getobj(_wins[25], "RAD", 664).xval == 0 ) { // Will check the filtered button by default
				getobj(_wins[25], "RAD", 663).xval = 1;
			}
			pozwin(_wins[25], true, true, 0, 0, 1, 0);
			showwin(_wins[25], true, 1, 0);
			showblocker(true);
			_acttarget = "USRACTREAFFECT";
			break;
		case "BTN_690":			//user actions - batch activities export
			var csv:Boolean = getobj(_wins[19], "RAD", 682).xval;
			var html:Boolean = getobj(_wins[19], "RAD", 683).xval;
			var tempStp:fstp1 = getobj(_wins[19], "STP", 684);
			var temp:String = tempStp.xval;
			var coho:String = getobj(_wins[19], "STP", 685).xval;
			var invalidInputMsg = "";
			
			if ( !csv && !html ) {
				invalidInputMsg = "Veuillez sélectionner le type de sortie que vous souhaitez générer (CSV ou HTML).";
			}
			else if ( temp == '---' ) {
				invalidInputMsg = "Veuillez entrer un temps.";
			}
			else if ( temp.match(/T-[0-9][0-9]/) == null ) {
				invalidInputMsg = "Veuillez entrer un temps valide.";
			}
			else if ( coho == '---' ) {
				invalidInputMsg = "Veuillez entrer une cohorte.";
			}
			else if ( coho.match(/C-[0-9][0-9]/) == null ) {
				invalidInputMsg = "Veuillez entrer une cohorte valide.";
			}
			
			if ( invalidInputMsg == "" ) {
				pozwin(_wins[25], true, true, 0, 0, 1, 0);
				showwin(_wins[25], true, 1, 0);
				showblocker(true);
				_acttarget = "USRXP";
			}
			else {
				alert(_wins[0], invalidInputMsg, "");
			}
			break;
		case "BTN_715":			//user actions - batch activities planning
			_acttarget = "USRACTPLAN";
			actionapplyto();
			break;
		case "BTN_738":			//user actions - batch activities execute
			if (validateform(win, 6))
			{
				pozwin(_wins[25], true, true, 0, 0, 1, 0);
				showwin(_wins[25], true, 1, 0);
				showblocker(true);
				_acttarget = "USRACTEXE";
			}
			else
			{
				alert(_wins[0], "Remplisez correctement toutes les informations obligatoires.", "");
			}
			break;
			
		case "BTN_576":			//activity actions - batch activities export
			pozwin(_wins[25], true, true, 0, 0, 1, 0);
			showwin(_wins[25], true, 1, 0);
			showblocker(true);
			_acttarget = "ACTXP";
			break;

		case "BTN_625":			//addresses history
			v = getobj(win, "INP", 605).xval;
			_dblookuptg = [win, "USRADDR"];
			pozwin(_wins[23], true, true, 0, 0, 1, 0)
			showwin(_wins[23], true, 1, 0);
			showblocker(true);
			dbloadlookup("USRADDR", v);
			break;
		case "BTN_643":			//signed documents lookup
			_lookuptg = [getobj(win, "INP", 642)];
			v = _lookuptg[0].xval;
			if (v.indexOf("RECH") != -1) { getobj(_wins[27], "CHK", 667).xval = 1; } else { getobj(_wins[27], "CHK", 667).xval = 0; }
			if (v.indexOf("RAMQ") != -1) { getobj(_wins[27], "CHK", 668).xval = 1; } else { getobj(_wins[27], "CHK", 668).xval = 0; }
			if (v.indexOf("AREC") != -1) { getobj(_wins[27], "CHK", 669).xval = 1; } else { getobj(_wins[27], "CHK", 669).xval = 0; }
			if (v.indexOf("SDIAG") != -1) { getobj(_wins[27], "CHK", 670).xval = 1; } else { getobj(_wins[27], "CHK", 670).xval = 0; }
			pozwin(_wins[27], true, true, 0, 0, 1, 0);
			showwin(_wins[27], true, 1, 0);
			showblocker(true);
			break;
		/*	
		case "BTN_656":			//calculate total cost km
			v = parseFloat(getobj(win, "INP", 649).xval) * parseFloat(getobj(win, "INP", 653).xval);
			getobj(win, "INP", 650).xval = v.toFixed(2);
			break;
		case "BTN_657":			//calculate total cost hrs
			v = parseFloat(getobj(win, "INP", 651).xval) * parseFloat(getobj(win, "INP", 654).xval);
			getobj(win, "INP", 652).xval = v.toFixed(2);
			break;
		*/
		case "BTN_661":			//save user + action interviewer screen
			dbsaverecordcombo(win);
			showwin(win, false, 1, 0);
			break;
			
			
		case "BTN_601":		//save visited addresses status
			a = [];
			v = "";
			for (i = 586; i <= 599; ++i)
			{
				ox = getobj(win, "STP", i);
				if (ox.xval == "REC") { v = getobj(win, "STP", i).labtext; v = removehtmltags(v); break; }
			}
			getobj(_wins[10], "INP", 143).xval = v;
			for (i = 586; i <= 599; ++i)
			{
				a[a.length] = getobj(win, "STP", i).xval;
			}
			a = a.join("·");
			pv = "fn180¦" + getobj(_wins[10], "INP", 96).xval + "¦" + getobj(_wins[10], "INP", 94).xval + "¦" + a ;
			actdbpost(_apppath + "dbactions.php", pv);
			showwin(_wins[24], false, 1, 0);
			showblocker(false);
			break;
			
		case "BTN_666":			//action apply to window ok
			actionapplyto();
		case "BTN_665":			//action apply to window cancel
			showwin(win, false, 1, 0);
			showblocker(false);
			break;
		case "BTN_675":          //Sauvegarder les réglages
			saveChecklistToTemp();
			_lookuptg[0].xval = _lookuptg[1].xval.replace( new RegExp(/[^\]*|T-[0-9][0-9]:\{\}[\|]*[ ]*[\$]*/g ), "");
			trace("Checklist filter cleaned up:", _lookuptg[0].xval);
			
		case "BTN_676":			//Fermer la fenêtre
			showwin(_wins[27], false, 1, 0);
			showblocker(false);
			break;
			
		default:
			break;
	}
}

private function obactbtnq(ob, obn, win):void
{
	var v;
	questbizrules(ob, obn, win);
}

private function objactionsover(ob):*
{
	var win;
	win = ob.parent.parent;
}

private function objactionsout(ob):*
{
	var win;
	win = ob.parent.parent;
}

private function winrefresh(win):void
{
	if (win == _wins[9])
	{
		dbloadlist("USR", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0]);
	}
	else if (win == _wins[11])
	{
		dbloadlist("ACT", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1]);
	}
	else if (win == _wins[13])
	{
		dbloadlist("ASS", _dbpage[2], _dbpagelen[2], _dbflt[2], _dbsort[2], _dbsortdir[2]);
	}
}

private function actionresize(sw, sh):void
{
	var i, l, bt;
	bt = null;
	_wins[4].resizewin(sw - 40, _wins[4].vheight);			//menu
	bt = getobj(_wins[4], "BTN", 52);
	if (bt != null) { bt.x = _wins[4].vwidth - bt.xwidth; }
	_wins[4].x = 20;
	_wins[5].x = 20;										//status bar
	_wins[5].y = _main.back.height;
}

private function onwinlayout(win):void
{
	var v = null;
	if (win == _wins[6])			//login
	{
		getobj(win, "INP", 20).inp.displayAsPassword = true;
	}
	else if (win == _wins[10])			//user item
	{
		getobj(win, "WIS", 105).htext.x = -100;
		//getobj(win, "INP", 110).inp.displayAsPassword = true;
	}
	else if (win == _wins[13])			//activities list
	{
		getobj(win, "WIS", 283).htext.x = -120;
		getobj(win, "WIS", 284).htext.x = -100;
	}
	else if (win == _wins[14])			//activities item
	{
		getobj(win, "WIS", 308).htext.x = -175;
		getobj(win, "WIS", 336).htext.x = -190;
		getobj(win, "WIS", 337).htext.x = -160;
	}
	else if (win == _wins[16])			//activities filter
	{
		getobj(win, "WIS", 448).htext.x = -80;
	}
	else if (win == _wins[19])			//user actions
	{
		getobj(win, "WIS", 729).htext.x = -190;
		getobj(win, "WIS", 736).htext.y = -60;
		getobj(win, "WIS", 737).htext.x = -190;
		getobj(win, "WIS", 737).htext.y = -220;
	}
	else if (win == _wins[26])			//user actions
	{
		getobj(win, "WIS", 613).htext.x = -220;
		getobj(win, "WIS", 614).htext.x = -190;
	}
	else if (win == _wins[29])			//questionnaire
	{
		questadjustform();
	}
}

private function onwinclose(win):void
{
	if (win == _wins[9])		//users
	{
		showwin(_wins[10], false, 1, 0);
		showwin(_wins[15], false, 1, 0);
		showwin(_wins[19], false, 1, 0);
		getobj(_wins[4], "BTN", 47).xval = "U";
	}
	else if (win == _wins[13])		//agenda
	{
		showwin(_wins[14], false, 1, 0);
		showwin(_wins[16], false, 1, 0);
		showwin(_wins[21], false, 1, 0);
		getobj(_wins[4], "BTN", 48).xval = "U";
	}
	else if (win == _wins[11])		//assets
	{
		showwin(_wins[12], false, 1, 0);
		showwin(_wins[17], false, 1, 0);
		showwin(_wins[20], false, 1, 0);
		getobj(_wins[4], "BTN", 49).xval = "U";
	}
	else if (win == _wins[7])		//help
	{
		getobj(_wins[4], "BTN", 51).xval = "U";
	}
	else if (win == _wins[18])		//quest results
	{
		getobj(_wins[4], "BTN", 46).xval = "U";
	}
}

private function actiondragwin(win):void
{
	var i, pa;
	if (win == _wins[6])
	{
			pozwin(_wins[5], false, false, _wins[6].x + 30, _wins[6].y + _wins[6].vheight + 10, true, 0);
	}
}

private function delaypageload():void
{
	var wi;
	wi = arguments[0];
	wi.holder.y = wi.holdermask.y;
	wi.scrlbarv.percent = 0;
	makewinlayout(wi, arguments[1]);
	fitwin(wi, false);
	if (arguments[2] == "R")
	{
		pozwin(wi, false, false, wi.parent.width + 2, wi.y, 0, 0);
	}
	else if (arguments[2] == "L")
	{
		pozwin(wi, false, false, -wi.vwidth - 2, wi.y, 0, 0);
	}
	pozwin(wi, true, true, 0, 0, 1, 0);
}

private function actionalert(... parms):void
{
	var a, t, i, v, pv;
	switch(_alertact)
	{
		case "USRREC":		//update user record from questionnaire
			tofront(_wins[10]);
			pozwin(_wins[10], true, true, 0, 0, 1, 0)
			showwin(_wins[10], true, 1, 0);
			dbloadrecord("USR", _queparti[0]);
			getobj(_wins[10], "BTN", 189).labtext = "Énregistrer";
			break;
		case "USRDEL":
			v = getobj(_wins[9], "LST", 79).selrow;
			dbdeleterecord("USR", v[0]);
			break;
		case "ACTDEL":
			v = getobj(_wins[13], "LST", 285).selrow;
			dbdeleterecord("ACT", v[0]);
			break;
		case "ASSDEL":
			v = getobj(_wins[11], "LST", 201).selrow;
			dbdeleterecord("ASS", v[0]);
			break;
		case "ACTNEW":
			v = getobj(_wins[13], "LST", 285).selrow;
			//getobj(_wins[14], "INP", 300).xval = _curuser[0];		//idu
			//getobj(_wins[14], "INP", 311).xval = _curuser[4];		//idusr
			//getobj(_wins[14], "INP", 312).xval = _curuser[1] + " " + _curuser[2];		//nameusr
			getobj(_wins[14], "INP", 300).xval = v[8];		//idu
			getobj(_wins[14], "INP", 311).xval = v[9];		//idusr
			getobj(_wins[14], "INP", 312).xval = v[10];		//nameusr
			getobj(_wins[14], "INP", 301).xval = v[11];		//idp
			getobj(_wins[14], "STP", 298).xval = v[1];		//activity
			getobj(_wins[14], "STP", 303).xval = v[2];		//etat
			getobj(_wins[14], "STP", 304).xval = v[3];		//mode
			getobj(_wins[14], "STP", 305).xval = v[4];		//code
			getobj(_wins[14], "INP", 327).xval = v[12];		//idparty
			getobj(_wins[14], "INP", 328).xval = v[13];		//nameparti
			getobj(_wins[14], "STP", 331).xval = v[14];		//type user
			getobj(_wins[14], "STP", 332).xval = v[15];		//phase user
			getobj(_wins[14], "STP", 333).xval = v[16];		//step user
			getobj(_wins[14], "STP", 334).xval = v[17];		//status user
			getobj(_wins[14], "INP", 330).xval = v[18];		//xgroup user
			getobj(_wins[14], "INP", 339).xval = v[19];		//rate km
			getobj(_wins[14], "INP", 340).xval = v[20];		//rate hrs
			getobj(_wins[14], "CAL", 322).xval = getobj(_wins[14], "CAL", 324).xval = defdate();		//start + end date
			break;
		case "USRUTD":			//update user from activity
			t = trim(getobj(_wins[14], "INP", 328).xval);
			i = t.indexOf(" ");		//	var a1 = a.substr(0, i);	var a2 = a.substr(i + 1);
			pv = "fn122¦" + getobj(_wins[14], "INP", 301).xval + "¦" + getobj(_wins[14], "STP", 331).xval + "¦" + getobj(_wins[14], "STP", 332).xval + "¦" + getobj(_wins[14], "STP", 333).xval + "¦" + getobj(_wins[14], "STP", 334).xval + "¦" + t.substr(0, i) + "¦" + t.substr(i + 1) + "¦" + getobj(_wins[14], "INP", 311).xval;
			actdbpost(_apppath + "dbactions.php", pv);
			break;
		case "ABAN":		//quest. abandon
			getobj(_wins[4], "BTN", 46).xval = "U";
			showwin(_wins[29], false, 1, 0);
			questsaveansw("ABAN");
			break;
		case "QUIT":			//quest. quit
			getobj(_wins[4], "BTN", 46).xval = "U";
			showwin(_wins[29], false, 1, 0);
			questsaveansw("QUIT");
			break;
		default:
			break;
	}
}

private function actionapplyto():void
{
	var v, lay, pv;
	if (_acttarget == "USRXP")		//export users
	{
		v = null;
		try { v = getobj(_wins[19], "LST", 688).selrow; } catch (er) { }
		if (v == null) { lay = 1; } else { lay = v[0]; }
		if (getobj(_wins[25], "RAD", 663).xval == 1)		//filtered list
		{
			if (getobj(_wins[19], "RAD", 682).xval == 1)		//csv
			{
				_dbxfile[0] = "usrlist.txt";
				dbloadlist("USRXCL", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0], _dbxfile[0], lay);
			}
			else if (getobj(_wins[19], "RAD", 683).xval == 1)		//html
			{
				_dbxfile[0] = "usrlist.htm";
				dbloadlist("USRXHL", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0], _dbxfile[0], getobj(_wins[19], "INP", 686).xval, lay, getobj(_wins[19], "STP", 684).xval, getobj(_wins[19], "STP", 685).xval );
			}
		}
		else if (getobj(_wins[25], "RAD", 664).xval == 1)		//selected items
		{
			if ( selrecsarray(_wins[9], "LST", 79) != "")
			{
				if (getobj(_wins[19], "RAD", 682).xval == 1)		//csv
				{
					_dbxfile[0] = "usrlist.txt";
					dbloadlist("USRXCS", _dbpage[0], _dbpagelen[0], selrecsarray(_wins[9], "LST", 79), _dbsort[0], _dbsortdir[0], _dbxfile[0], lay);
				}
				else if (getobj(_wins[19], "RAD", 683).xval == 1)		//html
				{
					_dbxfile[0] = "usrlist.htm";
					dbloadlist("USRXHS", _dbpage[0], _dbpagelen[0], selrecsarray(_wins[9], "LST", 79), _dbsort[0], _dbsortdir[0], _dbxfile[0], getobj(_wins[19], "INP", 686).xval, lay);
				}
			}
		}
	}
	else if (_acttarget == "USRACTPLAN")			//recruitment planning / objectives			
	{
		_dbxfile[0] = "usrlist.htm";
		pv = "fn177¦" + _dbxfile[0] + "¦" + _dbflt[0];
		actdbpost(_apppath + "dbactions.php", pv);
	}
	else if (_acttarget == "USRACTEXE")			//batch activities from users			
	{
		if (getobj(_wins[25], "RAD", 663).xval == 1)		//filtered list
		{
			tblactions(1)
		}
		else if (getobj(_wins[25], "RAD", 664).xval == 1)		//selected items
		{
			tblactions(2)
		}
	}
	
	else if (_acttarget == "ACTXP")		//export activity
	{
		v = null;
		try { v = getobj(_wins[21], "LST", 575).selrow; } catch (er) { }
		if (v == null) { lay = 1; } else { lay = v[0]; }
		if (getobj(_wins[25], "RAD", 663).xval == 1)		//filtered list
		{
			if (getobj(_wins[21], "RAD", 571).xval == 1)		//csv
			{
				_dbxfile[1] = "actlist.txt";
				dbloadlist("ACTXCL", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1], _dbxfile[1], lay);
			}
			else if (getobj(_wins[21], "RAD", 572).xval == 1)		//html
			{
				_dbxfile[1] = "actlist.htm";
				dbloadlist("ACTXHL", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1], _dbxfile[1], getobj(_wins[21], "INP", 573).xval, lay);
			}
		}
		else if (getobj(_wins[25], "RAD", 664).xval == 1)		//selected items
		{
			if ( selrecsarray(_wins[13], "LST", 285) != "")
			{
				if (getobj(_wins[21], "RAD", 571).xval == 1)		//csv
				{
					_dbxfile[1] = "actlist.txt";
					dbloadlist("ACTXCS", _dbpage[1], _dbpagelen[1], selrecsarray(_wins[13], "LST", 285), _dbsort[1], _dbsortdir[1], _dbxfile[1], lay);
				}
				else if (getobj(_wins[21], "RAD", 572).xval == 1)		//html
				{
					_dbxfile[1] = "actlist.htm";
					dbloadlist("ACTXHS", _dbpage[1], _dbpagelen[1], selrecsarray(_wins[13], "LST", 285), _dbsort[1], _dbsortdir[1], _dbxfile[1], getobj(_wins[21], "INP", 573).xval, lay);
				}
			}
		}
	}
	else if (_acttarget == "USRACTREAFFECT")
	{
		var act:String = "ACTREAFFECT";
		var intervA:String = trim((getobj(_wins[19], "INP", 700) as finp1).xval);
		var intervB:String = trim((getobj(_wins[19], "INP", 705) as finp1).xval);
		var reaffectFiltered:Boolean = (getobj(_wins[25], "RAD", 663).xval == 1);		//filtered list
		var usersCrit:String = ( reaffectFiltered ? _dbflt[0] /* Filter conditions as string */ : selrecsarray(_wins[9], "LST", 79) /* Selected users' ids */ );
		if ( usersCrit != "" ) {
			dbloadlist(act, _dbpage[1], _dbpagelen[1], usersCrit, _dbsort[1], _dbsortdir[1], _dbxfile[1], intervA, intervB, reaffectFiltered ? 1 : 0);
		}
	}
	else if (_acttarget == "USRACTGEOLOC")
	{
		var act:String = "ACTGEOLOCATE";
		var showFiltered:Boolean = (getobj(_wins[25], "RAD", 663).xval == 1);		//filtered list
		var usersCrit:String = ( showFiltered ? _dbflt[0] /* Filter conditions as string */ : selrecsarray(_wins[9], "LST", 79) /* Selected users' ids */ );
		if ( usersCrit != "" ) {
			dbloadlist(act, _dbpage[1], _dbpagelen[1], usersCrit, _dbsort[1], _dbsortdir[1], _dbxfile[1], showFiltered ? 1 : 0);
		}
		else {
			alert(_wins[0], (showFiltered ? "Aucun critère de filtrage n'a été spécifié." : "Aucun item n'a été sélectionné."), "");			
		}
	}
	showwin(_wins[25], false, 1, 0);
	showblocker(false);
}

private function showpopimage(fa:Array, ww, hh):void
{
	var ox;
	showblocker(true);
	_wins[3].resizewin(ww + 20, Math.min(hh + 20, _blocker.height * .9));
	ox = getobj(_wins[3], "IMG", 45);
	ox.setpics(fa);
	pozwin(_wins[3], true, true, 0, 0, false, 0);
	showwin(_wins[3], true, 1, 0);
}


//--------------------------------------------- validate form functions


private function resetform(win):void
{
	var i, hld, oc, ox;
	hld = win.getChildByName("holder");
	for (i = 0; i < hld.numChildren; ++i)
	{
		ox = hld.getChildAt(i);
		if (ox.hasOwnProperty("xval"))
		{
			oc = ox.name.substr(4, 3);
			if (oc == "INP" || oc == "DDL" || oc == "STP" || oc == "CAL" || oc == "TIM")
			{
				ox.xval = "---";
			}
			else if (oc == "CHK" || oc == "RAD")
			{
				ox.xval = 0;
			}
			else if (oc == "LST")
			{
				ox.xval = "";
			}
		}
	}
}

private function resetfields(win, fls):void
{
	var i, l, ob;
	l = fls.length;
	for (i = 0; i < l; ++i)
	{
		ob = getobj(win, fls[i][0], fls[i][1]);
		if (fls[i][0] == "INP" || fls[i][0] == "DDL" || fls[i][0] == "STP" || fls[i][0] == "CAL" || fls[i][0] == "TIM")
		{
			ob.xval = "---";
		}
		else if (fls[i][0] == "CHK" || fls[i][0] == "RAD")
		{
			ob.xval = 0;
		}
		else if (fls[i][0] == "LST")
		{
			ob.xval = "";
		}
	}
}

private function validateform(win, subwin):Boolean
{
	var i, l, fl, v1, v2,v3;
	if (win == _wins[10])
	{
		/*
		v = getobj(win, "STP", 93).xval;			//user type
		if (v == "PAR" || v == "POT")
		{
		}
		else
		{
		}
		*/
	}
	else if (win == _wins[14])
	{
		fl = [["STP", 298], ["STP", 303], ["STP", 304], ["STP", 305], ["STP", 309], ["INP", 311], ["CAL", 322], ["CAL", 324], ["CAL", 324], ["INP", 327], ["STP", 332], ["STP", 333]];
		l = fl.length;
		for (i = 0; i < l; ++i)
		{
			if (isempty(getobj(win, fl[i][0], fl[i][1]).xval)) { return false;}
		}
		v1 = getobj(win, "STP", 333).xval;			//etape
		v2 = getobj(win, "INP", 311).xval;			//id resp
		if (v1 == "INT" && (v2.indexOf("INT") == -1 && v2.indexOf("ADM") == -1)) { return false; }
		if (v1 == "REC" && (v2.indexOf("REC") == -1 && v2.indexOf("ADM") == -1)) { return false; }
		v1 = getobj(win, "STP", 309).xval;			//description
		v2 = getobj(win, "STP", 334).xval;			//status
		if(v1 == "ASSIGNÉ RECRUTEUR" && v2 != "ACT") { return false;}
		if(v1 == "RECRUTEMENT" && (v2 == "ACT" || v2 == "NIW")) { return false;}
		if(v1 == "ASSIGNÉ INTERVIEWER" && (v2 != "ACT")) { return false;}
		if (v1 == "INTERVIEW (QUESTIONNAIRE)" && (v2 == "ACT" || v2 == "NRE")) { return false; }
		v3 = getobj(win, "INP", 328).xval;			//user name
		if (v1 == "ASSIGNÉ RECRUTEUR" && !isempty(v3)) { return false; }
		if (v1 == "RECRUTEMENT")
		{
			if ((v2 == "NRE" && !isempty(v3)) || (v2 != "NRE" && isempty(v3))) { return false; }
		}
		if((v1 == "ASSIGNÉ INTERVIEWER" || v1 == "INTERVIEW (QUESTIONNAIRE)") && isempty(v3)) { return false; }
	}
	else if (win == _wins[19])
	{
		if (subwin == 6)
		{
			fl = [["INP", 541], ["INP", 539], ["INP", 540], ["STP", 543], ["STP", 544], ["STP", 545], ["CAL", 549], ["CAL", 550], ["STP", 551]];
			l = fl.length;
			for (i = 0; i < l; ++i)
			{
				if (isempty(getobj(win, fl[i][0], fl[i][1]).xval)) { return false;}
			}
			v1 = getobj(win, "STP", 734).xval;			//etape
			v2 = getobj(win, "INP", 720).xval;			//id resp
			if (v1 == "INT" && (v2.indexOf("INT") == -1 && v2.indexOf("ADM") == -1)) { return false; }
			if (v1 == "REC" && (v2.indexOf("REC") == -1 && v2.indexOf("ADM") == -1)) { return false; }
			v1 = getobj(win, "STP", 732).xval;			//description
			v2 = getobj(win, "STP", 735).xval;			//status
			if(v1 == "ASSIGNÉ RECRUTEUR" && v2 != "ACT") { return false;}
			if (v1 == "ASSIGNÉ INTERVIEWER" && v2 != "ACT") { return false; }
			fl = [["STP", 552], ["STP", 553], ["STP", 554]];
			l = fl.length;
			if (v1 == "ASSIGNÉ RECRUTEUR" || v1 == "ASSIGNÉ INTERVIEWER")
			{
				for (i = 0; i < l; ++i)
				{
					if (isempty(getobj(win, fl[i][0], fl[i][1]).xval)) { return false;}
				}
			}
			else
			{
				for (i = 0; i < l; ++i)
				{
					if (!isempty(getobj(win, fl[i][0], fl[i][1]).xval)) { return false;}
				}
			}
		}
	}
	return true;
}


//--------------------------------------------- permissions


private function setwinperms(win):void
{
	var i, lst, lstv, flt, ena, a, wif, t, tb ;
	if (win == _wins[9])				//users list
	{
		wif = _wins[15];		//user filter
		resetform(wif);
		lst = [["INP", 83], ["BTN", 84], ["BTN", 85], ["BTN", 86], ["BTN", 87], ["BTN", 88], ["BTN", 90], ["BTN", 91], ["BTN", 92]];		//list buttons
		ena = [["STP", 358], ["STP", 359], ["CHK", 361], ["CHK", 362], ["CHK", 363], ["CHK", 364], ["CHK", 365], ["CHK", 366], ["CHK", 367], ["CHK", 368], ["CHK", 370], ["CHK", 371], ["CHK", 372], ["CHK", 373], ["CHK", 374], ["CHK", 375], ["CHK", 376], ["CHK", 377], ["CHK", 378], ["CHK", 379], ["CHK", 380], ["CHK", 381], ["CHK", 382], ["CHK", 383], ["CHK", 384], ["CHK", 385], ["CHK", 387], ["CHK", 388], ["CAL", 389], ["CAL", 390], ["CHK", 391], ["CHK", 392], ["CHK", 393], ["CHK", 394], ["CHK", 395], ["CHK", 396], ["INP", 397], ["INP", 398], ["CHK", 400], ["CHK", 401], ["CHK", 402], ["CHK", 403], ["CHK", 404], ["CHK", 405], ["STP", 407], ["INP", 408], ["INP", 409], ["INP", 413], ["BTN", 414], ["RAD", 415], ["RAD", 416], ["STP", 417], ["INP", 420], ["CAL", 423], ["CAL", 424], ["INP", 425], ["INP", 426], ["INP", 427], ["INP", 418], ["INP", 419], ["BTN", 422]];
		if (_curuser[3] == "REC")
		{
			lstv = [1, 1, 0, 0, 0, 0, 1, 0, 0];
			_dbflt[0] = "1·0·0·0·0·0·0·0·" + _curphase + "·---·1·1·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·---·---·0·0·---·" + _curuser[4] + "·---·---·---·---·---";		//parti asigned to logged recruiter
		}
		else if (_curuser[3] == "INT")
		{
			lstv = [1, 1, 0, 0, 0, 0, 1, 0, 0];
			_dbflt[0] = "0·0·0·0·0·0·0·0·" + _curphase + "·---·0·0·0·1·0·0·0·1·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·---·---·1·0·---·" + _curuser[4] + "·---·---·---·---·---";			//parti asigned to logged interviewer
		}
		else if (_curuser[3] == "PRE")
		{
			lstv = [1, 1, 1, 0, 0, 0, 0, 0, 0];
			_dbflt[0] = "1·0·0·0·0·0·0·0·---·---·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·---·---·0·0·---·---·---·---·---·---·---";		//parti
			for (i = 0; i < ena.length; ++i) { enableobj(wif, ena[i][0], ena[i][1]); }
			a = [["CHK", 350], ["CHK", 351], ["CHK", 352], ["CHK", 353], ["CHK", 354], ["CHK", 355], ["CHK", 356]];
			for (i = 0; i < a.length; ++i) { disableobj(wif, a[i][0], a[i][1]); }
			getobj(wif, "CHK", 349).xval = 1; 
		}
		else if (_curuser[3] == "SUP")
		{
			lstv = [1, 1, 1, 1, 0, 0, 1, 0, 0];
			_dbflt[0] = "1·1·0·0·0·0·0·0·---·---·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·---·---·0·0·---·---·---·---·---·---·---";		//parti + prospects
			for (i = 0; i < ena.length; ++i) { enableobj(wif, ena[i][0], ena[i][1]); }
			a = [["CHK", 351], ["CHK", 352], ["CHK", 353], ["CHK", 354], ["CHK", 355], ["CHK", 356]];
			for (i = 0; i < a.length; ++i) { disableobj(wif, a[i][0], a[i][1]); }
			getobj(wif, "CHK", 349).xval = getobj(wif, "CHK", 350).xval = 1; 
		}
		else if (_curuser[3] == "ADM" || _curuser[3] == "AUT")
		{
			lstv = [1, 1, 1, 1, 1, 0, 1, 1, 1];
			_dbflt[0]  = "";
		}
		t = 0;
		tb = "USR";
	}
	else if (win == _wins[13])			//activities list
	{
		wif = _wins[16];
		resetform(wif);
		lst = [["INP", 291], ["BTN", 292], ["BTN", 293], ["BTN", 294], ["BTN", 295], ["BTN", 296], ["BTN", 297]];
		lstv = [1, 1, 1, 1, 1, 1, 1];
		_dbflt[1]  = "";
		t = 1;
		tb = "ACT";
	}
	else if (win == _wins[11])			//assets list
	{
		wif = _wins[17];
		resetform(wif);
		lst = [["INP", 206], ["BTN", 207], ["BTN", 208], ["BTN", 209], ["BTN", 210], ["BTN", 211], ["BTN", 212]];
		lstv = [1, 1, 1, 1, 1, 1, 1];
		_dbflt[2]  = "";
		t = 2;
		tb = "ASS";
	}
	else
	{
		return;
	}
	
	for (i = 0; i < lst.length; ++i)
	{
		if (lstv[i]) { enableobj(win, lst[i][0], lst[i][1]); } else { disableobj(win, lst[i][0], lst[i][1]); }
	}
	
	_dbpage[t] = 0;
	dbloadlist(tb, _dbpage[t], _dbpagelen[t], _dbflt[t], _dbsort[t], _dbsortdir[t]);
}

private function setfldsperms(win:*):void
{
	var i, hld, oc, ox, v, fl, l;
	hld = win.getChildByName("holder");
	for (i = 0; i < hld.numChildren; ++i)
	{
		ox = hld.getChildAt(i);
		if (ox.hasOwnProperty("xval")) 
		{
			oc = ox.name.split("_");
			enableobj(win, oc[1], oc[2]);
		}
	}
	if (win == _wins[10])
	{
		v = getobj(win, "STP", 93).xval;			//user type
		if (v == "PAR" || v == "POT")
		{
			if(_curuser[3] != "AUT")
			{
				fl = [["INP", 95], ["INP", 96], ["STP", 100], ["STP", 101], ["STP", 102], ["STP", 103], ["INP", 109], ["INP", 110], ["INP", 184], ["INP", 185]];			//["INP", 152], ["INP", 153], ["CAL", 154] , ["INP", 155], ["INP", 156], ["TIM", 157], ["TIM", 158], ["INP", 159], ["INP", 160], ["BTN", 161], ["INP", 162], ["INP", 163], ["STP", 164], ["STP", 165], ["INP", 166]
			}
			else
			{
				fl = [["INP", 95], ["INP", 96], ["INP", 109], ["INP", 110], ["INP", 184], ["INP", 185]];
			}
		}
		else
		{
			fl = [["STP", 100], ["STP", 101], ["STP", 102], ["STP", 103], ["CAL", 106], ["CAL", 107], ["STP", 117], ["INP", 118], ["STP", 119], ["INP", 121], ["STP", 122],["INP", 143], ["BTN", 146],  ["INP", 147], ["INP", 148], ["INP", 149], ["INP", 180], ["BTN", 181], ["INP", 182], ["LST", 187]];
		}
		l = fl.length;
		for (i = 0; i < l; ++i) { disableobj(win, fl[i][0], fl[i][1]); }
	}
}


//--------------------------------------------- db functions


private function dbloadlookup(tb, flt)
{
	var t, l;
	if (tb == "USRLKP")
	{
		t = 3;
		l = 5;
	}
	else if (tb == "USRADDR")
	{
		t = 4;
		l = 8;
	}
	_dbpage[t] = 0;
	_dbpagelen[t] = l;
	_dbflt[t] = flt;
	dbloadlist(tb, _dbpage[t], _dbpagelen[t], _dbflt[t], _dbsort[t], _dbsortdir[t]);
}

private function dbloginuser(uid:String, pwd:String):void
{
	var pv;
	pv = "fn100¦" + uid + "¦" + pwd;		//·
	actdbpost(_apppath + "dbactions.php", pv);
}

private function dbloadquest(que:String, par:String):void
{
	var pv;
	pv = "fn101¦" + que + "¦" + par;
	actdbpost(_apppath + "dbactions.php", pv);
}

private function dblistscroll(sn):void
{
	var p, t, tb;
	if (sn == "OBJ_LST_79")			//users list
	{
		t = 0; tb = "USR";
	}
	else if (sn == "OBJ_LST_285")		//activities list
	{
		t = 1; tb = "ACT";
	}
	else if (sn == "OBJ_LST_201")			//assets list
	{
		t = 2; tb = "ASS";
	}
	else if (sn == "OBJ_LST_23")			//users lookup
	{
		t = 3; tb = "USRLKP";
	}
	else if (sn == "OBJ_LST_42")			//addresse lookup
	{
		t = 4; tb = "USRADDR";
	}
	else
	{
		return;
	}
	if (_dbrows[t] <= _dbpagelen[t]) { _scroller.percent = 0; return; }
	p = Math.round(_scroller.percent * _dbrows[t]);
	if (p < 0) { p = 0; }
	if (p > _dbrows[t] - _dbpagelen[t]) { p = _dbrows[t] - _dbpagelen[t]; }
	_dbpage[t] = p;
	dbloadlist(tb, _dbpage[t], _dbpagelen[t], _dbflt[t], _dbsort[t], _dbsortdir[t]);
}

private function dbnextpage(ls):void
{
	var sn, t, tb;
	sn = ls.name;
	if (sn == "OBJ_LST_79")			//users list
	{
		t = 0; tb = "USR";
	}
	else if (sn == "OBJ_LST_285")			//activities list
	{
		t = 1; tb = "ACT";
	}
	else if (sn == "OBJ_LST_201")			//assets list
	{
		t = 2; tb = "ASS";
	}
	else if (sn == "OBJ_LST_23")			//users lookup
	{
		t = 3; tb = "USRLKP";
	}
	else if (sn == "OBJ_LST_42")			//addresse lookup
	{
		t = 4; tb = "USRADDR";
	}
	else
	{
		return;
	}
	_dbpage[t] = Math.min(_dbpage[t] + _dbpagelen[t] - 1, _dbrows[t] - _dbpagelen[t]);
	ls.percent = _dbpage[t] / _dbrows[t];
	dbloadlist(tb, _dbpage[t], _dbpagelen[t], _dbflt[t], _dbsort[t], _dbsortdir[t]);
}

private function dbprevpage(ls):void
{
	var sn, t, tb;
	sn = ls.name;
	if (sn == "OBJ_LST_79")			//users list
	{
		t = 0; tb = "USR";
	}
	else if (sn == "OBJ_LST_285")			//activities list
	{
		t = 1; tb = "ACT";
	}
	else if (sn == "OBJ_LST_201")			//assets list
	{
		t = 2; tb = "ASS";
	}
	else if (sn == "OBJ_LST_23")			//users lookup
	{
		t = 3; tb = "USRLKP";
	}
	else if (sn == "OBJ_LST_42")			//addresse lookup
	{
		t = 4; tb = "USRADDR";
	}
	else
	{
		return;
	}
	_dbpage[t] = Math.max(_dbpage[t] - _dbpagelen[t] + 1, 0);
	ls.percent = _dbpage[t] / _dbrows[t];
	dbloadlist(tb, _dbpage[t], _dbpagelen[t], _dbflt[t], _dbsort[t], _dbsortdir[t]);
}

private function dbloadlist(tbl:String, po:int, ps:int, flt:String, srt:String, srtd:String, ... parms):void			//tbl=table (USR,ACT,MAT), po=db table paging offset, ps=db table page size, flt = filter: val1.val2.val3...  where vals in same order as from the filter form, srt = sort colum, srtd = sort direction		
{
	var pv, pa;
	if (tbl == "USR")
	{
		pv = "fn102¦";
	}
	else if (tbl == "USRLKP")
	{
		pv = "fn110¦";
	}
	
	else if (tbl == "USRXCL")
	{
		pv = "fn150¦";
	}
	else if (tbl == "USRXCS")
	{
		pv = "fn151¦";
	}
	else if (tbl == "USRXHL")
	{
		pv = "fn160¦";
	}
	else if (tbl == "USRXHS")
	{
		pv = "fn161¦";
	}
	else if (tbl == "USRADDR")
	{
		pv = "fn170¦";
	}
	

	else if (tbl == "ACT")
	{
		pv = "fn202¦";
	}
	else if (tbl == "ASS")
	{
		pv = "fn302¦";
	}
	else if (tbl == "ACTXCL")
	{
		pv = "fn250¦";
	}
	else if (tbl == "ACTXCS")
	{
		pv = "fn251¦";
	}
	else if (tbl == "ACTXHL")
	{
		pv = "fn260¦";
	}
	else if (tbl == "ACTXHS")
	{
		pv = "fn261¦";
	}
	else if (tbl == "ACTREAFFECT")
	{
		pv = "fn176¦";
	}
	else if (tbl == "ACTGEOLOCATE")
	{
		pv = "fn178¦";
	}
	else
	{
		return;
	}
	if (parms.length > 0) { pa = "¦" + parms.join("¦"); } else { pa = ""; }
	pv += po + "¦" + ps + "¦" + flt + "¦" + srt + "¦" + srtd + pa;
	actdbpost(_apppath + "dbactions.php", pv);
}

private function dbfindrec(tbl:String, v:String)
{
	var f, fa, l, vf;
	if (tbl == "USR")
	{
		f = 0;
		_dbpage[f] = 0;
		if (_dbflt[f] == "") { _dbflt[f] = "1·1·1·1·1·1·1·1·---·---·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·0·0·0·0·0·0·---·---·---·---·0·0·---·---·---·---·---·---·---"; }
		if (!isempty(v)) { vf = v; } else { vf = "---"; }
		fa = _dbflt[f].split("·");
		l = fa.length - 1;
		//fa[l] = fa[l - 1] = fa[l - 2] = fa[l - 3] = vf;
		fa[l - 2] = vf;
	}
	else if (tbl == "ACT")
	{
		f = 1;
		_dbpage[f] = 0;
		if (_dbflt[f] == "") { _dbflt[f] = "1·1·0·0·0·0·0·0·---·---·0·0·---·---·---·---·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·0·---·---·---"; }
		if (!isempty(v)) { vf = v; } else { vf = "---"; }
		fa = _dbflt[f].split("·");
		l = fa.length - 1;
		fa[l] = vf;
	}
	else if (tbl == "ASS")
	{
		f = 2;
		_dbpage[f] = 0;
		if (_dbflt[f] == "") { _dbflt[f] = "1·1·1·1·1·1·---·---·---"; }
		if (!isempty(v)) { vf = v; } else { vf = "---"; }
		fa = _dbflt[f].split("·");
		l = fa.length - 1;
		fa[l] = vf;
	}
	else
	{
		return;
	}
	_dbflt[f] = fa.join("·");
	//trace(_dbflt[f]);
}

private function dbloadrecord(tbl:String, id:String):void		//tbl=table
{
	var pv;
	if (tbl == "USR")
	{
		pv = "fn103¦" + id;
	}
	else if (tbl == "ACT")
	{
		pv = "fn203¦" + id;
	}
	else if (tbl == "ASS")
	{
		pv = "fn303¦" + id;
	}
	else if (tbl == "USRADDV")		//load visited address
	{
		pv = "fn181¦" + id;
	}
	else if (tbl == "USRADDM")		//load mail address
	{
		pv = "fn182¦" + id;
	}
	else
	{
		return;
	}
	actdbpost(_apppath + "dbactions.php", pv);
}

private function dbsaverecord(tbl:String)
{
	var i, l, a, v, ob, wh, pv;
	if (tbl == "USR")
	{
		wh = _wins[10].holder;
		pv = "fn104";
	}
	else if (tbl == "ACT")
	{
		wh = _wins[14].holder;
		pv = "fn204";
	}
	else if (tbl == "ASS")
	{
		wh = _wins[12].holder;
		pv = "fn304";
	}
	else if (tbl == "USRADDM")		//save mail address
	{
		wh = _wins[28].holder;
		pv = "fn183";
	}
	else
	{
		return;
	}
	a = [];
	l = wh.numChildren;
	for (i = 0; i < l; ++i) 
	{
		ob = wh.getChildAt(i);
		if (ob.hasOwnProperty("xdbfld"))
		{
			if (ob.xdbfld > 0)
			{ 
				v = ob.xval;
				if (v == "---") { v = ""; }
				a[a.length] = [ob.xdbfld, v];
			}
		}
	}
	a.sortOn(["0"], [Array.NUMERIC]);
	l = a.length;
	for (i = 0; i < l; ++i) { pv += "¦" + a[i][1]; }
	actdbpost(_apppath + "dbactions.php", pv)
}

private function dbsaverecordcombo(win:*):void
{
	var i, u, a, l, f, v, ob, pv, wh;
	if (win == _wins[26])
	{
		//getobj(win, "CAL", 615).xval = getobj(win, "CAL", 647).xval;
		//getobj(win, "CAL", 616).xval = dateadd(getobj(win, "CAL", 647).xval, 730);
		if (!validateform(win, 0)) { return; }
		wh = win.holder;
		u = [];
		for (i = 0; i < 78; ++i) { u[i + 1] = ""; }		// 78 = users table field count
		l = wh.numChildren;
		for (i = 0; i < l; ++i) 
		{
			ob = wh.getChildAt(i);
			if (ob.hasOwnProperty("xdbfld"))
			{
				f = ob.xdbfld;
				if (f > 0)
				{ 
					v = ob.xval;
					if (v == "---") { v = ""; }
					u[f] = v;
				}
			}
		}
		u = u.join("|");
		//a = getobj(win, "CAL", 647).xval + "|" + getobj(win, "INP", 648).xval + "|" + getobj(win, "INP", 649).xval + "|" + getobj(win, "INP", 650).xval + "|" + getobj(win, "INP", 651).xval + "|" + getobj(win, "INP", 652).xval + "|" + getobj(win, "INP", 653).xval + "|" + getobj(win, "INP", 654).xval + "|" + getobj(win, "INP", 655).xval; 
		a = getobj(win, "CAL", 647).xval + "|" + getobj(win, "INP", 648).xval + "|" + getobj(win, "INP", 649).xval + "|" + getobj(win, "INP", 650).xval + "|" + getobj(win, "INP", 651).xval + "|" + getobj(win, "INP", 652).xval + "|" + getobj(win, "INP", 653).xval + "|" + getobj(win, "INP", 654).xval; 
		pv = "fn131¦" + _curuser[0] + "|" + _curuser[1] + " " + _curuser[2] + "|" + _curuser[4] + "¦" + u + "¦" + a;
		actdbpost(_apppath + "dbactions.php", pv)
	}
}

private function dbdeleterecord(tbl:String, id:String):void
{
	var pv;
	if (tbl == "USR")
	{
		pv = "fn105¦" + id;
	}
	else if (tbl == "ACT")
	{
		pv = "fn205¦" + id;
	}
	else if (tbl == "ASS")
	{
		pv = "fn305¦" + id;
	}
	else
	{
		return;
	}
	actdbpost(_apppath + "dbactions.php", pv);	
}

private function actdbpost(purl:String, pv:String):void
{
	var rq, vs;
	trace(purl, pv);
	showpreloader();
	_actloader = new URLLoader();
	_actloader.dataFormat = URLLoaderDataFormat.TEXT;
	rq = new URLRequest();
	rq.method = URLRequestMethod.POST;
	vs = new URLVariables();
	vs.pvar = pv;
	rq.url = purl;
	rq.data = vs;
	_actloader.addEventListener(Event.COMPLETE, actdbposted, false, 0, true);
	_actloader.addEventListener(IOErrorEvent.IO_ERROR, actdbioerror, false, 0, true);
	_actloader.load(rq);
}

private function actdbposted(e:Event):void
{
	var i, a, d;
	hidepreloader();
	try { _actloader.removeEventListener(Event.COMPLETE, actdbposted); } catch (er) { }
	try { _actloader.removeEventListener(IOErrorEvent.IO_ERROR, actdbioerror); } catch (er) { }
	_actloader = null;
	d = e.target.data;
	if (d.substr(0, 4) != "-er-")
	{
		if (d == "-ok-fn176-" || d == '-ok-fn178-' || d == "-ok-fn120-" || d == "-ok-fn121-") { alert(_wins[0], "Action effectuée.", ""); }
		actiondb(e.target.data);
	}
	else
	{
		if (d == "-er-sql-")
		{
			a = "Erreur BD SQL.";
		}
		else if (d == "-er-fn100-")
		{
			a = "Login invalide.";
		}
		else if (d == "-er-fn101-")
		{
			a = "Questionnaire ou ID invalide.";
			getobj(_wins[4], "BTN", 46).xval = "U";
		}
		else
		{
			a = "Erreur : " + d.substr(4,5);
		}
		alert(_wins[0], a, "");
	}
}

private function actdbioerror(e:IOErrorEvent):void
{
	hidepreloader();
	_actloader.removeEventListener(Event.COMPLETE, actdbposted);
	_actloader.removeEventListener(IOErrorEvent.IO_ERROR, actdbioerror);
	_actloader = null;
	//_actrequest = null;
	//_actdbvars  = null;
	alert(_wins[0], "Erreur BD I/O.", "");
}

private function actiondb(d:String):void
{
	var i, j, k, v, wi, da, s, a, ox, lst, rec, pv;
	da = d.substr(0, 10);
	if (da == "-ok-fn100-")		//login ok
	{
		d = d.substr(10);
		_curuser = d.split("¦");
		showwin(_wins[6], false, 1, 0);
		showblocker(false);
		//_logged = true;
		//changelabtxt(getobj(_wins[4], "BTN", 52), "Login", "Logout");
		//for (i = 46; i <= 51; ++i) { getobj(_wins[4], "BTN", i).visible = true; }
		/*
		if (_curuser[3] == "PAR" || _curuser[3] == "POT")
		{
			//a = [1, 0, 0, 0, 0, 1, 1];
			a = [1, 0, 0, 0, 0, 1, 1];
		}
		else if (_curuser[3] == "REC")
		{
			a = [0, 1, 0, 0, 0, 1, 1];
		}
		*/
		if (_curuser[3] == "PAR" || _curuser[3] == "POT" || _curuser[3] == "REC")
		{
			alert(_wins[0], "Access réfusé.", "");
			return;
		}
		else if (_curuser[3] == "INT" || _curuser[3] == "PRE")
		{
			//a = [1, 1, 0, 0, 0, 1, 1];
			a = [0, 1, 0, 0, 0, 1, 1];
		}
		else if (_curuser[3] == "SUP")
		{
			//a = [1, 1, 1, 1, 0, 1, 1];
			a = [0, 1, 1, 1, 0, 1, 1];
		}
		else if (_curuser[3] == "ADM")
		{
			//a = [1, 1, 1, 1, 1, 1, 1];
			a = [0, 1, 1, 1, 1, 1, 1];
		}
		else if (_curuser[3] == "AUT")
		{
			a = [1, 1, 1, 1, 1, 1, 1];
		}
		
		_logged = true;
		changelabtxt(getobj(_wins[4], "BTN", 52), "Login", "Logout");
		for (i = 46; i <= 51; ++i) { getobj(_wins[4], "BTN", i).visible = true; }

		for (i = 0; i <= 6; ++i)
		{
			if (a[i] == 1) { enableobj(_wins[4], "BTN", i + 46); } else { disableobj(_wins[4], "BTN", i + 46); }
		}
		ox = _main.getChildAt(1);
		if (ox != null)
		{
			TweenMax.to(ox, .3, { alpha:.1 } );
			//try { TweenMax.to(ox.traces, .3, { autoAlpha:0 } ); } catch (er) { }
			//try { TweenMax.to(ox.tricons, .3, { autoAlpha:0 } ); } catch (er) { }
		}
	}
	else if (da == "-ok-fn101-")		//quest selection ok
	{
		d = d.substr(10);
		_queparti = d.split("¦");
		pv = "fn402¦" + _curquest + "¦" + _queparti[0];
		actdbpost(_apppath + "dbactions.php", pv);
	}
	else if (da == "-ok-fn102-")		//users list ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			s = d.substr(0, j);
			_dbrows[0] = parseInt(s.substr(10));
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("|");
				for (i = 0; i < lst.length; ++i)
				{
					lst[i] = lst[i].split("¦");
				}
			}
		}
		else
		{
			_dbrows[0] = 0;
			lst = "";
		}
		getobj(_wins[9], "LST", 79).xval = lst;		//fill table
		_wins[9].title = "<b>Usagers</b>          [ " + _dbrows[0] + " ]";
	}
	else if (da == "-ok-fn103-")		//get user record ok
	{
		//rec2form(_wins[10], d.substr(10).split("¦"));
		if (_curuser[3] == "INT" || _curuser[3] == "REC") { rec2form(_wins[26], d.substr(10).split("¦")); } else { rec2form(_wins[10], d.substr(10).split("¦")); }
		//rec2form(_wins[10], d.substr(10).split("¦"));
	}
	else if (da == "-ok-fn104-")		//edit / insert user record ok
	{
		dbloadlist("USR", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0]);
	}
	else if (da == "-ok-fn105-")		//delete user record ok
	{
		dbloadlist("USR", _dbpage[0], _dbpagelen[0], _dbflt[0], _dbsort[0], _dbsortdir[0]);
	}
	else if (da == "-ok-fn110-")		//user lookup list ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			s = d.substr(0, j);
			_dbrows[3] = parseInt(s.substr(10));
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("|");
				for (i = 0; i < lst.length; ++i) { lst[i] = lst[i].split("¦"); }
			}
			_userLookupNumResults = lst.length;
		}
		else
		{
			_dbrows[3] = 0;
			lst = "";
			_userLookupNumResults = 0;
		}
		getobj(_wins[22], "LST", 23).xval = lst;		//fill table
		_wins[22].title = "<b>Enregistrement(s) trouvé(s)</b>          [ " + _dbrows[3] + " ]"
	}
	else if (da == "-ok-fn111-")		//resp for user from activities ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			s = d.substr(0, j);
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("|");
				for (i = 0; i < lst.length; ++i) { lst[i] = lst[i].split("¦"); }
				getobj(_wins[10], "LST", 187).xval = lst;		//fill table
			}
			else
			{
				getobj(_wins[10], "LST", 187).xval = "";		//clear table
			}
		}
		else
		{
			getobj(_wins[10], "LST", 187).xval = "";		//clear table
		}
	}
	else if (da == "-ok-fn112-")		//get new user id ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			v = d.substr(j + 1);			//remove also the first | (pipe)
			if (v != "")
			{
				 var tauxKM:String = '---', tauxHeure:String = '---';
				if (v.substr(0, 3) == "INT" ) {
					tauxKM = "0.43";
					tauxHeure = "21.00";
				}
				getobj(_wins[10], "INP", 184).xval = tauxKM;
				getobj(_wins[10], "INP", 185).xval = tauxHeure;
				if (isNaN(parseInt(v)))
				{
					v = v.substr(0, 3) + zeropad((parseInt(v.substr(3)) + 1), 3);
				}
				else
				{
					v = parseInt(v) + 1;
				}
			}
			getobj(_wins[10], "INP", 94).xval = v;
		}
	}
	else if (da == "-ok-fn122-")		//user updated from activities ok
	{
		s = parseInt(d.substr(10));
		dbloadrecord("USR", s);
		getobj(_wins[10], "BTN", 189).labtext = "Énregistrer";
		scrollto(_wins[10], 0);
		tofront(_wins[10]);
		pozwin(_wins[10], true, true, 0, 0, 1, 0)
		showwin(_wins[10], true, 1, 0);
	}
	else if (da == "-ok-fn130-")		//loaded activity data for user restricted edit form ok
	{
		//a = [["CAL", 647], ["INP", 648], ["INP", 649], ["INP", 650], ["INP", 651], ["INP", 652], ["INP", 653], ["INP", 654]];
		a = [["INP", 648], ["INP", 649], ["INP", 650], ["INP", 651], ["INP", 652], ["INP", 653], ["INP", 654]];
		//for (i = 0; i < a.length; ++i) { getobj(_wins[26], a[i][0], a[i][1]).xval = ""; }
		for (i = 0; i < a.length; ++i) { getobj(_wins[26], a[i][0], a[i][1]).xval; }
		j = d.indexOf("|");
		if (j != -1)
		{
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("¦");
				//trace(lst);
				for (i = 0; i < a.length; ++i) { getobj(_wins[26], a[i][0], a[i][1]).xval = lst[i]; }
			}
		}
	}
	else if (da == "-ok-fn131-")		//saved activity data for user restricted edit form ok
	{
		
	}
	else if (da == "-ok-fn150-" || da == "-ok-fn151-" || da == "-ok-fn160-" || da == "-ok-fn161-")		//users export lists ok
	{
		getURL(_apppath + _dbxfile[0], "_blank");
	}
	else if (da == "-ok-fn170-")		//user lookup list ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			s = d.substr(0, j);
			_dbrows[4] = parseInt(s.substr(10));
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("|");
				for (i = 0; i < lst.length; ++i) { lst[i] = lst[i].split("¦"); }
			}
		}
		else
		{
			_dbrows[4] = 0;
			lst = "";
		}
		getobj(_wins[23], "LST", 42).xval = lst;		//fill table
		_wins[23].title = "<b>Enregistrement(s) trouvé(s)</b>          [ " + _dbrows[4] + " ]"
	}
	else if (da == "-ok-fn177-")		//activities planning ok
	{
		getURL(_apppath + _dbxfile[0], "_blank");
	}
	else if (da == "-ok-fn178-") {
		getURL('carte.htm');
	}
	else if (da == "-ok-fn181-")		//user visited addresses
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			lst = d.substr(j+1);			//remove also the first | (pipe)
			lst = lst.split("|");
			if (lst.length > 0)
			{
				for (i = 0; i < 14; ++i) { try { getobj(_wins[24], "STP", 586 + i).xval = lst[i]; } catch (er) { } }
				getobj(_wins[24], "LAB", 600).labtext = "Adresse principale (A-0) :\r" + lst[14] + "\r" + "Lat : " + lst[15] + "  Lng : " + lst[16] + "  Zones : " + lst[17] + "  " + lst[18] + "  " + lst[19];
			}
		}
	}
	else if (da == "-ok-fn182-")		//loaded mail address record
	{
		rec2form(_wins[28], d.substr(10).split("¦"));
	}
	else if (da == "-ok-fn202-")		//activities list ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			s = d.substr(0, j);
			_dbrows[1] = parseInt(s.substr(10));
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("|");
				for (i = 0; i < lst.length; ++i)
				{
					lst[i] = lst[i].split("¦");
					for (k = 0; k < lst[i].length; ++k)
					{
						if (lst[i][k] == "0000-00-00") { lst[i][k] = ""; }
					}
				}
			}
		}
		else
		{
			_dbrows[1] = 0;
			lst = "";
		}
		getobj(_wins[13], "LST", 285).xval = lst;		//fill table
		_wins[13].title = "<b>Activités</b>          [ " + _dbrows[1] + " ]";
	}
	else if (da == "-ok-fn203-")		//get actvity record ok
	{
		rec2form(_wins[14], d.substr(10).split("¦"));
	}
	else if (da == "-ok-fn204-")		//edit / insert actvity record ok
	{
		dbloadlist("ACT", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1]);
	}
	else if (da == "-ok-fn205-")		//delete actvity record ok
	{
		dbloadlist("ACT", _dbpage[1], _dbpagelen[1], _dbflt[1], _dbsort[1], _dbsortdir[1]);
	}
	else if (da == "-ok-fn250-" || da == "-ok-fn251-" || da == "-ok-fn260-" || da == "-ok-fn261-")		//activities export lists ok
	{
		getURL(_apppath + _dbxfile[1], "_blank");
	}
	else if (da == "-ok-fn302-")		//assets list ok
	{
		j = d.indexOf("|");
		if (j != -1)
		{
			s = d.substr(0, j);
			_dbrows[2] = parseInt(s.substr(10));
			lst = d.substr(j+1);			//remove also the first | (pipe)
			if (lst.length > 0)
			{
				lst = lst.split("|");
				for (i = 0; i < lst.length; ++i)
				{
					lst[i] = lst[i].split("¦");
					for (k = 0; k < lst[i].length; ++k)
					{
						if (lst[i][k] == "0000-00-00") { lst[i][k] = ""; }
					}
				}
			}
		}
		else
		{
			_dbrows[2] = 0;
			lst = "";
		}
		getobj(_wins[11], "LST", 201).xval = lst;		//fill table
		_wins[11].title = "<b>Inventaire matériel</b>          [ " + _dbrows[2] + " ]";
	}
	else if (da == "-ok-fn303-")		//get user record ok
	{
		rec2form(_wins[12], d.substr(10).split("¦"));
	}
	else if (da == "-ok-fn304-")		//edit / insert user record ok
	{
		dbloadlist("ASS", _dbpage[2], _dbpagelen[2], _dbflt[2], _dbsort[2], _dbsortdir[2]);
	}
	else if (da == "-ok-fn305-")		//edit / insert user record ok
	{
		dbloadlist("ASS", _dbpage[2], _dbpagelen[2], _dbflt[2], _dbsort[2], _dbsortdir[2]);
	}
	else if (da == "-ok-fn402-")		//answers loaded ok
	{
		d = d.substr(11);
		da = d.split("¦");
		questclearansw(); 
		if (da[0].length > 0) { questfillansw(da[0]); }
		_wins[29].holder.y = _wins[29].holdermask.y;
		_wins[29].scrlbarv.percent = 0;
		_curqpg = 0;
		makewinlayout(_wins[29], _qnav[_curqpg]);				//refresh first quest page
		showwin(_wins[8], false, 0, 0);
		showblocker(false);
		fitwin(_wins[29], 0)
		showwin(_wins[29], true, 0, 0);
		a = [9, 10, 11, 12, 13, 14, 15, 16, 17, 19, 20, 21];
		for (i = 0; i < a.length; ++i) { showwin(_wins[a[i]], false, 0, 0); }
		a = [47, 48, 49, 50, 51];
		for (i = 0; i < a.length; ++i) { getobj(_wins[4], "BTN", a[i]).xval = "U"; }

		/*
		if (_queparti[2] == "")
		{
			a = "SVP assignez un numéro de dossier à " + _queparti[3] + " " + _queparti[4];
			_alertact = "USRREC";
			alert(_wins[1], a , "");
		}
		*/
	}
	else if (da == "-ok-fn403-")		//answers loaded ok
	{
		d = d.substr(11);
		da = d.split("¦");
		questclearansw(); 
		if (da[0].length > 0)
		{
			try { v = getobj(_wins[8], "LST", 28).selrow; } catch (er) { }
			tofront(_wins[18]);											//show answers window
			pozwin(_wins[18], true, true, 0, 0, 1, 0)
			showwin(_wins[18], true, 1, 0);
			getobj(_wins[18], "LAB", 986).labtext = v[0] + " :     " + getobj(_wins[8], "INP", 30).xval + "  (" + getobj(_wins[8], "INP", 29).xval + ")";
			questansw(da[0]);
		}
	}
}

private function rec2form(win:*, rec:*):void
{
	var i, hld, oc, ox, v;
	hld = win.getChildByName("holder");
	if (rec.length == 1) { return; }
	for (i = 0; i < hld.numChildren; ++i)
	{
		ox = hld.getChildAt(i);
		if (ox.hasOwnProperty("xdbfld") && ox.hasOwnProperty("xval"))
		{
			if (ox.xdbfld > 0)
			{
				oc = ox.name.substr(4, 3);
				v = rec[ox.xdbfld -1];
				if (oc == "CHK_")
				{
					v = int(v);
				}
				else if (oc == "INP" || oc == "DDL" || oc == "STP" || oc == "CAL" || oc == "TIM")
				{
					if (v == "0000-00-00") { v = ""; }
				}
				ox.xval = v;
			}
		}
	}
	if (win == _wins[10]) { setfldsperms(win); }
	adjustrec2form(win);
}

private function adjustrec2form(win:*):void
{
	var v1, v2, b1, b2, pv;
	if (win == _wins[10])		//user edit
	{
		b1 = b2 = 0;
		v1 = getobj(win, "INP", 111).xval;
		if (v1 == "H") { b1 = 1; b2 = 0; } else if (v1 == "F") { b1 = 0; b2 = 1; }
		getobj(win, "RAD", 112).xval = b1;
		getobj(win, "RAD", 113).xval = b2;
		pv = "fn111¦" + getobj(win, "INP", 96).xval;			//user record id
		actdbpost(_apppath + "dbactions.php", pv);			//load responsables list.
	}
	else if (win == _wins[26])		//user edit restricted
	{
		getobj(win, "CAL", 647).xval = getobj(win, "CAL", 615).xval;
		pv = "fn130¦" + _curuser[0] + "¦" + getobj(win, "INP", 605).xval + "¦" + getobj(win, "STP", 611).xval + "¦" + getobj(win, "STP", 612).xval + "¦" + getobj(win, "INP", 610).xval;		//interviewer id + participant id + step + status + phase
		actdbpost(_apppath + "dbactions.php", pv);
	}
}

private function form2rec(win:*):String
{
	return "";
}

private function lookup2form(win):void
{
	var sr;
	if (win == _wins[22])
	{
		var lst:flst1 = getobj(_wins[22], "LST", 23);
		sr = lst.selrow;
		if (sr == null) { 
			if ( _userLookupNumResults == 1 && lst.xval.length == 1 ) {
				sr = lst.xval[0];
			}
			else {
				return; 
			}
		}
		if (_dblookuptg[0] == _wins[14])		//activities item edit
		{
			if (_dblookuptg[1] == "ACTRES")
			{
				getobj(_wins[14], "INP", 300).xval = sr[0];
				getobj(_wins[14], "INP", 311).xval = sr[1];
				getobj(_wins[14], "INP", 312).xval = sr[2] + " " + sr[3];
				getobj(_wins[14], "INP", 339).xval = sr[6];
				getobj(_wins[14], "INP", 340).xval = sr[7];
			}
			else if (_dblookuptg[1] == "ACTPAR")
			{
				getobj(_wins[14], "INP", 301).xval = sr[0];
				getobj(_wins[14], "INP", 327).xval = sr[1];
				getobj(_wins[14], "INP", 328).xval = sr[2] + " " + sr[3];
				getobj(_wins[14], "INP", 330).xval = sr[5];
			}
		}
		else if (_dblookuptg[0] == _wins[15])		//users filter win
		{
			if (_dblookuptg[1] == "ACTRES")
			{
				getobj(_wins[15], "INP", 421).xval = sr[0];
				getobj(_wins[15], "INP", 419).xval = sr[1];
				getobj(_wins[15], "INP", 420).xval = sr[2] + " " + sr[3];
			}
		}
		else if (_dblookuptg[0] == _wins[19])		//actions user
		{
			if (_dblookuptg[1] == "ACVRES1")
			{
				getobj(_wins[19], "INP", 702).xval = sr[0];
				getobj(_wins[19], "INP", 700).xval = sr[1];
				getobj(_wins[19], "INP", 701).xval = sr[2] + " " + sr[3];
			}
			else if (_dblookuptg[1] == "ACVRES2")
			{
				getobj(_wins[19], "INP", 707).xval = sr[0];
				getobj(_wins[19], "INP", 705).xval = sr[1];
				getobj(_wins[19], "INP", 706).xval = sr[2] + " " + sr[3];
			}
			else if (_dblookuptg[1] == "ACVRES3")
			{
				getobj(_wins[19], "INP", 722).xval = sr[0];
				getobj(_wins[19], "INP", 720).xval = sr[1];
				getobj(_wins[19], "INP", 721).xval = sr[2] + " " + sr[3];
				getobj(_wins[19], "INP", 717).xval = sr[6];
				getobj(_wins[19], "INP", 718).xval = sr[7];
			}
		}
		else if (_dblookuptg[0] == _wins[12])		//actions user
		{
			if (_dblookuptg[1] == "ASSPAR")
			{
				getobj(_wins[12], "INP", 229).xval = sr[0];
				getobj(_wins[12], "INP", 227).xval = sr[1];
				getobj(_wins[12], "INP", 228).xval = sr[2] + " " + sr[3];
			}
		}
		else if (_dblookuptg[0] == _wins[8])		//quest launch win
		{
			if (_dblookuptg[1] == "QUEPAR")
			{
				getobj(_wins[8], "INP", 31).xval = sr[0];
				getobj(_wins[8], "INP", 29).xval = sr[1];
				getobj(_wins[8], "INP", 30).xval = sr[2] + " " + sr[3];
			}
		}
	}
}

private function dbmakefilter(tbl:String):void
{
	var a, v, i, f, wi;
	if (tbl == "USR")
	{
		wi  = 15;
		f = 0;
		a = [["CHK", 349], ["CHK", 350], ["CHK", 351], ["CHK", 352], ["CHK", 353], ["CHK", 354], ["CHK", 355], ["CHK", 356], ["STP", 358], ["STP", 359], ["CHK", 361], ["CHK", 362], ["CHK", 363], ["CHK", 364], ["CHK", 365], ["CHK", 366], ["CHK", 367], ["CHK", 368], ["CHK", 370], ["CHK", 371], ["CHK", 372], ["CHK", 373], ["CHK", 374], ["CHK", 375], ["CHK", 376], ["CHK", 377], ["CHK", 378], ["CHK", 379], ["CHK", 380], ["CHK", 381], ["CHK", 382], ["CHK", 383], ["CHK", 384], ["CHK", 385], ["CHK", 387], ["CHK", 388], ["CAL", 389], ["CAL", 390], ["CHK", 391], ["CHK", 392], ["CHK", 393], ["CHK", 394], ["CHK", 395], ["CHK", 396], ["INP", 397], ["INP", 398], ["CHK", 400], ["CHK", 401], ["CHK", 402], ["CHK", 403], ["CHK", 404], ["CHK", 405], ["STP", 407], ["INP", 408], ["INP", 409], ["INP", 414], ["RAD", 416], ["RAD", 417], ["STP", 418], ["INP", 419], ["CAL", 424], ["CAL", 425], ["INP", 426], ["CAL", 411], ["CAL", 412]];
	}
	else if (tbl == "ACT")
	{
		wi = 16;
		f = 1;
		//a = [["CHK", 433], ["CHK", 434], ["RAD", 436], ["RAD", 437], ["RAD", 438], ["RAD", 439], ["RAD", 440], ["RAD", 441], ["CAL", 442], ["CAL", 443], ["CHK", 445], ["CHK", 446], ["STP", 447], ["STP", 449], ["STP", 451], ["STP", 452], ["CHK", 454], ["CHK", 455], ["CHK", 456], ["CHK", 457], ["CHK", 458], ["CHK", 459], ["CHK", 460], ["CHK", 461], ["CHK", 463], ["CHK", 464], ["CHK", 465], ["CHK", 466], ["CHK", 467], ["CHK", 468], ["CHK", 469], ["CHK", 470], ["CHK", 471], ["CHK", 472], ["CHK", 473], ["CHK", 474], ["CHK", 475], ["CHK", 476], ["CHK", 477], ["CHK", 478], ["RAD", 480], ["RAD", 481], ["INP", 482]];
		a = [["CHK", 433], ["CHK", 434], ["RAD", 436], ["RAD", 437], ["RAD", 438], ["RAD", 439], ["RAD", 440], ["RAD", 441], ["CAL", 442], ["CAL", 443], ["CHK", 445], ["CHK", 446], ["STP", 447], ["STP", 449], ["STP", 451], ["STP", 452], ["CHK", 454], ["CHK", 455], ["CHK", 456], ["CHK", 457], ["CHK", 458], ["CHK", 459], ["CHK", 460], ["CHK", 461], ["CHK", 463], ["CHK", 464], ["CHK", 465], ["CHK", 466], ["CHK", 467], ["CHK", 468], ["CHK", 469], ["CHK", 470], ["CHK", 471], ["CHK", 472], ["CHK", 473], ["CHK", 474], ["CHK", 475], ["CHK", 476], ["CHK", 477], ["CHK", 478], ["RAD", 480], ["RAD", 481], ["CAL", 482], ["CAL", 483], ["INP", 484]];
	}
	else if (tbl == "ASS")
	{
		wi = 17;
		f = 2;
		a = [["CHK", 488], ["CHK", 489], ["CHK", 490], ["CHK", 491], ["CHK", 492], ["CHK", 492], ["CAL", 495], ["CAL", 496], ["INP", 497]];
	}
	else
	{
		return;
	}
	_dbflt[f] = "";
	for (i = 0; i < a.length; ++i)
	{
		v = getobj(_wins[wi], a[i][0], a[i][1]).xval;
		if (a[i][0] == "CHK" || a[i][0] == "RAD")
		{
			v = int(v);
		}
		else if (a[i][0] == "INP" || a[i][0] == "STP" || a[i][0] == "DDL" || a[i][0] == "TIM" || a[i][0] == "CAL")
		{
			if (isempty(v)) { v = "---"; }
		}
		if (i == 0) { _dbflt[f] += v; } else { _dbflt[f] += "·" + v; }
	}
	//trace( _dbflt[f]);
}

private function dbloadfilter(tbl:String):void
{
	/*
	var a, v, i, f;
	if (tbl == "USR")
	{
		f = 0;
		a = [["CHK", 349], ["CHK", 350], ["CHK", 351], ["CHK", 352], ["CHK", 353], ["CHK", 354], ["CHK", 355], ["CHK", 356], ["STP", 358], ["STP", 359], ["CHK", 361], ["CHK", 362], ["CHK", 363], ["CHK", 364], ["CHK", 365], ["CHK", 366], ["CHK", 367], ["CHK", 368], ["CHK", 370], ["CHK", 371], ["CHK", 372], ["CHK", 373], ["CHK", 374], ["CHK", 375], ["CHK", 376], ["CHK", 377], ["CHK", 378], ["CHK", 379], ["CHK", 380], ["CHK", 381], ["CHK", 382], ["CHK", 383], ["CHK", 384], ["CHK", 385], ["CHK", 387], ["CHK", 388], ["CAL", 389], ["CAL", 390], ["CHK", 391], ["CHK", 392], ["CHK", 393], ["CHK", 394], ["CHK", 395], ["CHK", 396], ["INP", 397], ["INP", 398], ["CHK", 400], ["CHK", 401], ["CHK", 402], ["CHK", 403], ["CHK", 404], ["CHK", 405], ["STP", 407], ["INP", 408], ["INP", 409], ["INP", 413], ["RAD", 415], ["RAD", 416], ["STP", 417], ["INP", 420], ["CAL", 423], ["CAL", 424], ["INP", 425], ["INP", 426], ["INP", 427]];
	}
	else if (tbl == "ACT")
	{
		f = 1;
		a = [["CHK", 433], ["CHK", 434], ["RAD", 436], ["RAD", 437], ["RAD", 438], ["RAD", 439], ["RAD", 440], ["RAD", 441], ["CAL", 442], ["CAL", 443], ["CHK", 445], ["CHK", 446], ["STP", 447], ["STP", 449], ["STP", 451], ["STP", 452], ["CHK", 454], ["CHK", 455], ["CHK", 456], ["CHK", 457], ["CHK", 458], ["CHK", 459], ["CHK", 460], ["CHK", 461], ["CHK", 463], ["CHK", 464], ["CHK", 465], ["CHK", 466], ["CHK", 467], ["CHK", 468], ["CHK", 469], ["CHK", 470], ["CHK", 471], ["CHK", 472], ["CHK", 473], ["CHK", 474], ["CHK", 475], ["CHK", 476], ["CHK", 477], ["CHK", 478], ["RAD", 480], ["RAD", 481], ["INP", 482]];
	}
	else if (tbl == "ASS")
	{
		f = 2;
		//a = [["CHK", 418], ["CHK", 419], ["CHK", 420], ["CHK", 421], ["CHK", 422], ["CAL", 424], ["CAL", 425], ["INP", 426]];
	}
	else
	{
		return;
	}
	*/
}

private function dbsortlist(tbl:String, fld:String, ob:*):void
{
	var t;
	if (tbl == "USR")
	{
		t = 0;
	}
	else if (tbl == "ACT")
	{
		t = 1;
	}
	else if (tbl == "ASS")
	{
		t = 2;
	}
	else
	{
		return;
	}
	_dbsort[t] = fld;
	if (ob.xval == "U") { _dbsortdir[t] = ""; } else { _dbsortdir[t] = "desc"; }
	_dbpage[t] = 0;
	dbloadlist(tbl, _dbpage[t], _dbpagelen[t], _dbflt[t], _dbsort[t], _dbsortdir[t]);
}

private function tblactions(t):void
{
	var i, a, v, sr, pv;
	switch(t)
	{
		case 1:			//users: actions assign to resp. - filtered list
			a = [["INP", 541], ["INP", 539], ["INP", 540], ["STP", 543], ["STP", 544], ["STP", 545], ["CAL", 549], ["CAL", 550], ["STP", 551], ["STP", 552], ["STP", 553], ["STP", 554], ["INP", 536], ["INP", 537]];
			pv = "fn120¦" +_dbflt[0];
			for (i = 0; i < a.length; ++i)
			{
				v = getobj(_wins[19], a[i][0], a[i][1]).xval;
				if (isempty(v)) { v = ""; }
				pv += "¦" + v;
			}
			actdbpost(_apppath + "dbactions.php", pv);
			break;
		case 2:			//users: actions assign to resp. - selected list items
			a = [["INP", 541], ["INP", 539], ["INP", 540], ["STP", 543], ["STP", 544], ["STP", 545], ["CAL", 549], ["CAL", 550], ["STP", 551], ["STP", 552], ["STP", 553], ["STP", 554], ["INP", 536], ["INP", 537]];
			sr = selrecsarray(_wins[9], "LST", 79);
			if (sr == "") { return; }
			pv = "fn121¦" + sr;
			for (i = 0; i < a.length; ++i)
			{
				v = getobj(_wins[19], a[i][0], a[i][1]).xval;
				if (isempty(v)) { v = ""; }
				pv += "¦" + v;
			}
			actdbpost(_apppath + "dbactions.php", pv);
			break;
		default:
			break;
	}
}

private function selrecsarray(win, ot, oi):String
{
	var i, sr, si;
	sr = getobj(win, ot, oi).selrows;
	if (sr == null) { return ""; }
	si = [];
	for (i = 0; i < sr.length; ++i)
	{
		if ( sr[i] != null ) {
			si[si.length] = sr[i][0];
		}
	}
	si = si.join("·");
	return si;
}

private function setChecklist():void
{
	var v:String = _lookuptg[1].xval;
	var subChecklistStr:String = "";
	var temps:fstp1 = getobj(_wins[27], "STP", 672);
	var t:int = v.indexOf(temps.xval);
	if ( t >= 0 ) {
		var cStart:int = v.indexOf('{', t) + 1;
		var cEnd:int = v.indexOf('}', cStart);
		subChecklistStr = v.substring(cStart, cEnd);
	}
	trace("Got", v, "Setting for time", temps.xval, "based on", subChecklistStr);
	if (subChecklistStr.indexOf("RECH") != -1) { getobj(_wins[27], "CHK", 667).xval = 1; } else { getobj(_wins[27], "CHK", 667).xval = 0; }
	if (subChecklistStr.indexOf("RAMQ") != -1) { getobj(_wins[27], "CHK", 668).xval = 1; } else { getobj(_wins[27], "CHK", 668).xval = 0; }
	if (subChecklistStr.indexOf("AREC") != -1) { getobj(_wins[27], "CHK", 669).xval = 1; } else { getobj(_wins[27], "CHK", 669).xval = 0; }
	if (subChecklistStr.indexOf("SDIAG") != -1) { getobj(_wins[27], "CHK", 670).xval = 1; } else { getobj(_wins[27], "CHK", 670).xval = 0; }
	if (subChecklistStr.indexOf("AUT") != -1) { getobj(_wins[27], "CHK", 671).xval = 1; } else { getobj(_wins[27], "CHK", 671).xval = 0; }
}

private function correctChecklist(v:String, tempCourant:String):String
{
	trace("Got: ", v);
	if (v.length > 0 ) {
		v = tempCourant + ":{" + v + "}";
	}
	trace("Checklist corrected to: ", v);
	return v;
}

private function saveChecklistToTemp():void
{
	var a = ["RECH", "RAMQ", "AREC", "SDIAG", "AUT"];
	var v = [];
	for (var i = 667; i <= 671; ++i)
	{
		if (getobj(_wins[27], "CHK", i).xval == 1) { v[v.length] = a[i - 667]; }
	}
	v = v.join("~");
	var tempChecklistHolder:finp1 = _lookuptg[1];
	var tempCompleteChecklistStr:String = tempChecklistHolder.xval;
	trace("Saving", v, "at time", _checklistTempsCourant, "Checklist before: ", tempCompleteChecklistStr);
	var idx:int = tempCompleteChecklistStr.indexOf(_checklistTempsCourant);
	if ( idx < 0 ) {
		tempCompleteChecklistStr += ( tempCompleteChecklistStr != "" ? "|" : "" ) + _checklistTempsCourant + ":{" + v + "}";
	}
	else {
		var re:RegExp = new RegExp(_checklistTempsCourant + ":\{[A-Z\~]*\}", "i");
		tempCompleteChecklistStr = tempCompleteChecklistStr.replace(re, _checklistTempsCourant + ":{" + v + "}");
	}
	tempChecklistHolder.xval = tempCompleteChecklistStr;
	trace("Temp complete checklist updated to: ", tempCompleteChecklistStr);
}
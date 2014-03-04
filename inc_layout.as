private function splitlayout(d:String):void
{
	var i, j, l, a;
	_appcode = d.split("¦");		//"\n"
	_appcode = _appcode[1].split("|");			//remove pages info
	l = _appcode.length;
	for (i = 0; i < l; ++i)
	{
		_appcode[i] = _appcode[i].split("·");
		for (j = 0; j < _nrarr.length; ++j)
		{
			a = _appcode[i][_nrarr[j]];
			if (!isNaN(a)) { _appcode[i][_nrarr[j]] = parseInt(a) * 1; }
			if (j == 14 || j == 15 || j == 16 || j == 17) { _appcode[i][j] = Math.round(_appcode[i][j]); }
		}
		
	}
	_appcode.sortOn(["3", "17", "16"], [Array.NUMERIC, Array.NUMERIC, Array.NUMERIC]);
}

private function clearlayout():void
{
	var i, l, s, ob;
	l = _wholder.numChildren;
	for (i = l-1; i >= 0; --i) 
	{
		ob = _wholder.getChildAt(i);
		s = ob.name.substr(0, 7);
		if (s != "marker_") { _wholder.removeChild(ob); }
	}
}

private function setlayout(lay):void
{
	var i, t, ob;
	clearlayout();
	t = 1;
	for (i = 0; i < _appcode.length; ++i)
	{
		if (_appcode[i][3] == lay)
		{
			ob = drawobject(_appcode[i]);
			if (getobclass(ob) == "INP" || getobclass(ob) == "DDL" || getobclass(ob) == "STP" || getobclass(ob) == "CAL" || getobclass(ob) == "TIM") { ob.inp.tabIndex = t; t++; }
		}
		else if  (_appcode[i][3] > lay)
		{
			break;
		}
	}
}

private function drawobject(obarr):*
{
	var j, l, t, cl, cls, cln, ta, ob, oo, ox, oy, v, rx, row, tx;
	if (obarr[1] == "INP" || obarr[1] == "DDL" || obarr[1] == "STP" || obarr[1] == "CAL" || obarr[1] == "TIM")
	{
		if (obarr[1] == "INP") { ob = new finp1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[63]); }
		else if (obarr[1] == "DDL") { ob = new fddl1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[63]); }
		else if (obarr[1] == "STP") { ob = new fstp1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[63]); }
		else if (obarr[1] == "CAL") { ob = new fcal1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[63]); }
		else if (obarr[1] == "TIM") { ob = new ftim1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[63]); }
		
		if (obarr[1] == "INP")
		{
			ob.inp.multiline = obarr[37]; 
			ob.xheight = obarr[15];
		}
		else if (obarr[1] == "STP")
		{
			ob.xval = 0; ob.xmax = 50; ob.xmin = 0; //ob.xlist = "---,alpha,beta,gamma,delta,eta";
			ob.xlist = obarr[63];
		}
		if (obarr[38]) { ob.labtext = obarr[18]; } else { tx = obarr[18]; ob.labtext = removehtmltags(tx); }		//html formatted
		ob.inp.maxChars = obarr[35];
		if (obarr[36] != "") { rx = txtreplace(obarr[36], "--", "\\-"); rx += "^|^¦^~^*"; ob.inp.restrict = rx; }
		ob.inp.selectable = obarr[39];
		if (ob.lab.background) { oo = ob; } else { oo = ob.inp; }
		if (obarr[47] != "") { TweenMax.to(oo, .01, { dropShadowFilter: { angle:parseInt(obarr[47]), color:0x000000, alpha:.3, blurX:3, blurY:3, distance:3 } } ); }
		ob.xvar = obarr[5];
		ob.xdbfld =  obarr[4];
		if (obarr[64] == "") { ob.xval = "---"; } else { ob.xval = obarr[64]; }
	}
	else if (obarr[1] == "LAB")
	{
		ob = new flab1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[50] );
		ob.xdbfld =  obarr[4];
		//if (!obarr[50])
		//{
			if (obarr[38]) { ob.labtext = obarr[18]; } else { tx = obarr[18]; ob.labtext = removehtmltags(tx); }
		//}
		ob.lab.selectable = ob.mouseEnabled = ob.mouseChildren = (obarr[39] != 0);
		if (obarr[47] != ""){ TweenMax.to(ob, .01, { dropShadowFilter: { angle:parseInt(obarr[47]), color:0x000000, alpha:.3, blurX:3, blurY:3, distance:3 } } ); }
	}
	else if (obarr[1] == "BTN")
	{
		ob = new fbtn1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[49]);
		if (obarr[38]) { ob.labtext = obarr[18]; } else { tx = obarr[18]; ob.labtext = removehtmltags(tx); }		//html formatted
		ob.lab.multiline = obarr[37];
		//ob.buttonMode = !_editon;
		ob.buttonMode = true;
		if (obarr[47] != ""){ TweenMax.to(ob, .01, { dropShadowFilter: { angle:parseInt(obarr[47]), color:0x000000, alpha:.3, blurX:3, blurY:3, distance:3 } } ); }
	}
	else if (obarr[1] == "CHK")
	{
		ob = new fchk1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34]);
		if (obarr[38]) { ob.labtext = obarr[18]; } else { tx = obarr[18]; ob.labtext = removehtmltags(tx); }		//html formatted
		if (obarr[47] != ""){ TweenMax.to(ob.chkbox, .01, { dropShadowFilter: { angle:parseInt(obarr[47]), color:0x000000, alpha:.3, blurX:3, blurY:3, distance:3 } } ); }
		ob.xvar = obarr[5];
		ob.xdbfld =  obarr[4];
		if (!isNaN(parseInt(obarr[64]))) { ob.xval = parseInt(obarr[64]); }
	}
	else if (obarr[1] == "RAD")
	{
		ob = new frad1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34]);
		if (obarr[38]) { ob.labtext = obarr[18]; } else { tx = obarr[18]; ob.labtext = removehtmltags(tx); }		//html formatted
		if (obarr[47] != ""){ TweenMax.to(ob.radbox, .01, { dropShadowFilter: { angle:parseInt(obarr[47]), color:0x000000, alpha:.3, blurX:3, blurY:3, distance:3 } } ); }
		ob.xvar = obarr[5];
		if (!isNaN(parseInt(obarr[64]))) { ob.xval = parseInt(obarr[64]); }
	}
	else if (obarr[1] == "LST")
	{
		ob = new flst1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[51], obarr[52], obarr[53], obarr[56], obarr[57], obarr[58], obarr[59], obarr[60], obarr[61], obarr[62]);
		ob.xvar = obarr[5];
	}
	else if (obarr[1] == "STA")
	{
		ob = new fsta1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34]);
		//ob.buttonMode = !_editon;
		ob.buttonMode = true;
		if (obarr[47] != ""){ TweenMax.to(ob, .01, { dropShadowFilter: { angle:parseInt(obarr[47]), color:0x000000, alpha:.3, blurX:3, blurY:3, distance:3 } } ); }
		ob.xvar = obarr[5];
		if (!isNaN(parseInt(obarr[64]))) { ob.xval = parseInt(obarr[64]); }
	}
	else if (obarr[1] == "IMG")
	{
		ob = new fimg1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[19], obarr[20], obarr[21], obarr[22], obarr[23], obarr[24], obarr[25], obarr[26], obarr[27], obarr[28], obarr[29], obarr[30], obarr[31], obarr[32], obarr[33], obarr[34], obarr[41], obarr[42], obarr[43], obarr[44]);
		if (obarr[48] != "") { ob.blendMode = obarr[48]; }
		ob.buttonMode = true;
	}
	else if (obarr[1] == "WIS")
	{
		ob = new fwis1("OBJ_" + obarr[1] + "_" + obarr[0], obarr[0], obarr[2], obarr[14], obarr[15], obarr[18]);
	}
	else
	{
		return null;
	}
	
	if (obarr[7] != 0)													//hidden
	{
		ob.visible = false;
		ob.x = ob.y = 0;
	}
	else																//round coordinates of visible objects
	{
		ob.x = Math.round(obarr[16]);
		ob.y = Math.round(obarr[17]);
	}
	if (obarr[8] == 0) { ob.visible = false; }							//visible on start
	if (obarr[6] == 0) 													//enabled
	{
		ob.mouseEnabled = false;
		ob.mouseChildren = false;
		ob.alpha = .3; 
	}
	else
	{
		ob.mouseEnabled = true;
		ob.mouseChildren = true;
		ob.alpha = obarr[46] / 100;											//alpha
	}
	
	ob.scaleX = ob.scaleY = obarr[45] / 100;							//scale
	_wholder.addChild(ob);
	return ob;
}

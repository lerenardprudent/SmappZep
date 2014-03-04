private function txtreplace(s, t, u):String
{
	// s  string to be processed, t  token to be found and removed,  u  token to be inserted
	var i = s.indexOf(t);
	var r = "";
	if (i == -1) return s;
	r += s.substring(0,i) + u;
	if (i + t.length < s.length)
	r += txtreplace(s.substring(i + t.length, s.length), t, u);
	return r;
}

private function trim(s:String):String
{
	return s.replace(/^\s+|\s+$/gs, '');
  	//return s.replace( /^([\s|\t|\n]+)?(.*)([\s|\t|\n]+)?$/gm, "$2" );				//left-trim
}

private function isempty(s):Boolean
{
	return ((s == null) || (s.length == 0) || isspaces(s) || s == "---")
}

private function isspaces(s):Boolean
{
	var a = s.split(" ");
	return a.length == s.length + 1;
}

private function isarray(obj):Boolean
{
	var v = (typeof(obj.length) == undefined)
	return v
}

private function isdate(s):Boolean
{
	var rx:RegExp = /^(19|20)\d\d[-](0[1-9]|1[012])[-](0[1-9]|[12][0-9]|3[01])$/;
	return( rx.test(s) );
}

private function isemail(s):Boolean
{
	var rx:RegExp = /([a-z0-9._-]+)@([a-z0-9.-]+)\.([a-z]{2,4})/;
	return( rx.test(s) );
}

private function isphone(s):Boolean
{
	var rx:RegExp = /\d\d\d-\d\d\d-\d\d\d\d/;
	return( rx.test(s) );
}

private function istime(s):Boolean
{
	var rx:RegExp =  /\d\d\:\d\d/;
	return( rx.test(s) );
}

private function roundnumber(num, decimalPlaces):Number
{
	decimalPlaces = Math.pow(10, decimalPlaces)
	return Math.round(num*decimalPlaces)/decimalPlaces
}

private function zerofill(num):String
{
	num = num.toString()
	if (num.length == 1) return '0' + num
	else return num
}

private function zeroempty(st):String
{
	var stx = st
	while(stx.indexOf("0") == 0)
	{stx = stx.substr(1)}
	return stx
}

private function zeropad(num, pad):String
{
	var i;
	var n = num + "";
	for (i = 0; i <= pad; ++i)
	{
		if (n.length >= pad) { break; }
		n = "0" + n;
	}
	return n;
}

private function forcenumber(num, dec, sp):String
{
	var s;
	if(isNaN(num)){return ""}
	var i = parseFloat(num);
	if(isNaN(i)) {i = 0}
	i = roundnumber(num,dec)
	s = i.toString()
	if(s.indexOf('.') < 0) {s += '.0000000000'} else {s += '0000000000'}
	s = s.substr(0,s.indexOf('.')+dec+1)
	if(sp){s = formatspnumber(s)}
	return s
}

private function formatspnumber(num):String
{
	var a;
	if(num == "")return ""
	var delimiter = " "; // replace with different separator if necessary
	a = num.split('.',2)
	var d = a[1];
	var i = parseInt(a[0]);
	if(isNaN(i)) { return ''; }
	var minus = '';
	if(i < 0) { minus = '-'; }
	i = Math.abs(i);
	var n = new String(i);
	a = [];
	while(n.length > 3)
	{
		var nn = n.substr(n.length-3);
		a.unshift(nn);
		n = n.substr(0,n.length-3);
	}
	if(n.length > 0) { a.unshift(n); }
	n = a.join(delimiter);
	if(d.length < 1) { num = n; }
	else { num = n + '.' + d; }
	num = minus + num;
	return num;
}

private function defdate():String
{
	var d = new Date()
	var dd = d.getFullYear() + "-" + zerofill(d.getMonth()+1)  + "-" + zerofill(d.getDate())
	return dd
}

private function deftime():String
{
	var d = new Date()
	var dd = zerofill(d.getHours()) + ":" + zerofill(d.getMinutes())  + ":" + zerofill(d.getSeconds())
	return dd
}

private function deftimeshort():String
{
	var d = new Date()
	var dd = zerofill(d.getHours()) + ":" + zerofill(d.getMinutes());
	return dd
}

private function ageof(d:String):int
{
	var da = d.split("-");
	var dd = defdate();
	dd = dd.split("-");
	return parseInt(dd[0]) - parseInt(da[0]);
}

private function datediff(d1, d2):int
{
	var dc:Number = 1000 * 60 * 60 * 24
	var dd1 = d1.split("-");
	var dd2 = d2.split("-");
	dd1 = new Date(parseInt(dd1[0]), parseInt(dd1[1]), parseInt(dd1[2]));
	dd2 = new Date(parseInt(dd2[0]), parseInt(dd2[1]), parseInt(dd2[2]));
	dd1 = dd1.getTime();
	dd2 = dd2.getTime();
	var ddiff = Math.abs(dd1 - dd2);	    
	return Math.round(ddiff/dc);			//hours
}

private function dateadd(d, a):*
{
	var dd = d.split("-");
	dd = new Date(parseInt(dd[0]), parseInt(dd[1]), parseInt(dd[2]));
	dd.date += a;
	var dt = dd.getFullYear() + "-" + zerofill(dd.getMonth())  + "-" + zerofill(dd.getDate())
	return (dt);		//iso date as string
}

private function formatdatestr(st, sp):String
{
	var i;
	var spa = new Array("-", ",", "/", " ")
	for(i=0;i<spa.length;i++)
	{if( st.indexOf(spa[i]) != -1){var d = st.split(spa[i]); break}}
	var dd = d[0] + sp + zerofill(d[1])  + sp + zerofill(d[2])
	return dd
}

private function compactdate(st, sp):String
{
	var i;
	var spa = new Array("-", ",", "/", " ")
	for(i=0;i<spa.length;i++)
	{if(st.indexOf(spa[i]) != -1){var d = st.split(spa[i]); break}}
	var dd = zeroempty(d[0]) + sp + zeroempty(d[1])  + sp + zeroempty(d[2])
	return dd
}

function leapyear(yr):Boolean
{
    return (yr % 400 == 0) || ((yr % 4 == 0) && (yr % 100 != 0));
}

private function extractemail(txt):String
{
	var email = "<none>"; // if no match, use this
	var earray = txt.match(/([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9._-]+)/gi);
	if (earray)
	{
		email = "";
		for (var i = 0; i < earray.length; i++){if (i != 0) email += "|"; email += earray[i];}
	}
	return email;
}

private function removehtmltags(t)
{
	var rgexp:RegExp = new RegExp("<[^<]+?>", "gi");
	t = t.replace(rgexp, "");
	return t;
}

private function txtellipsis(tg):void
{
	var i, j, tx;
	tx = tg.text;
	tg.text = "";
	tx = tx.split(" ");
	for (i = 0; i < tx.length; ++i)
	{
		tg.appendText(tx[i] + " ");
		if (tg.textWidth >= tg.width - 35) { j = tg.text.lastIndexOf(" ", tg.text.length - 2); tg.text = tg.text.substr(0, j) + " ... "; break; }
	}
}

private function choosefonts()
{
	/*
	var fntlst = TextField.getFontList()
	var accfonts = new Array("Arial","Helvetica")
	var accsize = new Array(11,11)
	var foundfonts = "|"
	for(i=0;i<fntlst.length;i++)
	{
		if(fntlst[i].indexOf("Arial") != -1 || fntlst[i].indexOf("Helvetica") != -1){foundfonts += fntlst[i]+"|"}
	}
	for(i=0;i<4;i++)
	{
		if(foundfonts.indexOf("|"+accfonts[i]+"|") != -1){_global.mainfont = accfonts[i]; _global.mainfontsize = accsize[i]; break}
	}
	*/
}


//-----------------------------------------------------------------		//draw functions


private function drawmixrect(hld, x1, y1, x2, y2, r, bkcl, bkal, bkpc, bkga, brw, brcl, bral):void
{
	var gm:Matrix = new Matrix();
	with (hld.graphics)
	{
		lineStyle(brw, brcl, bral, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER);
		if (bkcl.length == 1)
		{
			beginFill(bkcl[0], bkal[0]);
		}
		else if (bkcl.length > 1)
		{
			gm.createGradientBox(x2-x1, y2-y1, bkga, x1, y1);
			beginGradientFill(GradientType.LINEAR, bkcl, bkal, bkpc, gm);
		}
		moveTo(x1 + r[0], y1);
		lineTo(x2 - r[1], y1);
		curveTo(x2, y1, x2, y1 + r[1]);
		lineTo(x2, y2 - r[2]);
		curveTo(x2, y2, x2 - r[2], y2);
		lineTo(x1 + r[3], y2);
		curveTo(x1, y2, x1, y2 - r[3]);
		lineTo(x1, y1 + r[0]);
		curveTo(x1, y1, x1 + r[0], y1);
		if (bkcl.length > 0) { endFill(); }
	}
}
		
private function drawdotline(mc, x1, y1, x2, y2, clr1, clr2, alph, st):void
{
	var i, s, sd, t, xe, ye, p, clrs;
	var tgan = 0;
	mc.graphics.lineStyle(0, 0x2371cf, 1, false, LineScaleMode.NONE); mc.graphics.moveTo(x1, y1); mc.graphics.lineTo(x2, y2);
	if (x1 != x2)
	{
		if(x1 > x2)
		{
			t = x1; x1 = x2; x2 = t;
			t = y1; y1 = y2; y2 = t;
		}
		tgan = (y2 - y1) / (x2 - x1);
		sd = st * Math.cos(Math.atan(tgan))
		s = 0;
		i = 0;
		p = false;
		mc.graphics.moveTo(x1, y1);
		while (true)
		{
			i += sd;
			xe = x1 + i;
			if (xe > x2) { xe = x2; p = true; }
			ye = y2 - (x2 - x1 - i) * tgan;
			s++;
			if (s % 2 == 0) { clrs = clr1; } else { clrs = clr2; }
			mc.graphics.lineStyle(0, clrs, alph, false, LineScaleMode.NONE);
			mc.graphics.lineTo(xe, ye);
			if (p) { break; }
		}
	}
	else
	{
		if(y1 > y2)
		{
			t = y1; y1 = y2; y2 = t;
		}
		s = 0;
		i = 0;
		p = false;
		mc.graphics.moveTo(x1, y1);
		while (true)
		{
			i += st;
			ye = y1 + i;
			if (ye > y2) { ye = y2; p = true; }
			s++;
			if (s % 2 == 0) { clrs = clr1; } else { clrs = clr2; }
			mc.graphics.lineStyle(1.2, clrs, alph, false, LineScaleMode.NONE);
			mc.graphics.lineTo(x1, ye);
			if (p) { break; }
		}
	}
}

private function drawdotrect(mc, x1, y1, x2, y2, clr1, clr2, alph, st):void
{
	drawdotline(mc, x1, y1, x2, y1, clr1, clr2, alph, st);
	drawdotline(mc, x2, y1, x2, y2, clr1, clr2, alph, st);
	drawdotline(mc, x2, y2, x1, y2, clr1, clr2, alph, st);
	drawdotline(mc, x1, y2, x1, y1, clr1, clr2, alph, st);
}

private function drawdotpoly(mc, pts, lc, clr1, clr2, alph, st):void
{
	//pts = [x1, y1, x2, y2, x3, y3, x4, y4, x5, y5, ...]
	var i;
	var l = pts.length - 2;
	for (i = 0; i < l; i = i + 2)
	{
		drawdotline(mc, pts[i], pts[i + 1], pts[i + 2], pts[i + 3], clr1, clr2, alph, st);
	}
	if (lc) { drawdotline(mc, pts[l], pts[l + 1], pts[0], pts[1], clr1, clr2, alph, st); }
}

private function curve3pts(ob, x1, y1, x2, y2, x3, y3)
{
	var cx = 2*x2 - .5*(x1 + x3);
	var cy = 2 * y2 - .5 * (y1 + y3);
	with (ob)
	{
		graphics.moveTo (x1, y1);
		graphics.curveTo (cx, cy, x3, y3);
	}
}

private function deg2rad(d:int):Number
{
  return d * Math.PI / 180;
}

private function rad2deg(r:Number):int
{
  return Math.round(r * 180 / Math.PI);
}

private function squareinsquare(l1, t1, w1, h1, l2, t2, w2, h2):Boolean
{
  return (l1 >= l2 && l1 + w1 <= l2 + w2 && t1 >= t2 && t1 + h1 <= t2 + h2);
}


//----------------------------------------------------------------------------	object functions


private function tofront(ob):void
{
	ob.parent.setChildIndex(ob, ob.parent.numChildren - 1);
}

private function toback(ob):void
{
	ob.parent.setChildIndex(ob, 0);
}

private function clone(ob:Object):*
{
	var b:ByteArray = new ByteArray();
	b.writeObject(ob);
	b.position = 0;
	return(b.readObject());
}

private function encodeobject(p:*):String			//* = Object
{
	var b = new ByteArray();
	b.writeObject(p);
	return(base64.encode(b));
}

private function decodeobject(s:String):*			//* = Object
{
	var p = base64.decode(s)
	p.position = 0;
	return p.readObject();
}


//----------------------------------------------------------------------------	preloader functions


private function showpreloader():void
{
	//showblocker(true);
	_preloader.visible = true;
	_preloader.gotoAndPlay(1);
}

private function hidepreloader():void
{
	//showblocker(false);
	_preloader.visible = false;
	_preloader.gotoAndStop(1);
}

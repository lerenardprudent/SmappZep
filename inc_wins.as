private function makewin(w, wpa):void
{
	var ww = _winprops[w];
	_wins[w] = new ifwin(ww[0], wpa, ww[2], ww[3], ww[4], ww[5], ww[6], ww[7], ww[8], ww[9], ww[10], ww[11], ww[12], ww[13], ww[14], ww[15], ww[16], ww[17], ww[18], ww[19], ww[20], ww[21], ww[22], ww[23], ww[24], ww[25], ww[26], ww[27], ww[28], ww[29], ww[30], ww[31]);
}

private function getwin(ob):*
{
	var win = ob;
	while (true)
	{
		if (win != stage)
		{
			if (win.hasOwnProperty("name"))
			{
				if (win.name.substr(0, 4) == "win_") { break; } else { win = win.parent; }
			}
			else
			{
				win = win.parent;
			}
		}
		else
		{
			win = null;
			break;
		}
	}
	return win;
}

private function removewin(w):void
{
	var i;
	w.parent.removeChild(w);
	for (i = 0; i < _wins.length; ++i)
	{
		if (_wins[i] == w) { _wins.splice(i, 1); break; }
	}
}

private function removeallwins():void
{
	var i;
	for (i = 0; i < _wins.length; ++i) { _wins[i].parent.removeChild(_wins[i]); }
	_wins.length = 0;
	
}

private function hidextrawins(fx:Boolean):void
{
	var i, l;
	l = _wins.length;
	for (i = 4; i < l; ++i)
	{
		 if (_wins[i].visible) { showwin(_wins[i], false , fx, 0); }
	}
}

private function makewinlayout(win, lay):void
{
	_wholder = win.holder;
	win.layout = lay;
	setlayout(lay);
	onwinlayout(win);
}

private function showwin(win, v:Boolean, fx, de):void
{
	if (v && !win.visible)
	{
		win.alpha = 0;
		win.visible = true;
		if (fx)
		{
			TweenMax.to(win, .4, { alpha:1, delay:de, overwrite:1 } );
		}
		else
		{
			win.alpha = 1;
		}
	}
	else if(!v && win.visible)
	{
		if (fx)
		{
			TweenMax.to(win, .3, { autoAlpha:0, delay:de } );
		}
		else
		{
			win.visible = false;
		}
	}
}

private function fadewin(win, yo, alp, dur):void
{
	TweenMax.to(win, dur, { alpha:alp, yoyo:yo, repeat:1, overwrite:1 } );
}

private function enablewin(win, c:Boolean, a:Boolean):void
{
	win.mouseEnabled = c;
	win.mouseChildren = c;
	if (a) { TweenMax.to(win, .3, { alpha:1 } ); } else { TweenMax.to(win, .3, { alpha:.4 } ); }
}

private function pozwin(win, cx, cy, xx, yy, fx, de):void
{
	var xt, yt, dt;
	if (cx)	{ xt = (win.parent.back.width - win.vwidth * win.scaleX) * .5 + xx; } else { xt = xx; }
	if (cy) { yt = (win.parent.back.height - win.vheight * win.scaleY) * .5 + yy; } else { yt = yy; }
	if (fx == 0) { dt = 0; } else { dt = .4; }
	TweenMax.to(win, dt, { x:xt, y:yt, delay:de, roundProps:["x", "y"] } );
	//TweenMax.to(win, dt, { x:xt, y:yt, delay:de, onComplete:roundpoz, onCompleteParams:[win] } );
}

/*
private function roundpoz(ob:*):void
{
	ob.x = Math.round(ob.x);
	ob.y = Math.round(ob.y);
}
*/

private function fitwin(win, fx):void
{
	var fw, fh, cew, ceh;
	if (win.vfitwidth != "") { fw = Math.round(Math.min(win.parent.back.width * win.vfitwidth, win.holder.width)); } else { fw = Math.round(win.vwidth); }
	if (win.vfitheight != "") { fh = Math.round(Math.min((win.parent.back.height * win.vfitheight) / win.scaleY, win.holder.height + 30)); } else { fh = Math.round((win.vheight + 30) / win.scaleY); }
	if (fw != "" || fh != "") { win.resizewin(fw, fh); }
	if (win.vcenterw) { cew = true; } else { cew = false;}
	if (win.vcenterh) { ceh = true; } else { ceh = false; }
	if (cew || ceh) { pozwin(win, cew, ceh, 0, 0, fx, 0); }
}

private function slidewin(win, fx)
{
	
}

private function scrollto(win, p:Number):void
{
	if (win.hasOwnProperty("scrlbarv"))
	{
		win.scrlbarv.percent = p;
		win.scrlbarv.thisscroll();
	}
}

private function alert(win, msg, ltx, ... parms):void
{
	var a, i, ox;
	a = [0, 1, 2, 3, 6, 7, 8];
	for (i = 0; i < a.length; ++i) { _wins[a[i]].visible = false; }
	pozwin(win, true, true, 0, 0, false, 0);
	if (win == _wins[0])
	{
		ox = getobj(win, "LAB", 1);
		ox.labtext = msg;
	}
	else if (win == _wins[1])
	{
		ox = getobj(win, "LAB", 3);
		ox.labtext = msg;
	}
	else if (win == _wins[2])
	{
		ox = getobj(win, "LAB", 6);
		ox.labtext = msg;
		ox = getobj(win, "INP", 7);
		ox.labtext = ltx;
	}
	showblocker(true);
	win.visible = true;
}

private function showblocker(v):void
{
	var i, n;
	if (v)
	{
		_blocker.alpha = 0;
		_blocker.visible = true;
		TweenMax.to(_blocker, .2, { alpha:1 } );
	}
	else
	{
		TweenMax.killAll(false, true, true);
		n = _blocker.numChildren;
		for (i = 1; i < n; ++i) { _blocker.getChildAt(i).visible = false; }
		TweenMax.to(_blocker, .2, { autoAlpha:0 } );	
	}
}

private function getobj(win, ot, oi):*
{
	var hld;
	hld = win.getChildByName("holder");
	return hld.getChildByName("OBJ_" + ot + "_" + oi);
}

private function showobj(win, ot, oi, vis):void
{
	var hld, ob;
	hld = win.getChildByName("holder");
	ob = hld.getChildByName("OBJ_" + ot + "_" + oi);
	ob.visible = vis;
}

private function enableobj(win, ot, oi):void
{
	var ox, op;
	ox = getobj(win, ot, oi);
	ox.mouseEnabled = true;
	ox.mouseChildren = true;
	op = getobjprops("OBJ_" + ot + "_" + oi);
	ox.alpha = op[46] / 100;
}

private function disableobj(win, ot, oi):void
{
	var ox;
	ox = getobj(win, ot, oi);
	ox.mouseEnabled = false;
	ox.mouseChildren = false;
	ox.alpha = .4; 
}

private function getobid(ob):int
{
	var a = ob.name.split("_")
	return(parseInt(a[2]));
}

private function getobclass(ob):String
{
	var a = ob.name.split("_")
	return(a[1]);
}

private function getobjprops(obn):Array
{
	var n, i, j, k, a;
	n = obn.split("_")
	a = [];
	if (n[0] == "select") { k = parseInt(n[3]); } else if (n[0] == "OBJ") { k = parseInt(n[2]); } else { return null; }
	for (i = 0; i < _appcode.length; ++i)
	{
		if (_appcode[i][0] == k)
		{
			for (j = 0; j < _appcode[i].length; ++j) { a[j] = _appcode[i][j]; }
			return a;
			break; 
		}
	}
	return null;
}

private function changelabtxt(ob:*, t:String, s:String):void
{
	var th = ob.labtext;
	var tp = new RegExp(t, "gi");
	th = th.replace(tp, s);
	ob.labtext = th;
}

private function savewindata(win):void
{
	var i, l, ox, ov;
	for (i = 0; i < _appcode.length; ++i)
	{
		if (_appcode[i][3] == win.layout)
		{
			ox = getobj(win, _appcode[i][1], _appcode[i][0]);
			if (ox.hasOwnProperty("xval"))
			{
				ov = ox.xval;
				if (typeof(ov) == "boolean") { ov = int(ov); }
				_appcode[i][64] = ov;
			}
		}
	}
}




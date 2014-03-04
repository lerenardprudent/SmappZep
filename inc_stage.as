private function stagedown(e:MouseEvent):void
{
	var ta, tap, ob;
	if (_preloader.visible) { e.preventDefault(); return; }
	ta = e.target;
	tap = e.target.parent;
	if (_calendar.visible) { _calendar.visible = false; }
	if (_clock.visible) { _clock.visible = false; }
	if (ta == stage)
	{
		return;
	}
	else if (ta.name.substr(0,4) == "win_")
	{
		if (!ta.draggable) { return; }
		_windrag = ta;
		tap.setChildIndex(_windrag, tap.numChildren - 1)
		if (tap == _main)
		{
			_windrag.startDrag(false, new Rectangle(3, 3, _main.back.width - _windrag.vwidth - 6, _main.back.height - _windrag.vheight - 6));
		}
		else
		{
			_windrag.startDrag(false, new Rectangle(3, 3, tap.width - _windrag.vwidth - 6, tap.height - _windrag.vheight - 6));
		}
	}
	else if(tap.name == "scrl_o")
	{
		_scroller = tap;
		_scroller.thisdown(ta, e.localX, e.localY)
	}
	else
	{
		ob = mouseobject(ta);
		if (_obover != null)
		{
			try { _obover.thisdown(); } catch (er) { }
		}
	}
}

private function stagemove(e:MouseEvent):void
{
	var ta, tap, ob;
	ta = e.target;
	if (_scroller != null && e.buttonDown)
	{ 
		_scroller.thisscroll();
	}
	else
	{
		ob = mouseobject(ta);
		if (ob != _obover) { doout(ta); _obover = ob; doover(ta); }
	}
}

private function doover(ta):void
{
	var pass;
	if (_obover != null)
	{
		pass = true;
		try { _obover.thisover(ta); } catch (er) { pass = false; }
		if (pass){ try { objactionsover(_obover); } catch (er) { } }
	}
}

private function doout(ta):void
{
	var pass;
	if (_obover != null)
	{
		pass = true;
		try { _obover.thisout(ta); } catch (er) { pass = false; }
		if (pass) { try { objactionsout(_obover); } catch (er) { } }
	}
}

private function stageup(e:MouseEvent):void
{
	var ta, tap, ob, sn;
	if (_preloader.visible) { e.preventDefault(); return; }
	ta = e.target;
	if (_windrag != null)
	{
		_windrag.stopDrag(); 
		_windrag.x = Math.round(_windrag.x);
		_windrag.y = Math.round(_windrag.y);
		actiondragwin(_windrag);
		_windrag = null;
		return;
	}
	if (_scroller != null)
	{
		_scroller.thisup();
		if (_scroller.tgtype == "D") 
		{
			sn = _scroller.target.parent.name
			if ( sn.substr(0, 7) == "OBJ_LST") { dblistscroll(sn); }
		}
		_scroller = null;
		return;
	}
	//ob = mouseobject(ta);
	if (_obover != null)
	{
		try { _obover.thisup(); } catch (er) { }
	}
}

private function stageclick(e:MouseEvent):void
{
	var ta, ob, win;
	if (_preloader.visible) { e.preventDefault(); return; }
	ta = e.target;
	if (ta.name == null) { return; }
	if (getTimer() - _dblclick < 220) { _dblclick = 0; stagedblclick(ta); return} else { _dblclick = getTimer(); }
	if (ta.name == "w_clbtn") 		//window close button
	{ 
		win = ta.parent;
		showwin(win, false, 1, 0);
		if (win.parent == _blocker) { showblocker(false); }
		onwinclose(win);
		return;
	}
	if (ta.name == "w_rebtn") 		//window refresh button
	{ 
		win = ta.parent;
		winrefresh(win);
		return;
	}
	ob = mouseobject(ta);
	if (ob != null)
	{
		if (ta.name == "l_sarrd")
		{
			//trace(ta.parent.xdsrc)		//(D)ata, (A)rray
			if (ta.parent.xdsrc == "D")		//(D)ata, (A)rray
			{
				dbnextpage(ta.parent)
			}
			else
			{
				
			}
			return;
		}
		else if (ta.name == "l_sarru")
		{
			//trace(ta.parent.xdsrc)		//(D)ata, (A)rray
			if (ta.parent.xdsrc == "D")		//(D)ata, (A)rray
			{
				dbprevpage(ta.parent);
			}
			else
			{
				
			}
			return;
		}
		else if (ta.name == "i_cald")
		{
			_calendar.xtarget = ta.parent.inp;
			_calendar.x = stage.mouseX;
			_calendar.y = stage.mouseY;
			_calendar.visible = true;
			_calendar.go2date(_calendar.xtarget.text);
			return;
		}
		else if (ta.name == "i_time")
		{
			_clock.xtarget = ta.parent.inp;
			_clock.x = stage.mouseX;
			_clock.y = stage.mouseY;
			_clock.visible = true
			return;
		}
		try { ob.thisclick(ta, e.shiftKey, e.ctrlKey); } catch (er) { }
		objactionsclick(ob, ta);
	}
}

private function stagedblclick(ta):void
{
	/*
	var sc;
	if (ta.name.substr(0,4) == "win_") 
	{
		if (ta.scaleX != 1) { sc = 1; } else { sc = 1.2;}
		ta.scaleX = ta.scaleY = sc;
		fitwin(ta, 1);
	}
	*/
}

private function stagekeydown(e:KeyboardEvent):void
{
	var ob;
	if (e.keyCode == 13)
	{
		ob = mouseobject(e.target);
		if (ob != null) { actkeydown(ob, 13); }
	}
}

private function stagewheel(e:MouseEvent):void
{
	var ta, dt, ob, win, yy, pct;
	ta = e.target;
	win = getwin(ta);
	if (win == null || win.scrltype == "") { return; }
	if (win.holder.height <= win.holdermask.height) { return; }
	dt = e.delta;
	yy = win.holder.y;
	yy += dt * 20;
	pct = (yy - win.holdermask.y) / (win.holdermask.height - win.holder.height)
	if (pct < 0 ) { pct = 0; } else if (pct > 1) { pct = 1; }
	win.holder.y = Math.round(win.holdermask.y + (win.holdermask.height - win.holder.height) * pct);
	try { win.scrlbarv.percent = pct; }catch(er){}
}

private function stageresize(e:Event):void
{
	centerstage();
	actionresize(stage.stageWidth, stage.stageHeight);
}

private function centerstage():void
{
	var i, l, xx, yy, fw, fh, cew, ceh, ob, img;
	var sw = stage.stageWidth;
	var sh = stage.stageHeight;
	
	_apphead.xwidth = sw + 1;
	
	_main.x = 0;
	_main.y = Math.round(_apphead.xheight);
	_main.back.width = sw + 1;
	_main.back.height = Math.round(sh - _apphead.xheight - 30);
	
	if (_main.numChildren > 1)
	{
		img = _main.getChildAt(1);
		img.scaleX = _main.back.width / (img.width * (1 / img.scaleX)) ;
		img.scaleY = _main.back.height / (img.height * (1 / img.scaleY));
	}
	
	_blocker.back.width = _main.back.width;
	_blocker.back.height = _main.back.height;
	_blocker.x = 0;
	_blocker.y = _main.y;

	_preloader.x = (sw - _preloader.width) * .5;
	_preloader.y = (sh - _preloader.height) * .5;

	l = _wins.length;
	if (l == 0) { return; }
	for ( i = 0; i < l; ++i)
	{
		if (_wins[i].visible)
		{
			if (_wins[i].vfitheight != "" || _wins[i].vfitwidth != "")
			{
				_wins[i].holder.y = _wins[i].holdermask.y;
				try { _wins[i].scrlbarv.percent = 0; } catch (er) { }
				fitwin(_wins[i], true);
			}
			else if (_wins[i].vcenterw || _wins[i].vcenterh)
			{
				pozwin(_wins[i], _wins[i].vcenterw, _wins[i].vcenterh, 0, 0, 1, 0)
			}
			
			/*
			else
			{
				_wins[i].x = Math.round(_wins[i].x);
				_wins[i].y = Math.round(_wins[i].y);
				if (_wins[i].x + _wins[i].width > _wins[i].parent.back.width)
				{
					xx = _wins[i].parent.back.width - _wins[i].width - 1;
					if (xx < 0) { xx = 0; }
					_wins[i].x = Math.round(xx);
				}
				if (_wins[i].y + _wins[i].height > _wins[i].parent.back.height)
				{
					yy = _wins[i].parent.back.height - _wins[i].height - 1;
					if (yy < 0) { yy = 0; }
					_wins[i].y = Math.round(yy);
				}
				
			}*/		
		}
	}
}

private function mouseobject(ob):*
{
	var ot;
	ot = ob;
	while(ot != stage && ot != null)
	{
		if (ot.hasOwnProperty("name"))
		{
			if (ot.name.substr(0, 4) == "OBJ_")
			{
				return ot;
			}
			else
			{
				try { ot = ot.parent; } catch (er) { return null; }
			}
		}
		else
		{
			try { ot = ot.parent; } catch (er) { return null; }
		}
	}
	return null;
}


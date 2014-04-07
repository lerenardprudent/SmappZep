import flash.display.Loader;
import flash.events.IOErrorEvent;
private function appdbexec(df, par):void
{
	appdbload(_dbpath + df + ".php", par);
}

private function appdbload(purl:String, pv:String):void
{
	var rq, vs;
	_apploader = new URLLoader();
	_apploader.dataFormat = URLLoaderDataFormat.TEXT;
	rq = new URLRequest();
	rq.method = URLRequestMethod.POST;
	vs = new URLVariables();
	vs.pvar = pv;
	rq.url = purl;
	rq.data = vs;
	_apploader.addEventListener(Event.COMPLETE, appdbloaded, false, 0, true);
	_apploader.addEventListener(IOErrorEvent.IO_ERROR, appdbioerror, false, 0, true);
	_apploader.load(rq);
}

private function appdbloaded(e:Event):void
{
	var i, a, d;
	d = e.target.data;
	_apploader.removeEventListener(Event.COMPLETE, appdbloaded);
	_apploader.removeEventListener(IOErrorEvent.IO_ERROR, appdbioerror);
	_apploader = null;
	if(d.substr(0,10) == "-lay-l-ok-")				//load layout
	{
		d = d.substr(10);
		splitlayout(d);
		d = null;
		initapp();											//START APP HERE !!!
	}
	else
	{
		hidepreloader();
		//alert(_wins[0], "<font face='Arial' size='11' color='#5c5c6d' letterspacing='0' kerning='0'>Layout loading error.</font>", "");
	}
}

private function appdbioerror(e:IOErrorEvent):void
{
	//hidepreloader();
	_apploader.removeEventListener(Event.COMPLETE, appdbloaded);
	_apploader.removeEventListener(IOErrorEvent.IO_ERROR, appdbioerror);
	_apploader = null;
	//alert(_wins[0], "<font face='Arial' size='11' color='#5c5c6d' letterspacing='0' kerning='0'>Database I/O error.</font>", "");
}

private function getURL(url:String, target:String = null)
{
	try{navigateToURL(new URLRequest(url), target);}catch(er){trace("[getURL] " + er);}
}

private function txtload():void
{
	//showpreloader();
	_txtloader = new URLLoader();
	_txtloader.addEventListener(Event.COMPLETE, txtloaded, false, 0, true);
	_txtloader.addEventListener(IOErrorEvent.IO_ERROR, txtioerror, false, 0, true);
	_txtloader.load(new URLRequest(_txtfile));
}

private function txtloaded(e:Event):void
{
	var d;
	//hidepreloader();
	d = e.target.data;
	_txtloader.removeEventListener(Event.COMPLETE, txtloaded);
	_txtloader.removeEventListener(IOErrorEvent.IO_ERROR, txtioerror);
	_txtloader = null;
	if (_txtfile == "smapp.css")						//css file
	{
		_sheet.parseCSS(d);
		_txtfile = "vars.txt"
		txtload();
	}
	else if (_txtfile == "vars.txt")					//vars array
	{
		var i, l;
		_varsarr = d.split("\r\n");
		l = _varsarr.length;
		for (i = 0; i < l; ++i) { _varsarr[i] = _varsarr[i].split("|");}
		_txtfile = "";
		appdbexec("dbapp", "lay~l~" + _appid + "~" + _docid);			//load document layout
	}
}

private function txtioerror(e:IOErrorEvent):void
{
	_txtloader.removeEventListener(Event.COMPLETE, txtloaded);
	_txtloader.removeEventListener(IOErrorEvent.IO_ERROR, txtioerror);
	_txtloader = null;
	if (_txtfile == "smapp.css")						//error css file
	{
		_txtfile = "vars.txt"
		txtload();
	}
	else if (_txtfile == "vars.txt")					//error vars array file
	{
		_txtfile = "";
		appdbexec("dbapp", "lay~l~" + _appid);			//load document layout
	}
}

private function loadpic(pic, c:Function, use_xloader:Boolean = true):void
{
	//showpreloader();
	if ( use_xloader ) {
		_xloader = new Loader();
		_xloader.contentLoaderInfo.addEventListener(Event.COMPLETE,c, false, 0, true);
		_xloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, picioerror, false, 0, true);
		_xloader.load(new URLRequest(pic));
	}
	else {
		_picloader = new Loader();
		_picloader.contentLoaderInfo.addEventListener(Event.COMPLETE,c, false, 0, true);
		_picloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, picioerror, false, 0, true);
		_picloader.load(new URLRequest(pic));
	}
}

private function picloaded(e:Event):void
{
	var img, sc, iw, ih;
	//hidepreloader();
	_picloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picloaded);
	_picloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, picioerror);
	//img = Bitmap(_picloader.content);
	img = _picloader.content;
	_picloader = null;
	img.x = img.y = 0;
	iw = _picholder.width;
	ih = _picholder.height;
	if (_picfx[0] != "")			//fit
	{
		
	}
	img.scaleX = iw / img.width;
	img.scaleY = ih / img.height;
	img.alpha = _picfx[1];
	img.blendMode = _picfx[5];
	_picholder.addChild(img);
}

private function picioerror(e:IOErrorEvent):void
{
	//hidepreloader();
	_picloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picloaded);
	_picloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, picioerror);
	var errMsg:String = "INITIALIZATION ERROR: Could not load image file";
	if ( e.text.indexOf("URL") > 0 ) {
		errMsg += " (URL:" + e.text.split("URL:")[1] + ")";
	}
	browser_debug( errMsg );
}

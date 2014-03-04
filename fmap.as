//--------------------------------------------------------map functions

function startmap(ob)			//start map
{
	_maplat = 56.815313;
	_maplong = -98.364260;
	_mapzoom = 4;
	if(ob.mapholder.numChildren > 0){ob.mapholder.removeChildAt(0);}
	if(_mapmod == 1){_map = new Map3D();}else{_map = new Map();}
	_map.key = "ABQIAAAAYfiOq9sndN95-G180Nm-YxSkkNBvy_LBUypHHhrGUuZDGYmNYhQG0MmTruwuN_hERQ4zWtTn_jYI2A";		//treksoft
	_map.sensor="false"
	_map.language = "en";
	_map.setSize(new Point(_mapwidth, _mapheight));
    _map.addEventListener(MapEvent.MAP_PREINITIALIZE, onmappreinit, false, 0, true);
    _map.addEventListener(MapEvent.MAP_READY, onmapready, false, 0, true);
    ob.mapholder.addChild(_map);
	//k = setiwlayout();
}

function onmappreinit(e:MapEvent):void			//preinit map
{
	//map.setInitOptions(new MapOptions(new MapTypeOptions({maxResolution: 16, minResolution: 10})));
}

function onmapready(e:MapEvent):void			//map ready
{
	_map.removeMapType(MapType.PHYSICAL_MAP_TYPE);
	_map.removeMapType(MapType.SATELLITE_MAP_TYPE);
    _map.addControl(new ZoomControl(new ZoomControlOptions({position: new ControlPosition(ControlPosition.ANCHOR_TOP_RIGHT, 25, 85), buttonSize: new Point(17, 17), buttonSpacing: new Point(2, 2), hasScrollTrack: true})));
  	if(_mapmod == 1)
	{
		_map.viewMode = View.VIEWMODE_PERSPECTIVE;
		_map.setAttitude(new Attitude(20,40,0));
	}
	else
	{
		_map.setCenter(new LatLng(_maplat,_maplong), _mapzoom, MapType.NORMAL_MAP_TYPE);
	}
	_map.enableScrollWheelZoom();
    _map.enableContinuousZoom();
	_map.enableCrosshairs();
	_geocoder = new ClientGeocoder();
	_geocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, geocodeok, false, 0, true);
	_geocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, geocodefail, false, 0, true);
	_map.addEventListener(MapMouseEvent.CLICK, mapclick, false, 0, true);
	_map.addEventListener(MapMouseEvent.DOUBLE_CLICK, mapdblclick, false, 0, true);
	_map.addEventListener(MapEvent.INFOWINDOW_OPENED, mapiwoppened, false, 0, true);
}

function mapclick(e:MapMouseEvent):void			//map click
{
	
}

function mapdblclick(e:MapMouseEvent):void			//map dbl-click
{
	
}

function mapiwoppened(e:MapEvent):void			//info window opened (load layout content)
{
	//infomcx.addChildAt(new infomc1, 1);
}

function geocodeok(e:GeocodingEvent):void			//map geocoder answer
{
	
}

function geocodefail(e:GeocodingEvent):void			//map geocoder answer
{
	trace("fuck geocode")
}

/*
function geocodeok(e:GeocodingEvent):void			//map geocoder answer
{
	placemarks = e.response.placemarks;
	yourlocation = placemarks[0].point;
	markcount++;
	for(i=0; i<storearray.length; i++)
	{
		jj = storearray[i][SLATLNG].split(",");
		jj[0] = Number(jj[0]);
		jj[1] = Number(jj[1]);
		var ll = new LatLng(jj[0], jj[1]);
		var dd = mapdistance(yourlocation, ll);
		var di = Number(inpdist.text)
		if(dd <= di)
		{
			map.addOverlay(createmarker(ll, markcount, storearray[i][SNAME], storearray[i][SNAME], storearray[i][SADDR], 1));
			storearray[i][SSEL] = "T";
			storearray[i][SOBJ] = _mapmark;
			storearray[i][SDIST] = dd.toFixed(1);
		}
	}
	map.addOverlay(createmarker(yourlocation, markcount, "Votre location", "Votre location", placemarks[0].address, 0));
	yourmarker = _mapmark;
	map.panTo(yourlocation);
	map.setCenter(yourlocation, 12);
	storearray.sortOn("10",  Array.NUMERIC);
	for(i=0; i<storearray.length; i++)
	{
		if(storearray[i][8] == "T"){reslist.htmlText += "<a href = 'event:" + i + "'><span class='bld'>" + storearray[i][SNAME] + "  <font color='#ff0000'><b>·</b></font></span>  <span class='norm'>" + storearray[i][SADDR] + "   (" + storearray[i][SDIST] +" Km)<br></span></a>";}
	}
	scrlup.visible = scrldown.visible = scrlrail.visible = (reslist.maxScrollV > 1);
}

function reslistlink(e:TextEvent)
{
	ii = Number(e.text);
	jj = storearray[ii][SLATLNG].split(",");
	jj[0] = Number(jj[0]);
	jj[1] = Number(jj[1]);
	//map.panTo(new LatLng(jj[0], jj[1]));
	map.setCenter(new LatLng(jj[0], jj[1]),16)
	map.disableCrosshairs();
	infomcx.txtfld.htmlText = storearray[ii][SNAME] + "<br>" + storearray[ii][SADDR] + "<br>" + storearray[ii][SCITY] + ", " + storearray[ii][SPROV]  + ", " + storearray[ii][SPOST] + "<br>" + storearray[ii][SPHONE];
	infomcx.txtdis.text = storearray[ii][SDIST] + " Km"
	storearray[ii][SOBJ].openInfoWindow(new InfoWindowOptions({hasShadow:false, customContent:infomcx, customOffset: new Point(17, 15)}));
}

function geocodefail(e:GeocodingEvent):void			//map geocoder answer
{
	trace("fuck geocode")
}

function createmarker(latlng:LatLng, id:Number, mytip, mytitle, mycontent, mypin):Marker			//create marker in qaarray
{
	var mpin = setpiniw(mypin);
	_mapmark = new Marker(latlng, new MarkerOptions({draggable:false, hasShadow:false, gravity:0, icon:mpin, tooltip:mytip}));
	_mapmark.addEventListener(MapMouseEvent.ROLL_OVER, markerclick, false, 0, true);
	return _mapmark;
}

function markerclick(e:MapMouseEvent):void			//marker click events
{
	map.closeInfoWindow();
	map.enableCrosshairs();
	for(i=0; i<storearray.length; i++)
	{
		if(e.currentTarget == storearray[i][SOBJ])
		{
			map.disableCrosshairs();
			//map.panTo(yourlocation);
			infomcx.txtfld.htmlText = storearray[i][SNAME] + "<br>" + storearray[i][SADDR] + "<br>" + storearray[i][SCITY] + ", " + storearray[i][SPROV]  + ", " + storearray[i][SPOST] + "<br>" + storearray[i][SPHONE];
			infomcx.txtdis.text = storearray[i][SDIST] + " Km"
			e.currentTarget.openInfoWindow(new InfoWindowOptions({hasShadow:false, customContent:infomcx, customOffset: new Point(17, 15)}));
			break;
		}
	}
}

function setiwlayout():Boolean			//choose iw layout to use
{
	infomcx = new infomc();
	infomcx.iwclose.addEventListener(MouseEvent.CLICK, iwcloseclick, false, 0, true);
	return true;
}

function iwcloseclick(e:MouseEvent)
{
	map.closeInfoWindow();
	map.enableCrosshairs();
	//infomcx.iwclose.removeEventListener(MouseEvent.CLICK, iwcloseclick);
}

btnsearch.addEventListener(MouseEvent.CLICK, searchclick, false, 0, true);

function searchclick(e:MouseEvent)
{
	dosearch();
}

function dosearch():void
{
	reslist.htmlText = "";
	scrlup.visible = false;
	scrldown.visible = false;
	try
	{
		map.removeOverlay(yourmarker);
		for(i=0; i<storearray.length; i++)
		{
			if(storearray[i][SSEL] == "T")
			{
				map.removeOverlay(storearray[i][9]);
				storearray[i][SSEL] = ""; 
				storearray[i][SOBJ] = null;
				storearray[i][SDIST] = -1;
			}
		}
		map.closeInfoWindow();
		map.enableCrosshairs();
	}
	catch(ev)
	{
		//fuck all
	}
	geocoder.geocode(inpaddr.text + ", Canada");
}
*/

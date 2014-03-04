package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*
	import flash.ui.Mouse;
	import flash.text.*;
	import flash.net.*;
	import flash.utils.*;
	import scrlba;
	 
	public class flst1 extends MovieClip
	{
		private var _hold:Sprite =  new Sprite();
		private var _hmask:Sprite = new Sprite();
		private var _lst:Array = [];
		private var _tbldat:* = null;
		private var _rows:int;
		private var _cols:int;
		private var _selrow:* = null;
		private var _selcol:* = null;
		private var _selrows:Array = [];
		private var _rowh:int;
		private var _colw:Array;		//widths
		private var _cole:Array;		//editable
		private var _colf:Array;		//formats
		private var _cola:Array;		//alignments
		private var _colm:Array;		//max characters
		private var _colr:Array;		//restrict
		private var _scrl:scrlba
		private var _sarru:* = new sarru();
		private var _sarrd:* = new sarrd();
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _hmax:int;
		private var _varid:String = "";
		private var _metlab:TextLineMetrics;
		private var _metcell:TextLineMetrics;
		private var _tfcell:TextFormat = new TextFormat();
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;
		private var _dv:String;
		private var _dsrc:String;			//D=database, A=array
		private var _dsql:String;			//table name
		private var _doff:uint = 0;			//db records offset (paginate)

		public function flst1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, rows, cols, rowh, colw, cole, colf, cola, colm, colr, dv):void
		{
			var i, sm;
			this.name = na;
			_w = w;
			_h = h;
			_colw = colw.split(",");
			_cole = cole.split(",");
			for (i = 0; i < _cole.length; ++i) { _cole[i] = parseInt(_cole[i]); }
			_colf = colf.split(",");
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			_dv = dv;
			_style = st;
			_rows = rows;
			_cols = cols;
			for (i = 0; i < _rows; ++i) { _selrows[i] = false; }
			_rowh = rowh;
			_tfcell.font = "Arial";
			_tfcell.size = 12;
			_tfcell.leftMargin = _tfcell.rightMargin = 3;
			addChild(_hold);
			addChild(_hmask);
			if (_dv != "") { sm = "P"; _dsrc = "A"; } else { sm = "D"; _dsrc = "D"; }
			_scrl = new scrlba(_hold, sm, "V", 8, 20);
			_sarru.name = "l_sarru";
			addChild(_sarru);
			_sarrd.name = "l_sarrd";
			addChild(_sarrd);
			addChild(_scrl);
			drawobj();
		}
		
		private function drawobj():void
		{
			drawtable();
			drawmask();
			_hold.mask = _hmask;
			setsize();
			if (_dv != "" && _dv != "...") { xval = _dv; }
		}
		
		private function drawback():void
		{
			var cc;
			graphics.clear();
			cc = _c4.split(",");
			graphics.lineStyle(0, parseInt(cc[0]), parseInt(cc[1]), true);
			graphics.beginFill(0xffffff, .01);
			graphics.drawRect(0, 0, _w, _h);
			graphics.endFill();
		}
		
		private function redrawcells():void
		{
			var r, c, cw;
			_hold.graphics.clear();
			for (r = 0; r < _rows; ++r)
			{
				for (c = 0; c < _cols; ++c)
				{
					cw = Math.round((parseInt(_colw[c]) / 100) * (_w - _scrl.size));
					_lst[r][c].width = cw;
					if (c == 0) { _lst[r][c].x = 0 } else { _lst[r][c].x = _lst[r][c - 1].x + _lst[r][c - 1].width; }
					drawcellback(r, c, _lst[r][c].x, _lst[r][c].y, cw);
				}
			}
		}
		
		private function drawmask():void
		{
			with (_hmask)
			{
				graphics.clear();
				graphics.beginFill(0x000000);
				graphics.lineStyle(0, 0x000000, 1, true, LineScaleMode.NONE);
				graphics.drawRect(0, 0, _w, _h);
				graphics.endFill();
			}
		}
		
		private function drawtable():void
		{
			var r, c, ry, rh, cel, cw;
			_hold.graphics.clear();
			_hmax = 0;
			for (r = 0; r < _rows; ++r)
			{
				_lst[r] = [];
				rh = 0;
				for (c = 0; c < _cols; ++c)
				{
					cw = Math.round((parseInt(_colw[c]) / 100) * (_w - _scrl.size));
					if (_colf[c] == "T" || _colf[c] == "I" || _colf[c] == "N")
					{
						_lst[r][c] = new TextField();
						drawcelltxt(_lst[r][c], r, c, cw);
					}
					else if(_colf[c] == "O")
					{
						_lst[r][c] = new MovieClip();
						drawcellobj(_lst[r][c], r, c, cw);
					}
					_lst[r][c].name = "cell_" + r + "_" + c;
					_hold.addChild(_lst[r][c]);
					rh = Math.round(Math.max(rh, _lst[r][c].height));
					if (c == 0) { _lst[r][c].x = 0 } else { _lst[r][c].x = Math.round(_lst[r][c - 1].x + _lst[r][c - 1].width); }
					_lst[r][c].y = _hmax;
					_lst[r][c].filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
					drawcellback(r, c, _lst[r][c].x, _hmax, cw);
				}
				_hmax = Math.round(_hmax + rh);
			}
		}
		
		private function cleartable()
		{
			var i, l;
			l = _hold.numChildren;
			for (i = 0; i < l; ++i) { _hold.removeChildAt(0); }
		}

		private function drawcellback(r, c, xx, yy, cw):void		//se:boolean = selected
		{
			with (_hold)
			{
				if (_c4 == "")
				{
					graphics.lineStyle();
				}
				else
				{
					cc = _c4.split(",");
					graphics.lineStyle(0, parseInt(cc[0]), 1, true, LineScaleMode.NONE);
				}
				if (_c1 == "")
				{
					graphics.beginFill(0xffffff, .01);
				}
				else
				{
					if(!_selrows[r]){cc = _c1.split(",");}else{cc = _c3.split(",");}
					graphics.beginFill(parseInt(cc[0]), parseFloat(cc[2]));
				}
				graphics.drawRect(xx, yy, cw, _rowh);
				graphics.endFill();
			}
		}
		
		private function drawcelltxt(cel, r, c, cw):void
		{
			with (cel)
			{
				if (_cole[c]) { type = TextFieldType.INPUT; } else { type = TextFieldType.DYNAMIC; }
				defaultTextFormat = _tfcell;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.PIXEL;
				sharpness = 100;
				thickness = -50;
				mouseWheelEnabled = false;
				embedFonts = false;
				background = false;
				border = false;
				multiline = false;
				wordWrap = false;
				selectable = true;
				tabEnabled = true;
				textColor = parseInt(_c7);
				text = "";		// default value
				height = _rowh;
				width = cw;
			}
		}
		
		private function drawcellobj(cel, r, c, cw):void
		{
			with (cel)
			{
				mouseChildren = false;
			}
		}
		
		public function thisover (... parms):void
		{
			//trace(parms[0].name)
		}
		
		public function thisout (... parms):void
		{
			
		}
			
		public function thisdown (... parms):void
		{
			
		}
		
		public function thisup (... parms):void
		{
			
		}
		
		public function thisclick (... parms):void
		{
			var a, i, j, sr;
			a = parms[0].name.split("_");
			sr = parseInt(a[1]);
			_selrow = _selcol = null;
			if (parms[1])
			{
				j = -1;
				for (i = 0; i < _selrows.length; ++i)
				{
					if (_selrows[i]) { j = i; break; }
				}
				if (j != -1)
				{
					if (sr < j)
					{
						for (i = sr; i <= j; ++i) { _selrows[i] = true; }
					}
					else
					{
						for (i = j; i <= sr; ++i) { _selrows[i] = true; }
					}
				}
			}
			else if (parms[2])
			{
				_selrows[sr] = !_selrows[sr];
			}
			else
			{
				for (i = 0; i < _selrows.length; ++i) { _selrows[i] = false; }
				_selrows[sr] = true;
				_selrow = sr;
				_selcol = parseInt(a[2]);
			}
			redrawcells();
		}
		
		public function set xheight(v:Number):void			//full height
		{
			_h = v;
		}
		
		public function get xheight():Number			//full height
		{
			return _hmask.height;
		}
		
		public function set xwidth(v:Number):void			//full width
		{
			_w = v;
		}
		
		public function get xwidth():Number			//full width
		{
			return _hmask.width;
		}

		public function set xstyle(v:int):void			//lab text
		{
			_style = v;
			//setsize();
		}

		public function get xstyle():int			//lab text
		{
			return _style;
		}

		public function setsize():void
		{
			var r, c, cw;
			_hold.graphics.clear()
			if (_h > _hmax) { _h = _hmax; }
			drawback();
			_hold.x = _hmask.x = 0;
			_hold.y = _hmask.y = 0;
			_hmask.width = _w;
			_hmask.height = _h;
			redrawcells();
			_scrl.x = _w -_scrl.size;
			_scrl.y = 11;
			_scrl.length = _h - 22;
			_sarru.x = _sarrd.x = _scrl.x;
			_sarru.y = 1;
			_sarrd.y = _h - 1;
		}
		
		public function redrawtable():void
		{
			cleartable();
			drawtable();
		}
		
		public function get xrows():int
		{
			return _rows;
		}
		
		public function set xrows(r:int):void
		{
			_rows = r;
			redrawtable();
			xval = _tbldat;
		}
		
		public function get xcols():int
		{
			return _cols;
		}
		
		public function set xval(v:*):void
		{
			var i, l, r, c, p, vs, mr, mc, pass;
			//redrawtable();
			if (v == null || v == "") { redrawtable(); return; }
			for (i = 0; i < _selrows.length; ++i)
			{
				if (_selrows[i]) { pass = true; _selrows[i] = false; }
			}
			//if (pass) { redrawcells(); }
			vs = getQualifiedClassName(v);
			if (vs == "String")
			{
				_tbldat = v.split("\r");
				l = _tbldat.length;
				for (i = 0; i < l; ++i) { _tbldat[i] = _tbldat[i].split(","); }
			} 
			else if (vs == "Array") 
			{
				_tbldat = v;
				l = _tbldat.length;
			}
			else
			{
				redrawtable();
				return;
			}
			if (_dsrc != "D") { _rows = l; }
			redrawtable();
			if (pass) { redrawcells(); }
			//mr = Math.min(_rows, _tbldat.length);
			mr = Math.min(_rows, l);
			for (r = 0; r < _rows; ++r)
			{
				if (r < mr)
				{
					mc = Math.min(_cols, _tbldat[r].length);
					for (c = 0; c < _cols; ++c)
					{
						
						if (c < mc)
						{
							if (_colf[c] != "O") { _lst[r][c].defaultTextFormat = _tfcell; _lst[r][c].htmlText = _tbldat[r][c]; } else { }
						}
						else
						{
							if (_colf[c] != "O") { _lst[r][c].defaultTextFormat = _tfcell; _lst[r][c].htmlText = ""; } else { }
						}
					}
				}
				else
				{
					for (c = 0; c < _cols; ++c)
					{
						if (_colf[c] != "O") { _lst[r][c].defaultTextFormat = _tfcell; _lst[r][c].text = ""; } else { }
					}
				}
			}
			_sarrd.mouseEnabled = (_rows == mr);
		}
		
		public function get xval():*
		{
			if (_tbldat != null) { return _tbldat; } else { return null; }
		}
		
		public function set xvar(v:String):void
		{
			_varid = v;
		}
		
		public function get xvar():String
		{
			return _varid;
		}
		
		public function get xdsrc():String
		{
			return _dsrc;
		}
		
		public function set xdsrc(v:String):void
		{
			_dsrc = v;		// "A", "D"
		}
		
		public function get xdoff():uint
		{
			return _doff;
		}
		
		public function set xdoff(v:uint):void
		{
			_doff = v;		// record offset
		}
	
		public function get selrow():Array
		{
			return _tbldat[_selrow];
		}
	
		public function get selrows():Array
		{
			var i;
			var a:Array = [];
			for (i = 0; i < _selrows.length; ++i)
			{
				if (_selrows[i]) { a[a.length] = _tbldat[i]; }
			}
			return a;
		}

		public function get percent():Number
		{
			return _scrl.percent;
		}

		public function set percent(v:Number):void
		{
			_scrl.percent = v;
		}
		
		
	}
}

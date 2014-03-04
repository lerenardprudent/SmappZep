package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*
	import flash.ui.Mouse;
	import flash.text.*;
	import flash.net.*;
	import scrlba;
	 
	public class fimg1 extends MovieClip
	{
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _varid:String = "";
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;
		private var _hpt:Array = [];
		private var _picfiles:Array = [];
		private var _pics:Array = [];
		private var _piccnt = 2;
		private var _picloader:*;
		private var _overlay:Sprite;

		
		public function fimg1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, pf1, pf2, pf3, hpt):void
		{
			this.name = na;
			mouseChildren = false;
			_style = st;
			_w = w;
			_h = h;
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			_picfiles = [pf1, pf2, pf3];
			setpics(_picfiles);
			if (hpt != "")
			{ 
				_hpt = hpt.split("_");
				_overlay = new Sprite();
				addChild(_overlay);
			}
		}
		
		public function setsize():void
		{
			var i;
			for (i = 0; i <= 2; i++)
			{
				if (_pics[i] != null)
				{
					_pics[i].scaleX = 1; 
					_pics[i].scaleY = 1;
					_pics[i].scaleX = _w / _pics[i].width;
					_pics[i].scaleY = _h / _pics[i].height;
				}
			}
		}
			
		public function thisover (... parms):void
		{
			if (_pics[1] != null) { _pics[0].visible = false; _pics[1].visible = true; }
		}
			
		public function thisout (... parms):void
		{
			if (_pics[1] != null) { _pics[0].visible = true; _pics[1].visible = false; }
		}
		
		public function thisdown (... parms):void
		{
		}
		
		public function thisup (... parms):void
		{
		}
		
		public function thisclick (... parms):void
		{
		}
		
		public function set xheight(v:Number):void			//full width
		{
			_h = v;
		}
		
		public function get xheight():Number			//full height
		{
			return this.height;
		}
		
		public function set xwidth(v:Number):void			//full width
		{
			_w = v;
		}
		
		public function get xwidth():Number			//full width
		{
			return this.width;
		}

		public function set xstyle(v:int):void			//style
		{
			_style = v;
		}

		public function get xstyle():int			//style
		{
			return _style;
		}
		
		public function set xvar(v:String):void
		{
			_varid = v;
		}
		
		public function get xvar():String
		{
			return _varid;
		}
		
		public function setpics(p:Array):void			//pics
		{
			var i;
			for (i = 0; i <= 2; i++)
			{
				try{ removeChildAt(0); } catch (er) { }
			}
			_picfiles = p;
			_piccnt = 2;
			_pics = [null, null, null];
			loadpics();
		}		

		private function loadpics():void
		{
			if (_picfiles[_piccnt] != "")
			{
				_picloader = new Loader();
				_picloader.contentLoaderInfo.addEventListener(Event.COMPLETE,picloaded, false, 0, true);
				_picloader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, picioerror, false, 0, true);
				_picloader.load(new URLRequest(_picfiles[_piccnt]));
			}
			else
			{
				_piccnt--;
				if (_piccnt >= 0) { loadpics(); } //else { setsize(); }
			}
		}

		private function picloaded(e:Event):void
		{
			var sc;
			_picloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picloaded);
			_picloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, picioerror);
			//_pics[_piccnt] = Bitmap(_picloader.content);
			_pics[_piccnt] = _picloader.content;
			_pics[_piccnt].smoothing = true;
			_picloader = null;
			_pics[_piccnt].x = _pics[_piccnt].y = 0;
			//if (_picfx[0] != "")			//fit
			//{
				//sc =
			//}
			//img.alpha = _picfx[1];
			//img.blendMode = _picfx[5];
			_pics[_piccnt].visible = (_piccnt == 0);
			addChild(_pics[_piccnt]);
			_piccnt--;
			if (_piccnt >= 0) { loadpics(); } //else { setsize(); }
		}

		private function picioerror(e:IOErrorEvent):void
		{
			_picloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, picloaded);
			_picloader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, picioerror);
			_picloader = null;
			_piccnt--;
			if (_piccnt >= 0) { loadpics(); } //else { setsize(); }
		}
		
		private function endloadpics():void
		{
			var i;
			if (_pics[1] != null) { _pics[1].visible = false; }
			if (_pics[2] != null) { _pics[2].visible = false; }
		}
		
	}
}

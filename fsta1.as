package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;
	import flash.ui.Mouse;
	import flash.text.*;
	 
	public class fsta1 extends MovieClip
	{
		private var _star:MovieClip;
		private var _curval = false;
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _varid:String = "";
		private var _metlab:TextLineMetrics;
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;

		public function fsta1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16):void
		{
			this.name = na;
			_style = st;
			_w = w;
			_h = h;
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			if (_style == 1) { _star = new star1(); } else { _star = new star2(); }
			addChild(_star);
			_star.gotoAndStop(1);
		}
			
		public function thisover (... parms):void
		{
			
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
			var i, pa, v, ob, ov, sn, on;
			v = _varid;
			sn = parseInt(name.substr(8))
			xval = !xval;
			pa = this.parent;
			for (i = 0; i < pa.numChildren; ++i)
			{
				ob = pa.getChildAt(i);
				try { ov = ob.xvar } catch (er) { ov = null; }
				if (ov == v)
				{
					if (ob.name.substr(0, 8) == "OBJ_STA_" )
					{
						if (ob != this)
						{
							on = parseInt(ob.name.substr(8))
							ob.xval = (on < sn);
						}
					}
				}
			}
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

		public function set xstyle(v:int):void			//lab text
		{
			_style = v;
		}

		public function get xstyle():int			//lab text
		{
			return _style;
		}
		
		public function set xval(v:Boolean):void
		{
			if (v) { _star.gotoAndStop(2); } else { _star.gotoAndStop(1); }
			_curval = v;
		}
		
		public function get xval():Boolean
		{
			return _curval;
		}
		
		public function set xvar(v:String):void
		{
			_varid = v;
		}
		
		public function get xvar():String
		{
			return _varid;
		}
		
	}
}

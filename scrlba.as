package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;

    public class scrlba extends Sprite
	{

		private var _back:Sprite = new Sprite();
		private var _thumb:Sprite = new Sprite();
		private var _width:uint = 15;
		private var _length:uint = 225;
		private var _target:*;
		private var _tgtype:String;		//(P)anel, (T)ext
		private var _type:String;		//(V)ert, (H)oriz
		private var _backColor;
		private var _thumbColor;
		private var _borderColor;

		public function scrlba(tg:*= null, tgty:String = "P", ty:String = "H", w:uint = 8, l:uint = 200, bc:uint = 0xf6f6f6, tc:uint = 0xcbcbd1, cc:uint = 0xffffff):void
		{
			name = "scrl_o";
			_target = tg;
			_tgtype = tgty;
			_type = ty;
			_backColor = bc;
			_thumbColor = tc;
			_borderColor = cc;
			if (w < 4) { w = 4; }
			if (l < w) { l = w * 2; }
			_width = w;
			_length = l;
			addChild(_back);
			drawback();
			addChild(_thumb);
			drawthumb();
			if (_type == "H") { rotation = -90; }
			blendMode = "normal";
		}

		private function drawback():void
		{
			with (_back)
			{
				name = "scrlback_o";
				graphics.clear();
				graphics.beginFill(_backColor, 1);
				graphics.drawRect(0, 0, _width, _length);
				graphics.endFill();
				graphics.lineStyle(0, _borderColor, 1, true, LineScaleMode.NONE);
				graphics.moveTo(0, 0);
				graphics.lineTo(0, length);
			}
		}

		private function drawthumb():void
		{
			with (_thumb)
			{
				name = "scrlthumb_o";
				graphics.clear();
				//var gm:Matrix = new Matrix();
				//gm.createGradientBox(_width, _width, Math.PI * .5, 0, 0)
				//graphics.beginGradientFill(GradientType.LINEAR, [globals._scrollColorThumb1, globals._scrollColorThumb2], [1, 1], [50, 255], gm);
				graphics.beginFill(_thumbColor, 1);
				graphics.lineStyle(0, _thumbColor, 1, true, LineScaleMode.NONE);
				graphics.moveTo(0, 0);
				graphics.lineTo(0, _width);
				graphics.lineStyle(0, 0xaeaeb7, 1, true, LineScaleMode.NONE);
				graphics.lineTo(_width, _width);
				graphics.lineStyle(0, _thumbColor, 1, true, LineScaleMode.NONE);
				graphics.lineTo(_width, 0);
				graphics.lineStyle(0, 0xaeaeb7, 1, true, LineScaleMode.NONE);
				graphics.lineTo(0, 0);
				
				//graphics.drawRect(0, 0, _width, _width);
				graphics.endFill();
				buttonMode = true;
				x = y = 0;
			}
		}

		public function thisdown(ctrl, xs, ys, ... parms):void
		{
			var s;
			if (ctrl == _thumb)
			{
				_thumb.startDrag(false, new Rectangle(0, 0, 0, _length - _width));
			}
			else
			{
				var tw = Math.round(_width / 2);
				var yy = ys - tw;
				if (yy < 0) { yy = 0; }else if (yy + _width > _length) { yy = _length - _width; }
				_thumb.y = yy;
				thisscroll()
			}
		}
		
		public function thisup():void
		{
			_thumb.stopDrag();
			if (_tgtype == "P" || _tgtype == "T")			//masked panel
			{
				_target.x = Math.round(_target.x);
				_target.y = Math.round(_target.y);
			}
		}

		public function thisscroll():void
		{
			var m = _target.mask;
			if (_tgtype == "P")			//masked panel
			{
				if (_type == "V") { _target.y = Math.round(m.y + (m.height - _target.height) * percent); } else { _target.x = Math.round(m.x + (m.width - _target.width) * percent); }
			}
			else if (_tgtype == "T")			//text
			{
				if (_type == "V") { _target.scrollV = Math.round(_target.maxScrollV * percent); }
			}
			else if (_tgtype == "D")			//data
			{
				//show records label??
			}
		}
		
		public function get size():uint
		{
			return _width;
		}

		public function set size(w:uint):void
		{
			_width = w;
			drawback();
			_thumb.y = 0;
		}

		public function get length():uint
		{
			return _length;
		}

		public function set length(l:uint):void
		{
			var p = percent;
			if (l < 2 * _width) { l = 2 * _width; }
			_length = l;
			drawback();
			percent = p;
		}

		public function get thumb():Object
		{
			return _thumb;
		}

		public function set percent(p:Number):void
		{
			if (p > 1) { p = 1; }
			if (p < 0) { p = 0; }
			_thumb.y = p * (_length - _width);
		}

		public function get percent():Number
		{
			return _thumb.y  / (_length - _width);
		}

		public function set target(val:Object):void
		{
			_target = val;
		}

		public function get target():Object
		{
			return _target;
		}

		public function set scrltype(val:String):void
		{
			_type = val;
		}

		public function get scrltype():String
		{
			return _type;
		}

		public function set tgtype(val:String):void
		{
			_tgtype = val;
		}

		public function get tgtype():String
		{
			return _tgtype;
		}

	}
}
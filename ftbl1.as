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
	//import com.greensock.TweenMax;
	//import com.greensock.easing.*;
	 
	public class ftbl1 extends MovieClip
	{
		private var _back:Sprite = new Sprite();
		private var _hold:Sprite =  new Sprite();
		private var _hmask:Sprite = new Sprite();
		private var _tbl:Array = [];
		private var _tbldat:*;
		private var _rows:int;
		private var _cols:int;
		private var _colw:Array;
		private var _lab:TextField = new TextField();
		private var _scrl:scrlba = new scrlba(_hold, "T", "V", 8, 20);
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _metlab:TextLineMetrics;
		private var _metcell:TextLineMetrics;
		private var _tfcell:TextFormat = new TextFormat()
		private var _c0:int = 0xc0c0c0;
		private var _c1:int = 0xf0f0f0;
		private var _c2:int = 0xd3d3d3;
		private var _varid:String = "";

		public function ftbl1(na="ftbl1", id=0, st=1, w=200, h=100, rows=7, cols=4, colw=".2,.3,.1,.4"):void
		{
			var i;
			this.name = na;
			_w = 0;
			_colw = colw.split(",");
			for (i = 0; i < _colw.length; ++i) { _colw[i] = Math.round(parseFloat(_colw[i]) * (w - _scrl.size)); _w += _colw[i]; }
			_h = h;
			_scrl.x = 0;
			_scrl.y = 0;
			_style = st;
			_rows = rows;
			_cols = cols;
			_tfcell.font = "Arial";
			_tfcell.size = 10;
			_tfcell.letterSpacing = .5;
			_tfcell.color = 0x838396;
			_tfcell.leftMargin = _tfcell.rightMargin = 3;
			addChild(_back);
			addChild(_hold);
			addChild(_hmask);
			addChild(_lab);
			addChild(_scrl);
			drawobj();
		}
		
		private function drawobj():void
		{
			drawlabel();
			drawtable();
			drawmask();
			_hold.mask = _hmask;
			_hold.x = _hmask.x = 0;
			_hold.y = _hmask.y = _lab.height + 2;
			_hmask.width = _w;
			_hmask.height = _h - _lab.height - 2
			drawback();
			_scrl.x = _back.width -_scrl.size;
			_scrl.y = _hmask.y + 2;
			_scrl.length = _hmask.height - 2;
		}
		
		private function drawback():void
		{
			var gm:Matrix = new Matrix();
			with (_back)
			{
				gm.createGradientBox(_w, _h, Math.PI * .5, 0, 0);			//page back
				with (_back)
				{
					graphics.clear();
					graphics.lineStyle(0, _c0, .8, true);
					graphics.beginGradientFill(GradientType.LINEAR, [_c1, _c2], [1, 1], [100, 255], gm);
					if ( _style == 1)
					{
						graphics.drawRect(0, 0, _w, _h);
					}
					else if ( _style == 2)
					{
						graphics.drawRoundRect(0, 0, _w, _h, _h* .5, _h * .5);
					}
					graphics.endFill();
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
		
		private function drawlabel():void
		{
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 11;
			tf.letterSpacing = .5;
			tf.color = 0x838396;
			_tfcell.leftMargin = 3;
			with (_lab)
			{
				name = "lab";
				mouseWheelEnabled = false;
				type = TextFieldType.DYNAMIC;
				selectable = false;
				multiline = true;
				wordWrap = true;
				background = false;
				border = false;
				embedFonts = false;
				antiAliasType = AntiAliasType.ADVANCED;
				autoSize =  TextFieldAutoSize.LEFT;
				if (_style == 1) { tf.align = TextFormatAlign.LEFT;  tf.rightMargin = 0; } else if (_style == 2) { tf.align = TextFormatAlign.RIGHT;  tf.rightMargin = 3; }
				defaultTextFormat = tf;
				tabEnabled = false;
				text = "Label";
				filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
			}
			_metlab = _lab.getLineMetrics(0);
			_lab.height = Math.ceil(_lab.textHeight) + _metlab.descent + 1;
		}
		
		private function drawtable():void
		{
			var r, c, ry, rh, cel;
			ry = 0;
			for (r = 0; r < _rows; ++r)
			{
				_tbl[r] = [];
				rh = 0;
				for (c = 0; c < _cols; ++c)
				{
					_tbl[r][c] = new TextField();
					drawcell(_tbl[r][c], r, c);
					_hold.addChild(_tbl[r][c]);
					rh = Math.max(rh, _tbl[r][c].height);
					if (c == 0) { _tbl[r][c].x = 0 } else { _tbl[r][c].x = _tbl[r][c - 1].x + _tbl[r][c - 1].width; }
					_tbl[r][c].y = ry;
					_tbl[r][c].filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
				}
				ry += rh;
			}
			if (ry < _h) { _h = ry; }
		}
		
		private function drawcell(cel, r, c):void
		{
			with (cel)
			{
				name = "cell_" + r + "_" + c;
				mouseWheelEnabled = false;
				type = TextFieldType.INPUT;
				selectable = true;
				multiline = false;
				wordWrap = true;
				background = true;
				backgroundColor = 0xfafafa;
				border = true;
				borderColor = 0xcacad2;
				embedFonts = false;
				antiAliasType = AntiAliasType.ADVANCED;
				//autoSize =  TextFieldAutoSize.LEFT;
				defaultTextFormat = _tfcell;
				text = "---";		// default value
				tabEnabled = true;
				_metcell = getLineMetrics(0);
				height = Math.ceil(textHeight) + _metcell.descent + 1
				width = _colw[c];
			}
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

		public function get lab():TextField
		{
			return _lab;
		}
		
		public function set xheight(v:Number):void			//full height
		{
			_h = v;
			setsize();
		}
		
		public function get xheight():Number			//full height
		{
			return _back.height;
		}
		
		public function set xwidth(v:Number):void			//full width
		{
			_w = v;
			setsize();
		}
		
		public function get xwidth():Number			//full width
		{
			return _back.width;
		}

		public function set xstyle(v:int):void			//lab text
		{
			_style = v;
			setsize();
		}

		public function get xstyle():int			//lab text
		{
			return _style;
		}
		
		public function set labtext(v:String):void			//lab text
		{
			_lab.htmlText = v;
			setsize();
		}

		public function get labtext():String			//lab text
		{
			return _lab.htmlText
		}

		public function setsize():void
		{
			_lab.height = Math.ceil(_lab.textHeight) + _metlab.descent + 1;
			_hold.x = _hmask.x = 0;
			_hold.y = _hmask.y = _lab.height + 2;
			_hmask.width = _w;
			_hmask.height = _h - _lab.height - 2
			_scrl.x = _back.width -_scrl.size;
			_scrl.y = _hmask.y + 1;
			_scrl.length = _hmask.height - 2;
		}
		
		public function set xval(v:String):void
		{
			_tbldat = v;
		}
		
		public function get xval():String
		{
			return _tbldat;
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

package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*
	import flash.ui.Mouse;
	import flash.text.*;
	//import flash.net.*;
	import scrlba;
	//import com.greensock.TweenMax;
	//import com.greensock.easing.*;
	 
	public class finp1 extends MovieClip
	{
		private var _inp:TextField = new TextField();
		private var _lab:TextField = new TextField();
		private var _scrl:scrlba = new scrlba(_inp, "T", "V", 8, 20);
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _metinp:TextLineMetrics;
		private var _metlab:TextLineMetrics;
		private var _varid:String = "";
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;
		private var _dbfld:int;
		private var _dv:String;

		public function finp1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, dv):void
		{
			this.name = na;
			addChild(_inp);
			addChild(_lab);
			addChild(_scrl);
			_scrl.visible = false;
			_scrl.x = 0;
			_scrl.y = 0;
			_style = st;
			_w = w;
			_h = h;
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			if (dv == "") { _dv = "---"; } else { _dv = dv; }
			drawobj();
			this.filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
		}
		
		private function drawobj():void
		{
			var cc;
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 12;
			with (_inp)
			{
				name = "inpbox";
				type = TextFieldType.INPUT;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.PIXEL;
				sharpness = 100;
				thickness = -50;
				mouseWheelEnabled = false;
				embedFonts = false;
				tf.leftMargin = tf.rightMargin = 3;
				defaultTextFormat = tf;
				background = false;
				border = false;
				selectable = true;
				multiline = false;
				wordWrap = true;
				textColor = parseInt(_c7);
				background = false;
				text = _dv;		// default value
				tabEnabled = true;
			}
			with (_lab)
			{
				name = "lab";
				type = TextFieldType.DYNAMIC;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.PIXEL;
				sharpness = 100;
				thickness = -50;
				tf.leftMargin = tf.rightMargin = 0;
				if (_style == 1) { tf.align = TextFormatAlign.LEFT; tf.leftMargin = tf.rightMargin = 0; } else if (_style == 2) { tf.align = TextFormatAlign.RIGHT; tf.leftMargin = tf.rightMargin = 3; }
				defaultTextFormat = tf;
				mouseWheelEnabled = false;
				embedFonts = false;
				background = false;
				border = false;
				selectable = false;
				multiline = true;
				wordWrap = false;
				background = false;
				textColor = parseInt(_c14);
				tabEnabled = false;
			}
			labtext = "Label"
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

		public function get inp():TextField
		{
			return _inp;
		}
		
		public function set xheight(v:Number):void			//full height
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
			setsize();
		}

		public function get xstyle():int			//style
		{
			return _style;
		}
		
		public function set labtext(v:String):void			//lab text
		{
			if (_style == 1) { _lab.autoSize = TextFieldAutoSize.LEFT; } else { _lab.autoSize = TextFieldAutoSize.NONE; }
			_lab.htmlText = v;
			setsize();
		}

		public function get labtext():String			//lab text
		{
			return _lab.htmlText
		}

		public function setsize():void
		{
			_metinp = _inp.getLineMetrics(0);
			_metlab = _lab.getLineMetrics(0);
			if (_style == 1) 
			{
				_lab.x = _inp.x = 0;
				_lab.width = _inp.width = _w;
				_lab.y = 0;
				if (_lab.text != "")
				{
					_lab.height = Math.ceil(_lab.textHeight) + _metlab.descent + 1;
					_lab.visible = true;
					_inp.y = _lab.height;
				}
				else
				{
					_lab.height = 0;
					_lab.visible = false;
					_inp.y = 0;
				}
				if (!_inp.multiline) { _inp.height = _metinp.height + _metinp.descent + 1; _h = _lab.height + _inp.height;} else { _inp.height = Math.max(_metinp.height + _metinp.descent, _h - _lab.height); }
				_scrl.visible = _inp.multiline;
				_scrl.length = _inp.height - 2;
				_scrl.y = _inp.y + 1;
				_scrl.x = _inp.width - _scrl.size - 1;
				
			}
			else if (_style == 2) 
			{
				_lab.x = 0;
				_lab.y = _inp.y = 0;
				if (_lab.text != "")
				{
					_lab.width = Math.ceil(_lab.textWidth) + 15;
					if (!_inp.multiline){ _inp.height = _metinp.height + _metinp.descent + 1; _lab.height = Math.ceil(_lab.textHeight + _metlab.descent + 1); _h = _inp.height;} else { _inp.height =  _lab.height = _h; }
					if (_w < _lab.width + 30) { _w = _lab.width + 30; }
					_inp.width = _w - _lab.width;
					_inp.x = _lab.width;
					_lab.visible = true;
				}
				else
				{
					if (!_inp.multiline){ _inp.height = _metinp.height + _metinp.descent + 1; _h = _inp.height;} else { _inp.height = _h; }
					_lab.width = 0;
					_inp.width = _w;
					_inp.x = 0;
					_lab.visible = false;
				}
				_scrl.visible = _inp.multiline;
				_scrl.length = _inp.height - 2;
				_scrl.y = _inp.y + 1;
				_scrl.x = _w - _scrl.size - 1;
			}
			_inp.mouseWheelEnabled = _inp.multiline;
			drawback();
		}
		
		private function drawback():void
		{
			var cc;
			graphics.clear();
			if (_c11 == "") { graphics.lineStyle(); } else { graphics.lineStyle(0, parseInt(_c11), 1); }
			if (_c8 == ""){graphics.beginFill(0xffffff, .01);}else{graphics.beginFill(parseInt(_c8), 1);}
			graphics.drawRect(_lab.x,_lab.y, _lab.width, _lab.height);
			graphics.endFill();
			if (_c4 == "") { graphics.lineStyle(); } else { cc = _c4.split(","); graphics.lineStyle(0, parseInt(cc[0]), 1); }
			if (_c1 == ""){graphics.beginFill(0xffffff, .01);}else{cc = _c1.split(","); graphics.beginFill(parseInt(cc[0]), 1);}
			graphics.drawRect(_inp.x, _inp.y, _inp.width, _inp.height);
			graphics.endFill();
		}
		
		public function set xval(v:String):void
		{
			_inp.text = v;
		}
		
		public function get xval():String
		{
			return _inp.text;
		}
		
		public function set xvar(v:String):void
		{
			_varid = v;
		}
		
		public function get xvar():String
		{
			return _varid;
		}
		
		public function set xdbfld(v:int):void
		{
			_dbfld = v;
		}
		
		public function get xdbfld():int
		{
			return _dbfld;
		}
		
		public function set xpwd(v:Boolean):void
		{
			_inp.displayAsPassword = v;
		}
		
	}
}

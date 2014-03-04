package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*
	import flash.ui.Mouse;
	import flash.text.*;
	import flash.net.*;
	//import com.greensock.TweenMax;
	//import com.greensock.easing.*;
	 
	public class fbtn1 extends MovieClip
	{
		private var _back:Sprite = new Sprite();
		private var _lab:TextField = new TextField();
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _mo:String = "U";
		private var _state:String = "U";
		private var _metlab:TextLineMetrics;
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;
		private var _tgl:Boolean;

		public function fbtn1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, tgl):void
		{
			addChild(_back);
			this.name = na;
			addChild(_lab);
			_back.mouseEnabled = false;
			_lab.mouseEnabled = false;
			buttonMode = true;
			_style = st;
			_w = w;
			_h = h;
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			_tgl = tgl;
			drawobj();
			this.filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
		}
		
		private function drawobj():void
		{
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 12;
			tf.color = 0x838396;
			tf.align = TextFormatAlign.CENTER;
			with (_lab)
			{
				name = "lab";
				type = TextFieldType.DYNAMIC;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.PIXEL;
				sharpness = 100;
				thickness = -50;
				mouseWheelEnabled = false;
				embedFonts = false;
				defaultTextFormat = tf;
				background = false;
				border = false;
				selectable = false;
				multiline = true;
				wordWrap = false;
				if (_c8 == "")
				{
					background = false;
				}
				else
				{
					background = true;
					backgroundColor = parseInt(_c8);
				}
				if (_c11 == "")
				{
					border = false;
				}
				else
				{
					border = true;
					borderColor = parseInt(_c11);
				}
				textColor = parseInt(_c14);
				width =  _w;
				tabEnabled = false;
			}
			labtext = "Button";
		}
		
		private function drawback():void			// (U)ormal, (O)ver, (D)own
		{
			var cbk, cbr, bw;
			if (_mo == "U")
			{
				cbk = _c1.split(","); cbr = _c4.split(",");
			}
			else if (_mo == "O")
			{
				cbk = _c2.split(","); cbr = _c5.split(",");
			}
			else if (_mo == "D")
			{
				cbk = _c3.split(","); cbr = _c6.split(",");
			}
			with (_back)
			{
				with (_back)
				{
					graphics.clear();
					if (cbr.length > 0) { graphics.lineStyle(1.25, parseInt(cbr[0]), parseFloat(cbr[1]), true); bw = 1; } else { graphics.lineStyle(); bw = 0; }
					if (cbk.length == 0)
					{
						graphics.beginFill(0xffffff, .01);
					}
					else
					{
						var gm:Matrix = new Matrix();
						gm.createGradientBox(_w, _h, parseInt(cbk[4]) * Math.PI / 180, 0, 0);			//page back
						graphics.beginGradientFill(GradientType.LINEAR, [parseInt(cbk[0]), parseInt(cbk[1])], [parseInt(cbk[2]), parseInt(cbk[3])], [80, 255], gm);
					}
					if (_style == 1)
					{
						graphics.drawRoundRect(.4, .4, _w-bw, _h-bw, _h - 1, _h - 1);
					}
					else if ( _style == 2)
					{
						graphics.drawRoundRect(.4, .4, _w-bw, _h-bw, _h* .5, _h * .5);
					}
					else if ( _style == 3)
					{
						graphics.drawRect(0, 0, _w-bw, _h-bw);
					}
					graphics.endFill();
				}
			}
		}
				
		public function thisover (... parms):void
		{
			_mo = "O";
			drawback();
			_lab.textColor = parseInt(_c15);
		}
			
		public function thisout (... parms):void
		{
			if (!_tgl) { _mo = "U"; } else { _mo = _state; }
			drawback();
			if (_mo == "U") { _lab.textColor = parseInt(_c14); } else { _lab.textColor = parseInt(_c16); }
		}
		
		public function thisdown (... parms):void
		{
			_mo = "D";
			drawback();
			_lab.textColor = parseInt(_c16);
		}
		
		public function thisup (... parms):void
		{
			if (_tgl) { return; }
			_mo = "U";
			drawback();
			_lab.textColor = parseInt(_c14);
		}
		
		public function thisclick (... parms):void
		{
			if (_tgl)
			{
				if (_state == "U") { _state = "D"; } else { _state = "U"; }
				_mo = _state;
				if (_mo == "U") { _lab.textColor = parseInt(_c14); } else { _lab.textColor = parseInt(_c16); }
				drawback();
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
			drawback();
		}

		public function get xstyle():int			//lab text
		{
			return _style;
		}

		public function get lab():TextField
		{
			return _lab;
		}
		
		public function set labtext(v:String):void			//lab text
		{
			var l, yy;
			_lab.htmlText = v;
			_metlab = _lab.getLineMetrics(0);
			_lab.height = Math.ceil(_lab.textHeight) + _metlab.descent + 2;
			_lab.x = Math.round((_w - _lab.width) * .5);
			_lab.y = Math.round((_h - _lab.height) * .5);
			drawback();
		}

		public function get labtext():String			//lab text
		{
			return _lab.htmlText;
		}
		
		public function setsize():void
		{
			if (_lab.height > _h)
			{
				_lab.height = _h;
			}
			else
			{
				_metlab = _lab.getLineMetrics(0);
				_lab.height = Math.ceil(_lab.textHeight) + _metlab.descent + 2;
			}
			_lab.y = Math.round((_h - _lab.height) * .5);
			_lab.width = _w;
			_lab.x = Math.round((_w - _lab.width) * .5);
			drawback();
		}
		
		public function set xval(v:String):void
		{
			_state = v;
			_mo = _state;
			if (_mo == "U") { _lab.textColor = parseInt(_c14); } else { _lab.textColor = parseInt(_c16); }
			drawback();
		}
		
		public function get xval():String
		{
			return _state;
		}

	}
}

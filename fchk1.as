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
	 
	public class fchk1 extends MovieClip
	{
		private var _ckback:MovieClip = new ckback();
		private var _ckv:MovieClip = new ckv();
		private var _lab:TextField = new TextField();
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _curval:Boolean = false;
		private var _varid:String = "";
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;
		private var _dbfld:int;

		public function fchk1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16):void
		{
			this.name = na;
			addChild(_ckback);
			addChild(_ckv);
			addChild(_lab);
			_style = st;
			_w = w;
			_h = h;
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			this.filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
			drawobj();
			_lab.mouseEnabled = false;
			_ckv.mouseEnabled = false;
			_ckback.mouseEnabled = false;
			buttonMode = true;
		}
		
		private function drawobj():void
		{
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 12;
			tf.leftMargin = tf.rightMargin = 2;
			with (_lab)
			{
				name = "lab";
				type = TextFieldType.DYNAMIC;
				antiAliasType = AntiAliasType.ADVANCED;
				autoSize =  TextFieldAutoSize.LEFT;
				mouseWheelEnabled = false;
				embedFonts = false;
				defaultTextFormat = tf;
				selectable = false;
				multiline = true;
				wordWrap = false;
				textColor = parseInt(_c14);
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
				tabEnabled = false;
				text = "Check box";
				x = _ckback.width + 2;
				y = 0
			}
			_ckback.x = 0;
			_ckback.y = Math.round((_lab.height - _ckback.height) * .5);
			_ckv.x = Math.round((_ckback.width - _ckv.width) * .5);
			_ckv.y = Math.round(_ckback.y + (_ckback.height - _ckv.height) * .5);
			_ckv.visible = _curval;
		}
			
		public function thisover (... parms):void
		{
			_lab.textColor = parseInt(_c15);
		}
			
		public function thisout (... parms):void
		{
			if (_curval) { _lab.textColor = parseInt(_c16); } else { _lab.textColor = parseInt(_c14); }
		}
		
		public function thisdown (... parms):void
		{
			
		}
		
		public function thisup (... parms):void
		{
			
		}
		
		public function thisclick (... parms):void
		{
			xval = !xval;
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

		public function get lab():TextField
		{
			return _lab;
		}
		
		public function set labtext(v:String):void			//lab text
		{
			_lab.htmlText = v;
			_ckback.y = Math.round((_lab.height - _ckback.height) * .5);
			_ckv.x = Math.round((_ckback.width - _ckv.width) * .5);
			_ckv.y = Math.round(_ckback.y + (_ckback.height - _ckv.height) * .5);
		}

		public function get labtext():String			//lab text
		{
			return _lab.htmlText
		}

		public function get chkbox():MovieClip
		{
			return _ckback;
		}
		
		public function set xval(v:Boolean):void
		{
			_curval = v;
			_ckv.visible = _curval;
			if (_curval) { _lab.textColor = parseInt(_c16); } else { _lab.textColor = parseInt(_c14); }
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
		
		public function set xdbfld(v:int):void
		{
			_dbfld = v;
		}
		
		public function get xdbfld():int
		{
			return _dbfld;
		}

	}
}

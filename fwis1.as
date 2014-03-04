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
	 
	public class fwis1 extends MovieClip
	{
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _wis:* = null;
		private var _htext:TextField = new TextField();

		
		public function fwis1(na, id, st, w, h, txt):void
		{
			this.name = na;
			mouseChildren = false;
			_style = st;
			_w = w;
			_h = h;
			if (_style == 1) { _wis = new wis1(); } else if (_style == 2) { _wis = new wis2(); } else { _wis = new wis3(); }
			_wis.name = "wis";
			addChild(_wis);
			addChild(_htext);
			_htext.visible = false;
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 9;
			with (_htext)
			{
				name = "htext";
				type = TextFieldType.DYNAMIC;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.PIXEL;
				sharpness = 100;
				thickness = -50;
				tf.leftMargin = tf.rightMargin = 3;
				defaultTextFormat = tf;
				mouseWheelEnabled = false;
				embedFonts = false;
				selectable = false;
				multiline = true;
				wordWrap = false;
				textColor = 0x717184;
				background = true;
				backgroundColor = 0xf8f8ff;
				border = true;
				borderColor = 0xcfcfd6;
				autoSize = TextFieldAutoSize.LEFT;
				htmlText = txt;
				y = 0;		// -Math.round( height * .5);
				x = 20;
			}
			this.filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
		}
		
		public function setsize():void
		{
			
		}
			
		public function thisover (... parms):void
		{
			this.parent.setChildIndex(this, this.parent.numChildren-1); 
			_wis.gotoAndStop(2);
			_htext.visible = true;
		}
			
		public function thisout (... parms):void
		{
			_wis.gotoAndStop(1);
			_htext.visible = false;
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

		public function get htext():*			//_htext
		{
			return _htext;
		}
		
	}
}

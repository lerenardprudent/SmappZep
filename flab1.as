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
	 
	public class flab1 extends MovieClip
	{
		private var _lab:TextField = new TextField();
		private var _scrl:scrlba = new scrlba(_lab, "T", "V", 8, 20);
		private var _style:int = 1;
		private var _w:int;
		private var _h:int;
		private var _txf:Boolean;
		private var _txloader:*;
		private var _metlab:TextLineMetrics;
		private var _c1, _c2, _c3, _c4, _c5, _c6, _c7, _c8, _c9, _c10, _c11, _c12, _c13, _c14, _c15, _c16;
		private var _dbfld:int;

		
		public function flab1(na, id, st, w, h, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, txf):void
		{
			this.name = na;
			addChild(_lab);
			addChild(_scrl);
			_style = st;
			_w = w;
			_h = h;
			_c1 = c1; _c2 = c2; _c3 = c3; _c4 = c4; _c5 = c5; _c6 = c6; _c7 = c7; _c8 = c8; _c9 = c9; _c10 = c10; _c11 = c11; _c12 = c12; _c13 = c13; _c14 = c14; _c15 = c15; _c16 = c16;
			_txf = txf;
			drawobj();
			this.filters = [new BlurFilter(0, 0, 1)];		//patch for alpha and masking
		}
		
		private function drawobj():void
		{
			
			var cc;
			var tf:TextFormat = new TextFormat();
			tf.font = "Arial";
			tf.size = 12;
			tf.leftMargin = 3;
			tf.rightMargin = 12;
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
				wordWrap = true;
				textColor = parseInt(_c14);
				tabEnabled = false;
			}
			if (!_txf) { labtext = "---"; }
		}
		
		public function setsize():void
		{
			_metlab = _lab.getLineMetrics(0);
			_lab.width = _w;
			_lab.height = _h;
			_scrl.visible = (_lab.textHeight > _h);
			_scrl.length = _lab.height - 2;
			_scrl.y = 1;
			_scrl.x = _w - _scrl.size - 1;
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
		}

		public function get lab():TextField
		{
			return _lab;
		}
		
		public function set xheight(v:Number):void			//full width
		{
			_h = v;
			_lab.height = _h;
		}
		
		public function get xheight():Number			//full height
		{
			return _h;
		}
		
		public function set xwidth(v:Number):void			//full width
		{
			_w = v;
			_lab.width = _w;
		}
		
		public function get xwidth():Number			//full width
		{
			return _w;
		}

		public function set xstyle(v:int):void			//lab text
		{
			_style = v;
		}

		public function get xstyle():int			//lab text
		{
			return _style;
		}
		
		public function set labtext(v:String):void			//lab text
		{
			if (!_txf)
			{
				
				_lab.htmlText = v;
				setsize();
			}
			else 
			{
				_txloader = new URLLoader();
				_txloader.addEventListener(Event.COMPLETE, fileloaded, false, 0, true);
				_txloader.addEventListener(IOErrorEvent.IO_ERROR, fileerror, false, 0, true);
				_txloader.load(new URLRequest(v));
			}
		}

		public function get labtext():String			//lab text
		{
			return _lab.htmlText;
		}
		
		public function set xdbfld(v:int):void
		{
			_dbfld = v;
		}
		
		public function get xdbfld():int
		{
			return _dbfld;
		}
		
		private function fileloaded(e:Event):void		//load file
		{
			_lab.htmlText = e.target.data;
			_txloader.removeEventListener(Event.COMPLETE, fileloaded);
			_txloader.removeEventListener(IOErrorEvent.IO_ERROR, fileerror);
			_txloader = null;
			if (_w < 200) { _w = 200; }
			if (_h < 100) { _h = 100; }
			setsize();
		}
		
		private function fileerror(e:Event):void		//file error
		{
			_lab.htmlText = "File error";
			_txloader.removeEventListener(Event.COMPLETE, fileloaded);
			_txloader.removeEventListener(IOErrorEvent.IO_ERROR, fileerror);
			_txloader = null;
			setsize();
		}
		
	}
}

package
{
	import flash.display.*
	import flash.events.*;
	import flash.geom.*;
	import flash.filters.*
	import flash.ui.Mouse;
	import flash.text.*;
	 
	public class ifwin extends MovieClip
	{

		private var _hld = new Sprite();;
		private var _msk = new Sprite();
		private var _tit = new TextField();
		private var _obclbtn = new clbtn();
		private var _obrebtn = new rebtn();
		private var _tf:TextFormat = new TextFormat();
		private var _mettitle:TextLineMetrics;
		private var _layout:int;
		

		private var _ww;
		private var _hh;		
		private var _bkvi;
		private var _bkcl;
		private var _bkal;
		private var _bkpc;
		private var _bkga;
		private var _bkcr;
		private var _brdw;
		private var _brcl;
		private var _brda;
		private var _hdhh;
		private var _hdcl;
		private var _hdal;
		private var _hdpc;
		private var _hdga;
		private var _hdtx;
		private var _hdcr;
		private var _drg;
		private var _scrl;
		private var _acew;
		private var _aceh;
		private var _aszw;
		private var _aszh;
		private var _clbt;
		private var _rebt;
		
		private var _scrlbav:*;
		
		//window-id, window-parent, width, height, back-visible, back-clrs, back-alphas, back-clrs-pct, back-grad-angle, back-corners, bord-width, bord-clr, bord-alpha, header-height, head-clrs, head-alphas, head-clrs-pct, head-grad-angle, head-htmltext, head-corners, win-shade-angle, win-draggable, win-visible, win-alpha, win-enabled, scrollbar, autocenterh, autocenterv, autosizeh, autosizew, close-btn,refresh-btn		
		
		public function ifwin(win, wpa:*, ww:int, hh:int, bkvi:Boolean, bkcl:Array, bkal:Array, bkpc:Array, bkga:Number, bkcr:Array, brdw:int, brcl:int, brda:Number, hdhh:int, hdcl:Array, hdal:Array, hdpc:Array, hdga:Number, hdtx:String, hdcr:Array, shad:*, drg:Boolean, vis:Boolean, alp:Number, ena:Boolean, scrl:String, acew:Boolean, aceh:Boolean, aszw:*, aszh:*, clbt, rebt):void
		{
			_ww = ww;
			_hh = hh;
			_bkvi = bkvi;
			_bkcl = bkcl;
			_bkal = bkal;
			_bkpc = bkpc;
			_bkga = bkga;
			_bkcr = bkcr;
			_brdw = brdw;
			_brcl = brcl;
			_brda = brda;
			_hdhh = hdhh;
			_hdcl = hdcl;
			_hdal = hdal;
			_hdpc = hdpc;
			_hdga = hdga;
			_hdtx = hdtx;
			_hdcr = hdcr;
			_drg = drg;
			_scrl = scrl;
			_acew = acew;
			_aceh = aceh;
			_aszw = aszw;
			_aszh = aszh;
			_clbt = clbt;
			_rebt = rebt;
			
			_tf.font = "Arial";
			_tf.size = 12;
			_tf.letterSpacing = .3;
			_tf.color = 0xf6f6f6;
			
			this.name = "win_" + win;
			_hld.name = "holder";
			drawtrect(_hld, 0, 0, 1, 1);		//force holder height
			drawback(ww, hh);
			if (_hdhh > 0)
			{
				drawtitle(ww);
				this.addChild(_tit);
				this.addChild(_obclbtn);
				_obclbtn.name = "w_clbtn";
				_obclbtn.visible = _clbt;
				_obclbtn.x = _ww - 25;
				_obclbtn.y = 11;
				this.addChild(_obrebtn);
				_obrebtn.name = "w_rebtn";
				_obrebtn.visible = _rebt;
				_obrebtn.x = _ww - 50;
				_obrebtn.y = 11;
			}
			this.addChild(_hld);
			this.addChild(_msk);
			_hld.mask = _msk;
			_hld.x = _msk.x = _brdw;
			_hld.y = _msk.y = _hdhh + 10;
			drawscroll(ww, hh)
			this.mouseChildren = ena;
			this.mouseEnabled = ena;
			_msk.mouseEnabled = false;
			if (shad != "") { this.filters = [new DropShadowFilter(3, parseInt(shad), 0x000000, .3, 4, 4, 1, 4)]; }
			this.alpha = alp;
			this.visible = vis;
			wpa.addChild(this);
		}
		
		private function drawback(ww:int, hh:int):void
		{
			var dh = 0;
			this.graphics.clear();
			if (_bkvi)			//background
			{
				drawxrect(this, 0, 0, ww, hh, _bkcr, _bkcl, _bkal, _bkpc, _bkga, 0, _bkcl[1], _bkal[1]);
				if (_hdhh != 0) { drawxrect(this, 0, 0, ww, _hdhh, _hdcr, _hdcl, _hdal, _hdpc, _hdga, 0, _hdcl[1], _hdal[1]); }		//header
			}
			else
			{
				if (_hdhh != 0) { drawxrect(this, 0, 0, ww, _hdhh, _hdcr, _hdcl, _hdal, _hdpc, _hdga, 0, _hdcl[1], _hdal[1]); }		//header
				drawtrect(this, 0, 0, ww, hh)
			}
			if (_brdw >= 0) { drawxrect(this, .3, .3, ww, hh, _bkcr, [], [], [], 0, _brdw, _brcl, _brda); }					//border
			if (_scrl != "") { dh = 20; }
			_msk.graphics.clear();
			drawxrect(_msk, 0, 0, ww - 2 * _brdw, hh - _hdhh - _brdw - dh - 10, [_hdcr[4], _hdcr[3], _bkcr[2], _bkcr[3]], [0x000000], [1], [0, 255], 0, 0, 0x000000, 1);		//mask
		}
		
		private function drawtitle(ww:int):void
		{
			with (_tit)
			{
				name = "title";
				defaultTextFormat = _tf;
				antiAliasType = AntiAliasType.ADVANCED;
				gridFitType = GridFitType.PIXEL;
				sharpness = 100;
				thickness = -50;
				htmlText = _hdtx;
				width = ww - 40;
				x = 10;
				y = 8; // Math.round((hdhh - _tit.height) * .5);
				mouseEnabled = false;
			}
		}
		
		private function drawscroll(ww:int, hh:int):void
		{
			if (_scrl == "") { return; }
			if (_scrl == "V")
			{
				_scrlbav = new scrlba(_hld, "P", "V", 8, Math.round((hh - _hdhh)*.8));
				_scrlbav.x = ww - Math.round(_brdw * .5) - 8;
				_scrlbav.y = _hdhh + Math.round((hh - _hdhh - _scrlbav.length)*.5);
			}
			else if (_scrl == "H")
			{
				
			}
			else if (_scrl == "B")
			{
				
			}
			this.addChild(_scrlbav);
		}
		
		private function drawtrect(mc, xx, yy, ww, hh):void
		{
			with (mc.graphics)
			{
				lineStyle();
				beginFill(0xffffff, .01);
				drawRect(xx, yy, ww, hh);
			}
		}
		
		private function drawxrect(mc, x1, y1, x2, y2, r, bkcl, bkal, bkpc, bkga, brw, brcl, bral):void
		{
			var gm:Matrix = new Matrix();
			with (mc.graphics)
			{
				lineStyle(brw, brcl, bral, true, LineScaleMode.NONE, CapsStyle.NONE, JointStyle.MITER);
				if (bkcl.length == 1)
				{
					beginFill(bkcl[0], bkal[0]);
				}
				else if (bkcl.length > 1)
				{
					gm.createGradientBox(x2-x1, y2-y1, bkga, x1, y1);
					beginGradientFill(GradientType.LINEAR, bkcl, bkal, bkpc, gm);
				}
				moveTo(x1 + r[0], y1);
				lineTo(x2 - r[1], y1);
				curveTo(x2, y1, x2, y1 + r[1]);
				lineTo(x2, y2 - r[2]);
				curveTo(x2, y2, x2 - r[2], y2);
				lineTo(x1 + r[3], y2);
				curveTo(x1, y2, x1, y2 - r[3]);
				lineTo(x1, y1 + r[0]);
				curveTo(x1, y1, x1 + r[0], y1);
				if (bkcl.length > 0) { endFill(); }
			}
		}

		public function get holder():Sprite			//content holder
		{
			return _hld;
		}

		public function get holdermask():Sprite			//content holder
		{
			return _msk;
		}
		
		public function set title(v:String):void			//lab text
		{
			_tit.htmlText = v;
		}

		public function get title():String			//lab text
		{
			return _tit.htmlText;
		}
		
		public function set draggable(v:Boolean):void			//lab text
		{
			_drg = v;
		}

		public function get draggable():Boolean			//lab text
		{
			return _drg;
		}
		
		public function get vcenterw():Boolean
		{
			return _acew;
		}
		
		public function get vcenterh():Boolean
		{
			return _aceh;
		}
		
		public function get vwidth():Number			//visual width
		{
			return _ww;
		}

		public function get vheight():Number			//visual height
		{
			return _hh;
		}
		
		public function get vfitheight():*
		{
			if (_aszh != "") { return parseFloat(_aszh); } else { return ""; }
		}
		
		public function get vfitwidth():*
		{
			if (_aszw != "") { return parseFloat(_aszw); } else { return ""; }
		}
		
		public function resizewin(w, h)
		{
			_ww = w;
			_hh = h;
			drawback(_ww, _hh);
			try { _obclbtn.x = _ww - 25; } catch (er) { }
			try { _obclbtn.x = _ww - 50; } catch (er) { }
			if (_scrl == "") { return; }
			if (_scrl == "V")
			{
				_scrlbav.visible = (_hld.height - 10 > _msk.height);
				_scrlbav.x = _ww - Math.round(_brdw * .5) - 8;
				_scrlbav.y = _hdhh + Math.round((_hh - _hdhh - _scrlbav.length) * .5);
			}
		}
		
		public function get scrlbarv():*
		{
			return _scrlbav;
		}
		
		public function get scrltype():String
		{
			return _scrl;
		}
		
		public function set layout(l):void
		{
			_layout = l;
		}
		
		public function get layout():int
		{
			return _layout;
		}

	}
}

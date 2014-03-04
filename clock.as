package
{
	import flash.display.*
	import flash.events.*;
	 
	public class clock extends Sprite
	{
		private var _seq = 1;
		private var _nbr = ["0","1","2","3","4","5","6","7","8","9"];
		private var _clock = new xclock();
		private var _xtarget:*;
		private var _xtime = null;
		
		public function clock(tg=null, tgx="00:00"):void
		{
			addChild(_clock);
			addEventListener(MouseEvent.MOUSE_DOWN, clockdown, false, 0, true);
			addEventListener(MouseEvent.CLICK, clockclick, false, 0, true);
			for (var i = 0; i < 10; ++i) { var ob = _clock["wb_" + i]; ob.mouseChildren = false; ob.lab.text = _nbr[i]; ob.buttonMode = true; }
		}

		private function clockdown (e:MouseEvent):void
		{
			e.stopPropagation();
		}
		
		private function clockclick(e:MouseEvent):void
		{
			var tn;
			e.stopPropagation();
			if(e.target.name.substr(0,3) == "wb_")
			{
				tn = parseInt(e.target.name.substr(3));
				if(_seq == 1)
				{
					if(tn < 3){ _clock.hh1.text = tn; _seq++; }
				}
				else if(_seq == 2)
				{
					if(!(_clock.hh1.text == "2" && tn > 3)){ _clock.hh2.text = tn; _seq++; }
				}
				else if(_seq == 3)
				{
					if(tn < 6){ _clock.hh3.text = tn; _seq++; }
				}
				else if(_seq == 4)
				{
					_clock.hh4.text = tn; _seq++;
					_xtarget.text = _clock.hh1.text + _clock.hh2.text + ":" +_clock.hh3.text +_clock.hh4.text;
					this.visible = false;
				}
				else
				{
					_seq = 1;
					_clock.hh1.text = _clock.hh2.text = _clock.hh3.text = _clock.hh4.text = "0";
				}
			}
			else
			{
				_seq = 1;
				_clock.hh1.text = _clock.hh2.text = _clock.hh3.text = _clock.hh4.text = "0";
			}
			
		}
		
		public function get xtime():String
		{
			return _xtime;
		}
		
		public function set xtime(v:String):void
		{
			_clock.hh1.text = v.substr(0, 1);
			_clock.hh2.text = v.substr(1, 1);
			_clock.hh3.text = v.substr(3, 1);
			_clock.hh4.text = v.substr(4, 1);
			
		}
		
		public function get xtarget():*
		{
			return _xtarget;
		}
		
		public function set xtarget(ob:*):void			//full height
		{
			_xtarget = ob;
		}
		
	}
}
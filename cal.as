package
{
	import flash.display.*
	import flash.events.*;
	import flash.filters.*
	import flash.text.*;
	
	public class cal extends MovieClip
	{
		//public var obid:String = "mc";
		
		//private var monthNames:Array = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
		//private var dayNames:Array = new Array("Su", "Mo", "Tu", "We", "Th", "Fr", "Sa");
		private var monthNames:Array = new Array("Janvier", "Février", "Mars", "Avril", "Mai", "Juin", "Juillet", "Août", "Septembre", "Octobre", "Novembre", "Décembre");
		private var dayNames:Array = new Array("D", "L", "M", "M", "J", "V", "S");
		private var maxDays:Array = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		private var curDate:Date = new Date();
		private var curYear:int = curDate.getFullYear();
		private var curMonth:int = curDate.getMonth();
		private var curDay:int = curDate.getDate();
		private var curWDay:int = curDate.getDay();
		private var thisYear:int = curYear;
		private var thisMonth:int = curMonth;
		private var selYear:int = -1;
		private var selMonth:int = -1;
		private var selDay:int = -1;
		private var daysNr:int;
		private var daysHolder:MovieClip = new MovieClip();
		private var calTitle:TextField = new TextField();
		private var obOver:String = "bk";
		private var obClicked:String = "bk";
		private var color1:int = 0xf6f6f6;		//back
		private var color2:int = 0x808080;		//back reverse 
		private var color3:int = 0x606060;		//clicked day
		private var color4:int = 0xe0e0e0;		//day over
		private var color5:int = 0x404040;		//text normal
		private var color6:int = 0xff0000;		//text curday
		private var moUp:MovieClip = new ar1();
		private var moDn:MovieClip = new ar1();
		private var yrUp:MovieClip = new ar2();
		private var yrDn:MovieClip = new ar2();
		
		private var _xtarget:*;
		
		public function cal()
		{
 			setdays();
			setyearmonth(curMonth, curYear);
			addChild(calTitle);
			setweekdays();
			drawcal();
			addEventListener(MouseEvent.MOUSE_DOWN, caldown, false, 0, true);
			addEventListener(MouseEvent.MOUSE_MOVE, calmove, false, 0, true);
			addEventListener(MouseEvent.CLICK, calclick, false, 0, true);
			addEventListener(MouseEvent.MOUSE_WHEEL, calwheel, false, 0, true);
		}
		
		private function caldown (e:MouseEvent):void
		{
			e.stopPropagation();
		}

		private function calmove(e:Event):void
		{
			e.stopPropagation();
			if (obOver != e.target.name)
			{ 
				obOver = e.target.name;
				if (obOver.substr(0, 3) == "day") { updatedays("day", "O"); } else { updatedays(obOver, "O"); }
			}
		}
		
		private function calrollover (ob, nob):void
		{
			obOver = ob.name;
			if (obOver.substr(0, 3) == "day") { updatedays("day", "O"); } else { updatedays(obOver, "O"); }
		}
		
		private function calclick(e:Event):void
		{
			e.stopPropagation();
			obClicked = obOver;
			if (obOver.substr(0, 3) == "day")
			{
				selYear = curYear;
				selMonth = curMonth;
				selDay = parseInt(obClicked.substr(3));
				var d = new Date(selYear, selMonth, selDay);
				updatedays("day", "C");
				_xtarget.text = selYear + "-" + zpad(selMonth+1) + "-" + zpad(selDay);
				this.visible = false;
			}
			else
			{
				updatedays(obOver, "C");
			}
		}
		
		private function calwheel(e:MouseEvent):void
		{
			e.stopPropagation();
			var v, dt;
			dt = e.delta;
			if (dt > 0) { v = 1; } else { v = -1; }
			cleardays(); curYear += v; setdays(); setyearmonth(curMonth, curYear); setweekdays();
		}
		
		public function updatedays(tt, ac):void
		{
			var i, d;
			getChildByName("yrdn").alpha = getChildByName("modn").alpha = getChildByName("moup").alpha = getChildByName("yrup").alpha = .6;
			for (i = 1; i <= daysNr; i++)
			{
				d = daysHolder.getChildByName("day" + i);
				d.background = false;
				d.backgroundColor = color1;
				d.textColor = color5;
			}
			switch(tt)
			{
				case "day":
					d = daysHolder.getChildByName(obOver);
					if (d != null) { d.background = true; d.backgroundColor = color4; }
					break;
				case "bg":
					break;
				case "yrdn":
					getChildByName("yrdn").alpha = 1;
					if (ac == "C") { cleardays(); curYear -= 1; setdays(); setyearmonth(curMonth, curYear); setweekdays(); }
					break;
				case "modn":
					getChildByName("modn").alpha = 1;
					if (ac == "C") { cleardays(); curMonth = Math.max(curMonth - 1, 0); setdays(); setyearmonth(curMonth, curYear); setweekdays(); }
					break;
				case "moup":
					getChildByName("moup").alpha = 1;
					if (ac == "C") { cleardays(); curMonth = Math.min(curMonth + 1, 11); setdays(); setyearmonth(curMonth, curYear); setweekdays(); }
					break;
				case "yrup":
					getChildByName("yrup").alpha = 1;
					if (ac == "C") { cleardays(); curYear += 1; setdays(); setyearmonth(curMonth, curYear); setweekdays(); }
					break;
				default:
					break;
			}
			if (selYear == curYear && selMonth == curMonth)
			{
				d = daysHolder.getChildByName("day" + selDay);
				if (d != null) { d.background = true; d.backgroundColor = color3;  d.textColor = color1; }
			}
			if (curYear == thisYear && curMonth == thisMonth)
			{
				d = daysHolder.getChildByName("day" + curDay);
				if (d != null) { d.background = true; d.textColor = color6; }
			}
		}
		
		private function drawcal():void
		{
			var bk = new calbk();
			var brd = new MovieClip();
			moDn.scaleX = moDn.scaleY = .3; moDn.rotation = 180;  moDn.y = 9; moDn.x = 20; moDn.alpha = .6; moDn.name = "modn";
			yrDn.scaleX = yrDn.scaleY = .3; yrDn.rotation = 180; yrDn.y = 9; yrDn.x = 8; yrDn.alpha = .6; yrDn.name = "yrdn"; 
			moUp.scaleX = moUp.scaleY = .3; moUp.y = 9; moUp.x = width - 17; moUp.alpha = .6; moUp.name = "moup";
			yrUp.scaleX = yrUp.scaleY = .3; yrUp.y = 9; yrUp.x = width - 5; yrUp.alpha = .6; yrUp.name = "yrup"; 
			addChildAt(moDn, 0);
			addChildAt(yrDn, 0);
			addChildAt(moUp, 0);
			addChildAt(yrUp, 0);
			addChildAt(bk, 0);
			addChild(brd);
		}
		
		private function setweekdays():void
		{
			var tf = new TextFormat();
			tf.align = TextFormatAlign.CENTER;
			tf.font = "Arial";
			tf.color = color1;
			tf.size = 10;
			for (var i = 0; i < 7; i++)
			{
				var wd:TextField = new TextField();
				with (wd)
				{
					mouseEnabled = false;
					text = dayNames[i];
					selectable = false;
					border = false;
					background = false;
					backgroundColor = color2;
					width = 19;
					height = 14;
					x = i * 19 + 2;
					y = 17;
					setTextFormat(tf);
				}
				addChild(wd);
			}
		}
		
		private function setyearmonth(mm, yy):void
		{
			with (calTitle)
			{
				mouseEnabled = false;
				text = monthNames[mm] + " " + (yy);
				selectable = false;
				border = false;
				background = false;
				backgroundColor = color2;
				width = 85;
				height = 17;
				x = (this.width - width) * .5 + 1;
				y = 1;
				var tf = new TextFormat();
				tf.align = TextFormatAlign.CENTER;
				tf.font = "Arial";
				tf.color = color5;
				tf.size = 10;
				setTextFormat(tf);
			}
		}
		
		private function setdays():void
		{
			daysHolder.name = "dholder"
			daysNr = (curYear%4 == 0 && curMonth == 1 ? 29 : maxDays[curMonth]);
			var rd = new Date(curYear, curMonth, 1);
			var dw = rd.getDay();
			var row:Number = 0;
			for (var i = 1; i < daysNr + 1; i++)
			{
				drawday(i, dw, row);
				dw++;
				if (dw >= 7) { dw = 0; row++; }
			}
			daysHolder.x = 0;
			daysHolder.y = 20;
			addChild(daysHolder);
		}
		
		private function drawday(i, s, r):void
		{
			var dc:TextField = new TextField();
			with (dc)
			{
				name = "day" + i;
				text = i.toString();
				width = 19;
				height = 14;
				selectable = false;
				border = false;
				borderColor = color4;
				background = false;
				backgroundColor = color1;
				if (i != curDay) { textColor = color5; } else { if (curYear == thisYear && curMonth == thisMonth) { textColor = color6; } }
				var tf = new TextFormat();
				tf.font = "Arial";
				tf.size = 9;
				tf.align = TextFormatAlign.RIGHT;
				setTextFormat(tf);
				x = s * 19 + 1;
				y = (r + 1) * 14;
			}
			daysHolder.addChild(dc);
		}
		
		private function cleardays():void
		{
			for (var i = 1; i < 32; i++)
			{
				try { daysHolder.removeChildAt(0); } catch (er) { break; }
			}
		}
		
		private function zpad(v):String
		{
			var z;
			z = "" +  v;
			if (z.length < 2) { z = "0" + v; }
			return z;
		}
		
		public function get xtarget():*
		{
			return _xtarget;
		}
		
		public function set xtarget(ob:*):void			//full height
		{
			_xtarget = ob;
		}
		
		public function go2date(d:String):void
		{
			var dd = [];
			if (d == "" || d == "---") 
			{ 
				var de = new Date()
				dd[0] = de.getFullYear();
				dd[1] = de.getMonth();
				dd[2] = de.getDate();
			}
			else
			{
				dd = d.split("-");
				dd[0] = parseInt(dd[0]);
				dd[1] = parseInt(dd[1])-1;
				dd[2] = parseInt(dd[2]);
			}
			curYear = dd[0];
			curMonth = dd[1];
			cleardays(); setdays(); setyearmonth(curMonth, curYear); setweekdays();
		}
		
	}
}

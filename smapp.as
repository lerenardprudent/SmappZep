package
{
	//import adobe.utils.CustomActions;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import flash.text.*;
	import flash.utils.*;
	import flash.ui.*;
	import flash.filters.*;
	//import fl.controls.*
	import flash.net.*
	//import flash.system.System;
	import com.greensock.TweenMax;
	import com.greensock.OverwriteManager;
	import com.greensock.easing.*;
	
	/*
	import com.google.maps.*
	import com.google.maps.overlays.*;
	import com.google.maps.controls.*;
	import com.google.maps.geom.*;
	import com.google.maps.services.*;
	import com.google.maps.styles.*;
	import com.google.maps.interfaces.*;
	*/
	 
	public class smapp extends Sprite
	{
		private var _main:MovieClip;
		private var _apphead:*;
		private var _appheadob:Object;
		private var _blocker:MovieClip
		private var _preloader:*;
		private var _clock:* = new clock();
		private var _calendar:* = new cal();
		
		private var _cntxMenu:ContextMenu = new ContextMenu();	//context menu
		private var _zoom:Number = 1;
		private var _dblclick:int = 0;
		private var _sheet:StyleSheet = new StyleSheet();
		
		private var _xloader:*;
		private var _loader:URLLoader;
		private var _txtloader:*;
		private var _txtfile:String = "";
		private var _picloader:Loader;
		private var _picholder:*;
		private var _picfx:Array = ["", 1, 0, 0, "", "normal"];		//fit, alpha, blurX, blurY, tint, blendMode
		
		private var _apploader:*;
		
		private var _actloader:*;
				
		private var _obover:* = null;
		
		/*
		private const _dbpath = "";
		private const _apppath = "";
		private var _dbpath = "http://treksoft.com/saut/";
		private var _apppath = "http://treksoft.com/zeps/";
		*/
		private var _dbpath = "http://localhost/SmappZep/";
		private var _apppath = _dbpath;
		
		private var _appid:String = "ZEPSOM";
		private var _docid:String = "APPLAY";
		
		
		private var _wins:Array = [];					//all holders
		private var _winprops:Array = [];
		private var _appcode:Array = [];				//equiv SAUT pgcode: all the objects in the app
		//private var _defobj:Array = [0, "INP", 1, 0, 0, "", 1, 0, 1, 0, 0, 0, 1, "", 80, 20, 0, 0, "Text here " + 0, "0xfafafa,0xcacad2,1,1,90", "0xcacad2,0xfafafa,1,1,90", "0xcacad2,0xfafafa,1,1,90", "0x5c5c6d,1", "0xff0000,1", "0xff0000,1", "0x727287", "", "", "", "", "", "", "0x727287", "0x727287", "0x727287", 0, "", 0, 0, 1, "", "media/defpic.png", "", "", 0, 100, 100, "", "", 0, 0, 7, 3, 19, "", "", "30,50,20", "0,1,0", "T,N,O", "", "", "", "", "", "", "", "", ""];
		private var _nrarr:Array = [0, 2, 3, 4, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 35, 37, 38, 39, 44, 45, 46, 49, 50, 51, 52, 53];		//props w/ numeric values
		private var _shiftx:int = 0;
		private var _shifty:int = -30;
		
		
		private var _objid:int = 0;
		private var _objtext:String = "";
		private var _tabndx:int = 0;
		private var _wholder:Sprite;
		private var _editon:Boolean = false;
		private var _scroller:* = null;
		private var _windrag:* = null;
		private var _objdone:int = 0;
		
		private var _logged:Boolean = false;
		private var _alertact:String = "";
		private var _keepblock:Boolean = false;		//do not keep blocker on hide blocker
		private var _lookuptg:Array = [];
		
		private var _timer:*;
		
		//application specific ---------
		
		private var _defuser = [0, "", "", "", "", "", "", "", "", "", "0000-00-00", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "0000-00-00", 0, 0, 0, "", "", "", "", "", "", "", "", "", "", 0, 0, 0, "", "", "", "", "", "", "", "", "", "", "", "0000-00-00", "0000-00-00", "", ""];
		private var _users:*;
		private var _assets:Array = []; 		//id, assname, type, status, etc.
		private var _varsarr:*;					//variables IDs and names
		private var _answsarr:*;				//object id, type, page, value, variable, x (if dragged), y (if dragged)
		private var _curuser:*;					//current admin (other than parti)
		private var _curphase:String = "T-03";	//current phase
		//private var _curparti:*;				//parti id from parti windows
		private var _queparti:*;				//parti id for questionnaire
		private var _curquest:String = "";		//id of the questionnaire
		private var _curqpg:int = 0;			//current quest page
		private var _acttarget = "";			//action target
		//private var _qnav = [31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46];
		private var _qnav = [51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66];
		private var _questlabel = [];
		
		private var _dbpage:Array = [0,0,0,0,0];					//db page: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbpagelen:Array = [16,16,16,5,8];				//db page length: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		//private var _dbrec:Array = [];							//records (item): 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbflt:Array = ["","","","",""];				//filters: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbsort:Array = ["id","id","id","id",""];		//sort column: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbsortdir:Array = ["","","","",""];			//sort direction: 0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dbrows:Array = [0, 0, 0, 4, 0];				//db total (filtered) rows:  0-participants, 1-agenda, 2-assets, 3-usr lookup, 4-address lookup
		private var _dblookuptg:Array = [];
		private var _dbxfile:Array = ["","","","",""];
		
		//------------------------------
		

		public function smapp():void
		{
			_cntxMenu.hideBuiltInItems();
			contextMenu = _cntxMenu;
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.stageFocusRect = false;

			stage.addEventListener(MouseEvent.MOUSE_DOWN, stagedown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, stagemove, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_UP, stageup, false, 0, true);
			stage.addEventListener(MouseEvent.CLICK, stageclick, false, 0, true);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, stagekeydown, false, 0, true);
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, stagewheel, false, 0, true);
			stage.addEventListener(Event.RESIZE, stageresize, false, 0, true);
			
			_main = new main();
			_main.x = _main.y = 0;
			_main.visible = false;
			this.addChild(_main);
			
			_blocker = new mainblocker();
			_blocker.visible = false;
			this.addChild(_blocker);
			
			_xloader = new Loader();
			_xloader.contentLoaderInfo.addEventListener(Event.COMPLETE, appheadok, false, 0, true);
			_xloader.load(new URLRequest('media/apphead.swf'));
			
			_picholder = _main;
			_picfx = ["", .5, 0, 0, "", "normal"];
			loadpic("media/appback.swf");
			
			_clock.visible = false;
			_clock.filters = [new DropShadowFilter(3, 45, 0x000000, .3, 3, 3, 1, 3)]
			this.addChild(_clock);
			_calendar.visible = false;
			_calendar.filters = [new DropShadowFilter(3, 45, 0x000000, .3, 3, 3, 1, 3)]
			this.addChild(_calendar);
		}
		
		include "inc_stage.as";
		include "inc_funcs.as";
		include "inc_wins.as";
		include "inc_net.as";
		include "inc_layout.as";
		include "inc_actions.as";
		include "inc_quest.as";
		
		private function appheadok(e:Event):void
		{
			_xloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, appheadok);
			//var linfo:LoaderInfo = e.target as LoaderInfo;
			//_appheadob = linfo.content;
			_apphead = e.target.content;
			_apphead.x = _apphead.y = 0;
			this.addChild(_apphead);
			this.setChildIndex(_apphead, 0);
			_xloader = null;
			
			_xloader = new Loader();
			_xloader.contentLoaderInfo.addEventListener(Event.COMPLETE, preloaderok, false, 0, true);
			_xloader.load(new URLRequest('media/preload.swf'));
		}
		
		private function preloaderok(e:Event):void
		{
			_xloader.contentLoaderInfo.removeEventListener(Event.COMPLETE, preloaderok);
			_preloader = e.target.content;
			_preloader.x = (stage.stageWidth - _preloader.width) * .5;
			_preloader.y = (stage.stageHeight - _preloader.height) * .5;
			this.addChild(_preloader);
			_preloader.play();
			_xloader = null;
			
			centerstage();
			_main.visible = true;
			_txtfile = 	"smapp.css";
			txtload();
		}
		
		private function initapp():void
		{
			var i, wa, wpa, wlay;
			
			include "inc_winprops.as"
			
			/*
			0 - alert text ok (p1)
			1 - alert text ok / can (p2)
			2 - alert input (p3)
			3 - picpopup (p10)
			4 - menu (p11)
			5 - statusbar (p12)
			6 - login (p6)
			7 - help / terms (p4)
			8 - launch quest (p8)
			9 - user list (p14)
			10 - user record (p15)
			11 - asset list (p16)
			12 - asset record (p17)
			13 - activity list (p18)
			14 - activity record (p19)
			15 - user filter (p20)
			16 - activity filter (p21)
			17 - assets filter (p22)
			18 - quest answers (p50)
			19 - actions users (p23)
			20 - actions assets (p24)
			21 - actions agenda (p25)
			22 - user lookup (p7)
			23 - adresses history (p9)
			24 - adresses visited (p26)
			25 - actions list / selected (p28)
			26 - user record restricted (pg27)
			27 - additional documents (pg29)
			28 - mailing address (p13)
			29 - quest window (pg51)
			*/
			
			wlay = [1, 2, 3, 10, 11, 12, 6, 4, 8, 14, 15, 16, 17, 18, 19, 20, 21, 22, 50, 23, 24, 25, 7, 9, 26, 28, 27, 29, 13, 51];
			for (i = 0; i < wlay.length; ++i)
			{
				if(_winprops[i][1] == "B"){makewin(i, _blocker);}else if(_winprops[i][1] == "M"){makewin(i, _main);}
			}
			for (i = 0; i < wlay.length; ++i) { makewinlayout(_wins[i], wlay[i]); _wins[i].visible = false; }			//load layout

			pozwin(_wins[0], true, true, 0, 0, false, 0);
			pozwin(_wins[1], true, true, 0, 0, false, 0);
			pozwin(_wins[2], true, true, 0, 0, false, 0);
			pozwin(_wins[3], true, true, 0, 0, false, 0);
			pozwin(_wins[4], false, false, 20, -10, false, 0);
			pozwin(_wins[5], false, false, 20, _main.back.height - 10, false, 0);
			pozwin(_wins[6], true, true, 0, 0, false, 0);
			pozwin(_wins[7], true, true, 0, 0, false, 0);
			pozwin(_wins[8], true, true, 0, 0, false, 0);
			pozwin(_wins[9], true, true, 0, 0, false, 0);
			pozwin(_wins[10], true, true, 0, 0, false, 0);
			pozwin(_wins[11], true, true, 0, 0, false, 0);
			pozwin(_wins[12], true, true, 0, 0, false, 0);
			pozwin(_wins[13], true, true, 0, 0, false, 0);
			pozwin(_wins[14], true, true, 0, 0, false, 0);
			pozwin(_wins[15], true, true, 0, 0, false, 0);
			pozwin(_wins[16], true, true, 0, 0, false, 0);
			pozwin(_wins[17], true, true, 0, 0, false, 0);
			pozwin(_wins[18], true, true, 0, 0, false, 0);
			pozwin(_wins[19], true, true, 0, 0, false, 0);
			pozwin(_wins[20], true, true, 0, 0, false, 0);
			pozwin(_wins[21], true, true, 0, 0, false, 0);
			pozwin(_wins[22], true, true, 0, 0, false, 0);
			pozwin(_wins[23], true, true, 0, 0, false, 0);
			pozwin(_wins[24], true, true, 0, 0, false, 0);
			pozwin(_wins[25], true, true, 0, 0, false, 0);
			pozwin(_wins[26], true, true, 0, 0, false, 0);
			pozwin(_wins[27], true, true, 0, 0, false, 0);
			pozwin(_wins[28], true, true, 0, 0, false, 0);
			pozwin(_wins[29], true, true, 0, 0, false, 0);
			
			for (i = 46; i <= 51; ++i) { getobj(_wins[4], "BTN", i).visible = false; }
			_wins[4].visible = _wins[5].visible = true;
			actionresize(stage.stageWidth, stage.stageHeight);
			_preloader.visible = false;
			_preloader.gotoAndStop(1);
			
			pozwin(_wins[6], true, true, 0, 0, false, 0);		//login first time
			showwin(_wins[6], true, 0, 0);
			showblocker(true);
		}

	}
}

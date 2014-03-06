package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Dmarg
	 */
	public class Main extends Sprite 
	{
		private var sma:smapp = new smapp();
		
		public function Main():void 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
			this.addChild(sma);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			sma.start();
		}
		
	}
	
}
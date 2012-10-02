package {
	
	import org.flixel.FlxBasic;
	
	public class NightScene extends SfsGroup {
		
		private var _night:Night;
		private var _backdrop:NightBackdrop;
		private var _sky:NightSky;
		
		private var _isNight:Boolean = false;
		private var index:int;
		
		public function NightScene() {
			night     = new Night();
			backdrop  = new NightBackdrop();
			sky       = new NightSky();
			
			
			this.add( _backdrop );
			this.add( _sky );
			this.add( _night );
			this.zOrder = 10000;
		}
		
		public function get alpha():Number {
			for ( index = 0; index < members.length; index++ ) {
				return members[index].alpha;
			}
			return 0;
		}
		
		public function reset():void {
			for ( index = 0; index < members.length; index++ ) {
				if ( members[index] is Night )
				members[index].revert();
			}			
		}
		
		public function stamp( light:FlxBasic, x:int, y:int ):void {
			for ( index = 0; index < members.length; index++ ) {
				if ( members[index] is Night ) {
					members[index].stampEffect = "erase";
					members[index].stamp( light, x, y );
				}
			}				
		}
		
		public function get isNight():Boolean 
		{
			return _isNight;
		}
		
		public function toggleNight():void {
			isNight = !isNight;
			for ( index = 0; index < members.length; index++ ) {
				if ( members[index] is Night )
				members[index].toggleNight();
			}			
			
		}		
		
		public function set isNight(value:Boolean):void 
		{
			_isNight = value;
		}		
		
		public function get backdrop():NightBackdrop 
		{
			return _backdrop;
		}
		
		public function set backdrop(value:NightBackdrop):void 
		{
			_backdrop = value;
		}
		
		public function get sky():NightSky 
		{
			return _sky;
		}
		
		public function set sky(value:NightSky):void 
		{
			_sky = value;
		}
		
		public function get night():Night 
		{
			return _night;
		}
		
		public function set night(value:Night):void 
		{
			_night = value;
		}
			
	}
}
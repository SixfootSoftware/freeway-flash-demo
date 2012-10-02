package {
	
	import org.flixel.FlxSprite;
	
	public class NightSky extends Night {
		
		[Embed(source = './data/nightSky.png')] private var nightSky:Class;
		public function NightSky() {
			this.zOrder = -50;
			this.x = 0;
			this.y = 0;
			this.loadGraphic( nightSky );
			this.blend = "screen";
			this.visible = false;
			this.alpha = 0;
		}	
		
		override public function revert():void {
			return;
		}	
		
		override public function stamp(Brush:FlxSprite, X:int = 0, Y:int = 0):void {
			return;
		}
			
	}
}
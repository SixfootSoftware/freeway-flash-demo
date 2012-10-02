package {
	import org.flixel.FlxParticle;
	
	public class Smoke extends FlxParticle {
		
		[Embed(source = './data/smoke.png')] private var renderedSmoke:Class;	
		
		public function Smoke() {
			super();
			this.loadGraphic( renderedSmoke, true, false, 9, 9 );
			this.addAnimation( "smoke", [0, 1, 2], 18, false );
			this.play( "smoke" );
			exists = false;
			
		}
		
		override public function onEmit():void {
			
			super.onEmit();
			this.play( "smoke" );
			
		}
		
	}
}
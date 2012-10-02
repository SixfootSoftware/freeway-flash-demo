package {
	
	public class NightBackdrop extends Night {
		
		private const COLOR:Number = 0xdd090939;
		
		public function NightBackdrop() {
			this.zOrder = 340;
			this.x = 0;
			this.y = 0;
			this.makeGraphic( 640, 192, COLOR, true );
			this.blend = "multiply";
			this.visible = false;
			this.alpha = 0;
		}
		
		override public function revert():void {
			fill( COLOR );
		}		
			
	}
}
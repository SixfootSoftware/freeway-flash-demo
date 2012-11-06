package {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;	
	import org.flixel.FlxBasic;
	import org.flixel.FlxSprite;
	import com.sixfootsoftware.IZOrderable;
	
	public class SfsSprite extends FlxSprite implements IZOrderable {
		private var _zOrder:int = 0;
		private var _stampEffect:String = "";
		
		function SfsSprite( X:Number=0, Y:Number=0, SimpleGraphic:Class=null ) {
			super( X, Y, SimpleGraphic );
		}
		
		public function get zOrder():int 
		{
			return _zOrder;
		}
		
		public function set zOrder(value:int):void 
		{
			_zOrder = value;
		}
		
		public function get stampEffect():String 
		{
			return _stampEffect;
		}
		
		public function set stampEffect(value:String):void 
		{
			_stampEffect = value;
		}
		
		public function get bakedRotation():Number {
			return this._bakedRotation;
		}
		
		private function resetEffect( Brush:FlxSprite ): void {
			if ( stampEffect == "" ) {
				stampEffect = Brush.blend;
			}
		}
		
		private function isSimpleImage( Brush:FlxSprite ):Boolean {
			return ((Brush.angle == 0) 
			    || ((Brush as SfsSprite).bakedRotation > 0)) 
				&& (Brush.scale.x == 1) 
				&& (Brush.scale.y == 1) 
				&& (Brush.blend == null);
		}
		
		private function stampSimpleImage( Brush:FlxSprite, X:int = 0, Y:int = 0 ):void {
			_flashPoint.x = X;
			_flashPoint.y = Y;
			_flashRect2.width = Brush.framePixels.width;
			_flashRect2.height = Brush.framePixels.height;
			_pixels.copyPixels( Brush.framePixels.bitmapData,_flashRect2,_flashPoint,null,null,true);
			_flashRect2.width = _pixels.width;
			_flashRect2.height = _pixels.height;
			calcFrame();
		}		
		
		private function stampAdvancedImage( Brush:FlxSprite, X:int = 0, Y:int = 0 ):void {
			this.resetEffect( Brush );
			_matrix.identity();
			_matrix.translate(-Brush.origin.x,-Brush.origin.y);
			_matrix.scale(Brush.scale.x,Brush.scale.y);
			if(Brush.angle != 0)
				_matrix.rotate(Brush.angle * 0.017453293);
			_matrix.translate(X+Brush.origin.x,Y+Brush.origin.y);
			_pixels.draw(Brush.framePixels,_matrix,null,stampEffect,null,Brush.antialiasing);
			calcFrame();
			stampEffect = "";
		}
		
		override public function stamp(Brush:FlxSprite,X:int=0,Y:int=0 ):void {
			Brush.drawFrame();
			var bitmap:Bitmap = Brush.framePixels;

			if ( this.isSimpleImage( Brush ) ) {
				return this.stampSimpleImage( Brush, X, Y );
			}
			
			return this.stampAdvancedImage( Brush, X, Y );
		}		

	}

}
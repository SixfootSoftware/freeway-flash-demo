package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import mx.core.BitmapAsset;
	import mx.core.FlexSprite;
	import org.flixel.*;
	import com.sixfootsoftware.*;
	
	/**
	 * ...
	 * @author David Long
	 */
	
	public class FreewayTileSet {
		
		private var tileHeight:uint;
		private var tileWidth:uint;
		private var _tileList:Array;
		
		public function FreewayTileSet( Graphic:Bitmap, tileHeight:uint, tileWidth:uint, numberOfTilesWide:uint = 1, numberOfTilesHigh:uint = 1 ) {
			this.tileHeight = tileHeight;
			this.tileWidth  = tileWidth;
			this._tileList    = new Array( numberOfTilesWide * numberOfTilesHigh );
			
			var tileIndex:int = 0;
			
			for ( var y:int = 0; y < numberOfTilesHigh; y++ ) {
				for ( var x:int = 0; x < numberOfTilesWide; x++ ) {					
					this._tileList[ tileIndex ] = this.generateTile( Graphic, x * this.tileWidth, y * this.tileHeight );
					tileIndex++;
				}				
			}
		}
		
		public function length():uint {
			var length:uint = this._tileList.length;
			return length;
		}
		
		private function generateTile( Graphic:Bitmap, startX:int, startY:int ):Tile {
			var tileData:BitmapData         = Graphic.bitmapData;
			var newTileGraphic:BitmapData   = new BitmapData( this.tileWidth << 1, this.tileHeight, true, 0x00000000 );
			var copyMatrix:Matrix           = new Matrix();
			var clippingRectangle:Rectangle = new Rectangle( 0, 0, this.tileWidth, this.tileHeight );
			//copyMatrix.scale( 1, 1 );
		    copyMatrix.translate( -startX, -startY );
		    newTileGraphic.draw( tileData, copyMatrix, null, null, clippingRectangle );
			return new Tile( newTileGraphic );
		}
		
		public function get tileList():Array {
			return _tileList;
		}

	}

}
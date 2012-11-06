package {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import mx.core.BitmapAsset;	
		
	public class Level1 extends Level {
		
		[Embed(source = './data/mapCSV_Group1_Map5.csv', mimeType = "application/octet-stream")] private var mapLayer5Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map4.csv', mimeType = "application/octet-stream")] private var mapLayer4Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map3.csv', mimeType = "application/octet-stream")] private var mapLayer3Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map1.csv', mimeType = "application/octet-stream")] private var mapLayer1Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map6.csv', mimeType = "application/octet-stream")] private var mapLayer6Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map2.csv', mimeType = "application/octet-stream")] private var mapLayer2Data:Class;
		
		private var i:uint, j:uint = 0;
				
		private function initialiseLayeredTileMap():void {
			for ( i = 0; i < LAYERED_TILE_MAP_WIDTH; i++ ) {
				this.layeredTileMapList[i] = new LayeredTileMap();
				this.layeredTileMapList[i].id = i;
			}
		}		
		
		public function Level1():void {
			
			this.initialiseTilePalette();
			
			this.layeredTileMapList = new Object();
			this.tileMapList        = new Object();
			for ( i = 0; i < LAYERED_TILE_MAP_HEIGHT; i++ ) {
				this.tileMapList[i] = new Object();
			}
			
			var mapLayer:Array = new Array( LAYERED_TILE_MAP_HEIGHT );
			var mapSpeed:Array = new Array( LAYERED_TILE_MAP_HEIGHT );
			
			mapLayer[0] = loadMapFile( mapLayer5Data );
			mapSpeed[0] = 0.5;
			mapLayer[1] = loadMapFile( mapLayer4Data );
			mapSpeed[1] = 0.75;
			mapLayer[2] = loadMapFile( mapLayer3Data );
			mapSpeed[2] = 1;
			mapLayer[3] = loadMapFile( mapLayer1Data );
			mapSpeed[3] = 1;			
			mapLayer[4] = loadMapFile( mapLayer6Data );
			mapSpeed[4] = 1;
			mapLayer[5] = loadMapFile( mapLayer2Data );
			mapSpeed[5] = 1;
						
			for ( i = 0; i < LAYERED_TILE_MAP_WIDTH; i++ ) {
				this.layeredTileMapList[i] = new LayeredTileMap();
				this.layeredTileMapList[i].id = i;
			}
			
			for ( j = 0; j < LAYERED_TILE_MAP_HEIGHT; j++ ) {
				for ( i = 0; i < LAYERED_TILE_MAP_WIDTH; i++ ) {
					this.tileMapList[i] = new TileMap( mapLayer[j], this.tileSet, i );
					this.tileMapList[i].velocity    = 500;
					this.tileMapList[i].setScrollRate( mapSpeed[j] );
					this.tileMapList[i].zOrder = (j * 100) + i;
					this.layeredTileMapList[i].add( this.tileMapList[i] );		
				}		
				
				for ( i = 0; i < LAYERED_TILE_MAP_WIDTH; i++ ) {
					if ( i != 23 ) {
						this.layeredTileMapList[i].layer( j ).next = this.layeredTileMapList[i + 1].layer( j );
					} 
					if ( i != 0 ) {
						this.layeredTileMapList[i].layer( j ).prev = this.layeredTileMapList[i - 1].layer( j );
					}
				}
				this.layeredTileMapList[0].layer( j ).prev = this.layeredTileMapList[23].layer( j );
				this.layeredTileMapList[23].layer( j ).next = this.layeredTileMapList[0].layer( j );
				this.layeredTileMapList[23].layer( j ).isNext = true;
			
			}		
		}	
	}
}
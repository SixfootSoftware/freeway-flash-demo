package {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import mx.core.BitmapAsset;
	import org.flixel.*;
	import actor.*;

	public class PlayState extends FlxState
	{	
		[Embed(source = './data/freeway.png')] private var renderedTileSet:Class;			
		[Embed(source = './data/mapCSV_Group1_Map5.csv', mimeType = "application/octet-stream")] private var mapLayer5Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map4.csv', mimeType = "application/octet-stream")] private var mapLayer4Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map3.csv', mimeType = "application/octet-stream")] private var mapLayer3Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map1.csv', mimeType = "application/octet-stream")] private var mapLayer1Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map6.csv', mimeType = "application/octet-stream")] private var mapLayer6Data:Class;
		[Embed(source = './data/mapCSV_Group1_Map2.csv', mimeType = "application/octet-stream")] private var mapLayer2Data:Class;

	
		private var tileSet:FreewayTileSet;
		private var tileMapList:Object;
		private var layeredTileMapList:Object;
		
		override public function create():void {
			
			Registry.register();
			
			this.layeredTileMapList = new Object();
			this.tileMapList        = new Object();
			for ( i = 0; i < 6; i++ ) {
				this.tileMapList[i] = new Object();
			}
			
			var tmpBitmapAsset:BitmapAsset = this.getBitmapData( renderedTileSet );
			this.tileSet = new FreewayTileSet( tmpBitmapAsset, TileMap.TILE_SIZE_WIDTH, TileMap.TILE_SIZE_WIDTH, Math.floor( tmpBitmapAsset.width >> TileMap.TILE_SHIFT_WIDTH ), Math.floor( tmpBitmapAsset.height >> TileMap.TILE_SHIFT_HEIGHT ) );
			FlxG.bgColor = 0xff9fd3f8;
			
			var mapLayer:Array = new Array( 5 );
			var mapSpeed:Array = new Array( 5 );
			
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
						
			var i:int, j:int;
			
			for ( i = 0; i < 24; i++ ) {
				this.layeredTileMapList[i] = new LayeredTileMap();
				this.layeredTileMapList[i].id = i;
			}
			
			for ( j = 0; j < 6; j++ ) {
				
				for ( i = 0; i < 24; i++ ) {
					this.tileMapList[i] = new TileMap( mapLayer[j], this.tileSet, i );
					this.tileMapList[i].velocity    = 500;
					this.tileMapList[i].setScrollRate( mapSpeed[j] );
					this.tileMapList[i].zOrder = (j * 100) + i;
					this.layeredTileMapList[i].add( this.tileMapList[i] );		
				}		
				
				for ( i = 0; i < 24; i++ ) {
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
						
			this.add( Registry.road );			
			this.add( Registry.player );	
			
			for ( j = 0; j < Registry.nightScene.members.length; j ++ ) {
					this.add( Registry.nightScene.members[j] );
			}			
			
			for ( i = 0; i < 24; i++ ) {
				for ( j= 0; j < layeredTileMapList[i].members.length; j ++ ) {
					this.add( layeredTileMapList[i].members[j] );
				}
			}			

		}
		
		override public function update():void {		
						
			if (FlxG.keys.justPressed( "L" ) ) {
				Registry.nightScene.toggleNight();		
			}
			
			if ( Registry.nightScene.isNight || Registry.nightScene.alpha > 0 ) {
				Registry.nightScene.reset();
				Registry.player.stampNight( Registry.nightScene );
				Registry.nightScene.stamp( Registry.nightScene.sky, 0, 0 );
			}
	
			super.update();
		}
				
		private function loadMapFile( mapData:Class ):String
		{			
			var b:ByteArray = new mapData();
			var s:String    = b.readUTFBytes( b.length );
			
			return s;
		}	
		
		private function getBitmapData( tempTileSet:Class ):BitmapAsset
		{
			var bitmapAsset:BitmapAsset = new tempTileSet();
			return bitmapAsset;
		}
		
		override public function draw(): void {
			var basic:FlxBasic;
			var map:LayeredTileMap;
			var i:uint = 0;
			var j:uint = 0;		
			
			members.sortOn( "zOrder", Array.NUMERIC );
		
			i = 0;
			
			while (i < length ) {
					basic = members[i] as FlxBasic;
					if((basic != null) && basic.exists && basic.visible)
						basic.draw();					
				i++;
			}
			
		}
		
		
	}
}


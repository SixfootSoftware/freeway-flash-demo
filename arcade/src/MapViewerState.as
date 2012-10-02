package
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import flash.net.*;
	import org.flixel.*;
	import actor.*;

	public class MapViewerState extends FlxState
	{	
		private var textLoader:URLLoader;
		private var imageLoader:Loader;
		private var renderedTileSet:Bitmap;	
		private var mapLayer1Data:String;
		private var mapLayer2Data:String;
		private var tileSet:FreewayTileSet;
		private var tileMap:TileMap;
		private var tileMap2:TileMap;
		private var layeredTileMapList:Object;		
		
		override public function create():void {
			
			textLoader  = new URLLoader();			
			imageLoader = new Loader();
			
			imageLoader.load( new URLRequest( "freeway.png" ) );		
			imageLoader.contentLoaderInfo.addEventListener( Event.COMPLETE, this.loadTileSet );
			
			this.layeredTileMapList = new Object();
						
			FlxG.bgColor = 0xff9fd3f8;
			}
		
		override public function update():void {
			super.update();
		}
		
		public function loadTileSet( event:Event ):void {
			
			renderedTileSet = Bitmap( imageLoader.content );
			trace( renderedTileSet );
			this.tileSet = new FreewayTileSet( renderedTileSet, 32, 32, Math.floor( renderedTileSet.width / 32), Math.floor(renderedTileSet.height / 32 ) );
			trace( "start loader" );
			textLoader.dataFormat = URLLoaderDataFormat.TEXT;
			textLoader.removeEventListener( Event.COMPLETE, this.loadMapLayer1 );
			textLoader.addEventListener( Event.COMPLETE, this.loadMapLayer1 );
			textLoader.load( new URLRequest( "freeway.layer1.map" ) );				
		}
		
		public function loadMapLayer1( event:Event ):void {
			trace( "start loader map1" );
			mapLayer1Data = textLoader.data;
			this.tileMap = new TileMap( mapLayer1Data, this.tileSet );
			this.layeredTileMapList[0] = new LayeredTileMap();	
			this.layeredTileMapList[0].add( this.tileMap ); 
			textLoader.removeEventListener( Event.COMPLETE, this.loadMapLayer1 );
			textLoader.addEventListener( Event.COMPLETE, this.loadMapLayer2 );
			textLoader.load( new URLRequest( "freeway.layer2.map" ) );				
		}
		
		public function loadMapLayer2( event:Event ):void {
			trace( "start loader map2" );
			mapLayer2Data = textLoader.data;
			this.tileMap2 = new TileMap( mapLayer2Data, this.tileSet );
			this.layeredTileMapList[0].add( this.tileMap2 ); //Make Layered Map!
			textLoader.removeEventListener( Event.COMPLETE, this.loadMapLayer2 );
			this.tileMap.velocity = 200;
			this.tileMap2.velocity = 200;
			
			this.layeredTileMapList[1] = this.layeredTileMapList[0].clone();
			this.layeredTileMapList[1].alignWith( this.layeredTileMapList[0] );
			
			this.layeredTileMapList[0].next = this.layeredTileMapList[1];
			this.layeredTileMapList[1].next = this.layeredTileMapList[0];
			
			this.add( layeredTileMapList[0] );
			this.add( layeredTileMapList[1] );			
		}		
		
		private function loadMapFile( mapData:Class ):String
		{			
			var b:ByteArray = new mapData();
			var s:String    = b.readUTFBytes( b.length );
			
			return s;
		}	
		
		
	}
}


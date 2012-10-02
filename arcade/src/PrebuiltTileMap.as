package {
	import com.sixfootsoftware.*;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	
	public class PrebuiltTileMap extends TileMap implements ITileMap, ICloneable {
		
		public function PrebuiltTileMap( data:Object, mapWidth:int, mapHeight:int ) {
			
			for each( var tile:Tile in data ) {
				if ( !this.screenPositionTile ) {
					this.screenPositionTile = tile;
				}
				this.add( tile );
			}
			
			this.tileMapWidth = mapWidth;
			this.tileMapHeight = mapHeight;

			this.mapDimensions = new FlxPoint( (this.tileMapWidth) << TILE_SHIFT_WIDTH, this.tileMapHeight << TILE_SHIFT_WIDTH );
			col.width = this.tileMapWidth;
		
		}
		
	}
}


package {
	
	import org.flixel.FlxGroup;
	import com.sixfootsoftware.IZOrderable;
	
	public class SfsGroup extends FlxGroup implements IZOrderable {
		
		private var _zOrder:int = 0;
		
		public function get zOrder():int 
		{
			return _zOrder;
		}
		
		public function set zOrder(value:int):void 
		{
			_zOrder = value;
		}

	}

}
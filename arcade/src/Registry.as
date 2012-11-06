package {
	
	import org.flixel.FlxSprite;

	public class Registry {
		
		private static var _defaultCar:Car;	
		private static var _policeCar:Car;	
		
		private static var _road:Road;
		private static var _player:Player;
		private static var _nightScene:NightScene;
		
		static public function register():void {
			
			defaultCar = new SaloonCar();			
			policeCar  = new PoliceCar();			
			road       = new Road();
			player     = new Player( defaultCar );		
			nightScene = new NightScene();
		}
		
		static public function get road():Road 
		{
			return _road;
		}
		
		static public function set road(value:Road):void 
		{
			_road = value;
		}
		
		static public function get player():Player 
		{
			return _player;
		}
		
		static public function set player(value:Player):void 
		{
			_player = value;
		}
		
		static public function get nightScene():NightScene 
		{
			return _nightScene;
		}
		
		static public function set nightScene(value:NightScene):void 
		{
			_nightScene = value;
		}
		
		static public function get policeCar():Car 
		{
			return _policeCar;
		}
		
		static public function set policeCar(value:Car):void 
		{
			_policeCar = value;
		}
		
		static public function get defaultCar():Car 
		{
			return _defaultCar;
		}
		
		static public function set defaultCar(value:Car):void 
		{
			_defaultCar = value;
		}
		
		
		
	}
}
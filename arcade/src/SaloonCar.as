package {
	import org.flixel.FlxEmitter;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class SaloonCar extends Car {
		
		
		[Embed(source = './data/saloon_car.png')] private var saloonCar:Class;
		[Embed(source = './data/saloon_car_lights.png')] private var saloonCarLights:Class;
		
		public function SaloonCar() {
				
			super( saloonCar, saloonCarLights, 97 );		

		}
				
	}
}
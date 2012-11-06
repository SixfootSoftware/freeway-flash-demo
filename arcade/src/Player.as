package {
	
	import org.flixel.FlxG;
	
	public class Player extends Actor {
		
		public function Player( customCar:Car ) {
			super( customCar );			
		}
		
		override public function update():void {
			
			if (FlxG.keys.pressed("LEFT") ) {
				this.car.carSprite.velocity.x = -100;
			} else {
				if (FlxG.keys.pressed("RIGHT")) {
					this.car.carSprite.velocity.x = 100;
				} else {
					this.car.carSprite.velocity.x = 0;
				}
			}
			
			if (FlxG.keys.justPressed( "ONE" ) ) {
				this.changeCar( Registry.defaultCar );
			}			
			
			if (FlxG.keys.justPressed( "TWO" ) ) {
				this.changeCar( Registry.policeCar );
			}
			
			if (FlxG.keys.justPressed( "K" ) ) {
				Registry.nightScene.backdrop.zOrder +=20;
				trace( Registry.nightScene.backdrop.zOrder );
			}
			
			if (FlxG.keys.justPressed( "J" ) ) {
				Registry.nightScene.backdrop.zOrder -=20;
				trace( Registry.nightScene.backdrop.zOrder );
			}			

			if (FlxG.keys.pressed("UP") && this.car.carSprite.y > 175 ) {
				this.car.carSprite.velocity.y = -100;
			} else {
				if (FlxG.keys.pressed("DOWN") && this.car.carSprite.y < 387 ) {
					this.car.carSprite.velocity.y = 100;
				} else {
					this.car.carSprite.velocity.y = 0;
				}
			}
			
			super.update()
			
		}			
		
	}
}
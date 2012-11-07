package {
	
	import org.flixel.FlxG;
	
	public class Player extends Actor {
		
		public function Player( customCar:Car ) {
			super( customCar );			
			customCar.setPosition( 400, 300 );
		}
		
		override public function preUpdate():void {
			this.zOrder = this.calculateZOrder();
		}
		
		override public function update():void {
			
			if (FlxG.keys.pressed("LEFT") ) {
				this.car.setVelocityX( -ACTOR_MOVEMENT_DEFAULT_VELOCITY );
				
			} else if (FlxG.keys.pressed("RIGHT")) {
				this.car.setVelocityX( ACTOR_MOVEMENT_DEFAULT_VELOCITY );
			} else {
				this.car.setVelocityX( ACTOR_MOVEMENT_STOPPED );
			}
			
			if (FlxG.keys.justPressed( "ONE" ) ) {
				Registry.enemy.changeLane( Enemy.ENEMY_ROAD_LANE_1 );
			}			
			
			if (FlxG.keys.justPressed( "TWO" ) ) {
				Registry.enemy.changeLane( Enemy.ENEMY_ROAD_LANE_2 );
			}			
			if (FlxG.keys.justPressed( "THREE" ) ) {
				Registry.enemy.changeLane( Enemy.ENEMY_ROAD_LANE_3 );
			}			
			if (FlxG.keys.justPressed( "FOUR" ) ) {
				Registry.enemy.changeLane( Enemy.ENEMY_ROAD_LANE_4 );
			}
			
			if (FlxG.keys.justPressed( "K" ) ) {
				Registry.nightScene.backdrop.zOrder +=20;
				trace( Registry.nightScene.backdrop.zOrder );
			}
			
			if (FlxG.keys.justPressed( "J" ) ) {
				Registry.nightScene.backdrop.zOrder -=20;
				trace( Registry.nightScene.backdrop.zOrder );
			}			

			if (FlxG.keys.pressed("UP") && this.car.carSprite.y > ACTOR_ROAD_BOUNDS_TOP ) {
				this.car.setVelocityY( -ACTOR_MOVEMENT_DEFAULT_VELOCITY );
			} else if (FlxG.keys.pressed("DOWN") && this.car.carSprite.y < ACTOR_ROAD_BOUNDS_BOTTOM ) {
				this.car.setVelocityY( ACTOR_MOVEMENT_DEFAULT_VELOCITY );
			} else {
				this.car.setVelocityY( ACTOR_MOVEMENT_STOPPED );
			}
			
			super.update()
			
		}			
		
	}
}
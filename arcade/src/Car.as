package {
	import org.flixel.FlxEmitter;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	public class Car extends SfsGroup {
		
		private var car:FlxSprite;
		private var lights:FlxSprite;
		private var emitter:FlxEmitter;
		private var _point:FlxPoint;
		private var lightsStarted:Boolean;
		private var counter:Number;
		private var flicker:Number;
		
		[Embed(source = './data/cop_car.png')] private var carAnim:Class;
		[Embed(source = './data/cop_car_lights.png')] private var carLights:Class;
		
		public function Car( carGraphic:Class = null, carLightsGraphic:Class = null, width:int=111, height:int=60 ) {
				
			this.car    = new FlxSprite( 400, 300 );
			this.lights = new FlxSprite( 400, 300 );
			this._point = new FlxPoint( 0, 0 );
			
			carAnim   = carGraphic       != null ? carGraphic : carAnim;
			carLights = carLightsGraphic != null ? carLightsGraphic : carLights;
			
			this.car.loadGraphic( carAnim, true, false, width, height );
			this.lights.loadGraphic( carLights, false, false, 0, 0, true );
			this.lights.visible = false;
			this.lights.blend = "screen";
			this.car.addAnimation( "Running", [0, 1, 2, 3], 20, true );
			this.car.play( "Running" );	
			
			var smoke:Smoke = new Smoke();
			emitter = new FlxEmitter(100, 100, 1);
			emitter.maxRotation = 0;
			emitter.minRotation = 0;
			emitter.maxParticleSpeed.x = 50;
			emitter.maxParticleSpeed.y = 0;
			emitter.minParticleSpeed.x = 50;
			emitter.minParticleSpeed.y = 0;			
			
			emitter.add( smoke );
			
			emitter.at( this.car );
			emitter.start( false, 0.166, 0.25, 0 );	
			
			this.add( car );
			this.add( emitter );
			this.add( lights );
			
			_point = this.car.getMidpoint();
			this.lights.x = _point.x - ( car.width>>1 ) - 150;
			this.lights.y = _point.y - ( car.height>>1 );			

		}
		
		override public function update():void {
			
			counter += FlxG.elapsed;
			flicker += FlxG.elapsed;
			
			if (FlxG.keys.pressed("LEFT") ) {
				this.car.velocity.x = -100;
			} else {
				if (FlxG.keys.pressed("RIGHT")) {
					this.car.velocity.x = 100;
				} else {
					this.car.velocity.x = 0;
				}
			}
			
			if (FlxG.keys.justPressed( "ONE" ) ) {
				Registry.nightScene.night.visible = ! Registry.nightScene.night.visible;
			}			
			
			if (FlxG.keys.justPressed( "TWO" ) ) {
				Registry.nightScene.sky.visible = ! Registry.nightScene.sky.visible;
			}
			
			if (FlxG.keys.justPressed( "THREE" ) ) {
				Registry.nightScene.backdrop.visible = ! Registry.nightScene.backdrop.visible;
			}			
			
			if (FlxG.keys.justPressed( "K" ) ) {
				Registry.nightScene.backdrop.zOrder +=20;
				trace( Registry.nightScene.backdrop.zOrder );
			}
			
			if (FlxG.keys.justPressed( "J" ) ) {
				Registry.nightScene.backdrop.zOrder -=20;
				trace( Registry.nightScene.backdrop.zOrder );
			}			

			if (FlxG.keys.pressed("UP") && this.car.y > 175 ) {
				this.car.velocity.y = -100;
			} else {
				if (FlxG.keys.pressed("DOWN") && this.car.y < 387 ) {
					this.car.velocity.y = 100;
				} else {
					this.car.velocity.y = 0;
				}
			}
			
			emitter.x = this.car.x + this.car.width + 5;	
			emitter.y = this.car.y + this.car.height - 16;
			emitter.setXSpeed( this.car.velocity.x + 50, this.car.velocity.x + 50 );	
			
			super.update();
			
			//needs optimizing
			if ( !( lightsStarted ) && Registry.nightScene.isNight && Registry.nightScene.alpha > 0.5 ) {
				lightsStarted = true;
				counter = 0;
				flicker = 0;
			} else { 
				if ( lightsStarted && ! ( Registry.nightScene.isNight ) && Registry.nightScene.alpha < 0.4 ) {
					lightsStarted = false;
					counter = 0;
					flicker = 0;
				}
			}
			
			if ( counter < 0.4 ) {
				if ( counter <= 0.3 && flicker > 0.1 ) {
					flicker = 0;
					lights.visible = !lights.visible;
				}
				
				if ( counter > 0.3 ) {
					if ( lightsStarted ) {
						lights.visible = true;
					} else {
						lights.visible = false;
					}
				}
			}
			_point = this.car.getMidpoint();
			this.lights.x = _point.x - ( car.width>>1 ) - 142;
			this.lights.y = _point.y - ( car.height>>1 ) + 5;				
			
			
		}
		
		public function stampNight( night:NightScene ):void {
			if ( lights.visible ) 
				night.stamp( lights, lights.x, lights.y );
		}
		
	}
}
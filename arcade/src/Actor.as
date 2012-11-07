package {
	
	public class Actor extends SfsGroup {
		
		protected static const ACTOR_MOVEMENT_DEFAULT_VELOCITY:int = 100;
		protected static const ACTOR_MOVEMENT_STOPPED:int          = 0;
		
		protected static const ACTOR_ROAD_BOUNDS_TOP:int = 175;
		protected static const ACTOR_ROAD_BOUNDS_BOTTOM:int = 387;		
		protected static const ACTOR_ROAD_BOUNDS_MIDDLE:int = ACTOR_ROAD_BOUNDS_TOP + ( ( ACTOR_ROAD_BOUNDS_BOTTOM - ACTOR_ROAD_BOUNDS_TOP ) / 2 ) - 10;			
		
		private var _car:Car;
				
		public function Actor( customCar:Car = null ) {
			
			if ( customCar is Car ) {
				this.car = customCar;
			} else {
				this.car = new PoliceCar();
			}
			
			this.zOrder = this.calculateZOrder();
			this.add( car );
		}
		
		protected function calculateZOrder():int {
			return Math.round( 450 + ( ( this.car.carSprite.y - Actor.ACTOR_ROAD_BOUNDS_MIDDLE ) >> 5 ) );
		}
		
		public function changeCar( customCar:Car ):Actor {
			customCar.setPosition( this.car.carSprite.x, this.car.carSprite.y );
			this.remove( this.car );
			this.car = customCar;
			this.add( this.car );
			return this;
		}
		
		public function stampNight( night:NightScene ):void {
			car.stampNight( night );
		}
		
		public function get car():Car 
		{
			return _car;
		}
		
		public function set car(value:Car):void 
		{
			_car = value;
		}
		
	}
}
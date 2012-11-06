package {
	
	public class Actor extends SfsGroup {
		
		private var _car:Car;
				
		public function Actor( customCar:Car = null ) {
			
			this.zOrder = 450;
			
			if ( customCar is Car ) {
				this.car = customCar;
			} else {
				this.car = new PoliceCar();
			}
			
			this.add( car );

		}
		
		public function changeCar( customCar:Car ):Actor {
			customCar.carSprite.x = this.car.carSprite.x;
			customCar.carSprite.y = this.car.carSprite.y;
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
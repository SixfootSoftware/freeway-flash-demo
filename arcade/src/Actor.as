package {
	
	public class Actor extends SfsGroup {
		
		private var car:Car;
				
		public function Actor( customCar:Car = null ) {
			
			this.zOrder = 450;
			
			if ( customCar is Car ) {
				this.car = customCar;
			} else {
				this.car = new Car();
			}
			
			this.add( car );

		}
		
		public function changeCar( customCar:Car ):Actor {
			this.remove( this.car );
			this.car = customCar;
			this.add( this.car );
			return this;
		}
		
		public function stampNight( night:NightScene ):void {
			car.stampNight( night );
		}
		
	}
}
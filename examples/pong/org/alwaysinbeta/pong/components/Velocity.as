package org.alwaysinbeta.pong.components {
	import com.artemis.Component;

	public class Velocity extends Component {
		private var _velocityX : int;
		private var _velocityY : Number;

		public function Velocity(velocityX : int = 0, velocityY : Number = 0) {
			_velocityX = velocityX;
			_velocityY = velocityY;
		}

		public function get velocityX() : int {
			return _velocityX;
		}

		public function set velocityX(velocityX : int) : void {
			_velocityX = velocityX;
		}

		public function get velocityY() : Number {
			return _velocityY;
		}

		public function set velocityY(velocityY : Number) : void {
			_velocityY = velocityY;
		}

	}
}
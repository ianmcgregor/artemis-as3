package com.gamadu.starwarrior.components {
	import com.artemis.utils.Utils;
	import com.artemis.Component;

	public class Velocity extends Component {
		private var _velocity : Number;
		private var _angle : Number;

		public function Velocity(velocity : Number = 0, angle : Number = 0) {
			_velocity = velocity;
			_angle = angle;
		}

		public function getVelocity() : Number {
			return _velocity;
		}

		public function setVelocity(velocity : Number) : void {
			_velocity = velocity;
		}

		public function setAngle(angle : Number) : void {
			_angle = angle;
		}

		public function getAngle() : Number {
			return _angle;
		}

		public function addAngle(a : Number) : void {
			_angle = (_angle + a) % 360;
		}

		public function getAngleAsRadians() : Number {
			return Utils.toRadians(_angle);
		}
	}
}
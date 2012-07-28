package com.gamadu.starwarrior.components {
	import com.artemis.utils.Utils;
	import com.artemis.Component;

	public class Velocity extends Component {
		private var velocity : Number;
		private var angle : Number;

		public function Velocity(velocity : Number = 0, angle : Number = 0) {
			this.velocity = velocity;
			this.angle = angle;
		}

		public function getVelocity() : Number {
			return velocity;
		}

		public function setVelocity(velocity : Number) : void {
			this.velocity = velocity;
		}

		public function setAngle(angle : Number) : void {
			this.angle = angle;
		}

		public function getAngle() : Number {
			return angle;
		}

		public function addAngle(a : Number) : void {
			angle = (angle + a) % 360;
		}

		public function getAngleAsRadians() : Number {
			return Utils.toRadians(angle);
		}
	}
}
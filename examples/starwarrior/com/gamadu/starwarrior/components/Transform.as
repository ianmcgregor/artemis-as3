package com.gamadu.starwarrior.components {
	import com.artemis.Component;
	import com.artemis.utils.Utils;

	public class Transform extends Component {
		private var _x : Number;
		private var _y : Number;
		private var _rotation : Number;

		public function Transform(x : Number = 0, y : Number = 0, rotation : Number = 0) {
			_x = x;
			_y = y;
			_rotation = rotation;
		}

		public function addX(x : Number) : void {
			_x += x;
		}

		public function addY(y : Number) : void {
			_y += y;
		}

		public function getX() : Number {
			return _x;
		}

		public function setX(x : Number) : void {
			_x = x;
		}

		public function getY() : Number {
			return _y;
		}

		public function setY(y : Number) : void {
			_y = y;
		}

		public function setLocation(x : Number, y : Number) : void {
			_x = x;
			_y = y;
		}

		public function getRotation() : Number {
			return _rotation;
		}

		public function setRotation(rotation : Number) : void {
			_rotation = rotation;
		}

		public function addRotation(angle : Number) : void {
			_rotation = (_rotation + angle) % 360;
		}

		public function getRotationAsRadians() : Number {
			return Utils.toRadians(_rotation);
		}

		public function getDistanceTo(t : Transform) : Number {
			return Utils.distance(t.getX(), t.getY(), _x, _y);
		}
	}
}
package org.alwaysinbeta.pong.components {
	import com.artemis.Component;
	import com.artemis.utils.Utils;

	public class Transform extends Component {
		private var _x : int;
		private var _y : int;
		private var _rotation : int;

		public function Transform(x : int = 0, y : int = 0, rotation : int = 0) {
			_x = x;
			_y = y;
			_rotation = rotation;
		}

		public function addX(x : int) : void {
			_x += x;
		}

		public function addY(y : int) : void {
			_y += y;
		}

		public function get x() : int {
			return _x;
		}

		public function set x(x : int) : void {
			_x = x;
		}

		public function get y() : int {
			return _y;
		}

		public function set y(y : int) : void {
			_y = y;
		}

		public function setLocation(x : int, y : int) : void {
			_x = x;
			_y = y;
		}

		public function get rotation() : int {
			return _rotation;
		}

		public function set rotation(rotation : int) : void {
			_rotation = rotation;
		}

		public function addRotation(angle : int) : void {
			_rotation = (_rotation + angle) % 360;
		}

		public function getRotationAsRadians() : int {
			return Utils.toRadians(_rotation);
		}

		public function getDistanceTo(t : Transform) : int {
			return Utils.distance(t.x, t.y, _x, _y);
		}
	}
}
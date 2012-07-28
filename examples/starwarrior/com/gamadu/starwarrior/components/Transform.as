package com.gamadu.starwarrior.components {
	import com.artemis.Component;
	import com.artemis.utils.Utils;

	public class Transform extends Component {
		private var x : Number;
		private var y : Number;
		private var rotation : Number;

		public function Transform(x : Number = 0, y : Number = 0, rotation : Number = 0) {
			this.x = x;
			this.y = y;
			this.rotation = rotation;
		}

		public function addX(x : Number) : void {
			this.x += x;
		}

		public function addY(y : Number) : void {
			this.y += y;
		}

		public function getX() : Number {
			return x;
		}

		public function setX(x : Number) : void {
			this.x = x;
		}

		public function getY() : Number {
			return y;
		}

		public function setY(y : Number) : void {
			this.y = y;
		}

		public function setLocation(x : Number, y : Number) : void {
			// trace("Transform.setLocation(",x, y,")");
			this.x = x;
			this.y = y;
		}

		public function getRotation() : Number {
			return rotation;
		}

		public function setRotation(rotation : Number) : void {
			this.rotation = rotation;
		}

		public function addRotation(angle : Number) : void {
			rotation = (rotation + angle) % 360;
		}

		public function getRotationAsRadians() : Number {
			return Utils.toRadians(rotation);
		}

		public function getDistanceTo(t : Transform) : Number {
			return Utils.distance(t.getX(), t.getY(), x, y);
		}
	}
}
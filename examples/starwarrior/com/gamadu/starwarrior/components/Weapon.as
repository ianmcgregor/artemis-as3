package com.gamadu.starwarrior.components {
	import com.artemis.Component;

	public class Weapon extends Component {
		private var _shotAt : int;

		public function Weapon() {
		}

		public function setShotAt(shotAt : int) : void {
			_shotAt = shotAt;
		}

		public function getShotAt() : int {
			return _shotAt;
		}
	}
}
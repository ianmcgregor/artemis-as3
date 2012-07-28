package com.artemis {
	/**
	 * A system that processes entities at a interval in milliseconds.
	 * A typical usage would be a collision system or physics system.
	 * 
	 * @author Arni Arent
	 *
	 */
	// abstract
	public class IntervalEntitySystem extends EntitySystem {
		private var _accumulated : int;
		private var _interval : int;

		// public function IntervalEntitySystem(interval:int, Class<? extends Component>... types) {
		public function IntervalEntitySystem(interval : int, types : Array) {
			super(types);
			_interval = interval;
		}

		override protected function checkProcessing() : Boolean {
			_accumulated += _world.getDelta();
			if (_accumulated >= _interval) {
				_accumulated -= _interval;
				return true;
			}
			return false;
		}
	}
}
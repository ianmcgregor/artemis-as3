package com.artemis.utils {
	public class Timer {
		private var _delay : uint;
		private var _repeat : Boolean;
		private var _acc : uint;
		private var _done : Boolean;
		private var _stopped : Boolean;

		public function Timer(delay : int, repeat : Boolean) {
			_delay = delay;
			_repeat = repeat;
			_acc = 0;
		}

		public function update(delta : int) : void {
			if (!_done && !_stopped) {
				_acc += delta;

				if (_acc >= _delay) {
					_acc -= _delay;

					if (_repeat) {
						reset();
					} else {
						_done = true;
					}

					execute();
				}
			}
		}

		public function reset() : void {
			_stopped = false;
			_done = false;
			_acc = 0;
		}

		public function isDone() : Boolean {
			return _done;
		}

		public function isRunning() : Boolean {
			return !_done && _acc < _delay && !_stopped;
		}

		public function stop() : void {
			_stopped = true;
		}

		public function setDelay(delay : int) : void {
			_delay = delay;
		}

		// abstract
		public function execute() : void {
			// override
		}

		public function getPercentageRemaining() : Number {
			if (_done)
				return 100;
			else if (_stopped)
				return 0;
			else
				return 1 - Number((_delay - _acc)) / Number(_delay);
		}

		public function getDelay() : int {
			return _delay;
		}
	}
}
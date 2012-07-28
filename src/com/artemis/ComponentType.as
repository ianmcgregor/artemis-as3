package com.artemis {
	public class ComponentType {
		private static var _nextBit : uint = 1;
		private static var _nextId : uint = 0;
		private var _bit : uint;
		private var _id : uint;

		public function ComponentType() {
			init();
		}

		private function init() : void {
			_bit = _nextBit;
			_nextBit = _nextBit << 1;
			_id = _nextId++;
		}

		public function getBit() : uint {
			return _bit;
		}

		public function getId() : uint {
			return _id;
		}
	}
}
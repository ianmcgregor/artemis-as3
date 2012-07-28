package org.alwaysinbeta.game {
	/**
	 * @author ian
	 */
	public final class Random {
		private var _array : Vector.<Number>;
		private var _index : int = -1;
		private var _count : uint;	
		
		public function Random(count: uint = 1000, min: Number = 0, max: Number = 1) {
			_count = count;
			_array = new Vector.<Number>(_count);
			var i: uint = 0;
			while (i++ < _count) {
				_array[i] = min + Math.random() * (max - min);
			}
			_array.fixed = true;
		}
		
		public function get(): Number {
			_index ++;
			if(_index > _count - 1) _index = 0;
			return _array[_index];
		}
	}
}

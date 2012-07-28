package com.artemis {
	import flash.utils.Dictionary;

	// import java.util.HashMap;
	public class SystemBitManager {
		private static var _POS : uint = 0;
		// private static HashMap<Class<? extends EntitySystem>, Long> systemBits = new HashMap<Class<? extends EntitySystem>, Long>();
		private static var _systemBits : Dictionary = new Dictionary();

		// protected static function getBitFor(Class<? extends EntitySystem> es):Number {
		public static function getBitFor(entitySystem : Class) : Number {
			var bit : uint;

			if (_systemBits[entitySystem]) {
				bit = _systemBits[entitySystem];
			} else {
				bit = 1 << _POS;
				_POS++;
				_systemBits[entitySystem] = bit;
			}

			return bit;
		}
	}
}
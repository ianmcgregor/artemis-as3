package com.artemis.utils {
	// Thanks to Riven
	// From: http://riven8192.blogspot.com/2009/08/fastmath-sincos-lookup-tables.html
	public class TrigLUT {
		// public static function main(args:Array):void {
		// System.out.println(cos(float(Math.PI)));
		// System.out.println(cosDeg(180));
		// }
		public static function sin(rad : Number) : Number {
			return _sin[uint((rad * radToIndex)) & SIN_MASK];
		}

		public static function cos(rad : Number) : Number {
			return _cos[uint((rad * radToIndex)) & SIN_MASK];
		}

		public static function sinDeg(deg : Number) : Number {
			return _sin[uint((deg * degToIndex)) & SIN_MASK];
		}

		public static function cosDeg(deg : Number) : Number {
			return _cos[uint((deg * degToIndex)) & SIN_MASK];
		}

		private static var RAD : Number, DEG : Number;
		private static var SIN_BITS : uint, SIN_MASK : uint, SIN_COUNT : uint;
		private static var radFull : Number, radToIndex : Number;
		private static var degFull : Number, degToIndex : Number;
		private static var _sin : Vector.<Number>, _cos : Vector.<Number>;

		public function TrigLUT() {
			RAD = Math.PI / 180.0;
			DEG = 180.0 / Math.PI;

			SIN_BITS = 12;
			SIN_MASK = ~(-1 << SIN_BITS);
			SIN_COUNT = SIN_MASK + 1;

			radFull = Math.PI * 2.0;
			degFull = 360.0;
			radToIndex = SIN_COUNT / radFull;
			degToIndex = SIN_COUNT / degFull;

			_sin = new Vector.<Number>(SIN_COUNT);
			_cos = new Vector.<Number>(SIN_COUNT);

			for (var i : uint = 0; i < SIN_COUNT; i++) {
				_sin[i] = Math.sin((i + 0.5) / SIN_COUNT * radFull);
				_cos[i] = Math.cos((i + 0.5) / SIN_COUNT * radFull);
			}
		}
	}
}
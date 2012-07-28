package com.artemis.utils {
	public class FastMath {
		public static const PI : Number = Math.PI;
		public static const SQUARED_PI : Number = PI * PI;
		public static const HALF_PI : Number = 0.5 * PI;
		public static const TWO_PI : Number = 2.0 * PI;
		public static const THREE_PI_HALVES : Number = TWO_PI - HALF_PI;
		private static const _sin_a : Number = -4 / SQUARED_PI;
		private static const _sin_b : Number = 4 / PI;
		private static const _sin_p : Number = 9 / 40;
		private static const _asin_a : Number = -0.0481295276831013447;
		private static const _asin_b : Number = -0.343835993947915197;
		private static const _asin_c : Number = 0.962761848425913169;
		private static const _asin_d : Number = 1.00138940860107040;
		private static const _atan_a : Number = 0.280872;

		public static function cos(x : Number) : Number {
			return sin(x + ((x > HALF_PI) ? -THREE_PI_HALVES : HALF_PI));
		}

		public static function sin(x : Number) : Number {
			x = _sin_a * x * abs(x) + _sin_b * x;
			return _sin_p * (x * abs(x) - x) + x;
		}

		public static function tan(x : Number) : Number {
			return sin(x) / cos(x);
		}

		public static function asin(x : Number) : Number {
			return x * (abs(x) * (abs(x) * _asin_a + _asin_b) + _asin_c) + signum(x) * (_asin_d - Math.sqrt(1 - x * x));
		}

		public static function acos(x : Number) : Number {
			return HALF_PI - asin(x);
		}

		public static function atan(x : Number) : Number {
			return (abs(x) < 1) ? x / (1 + _atan_a * x * x) : signum(x) * HALF_PI - x / (x * x + _atan_a);
		}

		private static function signum(x : Number) : Number {
			if (x > 0) return 1;
			if (x < 0) return -1;
			return 0;
		}

//		public static function inverseSqrt(x : Number) : Number {
//			var xhalves : Number = 0.5 * x;
//			x = 0x5FE6EB50C7B537AA - x >> 1;
//			return x * (1.5 - xhalves * x * x);
//			// more iterations possible
//		}
//		public final static double inverseSqrt(double x) {
//			final double xhalves = 0.5d * x;
//			x = Double.longBitsToDouble(0x5FE6EB50C7B537AAl - (Double.doubleToRawLongBits(x) >> 1));
//			return x * (1.5d - xhalves * x * x); // more iterations possible
//		}
//		public static function sqrt(x : Number) : Number {
//			return x * inverseSqrt(x);
//		}

		// FIMXE: not fast! couldn't implement inverseSqrt in as3

		public static function sqrt(x : Number) : Number {
			return Math.sqrt(x);
		}

		public static function inverseSqrt(x : Number) : Number {
			return 1.0 / Math.sqrt(x);
		}


		private static function abs(x : Number) : Number {
			return x < 0 ? -x : x;
		}
	}
}
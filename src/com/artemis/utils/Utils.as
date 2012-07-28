package com.artemis.utils {
	// import java.io.BufferedReader;
	// import java.io.IOException;
	// import java.io.InputStream;
	// import java.io.InputStreamReader;
	// import java.io.Reader;
	// import java.io.StringWriter;
	// import java.io.Writer;
	public class Utils {
		public static function cubicInterpolation(v0 : Number, v1 : Number, v2 : Number, v3 : Number, t : Number) : Number {
			var t2 : Number = t * t;
			var a0 : Number = v3 - v2 - v0 + v1;
			var a1 : Number = v0 - v1 - a0;
			var a2 : Number = v2 - v0;
			var a3 : Number = v1;

			return (a0 * (t * t2)) + (a1 * t2) + (a2 * t) + a3;
		}

		public static function quadraticBezierInterpolation(a : Number, b : Number, c : Number, t : Number) : Number {
			return (((1 - t) * (1 - t)) * a) + (((2 * t) * (1 - t)) * b) + ((t * t) * c);
		}

		public static function lengthOfQuadraticBezierCurve(x0 : Number, y0 : Number, x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			if ((x0 == x1 && y0 == y1) || (x1 == x2 && y1 == y2)) {
				return distance(x0, y0, x2, y2);
			}

			var ax : Number, ay : Number, bx : Number, by : Number;
			ax = x0 - 2 * x1 + x2;
			ay = y0 - 2 * y1 + y2;
			bx = 2 * x1 - 2 * x0;
			by = 2 * y1 - 2 * y0;
			var A : Number = 4 * (ax * ax + ay * ay);
			var B : Number = 4 * (ax * bx + ay * by);
			var C : Number = bx * bx + by * by;

			var Sabc : Number = 2 * Number(Math.sqrt(A + B + C));
			var A_2 : Number = Number(Math.sqrt(A));
			var A_32 : Number = 2 * A * A_2;
			var C_2 : Number = 2 * Number(Math.sqrt(C));
			var BA : Number = B / A_2;

			return (A_32 * Sabc + A_2 * B * (Sabc - C_2) + (4 * C * A - B * B) * Number(Math.log((2 * A_2 + BA + Sabc) / (BA + C_2)))) / (4 * A_32);
		}

		public static function lerp(a : Number, b : Number, t : Number) : Number {
			if (t < 0)
				return a;
			return a + t * (b - a);
		}

		public static function distance(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			return euclideanDistance(x1, y1, x2, y2);
		}

		public static function doCirclesCollide(x1 : Number, y1 : Number, radius1 : Number, x2 : Number, y2 : Number, radius2 : Number) : Boolean {
			var dx : Number = x2 - x1;
			var dy : Number = y2 - y1;
			var d : Number = radius1 + radius2;
			return (dx * dx + dy * dy) < (d * d);
		}

		public static function euclideanDistanceSq2D(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			var dx : Number = x1 - x2;
			var dy : Number = y1 - y2;
			return dx * dx + dy * dy;
		}

		public static function manhattanDistance(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			return Math.abs(x1 - x2) + Math.abs(y1 - y2);
		}

		public static function euclideanDistance(x1 : Number, y1 : Number, x2 : Number, y2 : Number) : Number {
			var a : Number = x1 - x2;
			var b : Number = y1 - y2;

			return FastMath.sqrt(a * a + b * b);
		}

		// public static function angleInDegrees(ownerRotation:Number, x1:Number, y1:Number, x2:Number, y2:Number):Number {
		// return Math.abs(ownerRotation - angleInDegrees(x1, y1, x2, y2)) % 360;
		// }
		//
		public static function angleInDegrees(originX : Number, originY : Number, targetX : Number, targetY : Number) : Number {
			return toDegrees(Math.atan2(targetY - originY, targetX - originX));
		}

		public static function toDegrees(radians : Number) : Number {
			return radians * 180 / Math.PI ;
		}

		public static function toRadians(degrees : Number) : Number {
			return degrees * Math.PI / 180;
		}

		public static function angleInRadians(originX : Number, originY : Number, targetX : Number, targetY : Number) : Number {
			return Number(Math.atan2(targetY - originY, targetX - originX));
		}

		public static function shouldRotateCounterClockwise(angleFrom : Number, angleTo : Number) : Boolean {
			var diff : Number = (angleFrom - angleTo) % 360;
			return diff > 0 ? diff < 180 : diff < -180;
		}

		public static function getRotatedX(currentX : Number, currentY : Number, pivotX : Number, pivotY : Number, angleDegrees : Number) : Number {
			var x : Number = currentX - pivotX;
			var y : Number = currentY - pivotY;
			var xr : Number = (x * TrigLUT.cosDeg(angleDegrees)) - (y * TrigLUT.sinDeg(angleDegrees));
			return xr + pivotX;
		}

		public static function getRotatedY(currentX : Number, currentY : Number, pivotX : Number, pivotY : Number, angleDegrees : Number) : Number {
			var x : Number = currentX - pivotX;
			var y : Number = currentY - pivotY;
			var yr : Number = (x * TrigLUT.sinDeg(angleDegrees)) + (y * TrigLUT.cosDeg(angleDegrees));
			return yr + pivotY;
		}

		public static function getXAtEndOfRotatedLineByOrigin(x : Number, lineLength : Number, angleDegrees : Number) : Number {
			return x + TrigLUT.cosDeg(angleDegrees) * lineLength;
		}

		public static function getYAtEndOfRotatedLineByOrigin(y : Number, lineLength : Number, angleDegrees : Number) : Number {
			return y + TrigLUT.sinDeg(angleDegrees) * lineLength;
		}
		
		public static function collides(x1 : Number, y1 : Number, radius1 : Number, x2 : Number, y2 : Number, radius2 : Number) : Boolean {
			var d : Number = Utils.distance(x1, y1, x2, y2);

			d -= radius1 + radius2;

			return d < 0;
		}
		// public static function readFileContents(file:String):String {
		// var is:InputStream= Utils.class.getClassLoader().getResourceAsStream(file);
		// var contents:String= "";
		// try {
		// if (is != null) {
		// var writer:Writer= new StringWriter();
		//
		// var buffer:Array= new char[1024];
		// var reader:Reader= new BufferedReader(new InputStreamReader(is, "UTF-8"));
		// var n:int;
		// while ((n = reader.read(buffer)) != -1) {
		// writer.write(buffer, 0, n);
		// }
		//
		// contents = writer.toString();
		// }
		// } catch (e:Exception) {
		// e.printStackTrace();
		// } finally {
		// try {
		// is.close();
		// } catch (e:IOException) {
		// e.printStackTrace();
		// }
		// }
		//
		// return contents;
		// }
	}
}
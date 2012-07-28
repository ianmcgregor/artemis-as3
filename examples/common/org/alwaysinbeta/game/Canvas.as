package org.alwaysinbeta.game {
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.display.Stage;
	import flash.display.StageQuality;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author ian
	 */
	public class Canvas extends BitmapData {
		private const _destPoint : Point = new Point();
		private var _stage : Stage;
		private var _fillColor : uint;

		public function Canvas(width : int, height : int, stage : Stage, fillColor : uint = 0xff000000) {
			super(width, height, true, fillColor);
			_stage = stage;
			_fillColor = fillColor;
		}
		
		public function clear(): void {
			fillRect(rect, _fillColor);
		}
		
		public function blit(bitmapData: BitmapData, x: int, y: int) : void {
			_destPoint.x = x;
			_destPoint.y = y;
			copyPixels(bitmapData, bitmapData.rect, _destPoint);
		}
		
		public function drawHighQuality(source : IBitmapDrawable, matrix : Matrix = null, colorTransform : ColorTransform = null, blendMode : String = null, clipRect : Rectangle = null, smoothing : Boolean = true): void {
			_stage.quality = StageQuality.HIGH;
			draw(source, matrix, colorTransform, blendMode, clipRect, smoothing);
			_stage.quality = StageQuality.LOW;
		}
	}
}



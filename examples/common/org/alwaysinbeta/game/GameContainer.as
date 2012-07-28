package org.alwaysinbeta.game {
	import flash.display.Bitmap;
	import flash.events.Event;

	/**
	 * @author ian
	 */
	public class GameContainer extends Bitmap {
		private var _width : Number;
		private var _height : Number;
		private var _input : Input;
		private var _canvas : Canvas;
		
		public function GameContainer(width: Number, height: Number) {
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			bitmapData = _canvas = new Canvas(_width, _height, stage, 0xff000000);
			_input = new Input(stage);
		}

		public function getWidth() : Number {
			return _width;
		}

		public function getHeight() : Number {
			return _height;
		}

		public function getGraphics() : Canvas {
			return _canvas;
		}
		
		public function getInput() : Input {
			return _input;
		}
	}
}

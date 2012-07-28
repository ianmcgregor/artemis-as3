package org.alwaysinbeta.game {
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.getTimer;
	import org.alwaysinbeta.debug.FPS;

	/**
	 * @author ian
	 */
	public class BasicGame extends Sprite {
		private var _gameContainer : GameContainer;
		private var _time : int;
		private var _width : int;
		private var _height : int;
		private var _fps : FPS;

		public function BasicGame(width : int, height : int) {
			_width = width;
			_height = height;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event : Event) : void {
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.quality = StageQuality.LOW;

			addChild(_gameContainer = new GameContainer(_width, _height));
			init(_gameContainer);

			addChild(_fps = new FPS());

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void {
			var time : int = getTimer();
			var delta : int = time - _time;
			_time = time;
			_gameContainer.getGraphics().clear();
			update(_gameContainer, delta);
			render(_gameContainer, _gameContainer.getGraphics());
		}

		public function init(container : GameContainer) : void {
		}

		public function update(container : GameContainer, delta : int) : void {
		}

		public function render(container : GameContainer, g : Canvas) : void {
		}
	}
}

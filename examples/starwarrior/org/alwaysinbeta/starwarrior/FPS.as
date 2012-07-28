package org.alwaysinbeta.starwarrior {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.system.System;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;

	public final class FPS extends Bitmap {
		private var _text : TextField;

		public function FPS() {
			super();

			initialize();

			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function initialize() : void {
			_text = new TextField();
			_text.multiline = false;
			_text.autoSize = TextFieldAutoSize.LEFT;
			_text.defaultTextFormat = new TextFormat('_sans', 10, 0xFFFFFF, true);
			_text.embedFonts = false;
			_text.width = 120;
			_text.height = 120;

			bitmapData = new BitmapData(80, 52, false, 0xff000000);
		}

		private function onAddedToStage(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);

			startMonitoring();
		}

		private function onRemovedFromStage(event : Event) : void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			stopMonitoring();
		}

		// MONITORING
		public function startMonitoring() : void {
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		public function stopMonitoring() : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		private function onEnterFrame(event : Event) : void {
			updateFps();
			updateMem();

			var info : String = "";
			var frameRate : Number = stage.frameRate;
			info += "FPS: " + _currentFps + "/" + frameRate + "\n";
			info += "AVE: " + _averageFps + "/" + frameRate + "\n";
			info += "MEM: " + _mem + "\n";
			info += "MAX: " + _memMax + "\n";
			_text.text = info;

			bitmapData.fillRect(bitmapData.rect, 0xFF000000);
			bitmapData.draw(_text);
		}

		// FPS
		private var _timer : uint;
		private var _ms : uint;
		private var _fps : uint;
		private var _currentFps : uint;
		private var _averageFps : uint;
		private var _ticks : uint;
		private var _total : uint;

		private function updateFps() : void {
			_timer = getTimer();

			if (_timer - 1000 > _ms) {
				_ms = _timer;
				_currentFps = _fps;
				_fps = 0;
				
				if (_currentFps > 1) {
					_ticks ++;
					_total += _currentFps;
					_averageFps = Math.round(_total / _ticks);
				}
			}

			_fps++;
		}

		// MEMORY
		private var _mem : Number = 0;
		private var _memMax : Number = 0;

		private function updateMem() : void {
			_mem = Number((System.totalMemory * 0.000000954).toFixed(3));
			_memMax = _memMax > _mem ? _memMax : _mem;
		}
	}
}
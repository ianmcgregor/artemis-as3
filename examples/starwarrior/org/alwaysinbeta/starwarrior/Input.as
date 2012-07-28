package org.alwaysinbeta.starwarrior{
	import com.gamadu.starwarrior.systems.IKeyListener;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	/**
	 * @author ian
	 */
	public class Input {
		public function Input(stage: Stage) {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}

		private function onKeyDown(event : KeyboardEvent) : void {
			var key: uint = event.keyCode;
			var l: int = _keyListeners.length;
			for (var i : int = 0; i < l; ++i) {
				if(_keyListeners[i].isAcceptingInput())
					_keyListeners[i].keyPressed(key, null);
			}
		}

		private function onKeyUp(event : KeyboardEvent) : void {
			var key: uint = event.keyCode;
			var l: int = _keyListeners.length;
			for (var i : int = 0; i < l; ++i) {
				if(_keyListeners[i].isAcceptingInput())
					_keyListeners[i].keyReleased(key, null);
			}
		}
		
		private var _keyListeners: Vector.<IKeyListener> = new Vector.<IKeyListener>();
		
		public function addKeyListener(keyListener : IKeyListener) : void {
			if (_keyListeners.indexOf(keyListener) == -1) 
				_keyListeners[_keyListeners.length] = keyListener;	
		}
	}
}

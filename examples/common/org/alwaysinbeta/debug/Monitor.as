package org.alwaysinbeta.debug {
	import com.artemis.EntityManager;
	import com.artemis.World;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public final class Monitor extends Bitmap {
		private var _text : TextField;
		private var _world : World;

		public function Monitor(world : World) {
			super();

			_world = world;

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

			bitmapData = new BitmapData(100, 62, false, 0xff000000);
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
			var entityManager : EntityManager = _world.getEntityManager();
			var info : String = "";
			info += "ENTITIES: " + "\n";
			info += "COUNT: " + entityManager.getEntityCount() + "\n";
			info += "CREATED: " + entityManager.getTotalCreated() + "\n";
			info += "REMOVED: " + entityManager.getTotalRemoved() + "\n";
			info += "DELTA: " + _world.getDelta() + "ms" + "\n";
			_text.text = info;

			bitmapData.fillRect(bitmapData.rect, 0xFF000000);
			bitmapData.draw(_text);
		}
	}
}
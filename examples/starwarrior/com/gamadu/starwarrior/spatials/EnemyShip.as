package com.gamadu.starwarrior.spatials {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;
	import com.gamadu.starwarrior.components.Transform;

	import flash.display.BitmapData;

	import org.alwaysinbeta.starwarrior.Canvas;

	public class EnemyShip extends Spatial {
		private var _transform : Transform;
		private var _bitmapData : BitmapData;

		public function EnemyShip(world : World, owner : Entity) {
			super(world, owner);
		}

		override public function initalize() : void {
			// trace("EnemyShip.initalize()");
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);

			_bitmapData = new BitmapData(20, 20, false, 0x00ff00);
		}

		override public function render(g : Canvas) : void {
			// trace("EnemyShip.render(",g,")");
			var x : Number = _transform.getX() - 10;
			var y : Number = _transform.getY() - 10;
			g.blit(_bitmapData, x, y);
		}
	}
}
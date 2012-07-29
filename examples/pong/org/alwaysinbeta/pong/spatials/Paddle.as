package org.alwaysinbeta.pong.spatials {
	import com.artemis.ComponentMapper;
	import com.artemis.Entity;
	import com.artemis.World;

	import org.alwaysinbeta.game.Canvas;
	import org.alwaysinbeta.pong.components.Transform;

	import flash.display.BitmapData;

	/**
	 * @author McFamily
	 */
	public class Paddle extends Spatial {
		private var _transform : Transform;
		private var _bitmapData : BitmapData;
		
		public function Paddle(world : World, owner : Entity) {
			super(world, owner);
		}
		
		override public function initalize() : void {
			var transformMapper : ComponentMapper = new ComponentMapper(Transform, _world);
			_transform = transformMapper.get(_owner);

			_bitmapData = new BitmapData(20, 60, false, 0xff0000);
		}

		override public function render(g : Canvas) : void {
			var x : Number = _transform.x;
			var y : Number = _transform.y;
			g.blit(_bitmapData, x, y);
		}
	}
}

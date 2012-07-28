package com.gamadu.starwarrior.spatials {
	import com.artemis.Entity;
	import com.artemis.World;
	import org.alwaysinbeta.game.Canvas;


	public class Spatial {
		protected var _world : World;
		protected var _owner : Entity;

		public function Spatial(world : World, owner : Entity) {
			_world = world;
			_owner = owner;
		}

		public function initalize() : void {
		}

		public function render(g : Canvas) : void {
		}
	}
}
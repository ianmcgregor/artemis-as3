package com.artemis {
	import com.artemis.utils.IImmutableBag;

	/**
	 * The purpose of this class is to allow systems to execute at varying intervals.
	 * 
	 * An example system would be an ExpirationSystem, that deletes entities after a certain
	 * lifetime. Instead of running a system that decrements a timeLeft value for each
	 * entity, you can simply use this system to execute in a future at a time of the shortest
	 * lived entity, and then reset the system to run at a time in a future at a time of the
	 * shortest lived entity, etc.
	 * 
	 * Another example system would be an AnimationSystem. You know when you have to animate
	 * a certain entity, e.g. in 300 milliseconds. So you can set the system to run in 300 ms.
	 * to perform the animation.
	 * 
	 * This will save CPU cycles in some scenarios.
	 * 
	 * Make sure you detect all circumstances that change. E.g. if you create a new entity you
	 * should find out if you need to run the system sooner than scheduled, or when deleting
	 * a entity, maybe something changed and you need to recalculate when to run. Usually this
	 * applies to when entities are created, deleted, changed.
	 * 
	 * This class offers public methods allowing external systems to use it.
	 * 
	 * @author Arni Arent
	 *
	 */
	// abstract
	public internal class DelayedEntitySystem extends EntitySystem {
		private var _delay : int;
		private var _running : Boolean;
		private var _accumulated : int;

		public function DelayedEntitySystem(... types : Class) {
			super(types);
		}

		override protected function processEntities(entities : IImmutableBag) : void {
			processEntitiesWithAccumulatedData(entities, _accumulated);
			stop();
		}

		override protected function checkProcessing() : Boolean {
			if (_running) {
				_accumulated += _world.getDelta();

				if (_accumulated >= _delay) {
					return true;
				}
			}
			return false;
		}

		/**
		 * The entities to process with accumulated delta.
		 * @param entities read-only bag of entities.
		 */
		// protected abstract function processEntities(ImmutableBag<Entity> entities, accumulatedDelta:int):void ;
		protected function processEntitiesWithAccumulatedData(entities : IImmutableBag, accumulatedDelta : int) : void ;

		/**
		 * Start processing of entities after a certain amount of milliseconds.
		 * 
		 * Cancels current delayed run and starts a new one.
		 * 
		 * @param delay time delay in milliseconds until processing starts.
		 */
		public function startDelayedRun(delay : int) : void {
			_delay = delay;
			_accumulated = 0;
			_running = true;
		}

		/**
		 * Get the initial delay that the system was ordered to process entities after.
		 * 
		 * @return the originally set delay.
		 */
		public function getInitialTimeDelay() : int {
			return _delay;
		}

		public function getRemainingTimeUntilProcessing() : int {
			if (_running) {
				return _delay - _accumulated;
			}
			return 0;
		}

		/**
		 * Check if the system is counting down towards processing.
		 * 
		 * @return true if it's counting down, false if it's not running.
		 */
		public function isRunning() : Boolean {
			return _running;
		}

		/**
		 * Aborts running the system in the future and stops it. Call delayedRun() to start it again.
		 */
		public function stop() : void {
			_running = false;
			_accumulated = 0;
		}
	}
}
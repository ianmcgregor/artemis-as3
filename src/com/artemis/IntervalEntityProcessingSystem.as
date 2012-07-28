package com.artemis {
	import com.artemis.utils.IImmutableBag;

	/**
	 * If you need to process entities at a certain interval then use this.
	 * A typical usage would be to regenerate ammo or health at certain intervals, no need
	 * to do that every game loop, but perhaps every 100 ms. or every second.
	 * 
	 * @author Arni Arent
	 *
	 */
	// abstract 
	public class IntervalEntityProcessingSystem extends IntervalEntitySystem {
		/**
		 * Create a new IntervalEntityProcessingSystem. It requires at least one component.
		 * @param requiredType the required component type.
		 * @param otherTypes other component types.
		 */
		// public function IntervalEntityProcessingSystem(interval:int, Class<? extends Component> requiredType, Class<? extends Component>... otherTypes) {
		public function IntervalEntityProcessingSystem(interval : int, requiredType : Class, otherTypes : Array) {
			super(interval, getMergedTypes(requiredType, otherTypes));
		}

		/**
		 * Process a entity this system is interested in.
		 * @param e the entity to process.
		 */
		// protected abstract function process(e:Entity):void ;
		protected function processEntity(e : Entity) : void {}

		// override protected function processEntities(ImmutableBag<Entity> entities):void {
		override protected function processEntities(entities : IImmutableBag) : void {
			for (var i : int = 0, s : int = entities.size(); s > i; i++) {
				processEntity(entities.get(i));
			}
		}
	}
}
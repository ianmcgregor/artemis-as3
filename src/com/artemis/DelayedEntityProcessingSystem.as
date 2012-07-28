package com.artemis {
	import com.artemis.utils.IImmutableBag;

	// abstract
	public class DelayedEntityProcessingSystem extends DelayedEntitySystem {
		/**
		 * Create a new DelayedEntityProcessingSystem. It requires at least one component.
		 * @param requiredType the required component type.
		 * @param otherTypes other component types.
		 */
		// public function DelayedEntityProcessingSystem(Class<? extends Component> requiredType, Class<? extends Component>... otherTypes) {
		public function DelayedEntityProcessingSystem(requiredType : Class, otherTypes : Array) {
			super(getMergedTypes(requiredType, otherTypes));
		}

		/**
		 * Process a entity this system is interested in.
		 * @param e the entity to process.
		 */
		protected  function processEntityWithAccumulatedData(e : Entity, accumulatedDelta : int) : void {
			
		}

		// override protected function process(e:Entity, accumulatedDelta:int):void ;
		// override protected function processEntities(ImmutableBag<Entity> entities, accumulatedDelta:int):void {
		// override protected function processEntities(entities: IImmutableBag, accumulatedDelta:int):void {
		override protected function processEntitiesWithAccumulatedData(entities : IImmutableBag, accumulatedDelta : int) : void {
			for (var i : int = 0, s : int = entities.size(); s > i; i++) {
				processEntityWithAccumulatedData(entities.get(i), accumulatedDelta);
			}
		}
	}
}
package com.artemis {
	import com.artemis.utils.IImmutableBag;

	/**
	 * A typical entity system. Use this when you need to process entities possessing the
	 * provided component types.
	 * 
	 * @author Arni Arent
	 *
	 */
	// abstract
	public class EntityProcessingSystem extends EntitySystem {
		/**
		 * Create a new EntityProcessingSystem. It requires at least one component.
		 * @param requiredType the required component type.
		 * @param otherTypes other component types.
		 */
		// public function EntityProcessingSystem(Class<? extends Component> requiredType, Class<? extends Component>... otherTypes) {
		public function EntityProcessingSystem(requiredType : Class, otherTypes : Array) {
			super(getMergedTypes(requiredType, otherTypes));
		}

		/**
		 * Process a entity this system is interested in.
		 * @param e the entity to process.
		 */
		// protected abstract function process(e:Entity):void ;
		protected function processEntity(e : Entity) : void {
			//trace("EntityProcessingSystem.processEntity(",e,")");
		};

		// protected function process(e:Entity, accumulatedDelta:int):void ;
		// override protected function processEntities(ImmutableBag<Entity> entities):void {
		override protected function processEntities(entities : IImmutableBag) : void {
//			trace("EntityProcessingSystem.processEntities(",entities,")");
			// size needs to be read each iteration as it changes as items are removed during processing 
			for (var i : int = 0, s : int = entities.size(); s > i; i++) {
				processEntity(entities.get(i));
			}
		}

		override protected function checkProcessing() : Boolean {
			return true;
		}
	}
}
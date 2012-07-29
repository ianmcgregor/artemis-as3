package com.artemis {
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;

	/**
	 * The most raw entity system. It should not typically be used, but you can create your own
	 * entity system handling by extending this. It is recommended that you use the other provided
	 * entity system implementations.
	 * 
	 * @author Arni Arent
	 *
	 */
	// abstract
	public class EntitySystem {
		private var _systemBit : uint;
		private var _typeFlags : Number;
		protected var _world : World;
		// private Bag<Entity> actives;
		private var _actives : Bag;

		// public function EntitySystem() {
		// }
		// public function EntitySystem(Class<? extends Component>... types) {
		public function EntitySystem(types : Array) {
			// actives = new Bag<Entity>();
			_actives = new Bag();

			// for (Class<? extends Component> type : types) {
			for each (var type: Class in types) {
				var ct : ComponentType = ComponentTypeManager.getTypeFor(type);
				_typeFlags |= ct.getBit();
			}
		}

		public function setSystemBit(bit : uint) : void {
			_systemBit = bit;
		}

		/**
		 * Called before processing of entities begins. 
		 */
		protected function begin() : void {
		}

		public function process() : void {
			if (checkProcessing()) {
				begin();
				processEntities(_actives);
				end();
			}
		}

		/**
		 * Called after the processing of entities ends.
		 */
		protected function end() : void {
		};

		/**
		 * Any implementing entity system must implement this method and the logic
		 * to process the given entities of the system.
		 * 
		 * @param entities the entities this system contains.
		 */
		// protected abstract function processEntities(ImmutableBag<Entity> entities):void ;
		// protected function processEntities(entities: IImmutableBag, accumulatedDelta:int):void ;
		protected function processEntities(entities : IImmutableBag) : void {
		}

		/**
		 * 
		 * @return true if the system should be processed, false if not.
		 */
		// protected abstract function checkProcessing():Boolean ;
		protected function checkProcessing() : Boolean {
			return false;
		}

		/**
		 * Override to implement code that gets executed when systems are initialized.
		 */
		public function initialize() : void {
		}

		/**
		 * Called if the system has received a entity it is interested in, e.g. created or a component was added to it.
		 * @param e the entity that was added to this system.
		 */
		protected function added(e : Entity) : void {
		}

		/**
		 * Called if a entity was removed from this system, e.g. deleted or had one of it's components removed.
		 * @param e the entity that was removed from this system.
		 */
		protected function removed(e : Entity) : void {
		}

		public function change(e : Entity) : void {
//			trace("EntitySystem.change(",e,")");
			// FIXME: contains is not working correctly
			//var contains : Boolean = false;
			var contains : Boolean = (_systemBit & e.getSystemBits()) == _systemBit;
			var interest : Boolean = (_typeFlags & e.getTypeBits()) == _typeFlags;
			//contains = e.added;
			if (interest && !contains && _typeFlags > 0) {
				_actives.add(e);
				e.addSystemBit(_systemBit);
				//e.added = true;
				added(e);
			} else if (!interest && contains && _typeFlags > 0) {
				remove(e);
			}
		}

		private function remove(e : Entity) : void {
			//e.added = false;
			_actives.removeOb(e);
			e.removeSystemBit(_systemBit);
			removed(e);
		}

		public function setWorld(world : World) : void {
			_world = world;
		}

		/**
		 * Merge together a required type and a array of other types. Used in derived systems.
		 * @param requiredType
		 * @param otherTypes
		 * @return
		 */
		// protected static Class<? extends Component>[] getMergedTypes(Class<? extends Component> requiredType, Class<? extends Component>[] otherTypes) {
		protected static function getMergedTypes(requiredType : Class, otherTypes : Array) : Array {
			// Class<? extends Component>[] types = new Class[1+otherTypes.length];
			var types : Array = new Array();
			types[0] = requiredType;
			var l: int = otherTypes.length;
			for (var i : int = 0; i < l; ++i) {
				types[i + 1] = otherTypes[i];
			}
//			for (var i : int = 0; otherTypes.length > i; i++) {
//				types[i + 1] = otherTypes[i];
//			}
			return types;
		}
	}
}
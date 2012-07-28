package com.artemis {
	import com.artemis.utils.Bag;
	import com.artemis.utils.IImmutableBag;

	public class EntityManager {
		private var _world : World;
		// private Bag<Entity> activeEntities;
		// private Bag<Entity> removedAndAvailable;
		private var _activeEntities : Bag;
		private var _removedAndAvailable : Bag;
		private var _nextAvailableId : uint;
		private var _count : uint;
		private var _uniqueEntityId : uint;
		private var _totalCreated : uint;
		private var _totalRemoved : uint;
		// private Bag<Bag<Component>> componentsByType;
		private var _componentsByType : Bag;
		// private Bag<Component> entityComponents; // Added for debug support.
		private var _entityComponents : Bag;

		// Added for debug support.
		public function EntityManager(world : World) {
			_world = world;

			// activeEntities = new Bag<Entity>();
			// removedAndAvailable = new Bag<Entity>();
			_activeEntities = new Bag();
			_removedAndAvailable = new Bag();

			// componentsByType = new Bag<Bag<Component>>(64);
			// componentsByType = new Bag(64);
			_componentsByType = new Bag();

			// entityComponents = new Bag<Component>();
			_entityComponents = new Bag();
		}

		public function create() : Entity {
			var e : Entity = _removedAndAvailable.removeLast();
			if (e == null) {
				e = new Entity(_world, _nextAvailableId++);
			} else {
				e.reset();
			}
			e.setUniqueId(_uniqueEntityId++);
			_activeEntities.set(e.getId(), e);
			_count++;
			_totalCreated++;
			return e;
		}

		public function remove(e : Entity) : void {
			_activeEntities.set(e.getId(), null);

			e.setTypeBits(0);

			refresh(e);

			removeComponentsOfEntity(e);

			_count--;
			_totalRemoved++;

			_removedAndAvailable.add(e);
		}

		private function removeComponentsOfEntity(e : Entity) : void {
			for (var a : int = 0; _componentsByType.size() > a; a++) {
				// Bag<Component> components = componentsByType.get(a);
				var components : Bag = _componentsByType.get(a);
				if (components != null && e.getId() < components.size()) {
					components.set(e.getId(), null);
				}
			}
		}

		/**
		 * Check if this entity is active, or has been deleted, within the framework.
		 * 
		 * @param entityId
		 * @return active or not.
		 */
		public function isActive(entityId : int) : Boolean {
			return _activeEntities.get(entityId) != null;
		}

		public function addComponent(e : Entity, component : Component) : void {
			// var type:ComponentType= ComponentTypeManager.getTypeFor(component.getClass());
			var type : ComponentType = ComponentTypeManager.getTypeFor(Object(component).constructor as Class);

			if (type.getId() >= _componentsByType.getCapacity()) {
				_componentsByType.set(type.getId(), null);
			}

			// Bag<Component> components = componentsByType.get(type.getId());
			var components : Bag = _componentsByType.get(type.getId());
			if (components == null) {
				// components = new Bag<Component>();
				components = new Bag();
				_componentsByType.set(type.getId(), components);
			}

			components.set(e.getId(), component);

			e.addTypeBit(type.getBit());
		}

		public function refresh(e : Entity) : void {
			var systemManager : SystemManager = _world.getSystemManager();
			// Bag<EntitySystem> systems = systemManager.getSystems();
			var systems : Bag = systemManager.getSystems();
//			var l : int = systems.size();
			// for (var i : int = 0; i < l; ++i) {
			// EntitySystem(systems.get(i)).change(e);
			// }
			for (var i : int = 0, s : int = systems.size(); s > i; i++) {
				EntitySystem(systems.get(i)).change(e);
			}
		}

		// protected function removeComponent(e:Entity, component:Component):void {
		// var type:ComponentType= ComponentTypeManager.getTypeFor(component.getClass());
		// removeComponent(e, type);
		// }
		public function removeComponent(e : Entity, type : ComponentType) : void {
			// Bag<Component> components = componentsByType.get(type.getId());
			var components : Bag = _componentsByType.get(type.getId());
			components.set(e.getId(), null);
			e.removeTypeBit(type.getBit());
		}

		public function getComponent(e : Entity, type : ComponentType) : Component {
			// Bag<Component> bag = componentsByType.get(type.getId());
			var bag : Bag = _componentsByType.get(type.getId());
			if (bag != null && e.getId() < bag.getCapacity())
				return bag.get(e.getId());
			return null;
		}

		public function getEntity(entityId : int) : Entity {
			return _activeEntities.get(entityId);
		}

		/**
		 * 
		 * @return how many entities are currently active.
		 */
		public function getEntityCount() : uint {
			return _count;
		}

		/**
		 * 
		 * @return how many entities have been created since start.
		 */
		public function getTotalCreated() : uint {
			return _totalCreated;
		}

		/**
		 * 
		 * @return how many entities have been removed since start.
		 */
		public function getTotalRemoved() : uint {
			return _totalRemoved;
		}

		// protected ImmutableBag<Component> getComponents(var e:Entity) {
		public function getComponents(e : Entity) : IImmutableBag {
			_entityComponents.clear();
			for (var a : int = 0; _componentsByType.size() > a; a++) {
				// Bag<Component> components = componentsByType.get(a);
				var components : Bag = _componentsByType.get(a);
				if (components != null && e.getId() < components.size()) {
					var component : Component = components.get(e.getId());
					if (component != null) {
						_entityComponents.add(component);
					}
				}
			}
			return _entityComponents;
		}
	}
}
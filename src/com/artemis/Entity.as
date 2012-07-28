package com.artemis {
	import com.artemis.utils.IImmutableBag;

	/**
	 * The entity class. Cannot be instantiated outside the framework, you must create new entities using World.
	 * 
	 * @author Arni Arent
	 *
	 */
	public class Entity {
		private var _id : uint;
		private var _uniqueId : uint;
		private var _typeBits : uint;
		private var _systemBits : uint;
		private var _world : World;
		private var _entityManager : EntityManager;

		public function Entity(world : World, id : uint) {
			_world = world;
			_entityManager = world.getEntityManager();
			_id = id;
		}

		/**
		 * The internal id for this entity within the framework. No other entity will have the same ID, but
		 * ID's are however reused so another entity may acquire this ID if the previous entity was deleted.
		 * 
		 * @return id of the entity.
		 */
		public function getId() : uint {
			return _id;
		}

		public function setUniqueId(uniqueId : uint) : void {
			_uniqueId = uniqueId;
		}

		/**
		 * Get the unique ID of this entity. Because entity instances are reused internally use this to identify between different instances.
		 * @return the unique id of this entity.
		 */
		public function getUniqueId() : uint {
			return _uniqueId;
		}

		public function getTypeBits() : uint {
			return _typeBits;
		}

		public function addTypeBit(bit : uint) : void {
			_typeBits |= bit;
		}

		public function removeTypeBit(bit : uint) : void {
			_typeBits &= ~bit;
		}

		public function getSystemBits() : uint {
			return _systemBits;
		}

		public function addSystemBit(bit : uint) : void {
			_systemBits |= bit;
		}

		public function removeSystemBit(bit : uint) : void {
			_systemBits &= ~bit;
		}

		public function setSystemBits(systemBits : uint) : void {
			_systemBits = systemBits;
		}

		public function setTypeBits(typeBits : uint) : void {
			_typeBits = typeBits;
		}

		public function reset() : void {
			_systemBits = 0;
			_typeBits = 0;
		}

		public function toString() : String {
			return "Entity[" + _id + "]";
		}

		/**
		 * Add a component to this entity.
		 * @param component to add to this entity
		 */
		public function addComponent(component : Component) : void {
			_entityManager.addComponent(this, component);
		}

		/**
		 * Removes the component from this entity.
		 * @param component to remove from this entity.
		 */
		// public function removeComponent(component:Component):void {
		// entityManager.removeComponent(this, component);
		// }
		/**
		 * Faster removal of components from a entity.
		 * @param component to remove from this entity.
		 */
		public function removeComponent(type : ComponentType) : void {
			_entityManager.removeComponent(this, type);
		}

		/**
		 * Checks if the entity has been deleted from somewhere.
		 * @return if it's active.
		 */
		public function isActive() : Boolean {
			return _entityManager.isActive(_id);
		}

		/**
		 * This is the preferred method to use when retrieving a component from a entity. It will provide good performance.
		 * 
		 * @param type in order to retrieve the component fast you must provide a ComponentType instance for the expected component.
		 * @return
		 */
		public function getComponentByType(type : ComponentType) : Component {
			return _entityManager.getComponent(this, type);
		}

		/**
		 * Slower retrieval of components from this entity. Minimize usage of this, but is fine to use e.g. when creating new entities
		 * and setting data in components.
		 * @param <T> the expected return component type.
		 * @param type the expected return component type.
		 * @return component that matches, or null if none is found.
		 */
		public function getComponent(type : Class) : Component {
			return getComponentByType(ComponentTypeManager.getTypeFor(type));
		}

		// public function getComponent(type: Class):* {
		// //		return type.cast(getComponent(ComponentTypeManager.getTypeFor(type)));
		// return getComponent(ComponentTypeManager.getTypeFor(type));
		// }
		/**
		 * Get all components belonging to this entity.
		 * WARNING. Use only for debugging purposes, it is dead slow.
		 * WARNING. The returned bag is only valid until this method is called again, then it is overwritten.
		 * @return all components of this entity.
		 */
		// public ImmutableBag<Component> getComponents() {
		// return entityManager.getComponents(this);
		// }
		public function getComponents() : IImmutableBag {
			return _entityManager.getComponents(this);
		}

		/**
		 * Refresh all changes to components for this entity. After adding or removing components, you must call
		 * this method. It will update all relevant systems.
		 * It is typical to call this after adding components to a newly created entity.
		 */
		public function refresh() : void {
			_world.refreshEntity(this);
		}

		/**
		 * Delete this entity from the world.
		 */
		// public function delete():void {
		public function destroy() : void {
			_world.deleteEntity(this);
		}

		/**
		 * Set the group of the entity. Same as World.setGroup().
		 * @param group of the entity.
		 */
		public function setGroup(group : String) : void {
			_world.getGroupManager().set(group, this);
		}

		/**
		 * Assign a tag to this entity. Same as World.setTag().
		 * @param tag of the entity.
		 */
		public function setTag(tag : String) : void {
			_world.getTagManager().register(tag, this);
		}
	}
}
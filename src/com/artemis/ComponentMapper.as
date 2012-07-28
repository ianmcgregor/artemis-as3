package com.artemis {
	/**
	 * High performance component retrieval from entities. Use this wherever you need
	 * to retrieve components from entities often and fast.
	 * 
	 * @author Arni Arent
	 *
	 * @param <T>
	 */
	public class ComponentMapper {
		private var _type : ComponentType;
		private var _entityManager : EntityManager;
		private var _classType : Class;

		public function ComponentMapper(type : Class, world : World) {
			if (!type is Component) {
				throw new ArgumentError("type must be subclass of Component");
			}
			_entityManager = world.getEntityManager();
			_type = ComponentTypeManager.getTypeFor(type);
			_classType = type;
		}

		// TODO: should the return type be Component?
		public function get(e : Entity) : * {
			// return classType.cast(em.getComponent(e, type));
			return _entityManager.getComponent(e, _type);
		}
	}
}
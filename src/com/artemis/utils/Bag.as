package com.artemis.utils {
	// import com.artemis.Entity;
	/**
	 * Collection type a bit like ArrayList but does not preserve the order of its
	 * entities, speedwise it is very good, especially suited for games.
	 */
	// public class Bag<E> implements ImmutableBag<E> {
	public class Bag implements IImmutableBag {
		private var _data : Array;
		private var _size : uint = 0;

		/**
		 * Constructs an empty Bag with an initial capacity of 64.
		 * 
		 */
		// public function Bag() {
		// this(16);
		// }
		/**
		 * Constructs an empty Bag with the specified initial capacity.
		 * 
		 * @param capacity
		 *            the initial capacity of Bag
		 */
		// public function Bag(capacity:int = 16) {
		// data = new Object[capacity];
		public function Bag() {
			_data = new Array();
		}

		/**
		 * Removes the element at the specified position in this Bag. does this by
		 * overwriting it was last element then removing last element
		 * 
		 * @param index
		 *            the index of element to be removed
		 * @return element that was removed from the Bag
		 */
		// public function remove(index:int):E {
		public function remove(index : int) : * {
			var o : Object = _data[index];
			// make copy of element to remove so it can be
			// returned
			// FIXME: won't wprk in as3 need splice
			// data[index] = data[--_size]; // overwrite item to remove with last
			_data.splice(index, 1);
			// element
			// data[_size] = null; // null last element, so gc can do its work
			// return E(o);
			return o;
		}

		/**
		 * Remove and return the last object in the bag.
		 * 
		 * @return the last object in the bag, null if empty.
		 */
		// public function removeLast():E {
		public function removeLast() : * {
			if (_size > 0) {
				var o : Object = _data[--_size];
				_data[_size] = null;
				return o;
			}

			return null;
		}

		/**
		 * Removes the first occurrence of the specified element from this Bag, if
		 * it is present. If the Bag does not contain the element, it is unchanged.
		 * does this by overwriting it was last element then removing last element
		 * 
		 * @param o
		 *            element to be removed from this list, if present
		 * @return <tt>true</tt> if this list contained the specified element
		 */
		public function removeOb(o : *) : Boolean {
			for (var i : int = 0; i < _size; i++) {
				var o1 : Object = _data[i];

				if (o == o1) {
					// data[i] = data[--size]; // overwrite item to remove with last
					_data.splice(i, 1);
					_size--;
					// element
					// data[size] = null; // null last element, so gc can do its work
					return true;
				}
			}

			return false;
		}

		/**
		 * Check if bag contains this element.
		 * 
		 * @param o
		 * @return
		 */
		// public function contains(o:E):Boolean {
		public function contains(o : *) : Boolean {
			var l : int = _data.length;
			for (var i : int = 0; i < l; ++i) {
				if (o == _data[i]) {
					return true;
				}
			}
			return false;
		}

		/**
		 * Removes from this Bag all of its elements that are contained in the
		 * specified Bag.
		 * 
		 * @param bag
		 *            Bag containing elements to be removed from this Bag
		 * @return {@code true} if this Bag changed as a result of the call
		 */
		// public function removeAll(Bag<E> bag):Boolean {
		public function removeAll(bag : Bag) : Boolean {
			var modified : Boolean = false;

			for (var i : int = 0; i < bag.size(); i++) {
				var o1 : Object = bag.get(i);

				for (var j : int = 0; j < _size; j++) {
					var o2 : Object = _data[j];

					if (o1 == o2) {
						remove(j);
						j--;
						modified = true;
						break;
					}
				}
			}

			return modified;
		}

		/**
		 * Returns the element at the specified position in Bag.
		 * 
		 * @param index
		 *            index of the element to return
		 * @return the element at the specified position in bag
		 */
		// public function get(index:int):E {
		public function get(index : int) : * {
			return _data[index];
		}

		/**
		 * Returns the number of elements in this bag.
		 * 
		 * @return the number of elements in this bag
		 */
		public function size() : int {
			return _size;
		}

		/**
		 * Returns the number of elements the bag can hold without growing.
		 * 
		 * @return the number of elements the bag can hold without growing.
		 */
		public function getCapacity() : int {
			return _data.length;
		}

		/**
		 * Returns true if this list contains no elements.
		 * 
		 * @return true if this list contains no elements
		 */
		public function isEmpty() : Boolean {
			return _size == 0;
		}

		/**
		 * Adds the specified element to the end of this bag. if needed also
		 * increases the capacity of the bag.
		 * 
		 * @param o
		 *            element to be added to this list
		 */
		// public function add(o:E):void {
		public function add(o : *) : void {
			// is size greater than capacity increase capacity
			if (_size == _data.length) {
				grow();
			}

			_data[_size++] = o;
		}

		/**
		 * Set element at specified index in the bag.
		 * 
		 * @param index position of element
		 * @param o the element
		 */
		// public function set(index:int, o:E):void {
		public function set(index : int, o : *) : void {
			if (index >= _data.length) {
				grow(index * 2);
			}
			_size = index + 1;
			_data[index] = o;
		}

		// private function grow():void {
		// var newCapacity:int= (data.length * 3) / 2+ 1;
		// grow(newCapacity);
		// }
		private function grow(newCapacity : int = -1) : void {
			if (newCapacity == -1) newCapacity = (_data.length * 3) / 2 + 1;
			var oldData : Array = _data;
			// data = new Object[newCapacity];
			// System.arraycopy(oldData, 0, data, 0, oldData.length);
			_data = oldData.concat();
		}

		/**
		 * Removes all of the elements from this bag. The bag will be empty after
		 * this call returns.
		 */
		public function clear() : void {
			// null all elements so gc can clean up
			// for (var i : int = 0; i < _size; i++) {
			// _data[i] = null;
			// }
			_data = [];
			_size = 0;
		}

		/**
		 * Add all items into this bag. 
		 * @param added
		 */
		// public function addAll(Bag<E> items):void {
		public function addAll(items : Bag) : void {
			for (var i : int = 0; items.size() > i; i++) {
				add(items.get(i));
			}
		}
	}
}
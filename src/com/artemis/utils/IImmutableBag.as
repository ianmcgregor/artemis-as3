package com.artemis.utils {
	public interface IImmutableBag {
		function get(index : int) : *;

		function size() : int;

		function isEmpty() : Boolean;
	}
}
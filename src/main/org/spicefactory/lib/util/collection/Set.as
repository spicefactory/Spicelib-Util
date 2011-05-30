/*
 * Copyright 2011 the original author or authors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
 
package org.spicefactory.lib.util.collection {

import flash.utils.Dictionary;

/**
 * Simple Set implementation, an unordered collection that does not allow duplicates. 
 * Within the Spicefactory libraries and frameworks
 * these collections are usually only used inside the implementations, but not exposed in
 * the public APIs.
 * 
 * <p>Due to limitations in the Flash Proxy class which only accepts String-based keys,
 * the <code>Set</code> class does not support <code>for</code> and <code>for each</code> loops 
 * or bracket access for reading and writing values. For loops you can loop over <code>Set.toArray()</code>
 * instead.</p>
 * 
 * @author Jens Halm
 */	
public class Set {
	
	
	private var map:Dictionary = new Dictionary();
	private var _size:uint = 0;


	/**
	 * Creates a new instance.
	 * 
	 * @param items the items to populate the set with
	 */
	function Set (items:Array = null) {
		if (items != null) {
			for each (var item:Object in items) {
				add(item);
			}
		}
	}
	
	/**
	 * Adds the specified item to this set if it was not already present.
	 * 
	 * @param item the item to add to this set
	 * @return true if the item was added to this set or false if it was already present
	 */
	public function add (item:Object) : Boolean {
		if (map[item] === undefined) {
			map[item] = true;
			_size++;
			return true;
		}
		return false;
	}
	
	/**
	 * Removes the specified item from this set.
	 * 
	 * @param item the item to remove from this set
	 * @return true if the item was removed from this set or false if this set does not contain this item
	 */
	public function remove (item:Object) : Boolean {
		if (map[item] === undefined) {
			delete map[item];
			_size--;
			return true;
		}
		return false;
	}
	
	/**
	 * Removes all items from this set.
	 */
	public function removeAll () : void {
		map = new Dictionary();
		_size = 0;
	}
	
	/**
	 * Indicates whether this set is empty.
	 * 
	 * @return true if this set does not contain any items.
	 */
	public function isEmpty () : Boolean {
		return (_size == 0);
	}
	
	/**
	 * Returns the number of items in this set.
	 * 
	 * @return the number of items in this set
	 */
	public function size () : uint {
		return _size;
	}
	
	/**
	 * Indicates whether this set contains the specified item.
	 * 
	 * @param item the item to check
	 * @return true if this set contains the specified item  
	 */
	public function contains (item:Object) : Boolean {
		return (map[item] === true);
	}
	
	/**
	 * Clones this set. Modifications in the clone are not reflected
	 * in the original set and vice versa.
	 * 
	 * @return a clone of this set
	 */	
	public function clone () : Set {
		return new Set(toArray());	
	}
	
	/**
	 * Returns the items of this set in no particular order as an Array.
	 * 
	 * @return the items of this set as an Array
	 */
	public function toArray () : Array {
		var a:Array = new Array();
		for (var key:Object in map) {
			a.push(key);
		}
		return a;
	}
	
	
}
}

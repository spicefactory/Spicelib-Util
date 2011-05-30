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

/**
 * Map implementation that maps each key to one or more items. 
 * Within the Spicefactory libraries and frameworks
 * these collections are usually only used inside the implementations, but not exposed in
 * the public APIs.
 * 
 * <p>Due to limitations in the Flash Proxy class which only accepts String-based keys,
 * the <code>MultiMap</code> class does not support <code>for</code> and <code>for each</code> loops 
 * or bracket access for reading and writing values. For loops you can loop over <code>MultiMap.keys</code>
 * instead.</p>
 * 
 * @author Jens Halm
 */		
public class MultiMap {


	private var map : Map;

	
	/**
	 * Creates a new instance.
	 */
	public function MultiMap () {
		map = new Map();
	}

	/**
	 * Adds a value to the list of items mapped to the specified key.
	 * 
	 * @param key the key the list of items is mapped to
	 * @param value the value to add to the list of objects mapped to the specified key
	 */
	public function add (key:Object, value:*) : void {
		var l:List = map.get(key);
		if (!l) {
			l = new List();
			map.put(key, l); 
		}
		l.add(value);
	}
	
	/**
	 * Returns all items mapped to the specified key as a List.
	 * 
	 * @param key the key to return all mapped items for
	 * @return all items mapped to the specified key as a List
	 */
	public function getAll (key:Object) : List {
		var l:List = map.get(key);
		return (l != null) ? l : new List();
	}
	
	/**
	 * Removes a value from the list of items mapped to the specified key.
	 * 
	 * @param key the key the list of items is mapped to
	 * @param value the value to remove from the list of objects mapped to the specified key
	 */
	public function remove (key:Object, value:*) : void {
		var l:List = map.get(key);
		if (l != null) {
			l.remove(value);
			if (l.isEmpty()) {
				map.remove(key);
			}
		}
	}
	
	/**
	 * Removes all items mapped to the specified key.
	 * 
	 * @param key the key to remove
	 */
	public function removeKey (key:Object) : void {
		map.remove(key);
	}
	
	/**
	 * Removes all items from this map.
	 */
	public function removeAll () : void {
		map.removeAll();
	}
	
	/**
	 * Indicates whether this map is empty.
	 * 
	 * @return true if this map does not contain any items.
	 */
	public function isEmpty () : Boolean {
		return map.isEmpty();
	}
	
	/**
	 * Returns the number of keys in this map.
	 * 
	 * @return the number of keys in this map
	 */
	public function size () : uint {
		return map.size();
	}
	
	/**
	 * Indicates whether this map contains at least one value mapped to the specified key.
	 * 
	 * @param key the key to check
	 * @return true if this map contains at least one value mapped to the specified key  
	 */
	public function containsKey (key:Object) : Boolean {
		return map.containsKey(key);
	}
	
	/**
	 * All keys of this map in no particular oder.
	 */
	public function get keys () : List {
		return map.keys;
	}
	
		
}
	
}
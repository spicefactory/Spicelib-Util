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
 * Simple Map implementation that overcomes the limitations of the Flash Dictionary API which
 * lacks essential methods and properties like size/length. Within the Spicefactory libraries and frameworks
 * these collections are usually only used inside the implementations, but not exposed in
 * the public APIs.
 * 
 * <p>Due to limitations in the Flash Proxy class which only accepts String-based keys,
 * the <code>Map</code> class does not support <code>for</code> and <code>for each</code> loops 
 * or bracket access for reading and writing values. For loops you can loop over <code>Map.keys</code>
 * or <code>Map.values</code> instead.</p>
 * 
 * @author Jens Halm
 */		
public class Map {
	
		
	private var map:Dictionary;
	private var _size:uint = 0;


	/**
	 * Creates a new instance.
	 * 
	 * @param dictionary the dictionry to initially populate the map with
	 */
	function Map (dictionary:Dictionary = null) {
		map = dictionary || new Dictionary();
	}
	
	
	/**
	 * Adds a value for the specified key.
	 * If there was already a value mapped for this key,
	 * this method will remove it from the map and return it.
	 * Otherwise this method returns undefined.
	 * 
	 * @param key the key to map the value to
	 * @param value the value to add
	 * @return the value previously mapped to the key or undefined
	 */
	public function put (key:Object, value:*) : * {
		if (value === undefined) {
			return undefined;
		}
		var oldValue:* = remove(key);
		_size++;
		map[key] = value;
		return oldValue;
	}
	
	/**
	 * Returns the value mapped to the specified key or undefined.
	 * 
	 * @param key the key to return the mapped value for
	 * @return the value mapped to the specified key or undefined
	 */
	public function get (key:Object) : * {
		return map[key];
	}
	
	/**
	 * Removes and returns the value mapped to the specified key.
	 * 
	 * @param key the key to remove from the map
	 * @return the value previously mapped to the specified key or undefined
	 */
	public function remove (key:Object) : * {
		var oldValue:* = get(key);
		if (oldValue !== undefined) {
			_size--;
			delete map[key];
		}
		return oldValue;
	}
	
	/**
	 * Removes all keys and values from this map.
	 */
	public function removeAll () : void {
		map = new Dictionary();
		_size = 0;
	}
	
	/**
	 * Indicates whether this map is empty.
	 * 
	 * @return true if this map does not contain any items.
	 */
	public function isEmpty () : Boolean {
		return (_size == 0);
	}
	
	/**
	 * Returns the number of items in this map.
	 * 
	 * @return the number of items in this map
	 */
	public function size () : uint {
		return _size;
	}
	
	/**
	 * Indicates whether this map contains a value mapped to the specified key.
	 * 
	 * @param key the key to check
	 * @return true if this map contains a value mapped to the specified key  
	 */
	public function containsKey (key:Object) : Boolean {
		return (map[key] !== undefined);
	}
	
	/**
	 * Indicates whether this map contains the specified value at least once.
	 * 
	 * @param value the value to check
	 * @return true if this map contains the specified value at least once  
	 */
	public function containsValue (value : *) : Boolean {
		for each (var nextValue:* in map) {
			if (nextValue == value) return true;
		}	
		return false;
	}
	
	/**
	 * All keys of this map in no particular oder.
	 */
	public function get keys () : List {
		var l:List = new List();
		for (var key:Object in map) {
			l.add(key);
		}
		return l;		
	}
	
	/**
	 * All values of this map in no particular order.
	 */
	public function get values () : List {
		var l:List = new List();
		for each (var value:* in map) {
			l.add(value);
		}
		return l;		
	}	
	
	/**
	 * Clones this map. Modifications in the clone are not reflected
	 * in the original map and vice versa.
	 * 
	 * @return a clone of this map
	 */
	public function clone () : Map {
		return new Map(toDictionary());	
	}
	
	/**
	 * Returns this map as a Dictionary.
	 * 
	 * @return this map as a Dictionary
	 */
	public function toDictionary () : Dictionary {
		var d:Dictionary = new Dictionary();
		for (var key:Object in map) {
			d[key] = map[key];
		}
		return d;
	}
	
		
}
	
}
/*
 * Copyright 2007 the original author or authors.
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
 * @private
 * Temporary implementation, will be removed in later versions. Do not use in application code.
 * 
 * @author Jens Halm
 */		
public class SimpleMap {
	
		
	private var _map : Dictionary;
	private var _size:uint;


	
	public function SimpleMap () {
		init();
	}
	
	private function init () : void {
		_map = new Dictionary();
		_size = 0;		
	}
	
	public function put (key : String, value:*) : * {
		var oldValue:* = remove(key);
		var entry:MapEntry = new MapEntry(key, value);
		//_map[key] = entry;
		putEntry(entry);
		_size++;
		return oldValue;
	}
	
	public function get (key : String) : * {
		var entry:MapEntry = getEntry(key);
		return (entry != null) ? entry.value : null;
	}
	
	public function remove (key : String) : * {
		var entry:MapEntry = getEntry(key);
		if (entry == null) return null;
		_size--;
		removeEntry(key);
		return entry.value;
	}
	
	public function removeAll () : void {
		init();
	}
	
	public function isEmpty () : Boolean {
		return (_size == 0);
	}
	
	public function getSize () : uint {
		return _size;
	}
	
	public function containsKey (key : String) : Boolean {
		return (getEntry(key) != null);
	}
	
	public function containsValue (value : *) : Boolean {
		for each (var entry:MapEntry in _map) {
			if (entry.value == value) return true;
		}	
		return false;
	}
	
	public function get keys () : Array {
		var arr:Array = new Array();
		for (var key:String in _map) {
			arr.push(key.substring(1));
		}
		return arr;		
	}
	
	public function get values () : Array {
		var arr:Array = new Array();
		for each (var entry:MapEntry in _map) {
			arr.push(entry.value);
		}
		return arr;		
	}		
	
	public function get entries () : Array {
		var arr:Array = new Array();
		for each (var entry:MapEntry in _map) {
			arr.push(entry);
		}
		return arr;				
	}
	
	
	private function getEntry (key:String) : MapEntry {
		return MapEntry(_map["$" + key]);
	}
	
	private function putEntry (entry:MapEntry) : void {
		_map["$" + entry.key] = entry;
	}
	
	private function removeEntry (key:String) : void {
		delete _map["$" + key];
	}
		
}
	
}
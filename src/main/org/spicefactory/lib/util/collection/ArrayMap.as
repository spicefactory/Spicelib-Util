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
import org.spicefactory.lib.util.ArrayUtil;

/**
 * @private
 * Temporary implementation, will be removed in later versions. Do not use in application code.
 * 
 * @author Jens Halm
 */		
public class ArrayMap {

	
	private var map : SimpleMap;

	
	public function ArrayMap () {
		this.map = new SimpleMap();
	}

	
	public function put (key : String, value:*) : void {
		var arr:Array = map.get(key);
		if (arr == null) {
			arr = new Array();
			map.put(key, arr); 
		}
		arr.push(value);
	}
	
	public function getAll (key : String) : Array {
		var arr:Array = map.get(key);
		return (arr != null) ? arr : [];
	}
	
	public function remove (key : String, value:*) : void {
		var arr:Array = map.get(key);
		if (arr != null) {
			ArrayUtil.remove(arr, value);
			if (arr.length == 0) {
				map.remove(key);
			}
		}
	}
	
	public function removeAll (key : String) : void {
		map.remove(key);
	}
	
	public function clear () : void {
		map.removeAll();
	}
	
	public function get empty () : Boolean {
		return map.isEmpty();
	}
	
	public function get keyCount () : uint {
		return map.getSize();
	}
	
	public function getSize (key : String) : uint {
		return getAll(key).length;
	}
	
	public function containsKey (key : String) : Boolean {
		return map.containsKey(key);
	}
	
	public function get keys () : Array {
		return map.keys;
	}
	
	public function get entries () : Array {
		return map.entries;	
	}
	

		
}
	
}
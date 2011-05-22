/*
 * Copyright 2008 the original author or authors.
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

package org.spicefactory.lib.util {
import flash.utils.Dictionary;

/**
 * Wraps a weakly referenced instance. Uses a <code>flash.utils.Dictionary</code> with the wrapped instance as the
 * single key internal. If this weak reference is the only reference left, it is eligible for garbage collection.
 * 
 * @author Jens Halm
 */
public class WeakReference {
	
	
	private var _dictionary:Dictionary;
	
	
	/**
	 * Creates a new instance.
	 * 
	 * @param reference the instance to wrap weakly referenced
	 */
	function WeakReference (reference:Object) {
		_dictionary = new Dictionary(true);
		_dictionary[reference] = true;
	}
	
	
	/**
	 * The wrapped instance. 
	 * The property is null if the wrapped instance was already garbage collected. 
	 */
	public function get value () : Object {
		for (var reference:Object in _dictionary) {
			return reference;			
		}
		return null;
	}
	
	
}

}

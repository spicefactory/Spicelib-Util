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
 
package org.spicefactory.lib.util {

/**
 * Static utility methods for Arrays.
 * 
 * @author Jens Halm
 */
public class ArrayUtil {

	/**
	 * Removes the specified instance from the Array.
	 * 
	 * @param arr the Array to remove the element from
	 * @param element the element to remove
	 * @return true if the Array contained the specified element 
	 */
	public static function remove (arr:Array, element:*) : Boolean {
		var index:int = arr.indexOf(element);
		if (index > -1) {
			arr.splice(index, 1);
			return true;
		}
		return false;
	}
	
	[Deprecated(replacement="Array.indexOf")]
	public static function indexOf (arr:Array, element:*) : int {
		return arr.indexOf(element);
	}	

	[Deprecated(replacement="Array.lastIndexOf")]
	public static function lastIndexOf (arr:Array, element:*) : int {
		return arr.lastIndexOf(element);
	}	

	[Deprecated(replacement="Array.indexOf")]
	public static function contains (arr:Array, element:*) : Boolean {
		return  (arr.indexOf(element) != -1);
	}	

}
	
}
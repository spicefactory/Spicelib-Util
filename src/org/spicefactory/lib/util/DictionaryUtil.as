/*
 * Copyright 2010 the original author or authors.
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
 * Static utility methods for Arrays.
 * 
 * @author Jens Halm
 */
public class DictionaryUtil {

	/**
	 * Checks whether specified Dictionary does not contain any elements.
	 * 
	 * @param dict the Dictionary to examine
	 * @return true if the Dictionary does not contain any elements
	 */		
	public static function isEmpty (dict:Dictionary) : Boolean {
		for each (var o:Object in dict) {
			return false;
		}
		return true;
	}	

}
	
}
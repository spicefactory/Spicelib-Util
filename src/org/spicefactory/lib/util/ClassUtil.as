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
import org.spicefactory.lib.errors.IllegalArgumentError;

import flash.system.ApplicationDomain;
import flash.utils.getDefinitionByName;
import flash.utils.getQualifiedClassName;

/**
 * Static utility methods to reflectively create new instances.
 * 
 * @author Jens Halm
 */
public class ClassUtil {
	
	
	/**
	 * Creates a new instance of the class with the specified name.
	 * 
	 * @param className the fully qualified name of the class
	 * @param params the parameters to pass to the constructor of the class
	 * @return the new instance
	 * @throws ReferenceError if the class with the specified name does not exist
	 */
	public static function createForName (className:String, params:Array) : Object {
		var Clazz:Class = getDefinitionByName(className) as Class;
		return createNewInstance(Clazz, params);
	}

	/**
	 * Creates a new instance of the specified class.
	 * 
	 * @param type the class to create a new instance of
	 * @param params the parameters to pass to the constructor of the class
	 * @return the new instance
	 */
	public static function createNewInstance (type:Class, params:Array) : Object {
		switch (params.length) {
			// Now this is really stupid. But there is no "Class.createInstance(args)" in AS3
			case 0: return new type();
			case 1: return new type(params[0]);
			case 2: return new type(params[0], params[1]);
			case 3: return new type(params[0], params[1], params[2]);
			case 4: return new type(params[0], params[1], params[2], params[3]);
			case 5: return new type(params[0], params[1], params[2], params[3], params[4]);
			case 6: return new type(params[0], params[1], params[2], params[3], params[4], params[5]);
			case 7: return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
			case 8: return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
			default: throw new IllegalArgumentError("Unsupported number of Constructor args: " + params.length);
		}
	}
	
	/**
	 * Checks whether the specified ApplicationDomain contains the definition for the given instance.
	 * 
	 * @param domain the ApplicationDomain to check
	 * @param instance the instance to look for
	 * @return true if the specified ApplicationDomain contains the definition for the given instance
	 */
	public static function containsDefinition (domain:ApplicationDomain, instance:Object) : Boolean {
		var className:String = getQualifiedClassName(instance);
		if (domain.hasDefinition(className)) {
			var clazz:Class = domain.getDefinition(className) as Class;
			if (instance is clazz) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * Returns the unqualified short name of the specified class.
	 * 
	 * @param type the class to return the unqualified short name for
	 * @return the unqualified short name of the specified class
	 */
	public static function getSimpleName (type:Class) : String {
		var name:String = getQualifiedClassName(type).replace("::", ".");
		return name.substring(name.lastIndexOf(".") + 1);
	}
	
}

}
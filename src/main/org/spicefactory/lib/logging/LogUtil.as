/*
 * Copyright 2009 the original author or authors.
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

package org.spicefactory.lib.logging {

import org.spicefactory.lib.util.StringUtil;

import flash.events.ErrorEvent;
import flash.utils.getQualifiedClassName;

/**
 * Static utility methods for logging.
 * 
 * @author Jens Halm
 */
public class LogUtil {
	
	
	/**
	 * Retutns the name for a logger as a String based on the specified object.
	 * If the name parameter is a Class
	 * instance, the fully qualified class name will be used. Otherwise the <code>toString</code>
	 * method will be invoked on the given name instance.
	 */
	public static function getLogName (object:Object) : String {
		if (object is Class) {
			return getQualifiedClassName(object);
		} else {
			return object.toString();
		}
	}
	
	/**
	 * Builds the log message from the specified message and parameters.
	 * The message may contain numbered placeholders like '{0}' which will be replaced by the
	 * specified parameters. For parameters of type Error the whole stacktrace will be included.
	 * 
	 * @param message the message, possibly containing parameter placeholders
	 * @param params the parameters to fill the placeholders with
	 * @return the fully resolved log message 
	 */
	public static function buildLogMessage (message:String, params:Array) : String {
		if (params == null) return message;
		for (var i:int = 0; i < params.length; i++) {
			var param:* = params[i];
			if (param is Error || param is ErrorEvent) {
				param = "\n" + StringUtil.formatError(param);
			}
			message = message.replace(new RegExp("\\{"+ i +"\\}", "g"), param);
		}
		return message;
	}
	
	
}
}

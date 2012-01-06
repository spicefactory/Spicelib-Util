/*
 * Copyright 2012 the original author or authors.
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

import flash.events.ErrorEvent;
import flash.utils.getQualifiedClassName;
	
/**
 * Static utility methods for Strings.
 * 
 * @author Jens Halm
 */
public class StringUtil {
	
	
	/**
	 * Builds a string from the specified message and parameters.
	 * The message may contain numbered placeholders like '{0}' which will be replaced by the
	 * specified parameters. For parameters of type Error special formatting will get applied 
	 * (showing the whole stacktrace in the debug player, the message in the release player).
	 * 
	 * @param message the message, possibly containing parameter placeholders
	 * @param params the parameters to fill the placeholders with
	 * @return the fully resolved string 
	 */
	public static function format (message: String, ...params) : String {
		if (params == null) return message;
		for (var i:int = 0; i < params.length; i++) {
			var param:* = params[i];
			if (param is Error || param is ErrorEvent) {
				param = "\n" + formatError(param);
			}
			message = message.replace(new RegExp("\\{"+ i +"\\}", "g"), param);
		}
		return message;
	}
	
	
	/**
	 * Builds a string from the specified error.
	 * This utility method applies special formatting for Error and ErrorEvent types.
	 * For unknown types it will simply call <code>toString()</code>.
	 * 
	 * @param cause the cause of the error to format
	 * @return the fully resolved string
	 */
	public static function formatError (cause: Object) : String {
		if (cause is Error) {
			var e: Error = cause as Error;
			var stacktrace: String = e.getStackTrace(); // will be null in release players
			return stacktrace || "[" + getQualifiedClassName(e) + ": " + e.message + "]";
		}
		else if (cause is ErrorEvent) {
			return "[" + getQualifiedClassName(e) + ": " + ErrorEvent(cause).text + "]";
		}
		else {
			return cause ? cause.toString() : "[null]";
		}
	}
	
	
}
}

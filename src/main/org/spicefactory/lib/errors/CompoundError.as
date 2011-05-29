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

package org.spicefactory.lib.errors {
import flash.events.ErrorEvent;

/**
 * Base Error implementation that allows to specify multiple causes.
 * 
 * @author Jens Halm
 */
public class CompoundError extends Error {
	
	
	private var _causes:Array;
	

	/**
	 * Creates a new instance.
	 * 
	 * @param message the error message
	 * @param causes the causes of this Error
	 * @param id an optional reference number
	 */
	function CompoundError (message:String = "", causes:Array = null, id:int = 0) {
		super(getMessage(message, causes), id);
		_causes = (causes) ? causes : [];
	}
	
	private function getMessage (message:String, causes:Array) : String {
		if (causes == null || causes.length == 0) {
			return message;
		}
		else {
			return message + ": " + causes.length + " cause(s)";
		}
	}
	
	
	/**
	 * The causes of this Error, may be an empty Array.
	 * The causes are the original Errors that caused this Error to get thrown.
	 */
	public function get causes () : Array {
		return _causes;
	}
	

	/**
	 * @private
	 */
	public override function getStackTrace () : String {
		var txt:String = super.getStackTrace();
		if (causes.length > 0) {
			for (var i:int = 0; i < causes.length; i++) {
				txt += "\n Cause(" + i + "): ";
				var c:Object = causes[i];
				if (c is Error) {
					txt += (c as Error).getStackTrace();
				}
				else if (c is ErrorEvent) {
					txt += (c as ErrorEvent).text;
				}
				else {
					txt += c.toString();
				}
			}
		}
		return txt;
	}
	
	
}

}

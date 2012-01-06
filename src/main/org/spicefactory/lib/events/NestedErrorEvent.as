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

package org.spicefactory.lib.events {

import org.spicefactory.lib.util.StringUtil;

import flash.events.ErrorEvent;
import flash.events.Event;

/**
 * Base <code>ErrorEvent</code> implementation that allows to specify a cause.
 * 
 * @author Jens Halm
 */
public class NestedErrorEvent extends ErrorEvent {
	
	
	private var _cause:Object;
	

	/**
	 * Creates a new instance.
	 * 
	 * @param type the type of the event
	 * @param cause the cause of this ErrorEvent
	 * @param text the error message
	 * @param bubbles indicates whether the Event object bubbles
	 * @param cancelable indicates whether the Event object can be canceled
	 */
	function NestedErrorEvent (type:String, cause:Object = null, text:String = "",
			bubbles : Boolean = false, cancelable : Boolean = false) {
		super(type, bubbles, cancelable, text);
		_cause = cause;
	}
	
	
	/**
	 * The cause of this ErrorEvent, may be null.
	 * Permitted types are <code>Error</code> and <code>ErrorEvent</code> or any other type
	 * with a meaningful String representation. For these other types
	 * the <code>toString</code> method will be invoked to construct the value of the <code>text</code>
	 * property.
	 */
	public function get cause () : Object {
		return _cause;
	}	

	/**
	 * @private
	 */
	public override function get text () : String {
		var txt:String = super.text;
		if (cause != null) {
			txt += " - cause: ";
			txt += StringUtil.formatError(cause);
		}
		return txt;
	}
	
	
	public override function clone () : Event {
		return new NestedErrorEvent(type, cause, super.text, bubbles, cancelable);
	}
	
	
}

}

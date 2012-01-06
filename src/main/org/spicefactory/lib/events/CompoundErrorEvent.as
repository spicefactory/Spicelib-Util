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
 * Base ErrorEvent implementation that allows to specify multiple causes.
 * 
 * @author Jens Halm
 */
public class CompoundErrorEvent extends ErrorEvent {
	
	
	private var _causes:Array;
	

	/**
	 * Creates a new instance.
	 * 
	 * @param type the type of the event
	 * @param causes the causes of this ErrorEvent
	 * @param text the error message
	 * @param bubbles indicates whether the Event object bubbles
	 * @param cancelable indicates whether the Event object can be canceled
	 */
	function CompoundErrorEvent (type:String, causes:Array = null, text:String = "",
			bubbles : Boolean = false, cancelable : Boolean = false) {
		super(type, bubbles, cancelable, text);
		_causes = (causes) ? causes : [];
	}
	
	
	/**
	 * The causes of this ErrorEvent, may be an empty Array.
	 * Permitted types are <code>Error</code> and <code>ErrorEvent</code> or any other type
	 * with a meaningful String representation. For these other types
	 * the <code>toString</code> method will be invoked to construct the value of the <code>text</code>
	 * property.
	 */
	public function get causes () : Array {
		return _causes;
	}	

	/**
	 * @private
	 */
	public override function get text () : String {
		var txt:String = super.text;
		if (causes.length > 0) {
			txt += ": " + causes.length + " cause(s)";
			for (var i:int = 0; i < causes.length; i++) {
				txt += "\n Cause(" + i + "): ";
				txt += StringUtil.formatError(causes[i]);
			}
		}
		return txt;
	}
	
	
	public override function clone () : Event {
		return new NestedErrorEvent(type, causes, text, bubbles, cancelable);
	}
	
	
}

}

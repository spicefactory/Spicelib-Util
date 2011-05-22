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
import flash.events.TimerEvent;
import flash.utils.Timer;

/**
 * A type of DelegateChain that invokes the Delegates after a specified delay.
 * 
 * @author Jens Halm
 */
public class DelayedDelegateChain extends DelegateChain {
	
	
	private var timer:Timer;
	
	
	/**
	 * Creates a new instance.
	 * 
	 * @param delay the delay in milliseconds after which this chain will execute
	 */
	function DelayedDelegateChain (delay:int) {
		super();
		timer = new Timer(delay, 1);
		timer.addEventListener(TimerEvent.TIMER, onTimer);
		timer.start();
	}
	
	private function onTimer (event:TimerEvent) : void {
		timer = null;
		invoke();
	}
	
	
}
}

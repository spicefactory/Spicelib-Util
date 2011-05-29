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
 * A DelegateChain invokes multiple Delegate sequentially. 
 * DelegateChain is itself a subclass of Delegate (Composite Design Pattern) and
 * can be part of other DelegateChains.
 * 
 * @author Jens Halm
 */
public class DelegateChain extends Delegate {
	
	
	private var delegates:Array;

	/**
	 * Creates a new empty DelegateChain.
	 */
	public function DelegateChain () {
		super(invokeChain);
		delegates = new Array();
	}
	
	/**
	 * Adds the specified Delegate to this DelegateChain.
	 * 
	 * @param com the Delegate to add
	 */
	public function addDelegate (com:Delegate) : void {
		delegates.push(com);
	}
	
	/**
	 * Removes the specified Delegate from this DelegateChain.
	 * 
	 * @param com the Delegate to remove
	 */
	public function removeDelegate (com:Delegate) : void {
		var index:int = delegates.indexOf(com);
		if (index >= 0) delegates.splice(index, 1);
	}
	
	/**
	 * Checks whether this DelegateChain is empty (does not contain any Delegate).
	 * 
	 * @return true if this DelegateChain does not contain any Delegate
	 */
	public function isEmpty () : Boolean {
		return (delegates.length == 0);
	}
	
	/**
	 * Removes all Delegates from this DelegateChain.
	 */
	public function clear () : void {
		delegates = new Array();
	}
	
	private function invokeChain () : void {
		for (var i:int = 0; i < delegates.length; i++) {
			Delegate(delegates[i]).invoke();
		}
	}
	
	/**
	 * Creates a clone of this DelegateChain.
	 * 
	 * @return a new DelegateChain that contains the same Delegate as this DelegateChain
	 */
	public function clone () : DelegateChain {
		var cc:DelegateChain = new DelegateChain();
		cc.delegates = delegates.concat();
		return cc;
	}
	
}

}
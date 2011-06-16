/*
 * Copyright 2011 the original author or authors.
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
 
package org.spicefactory.lib.collection {

import org.spicefactory.lib.errors.IllegalArgumentError;
import flash.errors.IllegalOperationError;
import org.spicefactory.lib.util.ArrayUtil;

import flash.utils.Proxy;
import flash.utils.flash_proxy;
	

/**
 * Simple List implementation that overcomes the limitations of the Array API which
 * lacks essential methods like remove. Within the Spicefactory libraries and frameworks
 * these collections are usually only used inside the implementations, but not exposed in
 * the public APIs.
 * 
 * <p>The <code>List</code> class supports <code>for</code> and <code>for each</code> loops 
 * as well as bracket access for reading and writing values.</p>
 * 
 * @author Jens Halm
 */	
public class List extends Proxy {

	
	private var items:Array;
	
	
	/**
	 * Creates a new instance.
	 * 
	 * @param items the items to populate the list with
	 */
	function List (items:Array = null) {
		this.items = items || new Array();
	}
	
	private function assertRange (index:uint) : void {
		if (index < 0 || index > items.length) {
			throw new RangeError("Index out of range: " + index);
		}
	}
	
	private function assertNotEmpty () : void {
		if (items.length == 0) {
			throw new RangeError("List is empty");
		}
	}

	/**
	 * Adds the specified item to this list, appending it as the last item.
	 * 
	 * @param item the item to add to this list
	 */
	public function add (item:*) : void {
		items.push(item);
	}
	
	/**
	 * Inserts a new item at the specified index. 
	 * 
	 * @param index the 0-based index to insert the item at
	 * @param item the item to insert
	 */
	public function insert (index:uint, item:*) : void {
		assertRange(index);
		items.splice(index, 0, item);
	}
	
	/**
	 * Indicates whether this list contains the specified item.
	 * 
	 * @param item the item to check
	 * @return true if this list contains the specified item  
	 */
	public function contains (item:*) : Boolean {
		return (items.indexOf(item) >= 0);
	}
	
	/**
	 * Indicates whether this list is empty.
	 * 
	 * @return true if this list does not contain any items.
	 */
	public function isEmpty () : Boolean {
		return (items.length == 0);
	}
	
	/**
	 * Returns the number of items in this list.
	 * 
	 * @return the number of items in this list
	 */
	public function size () : uint {
		return items.length;
	}
	
	/**
	 * Returns the index of the specified item or -1 if it is not in this list.
	 * 
	 * @param item the item to return the index for
	 * @return the index of the specified item or -1 if it is not in this list
	 */
	public function indexOf (item:*) : int {
		return items.indexOf(item);
	}
	
	/**
	 * Removes the specified item from this list.
	 * 
	 * @param item the item to remove from this list
	 * @return true if this list contained the specified item
	 */
	public function remove (item:*) : Boolean {
		return ArrayUtil.remove(items, item);
	}
	
	/**
	 * Removes and returns the item at the specified index.
	 * 
	 * @param index the index to remove an item at
	 * @return the removed item
	 */
	public function removeAt (index:uint) : * {
		assertRange(index);
		var item:* = items[index];
		items.splice(index, 1);
		return item;
	}
	
	/**
	 * Removes all items from this list.
	 */
	public function removeAll () : void {
		items = new Array();
	}
	
	/**
	 * Removes and returns the first item from this list.
	 * 
	 * @return the removed item
	 */
	public function removeFirst () : * {
		assertNotEmpty();
		return removeAt(0);
	}
	
	/**
	 * Removes and returns the last item from this list.
	 * 
	 * @return the removed item
	 */
	public function removeLast () : * {
		assertNotEmpty();
		return removeAt(items.length - 1);		
	}
	
	/**
	 * Returns the first item from this list.
	 * 
	 * @return the first item in this list
	 */
	public function getFirst () : * {
		assertNotEmpty();
		return items[0];
	}
	
	/**
	 * Returns the last item from this list.
	 * 
	 * @return the last item in this list
	 */
	public function getLast () : * {
		assertNotEmpty();
		items[items.length - 1];
	}
	
	/**
	 * Sorts the elements in this list, delegating to the sort method
	 * of the underlying Array.
	 * 
	 * @param compareFunction a comparison function as expected by Array.sort
	 * @param options one or more options as accepted by Array.sort
	 */
	public function sort (compareFunction:Function, options:uint = 0) : void {
		items.sort(compareFunction, options);
	}
	
	/**
	 * Sorts the elements in this list according to the values of the specified
	 * properties, delegating to the sortOn method of the underlying Array.
	 * 
	 * @param propertyNames a list of property names with the first element representing the primary sort field
	 * @param options one or more options as accepted by Array.sortOn
	 */
	public function sortOn (propertyNames:Array, options:uint) : void {
		items.sortOn(propertyNames, options);
	}
	
	/**
	 * Clones this list. Modifications in the clone are not reflected
	 * in the original list and vice versa.
	 * 
	 * @return a clone of this list
	 */
	public function clone () : List {
		return new List(items.concat());
	}
	
	/**
	 * Returns the items of this list as an Array.
	 * 
	 * @return the items of this list as an Array
	 */
	public function toArray () : Array {
		return items.concat();
	}
	
	private function indexFromName (name:*) : uint {
		if (name is QName) {
			name = QName(name).localName;
		}
		var index:Number = Number(name);
		if (isNaN(index)) {
			throw new IllegalArgumentError("Index not a number: " + name);
		}
		assertRange(index);
		return index;
	}
	
    /**
     *  @private
     */
    override flash_proxy function getProperty(name:*):*
    {
        return items[indexFromName(name)];
    }
    
    /**
     *  @private
     */
    override flash_proxy function setProperty(name:*, value:*):void
    {
        items[indexFromName(name)] = value;
    }
    
    /**
     *  @private
     */
    override flash_proxy function hasProperty(name:*):Boolean
    {
        if (!(name is int) && !(name is uint)) {
			return false;
		}
		var index:int = int(name);
        return index >= 0 && index < items.length;
    }

    /**
     *  @private
     */
    override flash_proxy function nextNameIndex(index:int):int
    {
        return index < items.length ? index + 1 : 0;
    }
    
    /**
     *  @private
     */
    override flash_proxy function nextName(index:int):String
    {
        return (index - 1).toString();
    }
    
    /**
     *  @private
     */
    override flash_proxy function nextValue(index:int):*
    {
        return items[index - 1];
    }    

    /**
     *  @private
     */
    override flash_proxy function callProperty(name:*, ... rest):*
    {
        throw new IllegalOperationError("Unknown method: " + name);
    }
	
	
}

}
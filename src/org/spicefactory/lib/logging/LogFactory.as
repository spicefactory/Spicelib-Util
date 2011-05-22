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
 
package org.spicefactory.lib.logging {

/**
 * Factory interface of the Spicelib Log Wrapper API. Depending on the type of Application
 * implementations will delegate to the Flex Logging API or to the Spicelib Flash Logging Framework.
 * 
 * @author Jens Halm
 */	
public interface LogFactory {
	
	/**
	 * Returns the logger for the specified name. If the name parameter is a Class
	 * instance, the fully qualified class name will be used. Otherwise the <code>toString</code>
	 * method will be invoked on the given name instance.
	 * 
	 * @param name the name of the logger
	 * @return the logger for the specified name
	 */
	function getLogger (name:Object) : Logger;
	
}

}
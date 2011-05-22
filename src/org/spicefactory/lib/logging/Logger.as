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
 * The Logger interface of the Spicelib Log Wrapper API. Depending on the type of Application
 * implementations will delegate to the Flex Logging API or to the Spicelib Flash Logging Framework.
 * 
 * @author Jens Halm
 */
public interface Logger {
	
	/**
	 * The name of the logger.
	 */
	function get name () : String;
	
	/**
	 * Checks whether the log level <code>TRACE</code> is active for this Logger.
	 * 
	 * @return true if the log level <code>TRACE</code> is active for this Logger
	 */
	function isTraceEnabled () : Boolean;

	/**
	 * Checks whether the log level <code>DEBUG</code> is active for this Logger.
	 * 
	 * @return true if the log level <code>DEBUG</code> is active for this Logger
	 */	
	function isDebugEnabled () : Boolean;

	/**
	 * Checks whether the log level <code>INFO</code> is active for this Logger.
	 * 
	 * @return true if the log level <code>INFO</code> is active for this Logger
	 */	
	function isInfoEnabled () : Boolean;

	/**
	 * Checks whether the log level <code>WARN</code> is active for this Logger.
	 * 
	 * @return true if the log level <code>WARN</code> is active for this Logger
	 */	
	function isWarnEnabled () : Boolean;

	/**
	 * Checks whether the log level <code>ERROR</code> is active for this Logger.
	 * 
	 * @return true if the log level <code>ERROR</code> is active for this Logger
	 */	
	function isErrorEnabled () : Boolean;

	/**
	 * Checks whether the log level <code>FATAL</code> is active for this Logger.
	 * 
	 * @return true if the log level <code>FATAL</code> is active for this Logger
	 */	
	function isFatalEnabled () : Boolean;

	/**
	 * Logs a message with the <code>TRACE</code> log level.
	 * 
	 * @param message the log message
	 * @param error an optional Error instance associated with the log message.
	 */
	function trace (message:String, ...rest) : void;

	/**
	 * Logs a message with the <code>DEBUG</code> log level.
	 * 
	 * @param message the log message
	 * @param error an optional Error instance associated with the log message.
	 */		
	function debug (message:String, ...rest) : void;

	/**
	 * Logs a message with the <code>INFO</code> log level.
	 * 
	 * @param message the log message
	 * @param error an optional Error instance associated with the log message.
	 */	
	function info (message:String, ...rest) : void;

	/**
	 * Logs a message with the <code>WARN</code> log level.
	 * 
	 * @param message the log message
	 * @param error an optional Error instance associated with the log message.
	 */	
	function warn (message:String, ...rest) : void;

	/**
	 * Logs a message with the <code>ERROR</code> log level.
	 * 
	 * @param message the log message
	 * @param error an optional Error instance associated with the log message.
	 */
	function error (message:String, ...rest) : void;

	/**
	 * Logs a message with the <code>FATAL</code> log level.
	 * 
	 * @param message the log message
	 * @param error an optional Error instance associated with the log message.
	 */	
	function fatal (message:String, ...rest) : void;
	
}

}
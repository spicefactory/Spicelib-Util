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
 * Central entry point to the Spicelib Log Wrapper. The static <code>getLogger</code> method
 * is the default way for obtaining a <code>Logger</code> instance. Depending on the type of Application
 * implementations will delegate to the Flex Logging API or to the Spicelib Flash Logging Framework.
 * 
 * <p>Which type of delegate the wrapper will use depends on the <code>LogFactory</code> implementation
 * you provide. Instances of <code>FlexLogFactory</code> will delegate to the Flex Logging API,
 * instances of <code>FlashLogFactory</code> will delegate to the old Spicelib Flash Logging Framework.</p>
 * 
 * <p>When using Parsley the corresponding delegate will usually be set automatically.
 * When using Spicelib on its own you have to specify the factory manually.</p>
 * 
 * <p>All Spicefactory classes use the <code>LogContext</code> internally to obtain Logger instances.
 * In regular Flex application code there is usually no need to use this class. But if you create
 * libraries which might be used in Flex or Flash Applications this class may come in handy as it
 * allows you to add log statements to your classes and decide at deployment time whether they should
 * delegate to the Flex Logging API or to the Spicelib Flash Logging Framework.</p>
 * 
 * @author Jens Halm
 */
public class LogContext {
	
	
	private static var _factory:LogFactory;
	
	private static var loggers:Object = new Object();
	
	
	/**
	 * Returns the logger for the specified name. If the name parameter is a Class
	 * instance, the fully qualified class name will be used. Otherwise the <code>toString</code>
	 * method will be invoked on the given name instance.
	 * 
	 * <p>The returned logger is actually a delegate. See the documentation for the LogContext class above
	 * for details.</p>
	 * 
	 * @param name the name of the logger
	 * @return the logger for the specified name
	 */
	public static function getLogger (name:Object) : Logger {
		var nameStr:String = LogUtil.getLogName(name);
		if (loggers[nameStr] != null) {
			return loggers[nameStr];
		}
		var log:Logger = (_factory == null) ? null : _factory.getLogger(nameStr);
		var del:DelegateLogger = new DelegateLogger(nameStr, log, trace);
		loggers[nameStr] = del;
		return del;
	}
	
	/**
	 * The LogFactory for the global LogContext.
	 * This is the factory that will be used for all Loggers obtained with
	 * <code>LogContext.getLogger</code>. 
	 * 
	 * <p>Instances of <code>FlexLogFactory</code> will delegate to the Flex Logging API,
 	 * while instances of <code>FlashLogFactory</code> will delegate to the old Spicelib Flash Logging Framework.</p> 
	 */
	public static function get factory () : LogFactory {
		return _factory;
	}
	
	public static function set factory (factory:LogFactory) : void {
		_factory = factory;
		refreshDelegates();
	}
	
	
	private static function refreshDelegates () : void {
		for each (var log:DelegateLogger in loggers) {
			log.delegate = _factory.getLogger(log.name);
		}
	}
	
	
}
	
}

import org.spicefactory.lib.logging.Logger;
import org.spicefactory.lib.logging.LogUtil;

class DelegateLogger implements Logger {
		
	
	private var _name:String;
	private var _delegate:Logger;
	private var _traceFunc:Function;
	
	
	public function DelegateLogger (name:String, log:Logger, traceFunc:Function) {
		_name = name;
		_delegate = log;
		_traceFunc = traceFunc;
	}
	
	public function get delegate () : Logger {
		return _delegate;
	}
	
	public function set delegate (log:Logger) : void {
		_delegate = log;
	}
	
	
	public function get name () : String {
		return (_delegate == null) ? _name : _delegate.name;
	}


	public function isTraceEnabled () : Boolean {
		return (_delegate == null) ? true : _delegate.isTraceEnabled();
	}

	public function isDebugEnabled () : Boolean {
		return (_delegate == null) ? true : _delegate.isDebugEnabled();
	}

	public function isInfoEnabled () : Boolean {
		return (_delegate == null) ? true : _delegate.isInfoEnabled();
	}

	public function isWarnEnabled () : Boolean {
		return (_delegate == null) ? true : _delegate.isWarnEnabled();
	}

	public function isErrorEnabled () : Boolean {
		return (_delegate == null) ? true : _delegate.isErrorEnabled();
	}

	public function isFatalEnabled () : Boolean {
		return (_delegate == null) ? true : _delegate.isFatalEnabled();
	}

	public function trace (message : String, ...params) : void {
		if (_delegate == null) { log("TRACE: ", message, params); return; }
		params.unshift(message);
		_delegate.trace.apply(_delegate, params);
	}

	public function debug (message : String, ...params) : void {
		if (_delegate == null) { log("DEBUG: ", message, params); return; }
		params.unshift(message);
		_delegate.debug.apply(_delegate, params);
	}

	public function info (message : String, ...params) : void {
		if (_delegate == null) { log("INFO:  ", message, params); return; }
		params.unshift(message);
		_delegate.info.apply(_delegate, params);
	}

	public function warn (message : String, ...params) : void {
		if (_delegate == null) { log("WARN:  ", message, params); return; }
		params.unshift(message);
		_delegate.warn.apply(_delegate, params); 
	}

	public function error (message : String, ...params) : void {
		if (_delegate == null) { log("ERROR: ", message, params); return; }
		params.unshift(message);
		_delegate.error.apply(_delegate, params);
	}

	public function fatal (message : String, ...params) : void {
		if (_delegate == null) { log("FATAL: ", message, params); return; }
		params.unshift(message);
		_delegate.fatal.apply(_delegate, params);
	}

	private function log (level:String, message:String, params:Array) : void {
		_traceFunc(level + LogUtil.buildLogMessage(message, params));
	}

	
}
	
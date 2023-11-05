//
//  SchemeChecker.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/5/23.
//

import Foundation

struct SchemeChecker {
	#if DEBUG
	static let isDebug = true
	#else
	static let isDebug = false
	#endif
}

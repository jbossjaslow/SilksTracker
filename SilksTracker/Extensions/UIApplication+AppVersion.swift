//
//  UIApplication+AppVersion.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 11/12/23.
//

import UIKit

extension UIApplication {
	static var appVersion: String? {
		return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
	}
}

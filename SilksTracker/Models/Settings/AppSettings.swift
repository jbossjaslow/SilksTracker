//
//  Settings.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/1/23.
//

import Foundation
import Observation

@Observable
class AppSettings {
	var moveListOrdering: OrderType = .standard
	
	var showTimeWithDateInWorkoutList: Bool = true
	var showTimeWithDateInNewWorkout: Bool = true
	
	init() {
		moveListOrdering = OrderType(rawValue: UserDefaults.standard.string(forKey: UserDefaultsKey.moveListOrdering.rawValue) ?? "Standard") ?? .standard
		
		showTimeWithDateInWorkoutList = UserDefaults.standard.bool(forKey: UserDefaultsKey.showTimeWithDateInWorkoutList.rawValue)
		showTimeWithDateInNewWorkout = UserDefaults.standard.bool(forKey: UserDefaultsKey.showTimeWithDateInNewWorkout.rawValue)
	}
}

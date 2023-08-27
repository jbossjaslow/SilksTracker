//
//  Settings.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 7/1/23.
//

import Foundation
import Observation

@Observable
final class AppSettings {
	var moveListOrdering: MoveListOrderType = .standard
	var goalListOrdering: GoalListOrderType = .alphabetical
	
	var showTimeWithDateInWorkoutList: Bool = true
	var showTimeWithDateInNewWorkout: Bool = true
	
	// TODO: Convert to @AppStorage
	
	init() {
		moveListOrdering = MoveListOrderType(rawValue: UserDefaults.standard.string(forKey: UserDefaultsKey.moveListOrdering.rawValue) ?? "Standard") ?? .standard
		
		showTimeWithDateInWorkoutList = UserDefaults.standard.bool(forKey: UserDefaultsKey.showTimeWithDateInWorkoutList.rawValue)
		showTimeWithDateInNewWorkout = UserDefaults.standard.bool(forKey: UserDefaultsKey.showTimeWithDateInNewWorkout.rawValue)
	}
}

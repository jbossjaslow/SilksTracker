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
	var moveListOrdering: MoveListOrderType {
		get {
			access(keyPath: \.moveListOrdering)
			let string = UserDefaults.standard.string(forKey: UserDefaultsKey.moveListOrdering.rawValue) ?? "Standard"
			return MoveListOrderType(rawValue: string) ?? .standard
		} set {
			withMutation(keyPath: \.moveListOrdering) {
				UserDefaults.standard.set(newValue.rawValue,
										  forKey: UserDefaultsKey.moveListOrdering.rawValue)
			}
		}
	}
	var goalListOrdering: GoalListOrderType {
		get {
			access(keyPath: \.goalListOrdering)
			let string = UserDefaults.standard.string(forKey: UserDefaultsKey.goalListOrdering.rawValue) ?? "ABC"
			return GoalListOrderType(rawValue: string) ?? .alphabetical
		} set {
			withMutation(keyPath: \.goalListOrdering) {
				UserDefaults.standard.set(newValue.rawValue,
										  forKey: UserDefaultsKey.goalListOrdering.rawValue)
			}
		}
	}
	
	// TODO: Make macros for the primitive versions of this
	var showTimeWithDateInWorkoutList: Bool {
		get {
			access(keyPath: \.showTimeWithDateInWorkoutList)
			return UserDefaults.standard.bool(forKey: UserDefaultsKey.showTimeWithDateInWorkoutList.rawValue)
		} set {
			withMutation(keyPath: \.showTimeWithDateInWorkoutList) {
				UserDefaults.standard.set(newValue,
										  forKey: UserDefaultsKey.showTimeWithDateInWorkoutList.rawValue)
			}
		}
	}
	var showTimeWithDateInNewWorkout: Bool {
		get {
			access(keyPath: \.showTimeWithDateInNewWorkout)
			return UserDefaults.standard.bool(forKey: UserDefaultsKey.showTimeWithDateInNewWorkout.rawValue)
		} set {
			withMutation(keyPath: \.showTimeWithDateInNewWorkout) {
				UserDefaults.standard.set(newValue,
										  forKey: UserDefaultsKey.showTimeWithDateInNewWorkout.rawValue)
			}
		}
	}
}

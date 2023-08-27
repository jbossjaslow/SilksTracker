//
//  GoalListOrderType.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 8/27/23.
//

import Foundation

enum GoalListOrderType: String, CaseIterable {
	case alphabetical = "ABC"
	case earliestDate = "Date - Ascending"
	case mostRecentDate = "Date - Descending"
}

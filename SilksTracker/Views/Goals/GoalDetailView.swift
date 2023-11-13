//
//  GoalDetailView.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 9/2/23.
//

import SwiftUI
import SwiftData

struct GoalDetailView: View {
	// MARK: - Instance properties
	@Query(sort: \Workout.date, order: .forward) var workouts: [Workout]
	@Query var moves: [Move]
	@Query var goals: [Goal]
	
	@Environment(\.modelContext) private var modelContext
	@Environment(\.editMode) private var editMode
	@Environment(\.dismiss) private var dismiss
	
	@State var title = ""
	@State var subtitle = ""
	@State var dateAchieved = Date()
	@State var selectedMoves: Set<Move> = Set()
	@State var associatedWorkout: Workout?
	
	@State var goalAchieved = false
	@State var goalLinkedToWorkout = false
	@State var goalLinkedToMoves = false
	
	private let goalDetailViewMode: GoalDetailViewMode
	
	// MARK: - Init
	init(goalId: UUID? = nil,
		 goalDetailViewMode: GoalDetailViewMode) {
		if let id = goalId {
			_goals = Query(Goal.fromId(id))
		}
		self.goalDetailViewMode = goalDetailViewMode
	}
	
	// MARK: - Computed properties
	var existingGoal: Goal? {
		guard goalDetailViewMode == .editingExistingGoal else {
			return nil
		}
		
		return goals.first
	}
	
	var navTitle: String {
		switch goalDetailViewMode {
			case .addingNewGoal:
				"Add New Goal"
			case .editingExistingGoal:
				"Edit Existing Goal"
		}
	}
	
	var saveButtonText: String {
		switch goalDetailViewMode {
			case .addingNewGoal:
				"Save New Goal"
			case .editingExistingGoal:
				"Save Goal"
		}
	}
	
	// MARK: - Body
	var body: some View {
		VStack(alignment: .leading) {
			switch goalDetailViewMode {
				case .addingNewGoal:
					addViewContent
				case .editingExistingGoal:
					if let editMode = editMode,
					   let goal = existingGoal {
						editViewContent(editMode,
										goal)
					} else {
						Text("Unable to locate data")
					}
			}
		}
		.navigationTitle(navTitle)
		.toolbar {
			if goalDetailViewMode == .editingExistingGoal {
				EditButton()
			}
		}
		.onAppear {
			if let goal = existingGoal {
				onAppear(existingGoal: goal)
			}
		}
	}
	
	// MARK: - Helper views
	@ViewBuilder
	private var addViewContent: some View {
		readAndWriteViews()
		
		Spacer()
		
		saveButton
	}
	
	@ViewBuilder
	private func editViewContent(_ editMode: Binding<EditMode>,
								 _ existingGoal: Goal) -> some View {
		switch editMode.wrappedValue {
			case .active:
				readAndWriteViews()
				
				Spacer()
				
				saveButton
			case .inactive:
				readOnlyViews(goal: existingGoal)
					.padding(.horizontal)
				
				Spacer()
			default:
				EmptyView()
		}
	}
	
	var saveButton: some View {
		Button {
			saveGoal()
		} label: {
			Text(saveButtonText)
				.standardButtonStyle
		}
		.padding(.horizontal)
	}
	
	// MARK: - Logic functions
	private func onAppear(existingGoal: Goal) {
		title = existingGoal.title
		subtitle = existingGoal.subtitle
		goalAchieved = existingGoal.hasBeenAchieved
		dateAchieved = existingGoal.dateAchieved ?? Date()
		goalLinkedToWorkout = existingGoal.linkedToWorkout
		associatedWorkout = existingGoal.associatedWorkout
		goalLinkedToMoves = !existingGoal.associatedMoves.isEmpty
		selectedMoves = Set(existingGoal.associatedMoves)
	}
	
	func onTapOfMove(_ move: Move) {
		if selectedMoves.contains(move) {
			selectedMoves.remove(move)
		} else {
			selectedMoves.insert(move)
		}
	}
	
	func getMove(for moveName: MoveName) -> Move {
		let move = moves.first {
			$0.name == moveName.name
		}
		
		return move ?? Move(moveName: moveName)
	}
	
	private func saveGoal() {
		switch goalDetailViewMode {
			case .addingNewGoal:
				saveNewGoal()
			case .editingExistingGoal:
				saveExistingGoal()
		}
		
		try? modelContext.save()
	}
	
	private func saveNewGoal() {
		let newGoal = Goal(title: title,
						   subtitle: subtitle,
						   dateCreated: Date(),
						   dateAchieved: dateAchieved)
		modelContext.insert(newGoal)
		newGoal.addMoves(Array(selectedMoves))
		if let newWorkout = associatedWorkout {
			newGoal.updateWorkout(newWorkout)
		}
		
		dismiss()
	}
	
	private func saveExistingGoal() {
		existingGoal?.title = title
		existingGoal?.subtitle = subtitle
		existingGoal?.updateMoves(goalLinkedToMoves ? Array(selectedMoves) : [])
		existingGoal?.dateAchieved = goalAchieved ? dateAchieved : nil
		existingGoal?.updateWorkout(goalLinkedToWorkout ? associatedWorkout : nil)
		
		withAnimation(.easeInOut) {
			editMode?.wrappedValue = .inactive
		}
	}
}

//
//  GroupedMoves.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import Foundation

struct GroupedMoves {
	private init() {}
	
	// MARK: - Move groups
	static let grouped = [
		group0,
		group1,
		group2,
		group3,
		group4,
		group5,
		group6,
		group7,
		group8,
		group9,
		group10,
		group11,
		group12,
		group13,
		group14,
		group15,
		standingHipLeanVariations,
		sittingHipLeanVariations,
		ballVariations,
		cocoonVariations,
		standingVariationsOnBasicFootlock,
		laybackInvertVariations,
		arabesqueBackBalance,
		basicLegRollUpVariations,
		shoulderSlingFromSupportedBridge,
		roundTheBackHold,
		ironT,
		crossbackStraddleVariations
	]
	
	static let flows = [
		basics,
		ballFlow,
		hipKeys,
		straddles,
		verticalHangFlow
	]
	
	// MARK: - Individual move groups
	static let group0 = MoveGroup(id: 0,
								  moves: [
									MoveNames.StraightArmHang,
									MoveNames.ShoulderLockOff,
									MoveNames.BasicStand,
									MoveNames.BasicClimb,
									MoveNames.BasicFootLock,
									MoveNames.StandingHipLean,
									MoveNames.SittingHipLean,
								  ])
	
	static let group1 = MoveGroup(id: 1,
								  moves: [
									MoveNames.StandardDescent,
									MoveNames.ManualHipKey,
									MoveNames.Cocoon,
									MoveNames.Sail,
									MoveNames.Ball
								  ])
	
	static let group2 = MoveGroup(id: 2,
								  moves: [
									MoveNames.StraddleUpKnot,
									MoveNames.LaybackInvert,
									MoveNames.FootLockAir
								  ])
	
	static let group3 = MoveGroup(id: 3,
								  moves: [
									MoveNames.FlamencoGrip,
									MoveNames.Pencil,
									MoveNames.BallToPencil,
									MoveNames.ClotheslineV2,
									MoveNames.BowAndArrow
								  ])
	
	static let group4 = MoveGroup(id: 4,
								  moves: [
									MoveNames.BentLegHipKeyGround,
									MoveNames.Arabesque,
									MoveNames.LegRollUp1Roll,
									MoveNames.LegRollUp2Rolls,
									MoveNames.ClotheslineV1
								  ])
	
	static let group5 = MoveGroup(id: 5,
								  moves: [
									MoveNames.StraddleUpGround,
									MoveNames.Pike,
									MoveNames.BallToPencilToPike,
									MoveNames.ManInTheMoonLegRollUp2Rolls,
									MoveNames.ShoulderStandLegRollUp2Rolls
								  ])
	
	static let group6 = MoveGroup(id: 6,
								  moves: [
									MoveNames.RussianStand,
									MoveNames.RussianClimb,
									MoveNames.LegRollUp3Rolls,
									MoveNames.SupportedBridge
								  ])
	
	static let group7 = MoveGroup(id: 7,
								  moves: [
									MoveNames.HipKeyAir,
									MoveNames.SingleFootLockAir,
									MoveNames.SupportedBridgeNoHands,
									MoveNames.FlamingoArabesque
								  ])
	
	static let group8 = MoveGroup(id: 8,
								  moves: [
									MoveNames.StarFish,
									MoveNames.KneeHang
								  ])
	
	static let group9 = MoveGroup(id: 9,
								  moves: [
									MoveNames.StraddleUpAir,
									MoveNames.BallInversionAir,
									MoveNames.HalfScorpion,
									MoveNames.LotusHangSingleFootLock
								  ])
	
	static let group10 = MoveGroup(id: 10,
								   moves: [
									MoveNames.VerticalHang,
									MoveNames.LotusHangBasicFootLock,
									MoveNames.DoubleFootLocksAir
								   ])
	
	static let group11 = MoveGroup(id: 11,
								   moves: [
									MoveNames.EmmaSits,
									MoveNames.SidewaysMiddleSplitsV3
								   ])
	
	static let group12 = MoveGroup(id: 12,
								   moves: [
									MoveNames.Splits
								   ])
	
	static let group13 = MoveGroup(id: 13,
								   moves: [
									MoveNames.TheX,
									MoveNames.Arrow
								   ])
	
	static let group14 = MoveGroup(id: 14,
								   moves: [
									MoveNames.SidewaysMiddleSplitsV2,
									MoveNames.LegRollUpSplits
								   ])
	
	static let group15 = MoveGroup(id: 15,
								   moves: [
									MoveNames.SidewaysMiddleSplitsV1,
									MoveNames.CrossBackStraddle
								   ])
	
	static let standingHipLeanVariations = MoveGroup(id: 16,
													 sectionTitle: "Standing Hip Lean Variations",
													 moves: [
														MoveNames.standingHipLeanVariations_noHands,
														MoveNames.standingHipLeanVariations_heartToCeilingNoHands,
														MoveNames.standingHipLeanVariations_singleFootLock
													 ])
	
	static let sittingHipLeanVariations = MoveGroup(id: 17,
													sectionTitle: "Sitting Hip Lean Variations",
													moves: [
														MoveNames.sittingHipLeanVariations_noHands,
														MoveNames.sittingHipLeanVariations_oppositeSideLean,
														MoveNames.sittingHipLeanVariations_singleFootLock
													])
	
	static let ballVariations = MoveGroup(id: 18,
										  sectionTitle: "Ball",
										  moves: [
											MoveNames.ball_skinTheCatEntry,
											MoveNames.ball_skinTheCatExit,
											MoveNames.ball_cartWheels,
											MoveNames.ball_birdcageDouble,
											MoveNames.ball_birdcageSingle,
											MoveNames.ball_stagLegs,
											MoveNames.ball_fang,
											MoveNames.ball_splits
										  ])
	
	static let cocoonVariations = MoveGroup(id: 19,
											sectionTitle: "Cocoon Variations",
											moves: [
												MoveNames.cocoonVariations_fanOnFrontFabric,
												MoveNames.cocoonVariations_fanOnBackFabric
											])
	
	static let standingVariationsOnBasicFootlock = MoveGroup(id: 20,
															 sectionTitle: "Standing Variations on Basic Footlock",
															 moves: [
																MoveNames.standingVariationsOnBasicFootlock_frontSail,
																MoveNames.standingVariationsOnBasicFootlock_backSail,
																MoveNames.standingVariationsOnBasicFootlock_noHandsFrontSail
															 ])
	
	static let laybackInvertVariations = MoveGroup(id: 21,
												   sectionTitle: "Layback Invert Variations",
												   moves: [
													MoveNames.laybackInvertVariations_skinTheLaybackInvert,
													MoveNames.laybackInvertVariations_pike,
													MoveNames.laybackInvertVariations_laybackInvertSplits
												   ])
	
	static let arabesqueBackBalance = MoveGroup(id: 22,
												sectionTitle: "Arabesque Back Balance",
												moves: [
													MoveNames.arabesqueBackBalance
												])
	
	static let basicLegRollUpVariations = MoveGroup(id: 23,
													sectionTitle: "Basic Leg Roll Up Variations",
													moves: [
														MoveNames.basicLegRollUpVariations_kidneyHang,
														MoveNames.basicLegRollUpVariations_kidneyHang_flamencoGripEntrance,
														MoveNames.basicLegRollUpVariations_kidneyHang_upAndOverFromManOnTheMoonEntrance,
														MoveNames.basicLegRollUpVariations_splits,
														MoveNames.basicLegRollUpVariations_splits_open,
														MoveNames.basicLegRollUpVariations_splits_revolved,
														MoveNames.basicLegRollUpVariations_gazelle,
														MoveNames.basicLegRollUpVariations_gazelle_invertedSplitsOpen,
														MoveNames.basicLegRollUpVariations_gazelle_invertedSplitsRevolved
													])
	
	static let shoulderSlingFromSupportedBridge = MoveGroup(id: 24,
															sectionTitle: "Shoulder Sling from Supported Bridge",
															moves: [
																MoveNames.shoulderSlingFromSupportedBridge
															])
	
	static let roundTheBackHold = MoveGroup(id: 25,
											sectionTitle: "Round the Back Hold",
											moves: [
												MoveNames.roundTheBackHold_sailDance
											])
	
	static let ironT = MoveGroup(id: 26,
								 sectionTitle: "Iron T",
								 moves: [
									MoveNames.ironT
								 ])
	
	static let crossbackStraddleVariations = MoveGroup(id: 27,
													   sectionTitle: "Crossback Straddle Variations",
													   moves: [
														MoveNames.crossbackStraddleVariations_butterflyExit,
														MoveNames.crossbackStraddleVariations_splitsRollUpToXEntry,
														MoveNames.crossbackStraddleVariations_transitionToSideMiddleSplitsV3
													   ])
	
	// MARK: - Convenience move groups
	static let basics = MoveGroup(id: 100,
								  sectionTitle: "Basics",
								  moves: [
									MoveNames.StraightArmHang,
									MoveNames.ShoulderLockOff,
									MoveNames.BasicStand,
									MoveNames.BasicClimb,
									MoveNames.BasicFootLock
								  ])
	
	static let ballFlow = MoveGroup(id: 101,
									sectionTitle: "Ball Flow",
									moves: [
										MoveNames.Ball,
										MoveNames.BallToPencil,
										MoveNames.BallToPencilToPike,
										MoveNames.BallInversionAir
									])
	
	static let hipKeys = MoveGroup(id: 102,
								   sectionTitle: "Hip Keys",
								   moves: [
									MoveNames.ManualHipKey,
									MoveNames.BentLegHipKeyGround,
									MoveNames.HipKeyAir,
								   ])
	
	static let straddles = MoveGroup(id: 103,
									 sectionTitle: "Straddles",
									 moves: [
										MoveNames.StraddleUpKnot,
										MoveNames.StraddleUpGround,
										MoveNames.StraddleUpAir,
									 ])
	
	static let verticalHangFlow = MoveGroup(id: 104,
											sectionTitle: "Vertical Hang Flow",
											moves: [
												MoveNames.SupportedBridge,
												MoveNames.SupportedBridgeNoHands,
												MoveNames.FlamingoArabesque,
												MoveNames.StarFish,
												MoveNames.KneeHang,
												MoveNames.VerticalHang
											])
}

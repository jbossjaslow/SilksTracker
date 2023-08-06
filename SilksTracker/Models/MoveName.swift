//
//  MoveName.swift
//  SilksTracker
//
//  Created by Josh Jaslow on 6/25/23.
//

import Foundation

struct MoveName {
	let name: String
	let id: String
	
	init(codeSafeName: String,
		 displayName: String) {
		name = displayName
		id = codeSafeName
	}
}

extension MoveName: Comparable, Identifiable, Hashable, Equatable {
	static func < (lhs: MoveName, rhs: MoveName) -> Bool {
		lhs.name < rhs.name
	}
	
	static func == (lhs: MoveName, rhs: MoveName) -> Bool {
		lhs.name == rhs.name
	}
}

/*
enum MoveName: Int, CaseIterable, Codable {
	case StraightArmHang = 0
	case ShoulderLockOff
	case BasicStand
	case BasicClimb
	case BasicFootLock
	case StandingHipLean
	case SittingHipLean
	
	case StandardDescent
	case ManualHipKey
	case Cocoon
	case Sail
	case Ball
	
	case StraddleUpKnot
	case LaybackInvert
	case FootLockAir
	
	case FlamencoGrip
	case Pencil
	case BallToPencil
	case ClotheslineV2
	case BowAndArrow
	
	case BentLegHipKeyGround
	case Arabesque
	case LegRollUp1Roll
	case LegRollUp2Rolls
	case ClotheslineV1
	
	case StraddleUpGround
	case Pike
	case BallToPencilToPike
	case ManInTheMoonLegRollUp2Rolls
	case ShoulderStandLegRollUp2Rolls
	
	case RussianStand
	case RussianClimb
	case LegRollUp3Rolls
	case SupportedBridge
	
	case HipKeyAir
	case SingleFootLockAir
	case SupportedBridgeNoHands
	case FlamingoArabesque
	
	case StarFish
	case KneeHang
	
	case StraddleUpAir
	case BallInversionAir
	case HalfScorpion
	case LotusHangSingleFootLock
	
	case VerticalHang
	case LotusHangBasicFootLock
	case DoubleFootLocksAir
	
	case EmmaSits
	case SidewaysMiddleSplitsV3
	
	case Splits
	
	case TheX
	case Arrow
	
	case SidewaysMiddleSplitsV2
	case LegRollUpSplits
	
	case SidewaysMiddleSplitsV1
	case CrossBackStraddle
	
	// Standing Hip Lean Variations
	case standingHipLeanVariations_noHands
	case standingHipLeanVariations_heartToCeilingNoHands
	case standingHipLeanVariations_singleFootLock
	
	// Sitting Hip Lean Variations
	case sittingHipLeanVariations_noHands
	case sittingHipLeanVariations_oppositeSideLean
	case sittingHipLeanVariations_singleFootLock
	
	// Ball
	case ball_skinTheCatEntry
	case ball_skinTheCatExit
	case ball_cartWheels
	case ball_birdcageDouble
	case ball_birdcageSingle
	case ball_stagLegs
	case ball_fang
	case ball_splits
	
	// Cocoon Variations
	case cocoonVariations_fanOnFrontFabric
	case cocoonVariations_fanOnBackFabric
	
	// Standing Variations on Basic Footlock
	case standingVariationsOnBasicFootlock_frontSail
	case standingVariationsOnBasicFootlock_backSail
	case standingVariationsOnBasicFootlock_noHandsFrontSail
	
	// Layback Invert Variations
	case laybackInvertVariations_skinTheLaybackInvert
	case laybackInvertVariations_laybackInvertSplits
	
	// Arabesque Back Balance
	case arabesqueBackBalance
	
	// Basic Leg Roll Up Variations
	case basicLegRollUpVariations_kidneyHang
	case basicLegRollUpVariations_kidneyHang_flamencoGripEntrance
	case basicLegRollUpVariations_kidneyHang_upAndOverFromManOnTheMoonEntrance
	case basicLegRollUpVariations_splits
	case basicLegRollUpVariations_splits_open
	case basicLegRollUpVariations_splits_revolved
	case basicLegRollUpVariations_gazelle
	case basicLegRollUpVariations_gazelle_invertedSplitsOpen
	case basicLegRollUpVariations_gazelle_invertedSplitsRevolved
	
	// Shoulder Sling from Supported Bridge
	case shoulderSlingFromSupportedBridge
	
	// Round the Back Hold
	case roundTheBackHold_sailDance
	
	// Iron T
	case ironT
	
	// Crossback Straddle Variations
	case crossbackStraddleVariations_butterflyExit
	case crossbackStraddleVariations_transitionToSideMiddleSplitsV3
	case crossbackStraddleVariations_splitsRollUpToXEntry
}

extension MoveName: Comparable, Identifiable {
	static func < (lhs: MoveName, rhs: MoveName) -> Bool {
		lhs.name < rhs.name
	}
	
	var id: Int {
		rawValue
	}
}

extension MoveName {
	var name: String {
		switch self {
			case .StraightArmHang:
				return "Straight Arm Hang"
			case .ShoulderLockOff:
				return "Shoulder Lock Off"
			case .BasicStand:
				return "Basic Stand"
			case .BasicClimb:
				return "Basic Climb"
			case .BasicFootLock:
				return "Basic Foot Lock"
			case .StandingHipLean:
				return "Standing Hip Lean"
			case .SittingHipLean:
				return "Sitting Hip Lean"
			case .StandardDescent:
				return "Standard Descent"
			case .ManualHipKey:
				return "Manual Hip Key"
			case .Cocoon:
				return "Cocoon"
			case .Sail:
				return "Sail"
			case .Ball:
				return "Ball"
			case .StraddleUpKnot:
				return "Straddle Up (Knot)"
			case .LaybackInvert:
				return "Layback Invert"
			case .FootLockAir:
				return "Foot Lock from Air"
			case .FlamencoGrip:
				return "Flamenco Grip"
			case .Pencil:
				return "Pencil"
			case .BallToPencil:
				return "Ball → Pencil"
			case .ClotheslineV2:
				return "Clothesline vs. 2"
			case .BowAndArrow:
				return "Bow & Arrow"
			case .BentLegHipKeyGround:
				return "Bent Leg Hip Key (ground)"
			case .Arabesque:
				return "Arabesque"
			case .LegRollUp1Roll:
				return "Leg Roll Up - 1 roll"
			case .LegRollUp2Rolls:
				return "Leg Roll Up - 2 rolls"
			case .ClotheslineV1:
				return "Clothesline vs. 1"
			case .StraddleUpGround:
				return "Straddle Up (from ground)"
			case .Pike:
				return "Pike"
			case .BallToPencilToPike:
				return "Ball → Pencil → Pike"
			case .ManInTheMoonLegRollUp2Rolls:
				return "Man in the Moon/Leg Roll Up - 2 rolls"
			case .ShoulderStandLegRollUp2Rolls:
				return "Shoulder Stand/Leg Roll Up - 2 rolls"
			case .RussianStand:
				return "Russian Stand"
			case .RussianClimb:
				return "Russian Climb"
			case .LegRollUp3Rolls:
				return "Leg Roll Up - 3 rolls"
			case .SupportedBridge:
				return "Supported Bridge"
			case .HipKeyAir:
				return "Hip Key (from air)"
			case .SingleFootLockAir:
				return "Single Foot Lock from Air"
			case .SupportedBridgeNoHands:
				return "Supported Bridge - no hands"
			case .FlamingoArabesque:
				return "Flamingo Arabesque"
			case .StarFish:
				return "Star Fish"
			case .KneeHang:
				return "Knee Hang"
			case .StraddleUpAir:
				return "Straddle Up (from Air)"
			case .BallInversionAir:
				return "Ball Inversion (from Air)"
			case .HalfScorpion:
				return "1/2 Scorpion"
			case .LotusHangSingleFootLock:
				return "Lotus Hang - single foot lock"
			case .VerticalHang:
				return "Vertical Hang"
			case .LotusHangBasicFootLock:
				return "Lotus Hang - basic foot lock"
			case .DoubleFootLocksAir:
				return "Double Foot Locks (from air)"
			case .EmmaSits:
				return "Emma sits"
			case .SidewaysMiddleSplitsV3:
				return "Sideways Middle Splits vs. 3"
			case .Splits:
				return "Splits"
			case .TheX:
				return "The X"
			case .Arrow:
				return "Arrow"
			case .SidewaysMiddleSplitsV2:
				return "Sideways Middle Splits vs. 2"
			case .LegRollUpSplits:
				return "Leg Roll Up from Splits"
			case .SidewaysMiddleSplitsV1:
				return "Sideways Middle Splits vs. 1"
			case .CrossBackStraddle:
				return "Cross Back Straddle"
			case .standingHipLeanVariations_noHands:
				return "Standing Hip Lean - No Hands"
			case .standingHipLeanVariations_heartToCeilingNoHands:
				return "Standing Hip Lean - Heart to Ceiling w/ No Hands"
			case .standingHipLeanVariations_singleFootLock:
				return "Standing Hip Lean - Single Foot Lock"
			case .sittingHipLeanVariations_noHands:
				return "Sitting Hip Lean - No Hands"
			case .sittingHipLeanVariations_oppositeSideLean:
				return "Sitting Hip Lean - Opposite Side Lean"
			case .sittingHipLeanVariations_singleFootLock:
				return "Sitting Hip Lean - Single Foot Lock"
			case .ball_skinTheCatEntry:
				return "Ball - Skin the Cat Entry"
			case .ball_skinTheCatExit:
				return "Ball - Skin the Cat Exit"
			case .ball_cartWheels:
				return "Ball - Cartwheels"
			case .ball_birdcageDouble:
				return "Ball - Birdcage - double"
			case .ball_birdcageSingle:
				return "Ball - Birdcage - single"
			case .ball_stagLegs:
				return "Ball - Stag Legs"
			case .ball_fang:
				return "Ball - Fang"
			case .ball_splits:
				return "Ball - Splits"
			case .cocoonVariations_fanOnFrontFabric:
				return "Cocoon - Fan on front fabric"
			case .cocoonVariations_fanOnBackFabric:
				return "Cocoon - Fan on back fabric"
			case .standingVariationsOnBasicFootlock_frontSail:
				return "Standing Basic Footlock - Front Sail"
			case .standingVariationsOnBasicFootlock_backSail:
				return "Standing Basic Footlock - Back Sail"
			case .standingVariationsOnBasicFootlock_noHandsFrontSail:
				return "Standing Basic Footlock - No Hands Front Sail"
			case .laybackInvertVariations_skinTheLaybackInvert:
				return "Layback Invert - Skin the Layback Invert"
			case .laybackInvertVariations_laybackInvertSplits:
				return "Layback Invert - Layback Invert Splits"
			case .arabesqueBackBalance:
				return "Arabesque Back Balance"
			case .basicLegRollUpVariations_kidneyHang:
				return "Basic Leg Roll Up - Kidney Hang"
			case .basicLegRollUpVariations_kidneyHang_flamencoGripEntrance:
				return "Basic Leg Roll Up - Kidney Hang - Flamenco Grip Entrance"
			case .basicLegRollUpVariations_kidneyHang_upAndOverFromManOnTheMoonEntrance:
				return "Basic Leg Roll Up - Kidney Hang - Up & Over from Man/Moon Entrance"
			case .basicLegRollUpVariations_splits:
				return "Basic Leg Roll Up - Splits"
			case .basicLegRollUpVariations_splits_open:
				return "Basic Leg Roll Up - Splits - Open"
			case .basicLegRollUpVariations_splits_revolved:
				return "Basic Leg Roll Up - Splits - Revolved"
			case .basicLegRollUpVariations_gazelle:
				return "Basic Leg Roll Up - Gazelle"
			case .basicLegRollUpVariations_gazelle_invertedSplitsOpen:
				return "Basic Leg Roll Up - Gazelle - Inverted Splits open"
			case .basicLegRollUpVariations_gazelle_invertedSplitsRevolved:
				return "Basic Leg Roll Up - Gazelle - Inverted Splits revolved"
			case .shoulderSlingFromSupportedBridge:
				return "Shoulder Sling from Supported Bridge"
			case .roundTheBackHold_sailDance:
				return "Round the Back Hold - Sail Dance"
			case .ironT:
				return "Iron T"
			case .crossbackStraddleVariations_butterflyExit:
				return "Crossback Straddle - Butterfly Exit"
			case .crossbackStraddleVariations_transitionToSideMiddleSplitsV3:
				return "Crossback Straddle - Transition to Side Middle Splits vs. 3"
			case .crossbackStraddleVariations_splitsRollUpToXEntry:
				return "Crossback Straddle - Splits roll up to X entry"
		}
	}
}
*/

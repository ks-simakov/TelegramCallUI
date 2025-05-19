//
//  OngoingCallState.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import Foundation


struct OngoingCallState: Hashable, Equatable {

	enum SignalStrength: Int, CaseIterable, Hashable, Equatable {
		case weak = 0
		case good = 1
		case strong = 2
		case excellent = 3
	}

	let duration: TimeInterval
	let emojis: [String] = ["🐱", "🚀", "❄️", "🎨"]
	let signalStrength: SignalStrength

	func sharedKeyEmoji() -> String {
		return emojis.joined()
	}
}

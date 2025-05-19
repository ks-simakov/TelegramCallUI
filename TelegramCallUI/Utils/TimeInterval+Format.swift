//
//  TimeInterval+Format.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 19.05.25.
//

import Foundation

extension TimeInterval {
	var mmSS: String {
		let totalSeconds = Int(self)
		let minutes = totalSeconds / 60
		let seconds = totalSeconds % 60
		return String(format: "%02d:%02d", minutes, seconds)
	}
}

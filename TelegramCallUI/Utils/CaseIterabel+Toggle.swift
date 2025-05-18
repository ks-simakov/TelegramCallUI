//
//  CaseIterabel+Toggle.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

extension CaseIterable where Self: Hashable {
	func toggle() -> Self {
		let allCases = Array(Self.allCases)
		let currentIndex = allCases.firstIndex(of: self) ?? 0
		let nextIndex = (currentIndex + 1) % allCases.count
		return allCases[nextIndex]
	}
}

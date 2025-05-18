//
//  ReverseMask.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

extension View {
	@ViewBuilder func reverseMask<Mask: View>(
		alignment: Alignment = .center,
		@ViewBuilder _ mask: () -> Mask
	) -> some View {
		self.mask {
			Rectangle()
				.overlay(alignment: alignment) {
					mask()
						.blendMode(.destinationOut)
				}
		}
	}
}

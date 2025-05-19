//
//  SignalStrengthView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 19.05.25.
//

import SwiftUI

struct SignalStrengthView: View {

	let signalStrength: OngoingCallState.SignalStrength
	let foregroundColor: Color = .white

    var body: some View {
		Image(systemName: "cellularbars")
			.foregroundColor(foregroundColor)
			.reverseMask {
				ZStack(alignment: .leading) {
					GeometryReader { geometry in
						Rectangle()
							.foregroundColor(.black.opacity(0.5))
							.offset(x: geometry.size.width * maskOffsetCoefficient, y: 0)
					}
				}
			}
    }

	private var maskOffsetCoefficient: CGFloat {
		switch signalStrength {
		case .weak:
			return 0.25
		case .good:
			return 0.5
		case .strong:
			return 0.75
		case .excellent:
			return 1
		}
	}
}

#Preview {
	VStack {
		SignalStrengthView(signalStrength: .weak)
		SignalStrengthView(signalStrength: .good)
		SignalStrengthView(signalStrength: .strong)
		SignalStrengthView(signalStrength: .excellent)
	}
	.background() {
		GlowGradientBackgroundView(style: .connected)
			.ignoresSafeArea()
	}
}

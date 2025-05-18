//
//  GlowGradientBackgroundView.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

struct GlowGradientBackgroundView: View {

	enum Style: CaseIterable {
		case connecting
		case connected

		var backgroundColor: Color {
			switch self {
			case .connecting:
				return Color(#colorLiteral(red: 0.4344210059, green: 0.4770071453, blue: 0.917335001, alpha: 1))
			case .connected:
				return Color(#colorLiteral(red: 0.4274509804, green: 0.6588235294, blue: 0.6235294118, alpha: 1))
			}
		}

		var firstPeakColor: Color {
			switch self {
			case .connecting:
				return Color(#colorLiteral(red: 0.892404896, green: 0.5077461059, blue: 0.9803921569, alpha: 1))
			case .connected:
				return Color(#colorLiteral(red: 0.6156862745, green: 0.7098039216, blue: 0.4862745098, alpha: 1))
			}
		}

		var secondPeakColor: Color {
			switch self {
			case .connecting:
				return Color(#colorLiteral(red: 0.404628821, green: 0.6854452606, blue: 0.8924371778, alpha: 1))
			case .connected:
				return Color(#colorLiteral(red: 0.3563061953, green: 0.6742646098, blue: 0.7721881866, alpha: 1))
			}
		}
	}

	var style: Style = .connecting
	private let velocity: Double = 0.06
	private let gradientRadius: CGFloat = 500
	@State private var point1: UnitPoint = .center
	@State private var point2: UnitPoint = .center

    var body: some View {
		ZStack {
			style.backgroundColor

			Rectangle()
				.fill(
					RadialGradient(
						gradient: Gradient(colors: [
							style.firstPeakColor,
							Color.clear,
						]),
						center: point1,
						startRadius: 0,
						endRadius: gradientRadius
					)
				)
				.blur(radius: 10)
			
			Rectangle()
				.fill(
					RadialGradient(
						gradient: Gradient(colors: [
							style.secondPeakColor,
							.clear,
						]),
						center: point2,
						startRadius: 0,
						endRadius: gradientRadius
					)
				)
				.blur(radius: 10)
		}
		.clipped()
		.task {
			var angle: Double = 0
			while true {
				angle += velocity
				point1 = UnitPoint(
					x: 0.5 + 0.4 * cos(angle),
					y: 0.5 + 0.4 * sin(angle)
				)

				point2 = UnitPoint(
					x: 0.5 + 0.4 * cos(angle + .pi),
					y: 0.5 + 0.4 * sin(angle + .pi)
				)
				try? await Task.sleep(nanoseconds: 60_000_000)
			}
		}
    }
}

#Preview {
    GlowGradientBackgroundView(
		style: .connected
	)
	.ignoresSafeArea()
}

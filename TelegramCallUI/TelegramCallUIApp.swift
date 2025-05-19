//
//  TelegramCallUIApp.swift
//  TelegramCallUI
//
//  Created by Konstantin Simakov on 18.05.25.
//

import SwiftUI

@main
struct TelegramCallUIApp: App {

	let callService = CallsService()

    var body: some Scene {
        WindowGroup {
            ContentView(
				viewModel: callService.startCall()
			)
        }
    }
}

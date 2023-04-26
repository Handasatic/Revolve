//
//  ConverterExampleApp.swift
//  ConverterExample
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import SwiftUI
import Revolve

@main
struct ConverterExampleApp: App {
	@StateObject private var store = StateStore(
		initialState: AppState(),
		reducer: appReducer,
		scheduler: DispatchQueue.main.eraseToAnyScheduler()
	)

	var body: some Scene {
		WindowGroup {
			ContentView(store: store)
		}
	}
}

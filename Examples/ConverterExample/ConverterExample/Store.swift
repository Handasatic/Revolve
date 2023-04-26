//
//  Store.swift
//  ConverterExample
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import Foundation
import Revolve



let store = StateStore(
	initialState: AppState(),
	reducer: appReducer,
	scheduler: DispatchQueue.main.eraseToAnyScheduler()
)

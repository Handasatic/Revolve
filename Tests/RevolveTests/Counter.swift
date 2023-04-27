//
//  File.swift
//  
//
//  Created by Oti Oritsejafor on 4/27/23.
//

import Foundation
import Revolve

struct CounterState: Revolve.State {
	var count: Int = 0
}

enum CounterAction: Revolve.Action {
	case increment
	case decrement
}

let counterReducer: Revolve.Reducer<CounterState, CounterAction> = { state, action in
	switch action {
		case .increment:
			state.count += 1
		case .decrement:
			state.count -= 1
	}
}

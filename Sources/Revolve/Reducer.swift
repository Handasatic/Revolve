//
//  File.swift
//  
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import Foundation

public typealias Reducer<State: Revolve.State, Action: Revolve.Action> = (inout State, Action) -> Void

public func combine<State, Action>(
	reducers: Reducer<State, Action>...
) -> Reducer<State, Action> where State: Revolve.State, Action: Revolve.Action {
	return { state, action in
		for reducer in reducers {
			reducer(&state, action)
		}
	}
}

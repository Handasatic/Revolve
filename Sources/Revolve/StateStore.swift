//
//  File.swift
//  
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import Foundation

import Combine
import CombineSchedulers

public final class StateStore<State: Revolve.State, Action: Revolve.Action>: ObservableObject {
	@Published private(set) public var state: State
	private let reducer: Reducer<State, Action>
	private let scheduler: AnySchedulerOf<DispatchQueue>
	private var cancellables: Set<AnyCancellable> = []

	public init(
		initialState: State,
		reducer: @escaping Reducer<State, Action>,
		scheduler: AnySchedulerOf<DispatchQueue>
	) {
		self.state = initialState
		self.reducer = reducer
		self.scheduler = scheduler
	}

	public func send(_ action: Action) {
		scheduler.schedule {
			self.reducer(&self.state, action)
		}
	}


}

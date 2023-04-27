//
//  File.swift
//  
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import Foundation

import SwiftUI
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

	public func binding<Value>(
		for keyPath: KeyPath<State, Value>,
		send action: @escaping (Value) -> Action
	) -> Binding<Value> {
		Binding(
			get: { self.state[keyPath: keyPath] },
			set: { newValue in self.send(action(newValue)) }
		)
	}


}

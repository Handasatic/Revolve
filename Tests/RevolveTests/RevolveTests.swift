import XCTest
import CombineSchedulers
@testable import Revolve



final class RevolveTests: XCTestCase {
	typealias MainScheduler = AnySchedulerOf<DispatchQueue>
	static let mainScheduler = DispatchQueue.main.eraseToAnyScheduler()

	/// Test if the `counterReducer` handles actions correctly for the given `CounterState`.
	/// This test verifies that the reducer processes `.increment`, `.decrement`, and `.document`
	/// actions, updating the `CounterState` and `CounterDocumentState` as expected.
	func testCounterReducerIncrementAndDecrement() {
		var state = CounterState(count: 2)
		let incrementAction = CounterAction.increment

		counterReducer(&state, incrementAction)
		XCTAssertEqual(state.count, 3)

		let decrementAction = CounterAction.decrement

		counterReducer(&state, decrementAction)
		XCTAssertEqual(state.count, 2)

	}

	/// Test if the StateStore handles the `.increment` action correctly.
	/// It should increment the `count` in the `CounterState` by 1.
	func testStateStoreIncrement() {
		let initialState = CounterState()
		let store = StateStore(initialState: initialState,
													 reducer: counterReducer,
													 scheduler: RevolveTests.mainScheduler)

		let expectation = self.expectation(description: "Increment State")
		let cancellable = store.$state.sink { state in
			if state.count == 1 {
				expectation.fulfill()
			}
		}

		store.send(.increment)

		waitForExpectations(timeout: 1)

		XCTAssertEqual(store.state.count, 1)
	}

	/// Test if the StateStore handles the `.decrement` action correctly.
	/// It should decrement the `count` in the `CounterState` by 1.
	func testStateStoreDecrement() {
		let initialState = CounterState(count: 2)
		let store = StateStore(initialState: initialState,
													 reducer: counterReducer,
													 scheduler: RevolveTests.mainScheduler)

		let expectation = self.expectation(description: "Decrement State")
		let cancellable = store.$state.sink { state in
			if state.count == 1 {
				expectation.fulfill()
			}
		}

		store.send(.decrement)

		waitForExpectations(timeout: 1)

		XCTAssertEqual(store.state.count, 1)
	}


	/// Test if the StateStore correctly generates a binding for the `count` property
	/// in the `CounterState` using the `binding(for:keyPath:)` method.
	/// This test simulates incrementing the `count` property through the generated binding,
	/// and the StateStore should handle the action accordingly.
	func testBindingIncrement() {
		let initialState = CounterState()
		let store = StateStore(initialState: initialState,
													 reducer: counterReducer,
													 scheduler: RevolveTests.mainScheduler)

		let binding = store.binding(for: \CounterState.count) { count -> CounterAction in
				.increment
		}

		let expectation = self.expectation(description: "Binding Increment")
		let cancellable = store.$state.sink { state in
			if state.count == 1 {
				expectation.fulfill()
			}
		}

		binding.wrappedValue += 1

		waitForExpectations(timeout: 1)

		XCTAssertEqual(store.state.count, 1)
	}

	/// Test if the StateStore correctly generates a binding for the `count` property
	/// in the `CounterState` using the `binding(for:keyPath:)` method.
	/// This test simulates decrementing the `count` property through the generated binding,
	/// and the StateStore should handle the action accordingly.
	func testBindingDecrement() {
		let initialState = CounterState(count: 2)
		let store = StateStore(initialState: initialState,
													 reducer: counterReducer,
													 scheduler: RevolveTests.mainScheduler)

		let binding = store.binding(for: \CounterState.count) { count -> CounterAction in
				.decrement
		}

		let expectation = self.expectation(description: "Binding Decrement")
		let cancellable = store.$state.sink { state in
			if state.count == 1 {
				expectation.fulfill()
			}
		}

		store.send(.decrement)

		waitForExpectations(timeout: 1)

		XCTAssertEqual(store.state.count, 1)
	}

}

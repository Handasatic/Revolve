import XCTest
import CombineSchedulers
@testable import Revolve



final class RevolveTests: XCTestCase {
	typealias MainScheduler = AnySchedulerOf<DispatchQueue>
	static let mainScheduler = DispatchQueue.main.eraseToAnyScheduler()

	func testCounterReducerIncrement() {
		var state = CounterState()
		let action = CounterAction.increment

		counterReducer(&state, action)

		XCTAssertEqual(state.count, 1)
	}

	// Test reducer with decrement action
	func testCounterReducerDecrement() {
		var state = CounterState(count: 2)
		let action = CounterAction.decrement

		counterReducer(&state, action)

		XCTAssertEqual(state.count, 1)
	}

	// Test StateStore with increment action
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

	// Test StateStore with decrement action
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


}

//
//  AppState.swift
//  ConverterExample
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import Revolve
import Foundation
import CombineSchedulers

// State
struct AppState: Revolve.State {
	var baseCurrency: String = "EUR"
	var rates: [String: Double] = [:]
	var amount: Double = 1
	var convertedAmounts: [String: Double] = [:]
}

// Actions
enum AppAction: Revolve.Action {
	case updateBaseCurrency(String)
	case updateAmount(Double)
	case updateRates([String: Double])
	case convert
}

// Reducer
let appReducer: Reducer<AppState, AppAction> = { state, action in
	switch action {
		case let .updateBaseCurrency(currency):
			state.baseCurrency = currency
		case let .updateAmount(amount):
			state.amount = amount
			print(amount)
		case let .updateRates(rates):
			state.rates = rates
		case .convert:
			let baseCurrencyRate = state.rates[state.baseCurrency] ?? 1
			state.convertedAmounts = state.rates.mapValues { rate in
				let targetCurrencyRate = rate / baseCurrencyRate
				return targetCurrencyRate * state.amount
			}
	}
}


extension AppState {
	func conversionRate(for targetCurrency: String) -> Double {
		return rates[targetCurrency] ?? 0.0
	}
}

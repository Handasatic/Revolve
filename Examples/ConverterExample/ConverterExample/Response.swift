//
//  Mock.swift
//  ConverterExample
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import Foundation

struct FixerResponse: Codable {
	let base: String
	let date: String
	let rates: [String: Double]
	let success: Bool
	let timestamp: Int
}


let mockExchangeRates = FixerResponse(
	base: "USD",
	date: "2022-04-14",
	rates: [
		"EUR": 0.813399,
		"GBP": 0.72007,
		"JPY": 107.346001,
		"AUD": 1.3146,
		"CAD": 1.2551,
		"CHF": 0.9267,
		"CNY": 6.5402,
		"HKD": 7.7623,
		"NOK": 8.6314,
		"NZD": 1.4185,
		"NGN": 411.5,
	],
	success: true,
	timestamp: 1519296206
)

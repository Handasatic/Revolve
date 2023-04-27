//
//  ContentView.swift
//  ConverterExample
//
//  Created by Oti Oritsejafor on 4/26/23.
//

import SwiftUI
import Revolve

struct ContentView: View {
	let supportedCurrencies = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "CHF", "CNY", "HKD", "NOK", "NZD", "NGN"]

	@ObservedObject var store: StateStore<AppState, AppAction>

	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				VStack(alignment: .leading, spacing: 8) {
					Text("Amount")
						.font(.headline)

					TextField("Amount",
										value: store.binding(for: \.amount,
																				 send: { newAmount in
						.updateAmount(newAmount)}),
										formatter: NumberFormatter())
						.keyboardType(.decimalPad)
						.padding()
						.background(Color(.systemGray6))
						.cornerRadius(8)
						.onChange(of: store.state.amount) { _ in
							store.send(.convert)
						}
				}

				VStack(alignment: .leading, spacing: 8) {


					HStack {
						Text("Base Currency")
							.font(.headline)
						Picker("Base Currency",
									 selection: store.binding(for: \.baseCurrency,
																						send: {.updateBaseCurrency($0)})) {
							ForEach(supportedCurrencies, id: \.self) { currency in
								Text(currency).tag(currency)
							}
						}
						.pickerStyle(.menu)
						.onChange(of: store.state.baseCurrency) { _ in
							store.send(.convert)
						}
						Spacer()
					}
				}


				ScrollView(.vertical, showsIndicators: false) {
					VStack(alignment: .leading, spacing: 8) {
						Text("Converted Amounts")
							.font(.headline)

						ForEach(store.state.convertedAmounts.sorted(by: { $0.key < $1.key }), id: \.key) { (currency, amount) in
							HStack {
								Text(currency)
									.font(.callout)
								Spacer()
								Text("\(amount, specifier: "%.2f")")
									.font(.callout)
							}
						}
					}
				}
			}
			.onAppear{
				getMockRates()
			}
			.padding()
			.navigationTitle("Currency Converter")
		}
	}


	func getMockRates() {
		let rates = mockExchangeRates.rates
		store.send(.updateRates(rates))
	}


	func getExchangeRates() {
		let apiKey = "wGKop9upukf9AkrOsFXfUNTgJAHQ18Mu"
		let urlString = "https://api.apilayer.com/fixer/latest?base=USD&symbols=EUR,GBP"
		if let url = URL(string: urlString) {
			var request = URLRequest(url: url, timeoutInterval: Double.infinity)
			request.httpMethod = "GET"
			request.addValue(apiKey, forHTTPHeaderField: "apikey")

			URLSession.shared.dataTask(with: request) { data, response, error in
				if let data = data {
					let decoder = JSONDecoder()
					do {
						let exchangeRatesResponse = try decoder.decode(FixerResponse.self, from: data)
						DispatchQueue.main.async {
							store.send(.updateRates(exchangeRatesResponse.rates))
						}
					} catch {
						print("JSON decode failed: \(error.localizedDescription)")
					}
					return
				}
				print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
			}.resume()
		}
	}

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
			ContentView(store: StateStore(
				initialState: AppState(),
				reducer: appReducer,
				scheduler: DispatchQueue.main.eraseToAnyScheduler()
			))
    }
}

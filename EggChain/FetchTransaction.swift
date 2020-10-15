import Foundation

class FetchTransaction: ObservableObject {
	// 1.
	@Published var transactions = [Transaction]()

	init() {
		let url = URL(string: "http://192.168.1.69:5000/chain")!
		// 2.
		URLSession.shared.dataTask(with: url) { data, _, error in
			do {
				if let transactionData = data {
					// 3.
					let decodedData = try JSONDecoder().decode(Transaction.self, from: transactionData)
					let transactionTest: [Transaction] = [decodedData]
					DispatchQueue.main.async {
						self.transactions = transactionTest
					}
				} else {
					print("No data to fetch")
				}
			} catch {
				print("Error fetching data \(error)")
			}
		}.resume()
	}
}

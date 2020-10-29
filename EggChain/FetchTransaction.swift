import Foundation

class FetchTransaction: ObservableObject {
	// 1.
//	@Published var transactions = [Transaction]()
	@Published var fetchedTransactions = [Chain]()
	@Published var fetchedBlocks = [Block]()

	init() {
		// MARK: - Add URL here
		let url = URL(string: "http://192.168.1.22:5000/chain")!
		// 2.
		print("Starting...")
		URLSession.shared.dataTask(with: url) { data, _, error in
			do {
				if let transactionData = data {
//					// 3.
					let decodedData = try JSONDecoder().decode(Chain.self, from: transactionData)
					let transactionTest: [Chain] = [decodedData]
					DispatchQueue.main.async {
						self.fetchedTransactions = transactionTest
						print(self.fetchedTransactions)
					} 
//					let decodedData = try JSONDecoder().decode(Transaction.self, from: transactionData)
//					let transactionTest: [Transaction] = [decodedData]
//					DispatchQueue.main.async {
//						self.transactions = transactionTest
//					}
					// 3.
					print("Getting data.")
//					guard let decodedData = try JSONDecoder().decode(Chain?.self, from: transactionData) else {
//						print("Error decoding data")
//						return
//					}
//					let transactionTest: [Chain] = [decodedData]
//
//					DispatchQueue.main.async {
//						self.fetchedTransactions = transactionTest
//						self.fetchedBlocks = decodedData.blocks!
//						print("Async")
//						print("\(self.fetchedBlocks[0].transactions?[0].recipient)")
//					}
					print("Testing")
//					print("\(decodedData.chain?[1].transactions?[0].recipient)")
				} else {
					print("No data to fetch")
				}
			} catch {
				print("Error fetching data \(error)")
			}
		}.resume()
	}
}

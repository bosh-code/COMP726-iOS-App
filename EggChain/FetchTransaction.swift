import Foundation

class FetchTransaction: ObservableObject {
	// 1.
//	@Published var transactions = [Transaction]()
	@Published var chainData = [Chain]()
	@Published var fetchedBlocks = [Block]()
	@Published var transactionData = [Transaction]()

	init() {
		// MARK: - Add URL here

		let url = URL(string: "http://192.168.1.22:5000/chain")!
		// 2.
		print("Strating...")
		URLSession.shared.dataTask(with: url) { data, _, error in
			do {
				if let transactionData = data {
//					// 3.
//					let decodedData = try JSONDecoder().decode(Transaction.self, from: transactionData)
//					let transactionTest: [Transaction] = [decodedData]
//					DispatchQueue.main.async {
//						self.transactions = transactionTest
//					}
					// 3.
					print("Getting data.")
					let decodedData = try JSONDecoder().decode(Chain.self, from: transactionData)
					let transactionTest: [Chain] = [decodedData]

					DispatchQueue.main.async {
						self.chainData = transactionTest
						self.fetchedBlocks = decodedData.chain!
						print("Async")
//						print("Sender: \(String(describing: self.fetchedBlocks[1].transactions![0].recipient))")
						
//						for _ in self.fetchedBlocks {
//							self.transactionData[0] = self.fetchedBlocks[1].transactions![0]
//						}
					}
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

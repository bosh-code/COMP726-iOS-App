import Foundation

class FetchTransaction: ObservableObject {
	@Published var chainData = [Chain]()
	@Published var fetchedBlocks = [Block]()
	@Published var transactionData = [Transaction]()
	
	init() {
		// MARK: - Add URL here

		let url = URL(string: "http://192.168.1.22:5000/chain")!
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			do {
				if let transactionData = data {
					let decodedData = try JSONDecoder().decode(Chain.self, from: transactionData)
					let transactionTest: [Chain] = [decodedData]
					
					DispatchQueue.main.async {
						self.chainData = transactionTest
						self.fetchedBlocks = decodedData.chain!
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

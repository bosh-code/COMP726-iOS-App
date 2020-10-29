import Foundation

// MARK: - Welcome

struct Chain: Codable {
	let blocks: [Block]?
	let length: Int?
}

// MARK: - Chain

struct Block: Codable, Identifiable {
	public var id: Int = 0
	let timestamp: Double?
	let proof: Int?
	let transactions: [Transaction]?
	let previousHash: String?
	let index: Int?
	
	enum CodingKeys: String, CodingKey {
		case timestamp, proof, transactions
		case previousHash = "previous_hash"
		case index
	}
}

struct Transaction: Codable {
	var sender: String?
	var recipient: String?
	var amount: Int64?
	var code: String?
	var type: String?
	var timestamp: String?
}

struct FormattedTransaction: Identifiable {
	let id = UUID()
	var sender: String
	var amount: Int64
	var code: String
	var type: String
}

class FormattedTransactionContainer: ObservableObject {
	@Published var transactionArray = [FormattedTransaction]()
	var chainData = [Chain]()
	var fetchedBlocks = [Block]()
	
	
	func fetchTransactions() {
		// MARK: - Add URL here
		
		let url = URL(string: "http://192.168.1.22:5000/chain")!
		
		URLSession.shared.dataTask(with: url) { data, _, error in
			do {
				if let transactionData = data {
					let decodedData = try JSONDecoder().decode(Chain.self, from: transactionData)
					let decodedChain: [Chain] = [decodedData]
					var formattedT: FormattedTransaction
					
					
					
//					DispatchQueue.main.async {
//						self.chainData = decodedChain
//						self.fetchedBlocks = decodedData.chain!
//					}
				} else {
					print("No data to fetch")
				}
			} catch {
				print("Error fetching data \(error)")
			}
		}.resume()
	}
}

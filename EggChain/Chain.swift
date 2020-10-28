import Foundation

// MARK: - Welcome
struct Chain: Codable {
	let chain: [Block]?
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

// MARK: - Transaction
//struct Transactions: Codable {
//	let amount: Int?
//	let recipient, sender, code, type: String?
//	let timestamp: Double?
//}

struct Transaction: Codable {
	var sender: String?
	var recipient: String?
	var amount: Int64?
	var code: String?
	var type: String?
	var timestamp: String?
}

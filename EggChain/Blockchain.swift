// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let blockchain = try Blockchain(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.blockchainTask(with: url) { blockchain, response, error in
//     if let blockchain = blockchain {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Blockchain

struct Blockchain: Codable {
	let chain: [Chain]?
	let length: Int?

	enum CodingKeys: String, CodingKey {
		case chain
		case length
	}
}

// MARK: Blockchain convenience initializers and mutators

extension Blockchain {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(Blockchain.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		chain: [Chain]?? = nil,
		length: Int?? = nil
	) -> Blockchain {
		return Blockchain(
			chain: chain ?? self.chain,
			length: length ?? self.length
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.chainTask(with: url) { chain, response, error in
//     if let chain = chain {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Chain

struct Chain: Codable {
	let timestamp: Double?
	let proof: Int?
	let transactions: [Transaction]?
	let previousHash: String?
	let index: Int?

	enum CodingKeys: String, CodingKey {
		case timestamp
		case proof
		case transactions
		case previousHash = "previous_hash"
		case index
	}
}

// MARK: Chain convenience initializers and mutators

extension Chain {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(Chain.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		timestamp: Double?? = nil,
		proof: Int?? = nil,
		transactions: [Transaction]?? = nil,
		previousHash: String?? = nil,
		index: Int?? = nil
	) -> Chain {
		return Chain(
			timestamp: timestamp ?? self.timestamp,
			proof: proof ?? self.proof,
			transactions: transactions ?? self.transactions,
			previousHash: previousHash ?? self.previousHash,
			index: index ?? self.index
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.transactionTask(with: url) { transaction, response, error in
//     if let transaction = transaction {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Transaction

struct Transaction: Codable {
	let amount: Int?
	let recipient: String?
	let sender: String?
	let code: String?
	let type: String?
	let timestamp: String?

	enum CodingKeys: String, CodingKey {
		case amount
		case recipient
		case sender
		case code
		case type
		case timestamp
	}
}

// MARK: Transaction convenience initializers and mutators

extension Transaction {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(Transaction.self, from: data)
	}

	init(_ json: String, using encoding: String.Encoding = .utf8) throws {
		guard let data = json.data(using: encoding) else {
			throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
		}
		try self.init(data: data)
	}

	init(fromURL url: URL) throws {
		try self.init(data: try Data(contentsOf: url))
	}

	func with(
		amount: Int?? = nil,
		recipient: String?? = nil,
		sender: String?? = nil,
		code: String?? = nil,
		type: String?? = nil,
		timestamp: String?? = nil
	) -> Transaction {
		return Transaction(
			amount: amount ?? self.amount,
			recipient: recipient ?? self.recipient,
			sender: sender ?? self.sender,
			code: code ?? self.code,
			type: type ?? self.type,
			timestamp: timestamp ?? self.timestamp
		)
	}

	func jsonData() throws -> Data {
		return try newJSONEncoder().encode(self)
	}

	func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
		return String(data: try self.jsonData(), encoding: encoding)
	}
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
	let decoder = JSONDecoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		decoder.dateDecodingStrategy = .iso8601
	}
	return decoder
}

func newJSONEncoder() -> JSONEncoder {
	let encoder = JSONEncoder()
	if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
		encoder.dateEncodingStrategy = .iso8601
	}
	return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
	fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.dataTask(with: url) { data, response, error in
			guard let data = data, error == nil else {
				completionHandler(nil, response, error)
				return
			}
			completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
		}
	}

	func blockchainTask(with url: URL, completionHandler: @escaping (Blockchain?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.codableTask(with: url, completionHandler: completionHandler)
	}
}

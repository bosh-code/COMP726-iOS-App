// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mine = try Mine(json)

//
// To read values from URLs:
//
//   let task = URLSession.shared.mineTask(with: url) { mine, response, error in
//     if let mine = mine {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - Mine

struct Mine: Codable {
	let message: String?
	let proof: Int?
	let previousHash: String?
	let transactions: [Transaction]?
	let index: Int?

	enum CodingKeys: String, CodingKey {
		case message
		case proof
		case previousHash = "previous_hash"
		case transactions
		case index
	}
}

// MARK: Mine convenience initializers and mutators

extension Mine {
	init(data: Data) throws {
		self = try newJSONDecoder().decode(Mine.self, from: data)
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
		message: String?? = nil,
		proof: Int?? = nil,
		previousHash: String?? = nil,
		transactions: [Transaction]?? = nil,
		index: Int?? = nil
	) -> Mine {
		return Mine(
			message: message ?? self.message,
			proof: proof ?? self.proof,
			previousHash: previousHash ?? self.previousHash,
			transactions: transactions ?? self.transactions,
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

	func mineTask(with url: URL, completionHandler: @escaping (Mine?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
		return self.codableTask(with: url, completionHandler: completionHandler)
	}
}

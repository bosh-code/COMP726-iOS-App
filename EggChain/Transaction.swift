//
//  Transaction.swift
//  EggChain
//
//  Created by Ryan Bosher on 25/08/20.
//

import Foundation

struct Transaction: Codable {
	var sender: String
	var recipient: String
	var amount: Int64
	var code: String
	var type: String
}

//struct SendResponse: Codable {
//	var results: [SendResult]
//}
//
//struct SendResult: Codable {
//	var trackId: Int
//	var trackName: String
//	var collectionName: String
//}
//
//struct Block: Codable {
//	var index: Int64 // height index in the chain
//	var timestamp: Date // Date timestamp
//	var transactions: [Transaction] // Array of transactions for the block
//	var proof: Int64
//	var previous_hash: String // Has of the previous block
//
//}

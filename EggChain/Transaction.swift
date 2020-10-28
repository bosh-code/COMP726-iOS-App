//
//  Transaction.swift
//  EggChain
//
//  Created by Ryan Bosher on 25/08/20.
//

import Foundation

struct Transaction: Codable {
	var sender: String?
	var recipient: String?
	var amount: Int64?
	var code: String?
	var type: String?
	var timestamp: String?
}

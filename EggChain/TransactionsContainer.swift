//
//  TransactionContainer.swift
//  EggChain
//
//  Created by Ryan Bosher on 29/10/20.
//

import Foundation

class TransactionsContainer: ObservableObject {
	@Published var transactions = [TransactionRow]()
}

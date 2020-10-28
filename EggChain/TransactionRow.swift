//
//  TransactionRow.swift
//  EggChain
//
//  Created by Ryan Bosher on 28/10/20.
//

import SwiftUI

struct TransactionRow: View {
	var transaction: Transactions
	
    var body: some View {
		HStack {
			Text("Sender: \(transaction.sender!)")
			Text("Recipient: \(transaction.recipient!)")
			Text("Amount: \(transaction.amount!)")
			Text("Type: \(transaction.type!)")
			Text("Code: \(transaction.code!)")
			Spacer()
		}
    }
}

//struct TransactionRow_Previews: PreviewProvider {
//    static var previews: some View {
//        TransactionRow(transaction: <#T##Transactions#>)
//    }
//}

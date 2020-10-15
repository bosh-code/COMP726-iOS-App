//
//  TransactionView.swift
//  EggChain
//
//  Created by Ryan Bosher on 4/10/20.
//

import SwiftUI

struct TransactionView: View {
	// 1.
	@ObservedObject var fetch = FetchTransaction()
	var body: some View {
		VStack {
			// 2.
			List(fetch.transactions) { transaction in
				VStack(alignment: .leading) {
					// 3.
					Text(transaction.sender ?? "nil")
					Text("\(transaction.amount ?? 0)") // print boolean
						.font(.system(size: 11))
						.foregroundColor(Color.gray)
				}
			}
		}
	}
}

struct TransactionView_Previews: PreviewProvider {
	static var previews: some View {
		TransactionView()
	}
}

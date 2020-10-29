//
//  ContentView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import SwiftUI

struct ContentView: View {
	var body: some View {
		TabView {
			TransactionListView()
				.tabItem {
					Image(systemName: "link.circle.fill")
					Text("Transactions")
				}
			AboutView()
				.tabItem {
					Image(systemName: "questionmark.circle.fill")
					Text("About")
				}
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

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
			ProspectsView()
				.tabItem {
					Image(systemName: "link.circle.fill")
					Text("Tab 1")
				}
			TransactionView()
				.tabItem {
					Image(systemName: "link.icloud.fill")
					Text("Transaction View")
				}
			ProspectsView()
				.tabItem {
					Image(systemName: "exclamationmark.circle.fill")
					Text("Tab 3")
				}
			MeView()
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

//
//  ContentView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import SwiftUI

var prospects = Prospects()

struct ContentView: View {
    var body: some View {
		TabView {
			ProspectsView(filter: .none)
				.tabItem {
					Image(systemName: "link.circle.fill")
					Text("Tab 1")
				}
			ProspectsView(filter: .contacted)
				.tabItem {
					Image(systemName: "link.icloud.fill")
					Text("Tab 2")
				}
			ProspectsView(filter: .uncontacted)
				.tabItem {
					Image(systemName: "exclamationmark.circle.fill")
					Text("Tab 3")
				}
			MeView()
				.tabItem {
					Image(systemName: "questionmark.circle.fill")
					Text("About")
				}
		}.environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

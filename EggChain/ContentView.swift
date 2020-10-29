//
//  ContentView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import SwiftUI

struct ContentView: View {
	
	@State private var selectedTab = 0
	
	let numTabs = 2
	let minDragTranslationForSwipe: CGFloat = 50
	
	var body: some View {
		TabView (selection: $selectedTab) {
			TransactionListView()
				.tabItem {
					Image(systemName: "link.circle.fill")
					Text("Transactions")
				}.tag(0)
				.highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
			AboutView()
				.tabItem {
					Image(systemName: "questionmark.circle.fill")
					Text("About")
				}.tag(1)
				.highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
		}
	}
	
	private func handleSwipe(translation: CGFloat) {
		if translation > minDragTranslationForSwipe && selectedTab > 0 {
			selectedTab -= 1
		} else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
			selectedTab += 1
		}
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

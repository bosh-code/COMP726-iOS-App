//
//  ProspectsView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import SwiftUI

enum FilterType {
	case none, contacted, uncontacted
}

struct EggListView: View {
	@State private var isShowingScanner = false
	@EnvironmentObject var prospects: EggObjects
	
	let filter: FilterType
	
	
	var body: some View {
		NavigationView {
			List {
				ForEach(filteredEggs) { prospect in
					VStack(alignment: .leading) {
						Text(prospect.name)
							.font(.headline)
						Text(prospect.emailAddress)
							.foregroundColor(.secondary)
					}
				}
				.navigationBarTitle("Your scanned eggs")
				.navigationBarItems(trailing: Button(action: {
					self.isShowingScanner = true
				}) {
					Image(systemName: "qrcode.viewfinder")
					Text("Scan new egg")
				})
				.sheet(isPresented: $isShowingScanner) {
					ZStack {
						CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
						VStack(alignment: .center) {
						Image(systemName: "viewfinder").resizable()
							.frame(width: 180, height: 180)
							.foregroundColor(.white)
							.padding()
							Text("Position the egg's QR Code in the viewfinder.")
								.font(.body)
								.foregroundColor(.white)
						}
						VStack{
							HStack{
								Spacer()
								Button(action: {
									self.isShowingScanner = false
								}) {
									Image(systemName: "xmark.circle.fill").resizable()
										.frame(width: 32, height: 32)
										.foregroundColor(.blue)
										.shadow(radius: 5)
										.padding()
								}
								.padding()
							}
							Spacer()
						}
					}
				}
			}
		}
	}
	
	var filteredEggs: [Egg] {
		switch filter {
		case .none:
			return prospects.eggs
		case .contacted:
			return prospects.eggs.filter { $0.isContacted }
		case .uncontacted:
			return prospects.eggs.filter { !$0.isContacted }
		}
	}
	
	func handleScan(result: Result<String, CodeScannerView.ScanError>) {
		self.isShowingScanner = false
		switch result {
		case .success(let code):
			let details = code.components(separatedBy: "\n")
			guard details.count == 2 else { return }
			let person = Egg()
			person.name = details[0]
			person.emailAddress = details[1]
			
			self.prospects.eggs.append(person)
		case .failure(let error):
			print("Scanning failed: \(error)")
		}
	}
}

struct ProspectsView_Previews: PreviewProvider {
	static var previews: some View {
		EggListView(filter: .none)
	}
}

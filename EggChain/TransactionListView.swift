//
//  ProspectsView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import Combine
import SwiftUI

struct TransactionListView: View {
	@State private var isShowingScanner = false
	@ObservedObject var fetchToDo = FetchToDo()

	var body: some View {
		NavigationView {
			List(fetchToDo.todos) { todo in
				VStack {
					Text(todo.title)
					Text("\(todo.completed.description)")
						.font(.system(size: 12))
						.foregroundColor(Color.gray)
				}
				.navigationBarItems(trailing: Button(action: {
					self.isShowingScanner = true
				}) {
					Image(systemName: "qrcode.viewfinder")
					Text("New Scan")
				})
				.sheet(isPresented: $isShowingScanner) {
					ZStack {
						CodeScannerView(codeTypes: [.qr], completion: self.handleScan)
						VStack(alignment: .center) {
							Image(systemName: "viewfinder").resizable()
								.frame(width: 180, height: 180)
								.foregroundColor(.white)
								.padding()
							Text("Position the QR Code in the viewfinder.")
								.font(.body)
								.foregroundColor(.white)
						}
						VStack {
							HStack {
								Spacer()
								Button(action: {
									self.isShowingScanner = false
								}) {
									Image(systemName: "xmark.circle.fill").resizable()
										.frame(width: 32, height: 32)
										.foregroundColor(.blue)
										.padding()
								}
								.padding()
							}
							Spacer()
						}
					}
				}
			}.navigationBarTitle("Transactions")
		}
	}

	func handleScan(result: Result<String, CodeScannerView.ScanError>) {
		isShowingScanner = false
		switch result {
		case .success(let code):
			print("Scanned QR!")
			let details = code.components(separatedBy: ",")
			print(details)
			guard details.count == 2 else { return }
		case .failure(let error):
			print("Scanning failed: \(error)")
		}
	}
}

// MARK: - Demo List Population

struct Todo: Codable, Identifiable {
	public var id: Int
	public var title: String
	public var completed: Bool
}

class FetchToDo: ObservableObject {
	@Published var todos = [Todo]()

	init() {
		let url = URL(string: "https://jsonplaceholder.typicode.com/todos")!
		URLSession.shared.dataTask(with: url) { data, _, _ in
			do {
				if let todoData = data {
					let decodedData = try JSONDecoder().decode([Todo].self, from: todoData)
					DispatchQueue.main.async {
						self.todos = decodedData
					}
				} else {
					print("No data")
				}
			} catch {
				print("Error")
			}
		}.resume()
	}
}

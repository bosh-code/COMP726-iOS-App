//
//  MeView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

enum ActiveSheet: Identifiable {
	case info, transaction
	
	var id: Int {
		hashValue
	}
}

struct AboutView: View {
	@State var activeSheet: ActiveSheet?
	@State private var alertTitle = ""
	@State private var confirmationMessage = ""
	@State private var showingConfirmation = false
	@State private var isLoading: Bool = false
	@State private var name = "Ryan Bosher"
	@State private var emailAddress = "https://bosh.codes/"
	
	init() {}
	
	var body: some View {
		NavigationView {
			VStack {
				Image("memojiCircle")
					.resizable()
					.scaledToFit()
					.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
				HStack {
					Spacer()
					VStack {
						Text("Ryan Bosher")
							.textContentType(.name)
							.font(.headline)
							.padding(.horizontal)
						
						Text("https://bosh.codes/")
							.textContentType(.emailAddress)
							.font(.subheadline)
							.padding([.horizontal, .bottom])
					}.frame(width: UIScreen.main.bounds.size.width / 2, height: 100, alignment: .center)
					
					Spacer()
				}
				
				Spacer()
				
				Button(action: {
					self.activeSheet = .transaction
					print("toggle")
				}) {
					Text("Add Transaction")
						.font(.system(size: 16))
						.fontWeight(.semibold)
						.foregroundColor(.white)
						.padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 50))
						.background(Color.blue)
						.cornerRadius(12)
				}
				
				.buttonStyle(PlainButtonStyle())
				.frame(maxWidth: .infinity)
				.padding()
			}
			
			.navigationBarTitle("About")
			.navigationBarItems(trailing: Button(action: {
				mine()
			}) {
				Text("Mine")
				if isLoading {
					ProgressView().foregroundColor(Color.blue)
						.progressViewStyle(CircularProgressViewStyle())
						.padding(4)
				} else {
					Image(systemName: "hammer.fill")
				}
			})

			// MARK: - TODO: Reformat the sheet selection

			.sheet(item: $activeSheet) { item in
				switch item {
				case .info:
					AddTransactionView()
				case .transaction:
					AddTransactionView()
				}
			}
			.alert(isPresented: $showingConfirmation) {
				Alert(title: Text(alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
			}
		}
	}
	
	func mine() {
		
		// MARK: - Enter URL here
		
		let url = URL(string: "http://192.168.1.22:5000/mine")!
		
		isLoading = true
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "GET"
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		let session: URLSession = URLSession(configuration: .default)
		do {
			session.dataTask(with: request) { data, _, error in
				guard let data = data else {
					print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
					self.alertTitle = "Error"
					self.confirmationMessage = "\(error?.localizedDescription ?? "An unknown error has occured")"
					self.showingConfirmation = true
					isLoading = false
					session.invalidateAndCancel()
					return
				}
				
				let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
				
				if let responseJSON = responseJSON as? [String: Any] {
					print(responseJSON)
					self.alertTitle = "Success"
					self.confirmationMessage = "\(responseJSON.description.replacingOccurrences(of: "[\"message\": ", with: "").replacingOccurrences(of: "]", with: ""))"
					self.showingConfirmation = true
					session.invalidateAndCancel()
					isLoading = false
				} else {
					print("Invalid response from server")
					self.alertTitle = "Error"
					self.confirmationMessage = "Invalid response from server"
					self.showingConfirmation = true
					isLoading = false
					session.invalidateAndCancel()
					return
				}
			}.resume()
		}
	}
}

#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif

struct MeView_Previews: PreviewProvider {
	static var previews: some View {
		Group {
			AboutView()
		}
	}
}

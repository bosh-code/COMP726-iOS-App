//
//  InfoSheetView.swift
//  EggChain
//
//  Created by Ryan Bosher on 25/08/20.
//

import SwiftUI

struct MineView: View {
	@State private var alertTitle = ""
	@State private var confirmationMessage = ""
	@State private var showingConfirmation = false
	@State private var isLoading = false
	@State private var chainData = [Chain]()
	
	var body: some View {
		VStack {
			Text("Block Mining ouput")
				.font(.title)
				.padding()
			
			if isLoading {
				Spacer()
				Text("Mining")
				ProgressView()
					.progressViewStyle(CircularProgressViewStyle())
					.padding(10)
				Spacer()
			}
			
			Button(action: { mine()
				self.hideKeyboard()
			}) {
				Text("Mine")
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
			.alert(isPresented: $showingConfirmation) {
				Alert(title: Text(alertTitle), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
			}
		}
	}
	
	func mine() {
		isLoading = true
		let url = URL(string: "http://192.168.1.69:5000/mine")!
		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "GET"
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		do {
			URLSession.shared.dataTask(with: request) { data, _, error in
				guard let data = data else {
					print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
					self.alertTitle = "Error"
					self.confirmationMessage = "\(error?.localizedDescription ?? "An unknown error has occured")"
					self.showingConfirmation = true
					isLoading = false
					return
				}
				
				let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
				
				if let responseJSON = responseJSON as? [String: Any] {
					print(responseJSON)
					self.alertTitle = "Success"
					self.confirmationMessage = "\(responseJSON.description.replacingOccurrences(of: "[\"message\": ", with: "").replacingOccurrences(of: "]", with: ""))"
					self.showingConfirmation = true
					
					isLoading = false
				} else {
					print("Invalid response from server")
					self.alertTitle = "Error"
					self.confirmationMessage = "Invalid response from server"
					self.showingConfirmation = true
					isLoading = false
					return
				}
			}.resume()
		} catch {
			print(error)
		}
	}
}

//
//  AddTransactionView.swift
//  EggChain
//
//  Created by Ryan Bosher on 25/08/20.
//

import SwiftUI

struct AddTransactionView: View {
	@State private var alertTitle = ""
	@State private var confirmationMessage = ""
	@State private var showingConfirmation = false

	@State private var sender: String = ""
	@State private var recipient: String = ""
	@State private var amount: String = ""
	@State private var type: String = ""
	@State private var code: String = ""
	var body: some View {
		Form {
			Section(header: Text("New Transaction:")) {
				TextField("Sender: e.g. Amy", text: $sender)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.disableAutocorrection(true)
					.padding(10)

				TextField("Recipient: e.g. Bob", text: $recipient)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.disableAutocorrection(true)
					.padding(10)

				TextField("Amount: e.g. 1", text: $amount)
					.keyboardType(.numberPad)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.disableAutocorrection(true)
					.padding(10)

				TextField("Type: e.g. Caged", text: $type)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.disableAutocorrection(true)
					.padding(10)

				TextField("Code: e.g. EGG123", text: $code)
					.textFieldStyle(RoundedBorderTextFieldStyle())
					.disableAutocorrection(true)
					.padding(10)

				Button(action: { submit()
					self.hideKeyboard()
				}) {
					Text("Submit Transaction")
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
	}

	func submit() {
		// Check form for empty fields
		if self.sender == "" || self.recipient == "" || self.amount == "" || self.type == "" || self.code == "" {
			print("sender empty")
			self.alertTitle = "Error"
			self.confirmationMessage = "Please fill in all fields"
			self.showingConfirmation = true
			return
		}

		// Check int amount is correct
		guard let intAmount = Int64(amount)
		else {
			print("Failed to convert int")
			self.alertTitle = "Error"
			self.confirmationMessage = "Incorrect amount"
			self.showingConfirmation = true
			return
		}

		// Create the URL & Request
		// MARK: - Enter URL heregit
		let url = URL(string: "http://192.168.1.69:5000/transactions/new")!
		// let url = URL(string: "http://172.28.47.188:5000/transactions/new")!

		var request = URLRequest(url: url)
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		request.httpMethod = "POST"
		let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		let transaction = Transaction( sender: sender, recipient: recipient, amount: intAmount, code: code, type: type)
		// Try send the request
		do {
			let data = try encoder.encode(transaction)
			request.httpBody = data

			URLSession.shared.dataTask(with: request) { data, _, error in
				guard let data = data else {
					print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
					self.alertTitle = "Error"
					self.confirmationMessage = "\(error?.localizedDescription ?? "An unknown error has occured")"
					self.showingConfirmation = true
					return
				}

				let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
				if let responseJSON = responseJSON as? [String: Any] {
					print(responseJSON)
					self.alertTitle = "Success"
					self.confirmationMessage = "\(responseJSON.description.replacingOccurrences(of: "[\"message\": ", with: "").replacingOccurrences(of: "]", with: ""))"
					self.showingConfirmation = true
				} else {
					print("Invalid response from server")
					self.alertTitle = "Error"
					self.confirmationMessage = "Invalid response from server"
					self.showingConfirmation = true
					return
				}
			}.resume()
		} catch {
			print(error)
		}
	}
}

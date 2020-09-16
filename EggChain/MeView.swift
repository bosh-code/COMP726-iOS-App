//
//  MeView.swift
//  EggChain
//
//  Created by Ryan Bosher on 24/08/20.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

let context = CIContext()
let filter = CIFilter.qrCodeGenerator()

enum ActiveSheet: Identifiable {
	case info, transaction
	
	var id: Int{
		self.hashValue
	}
}

struct MeView: View {
	@State var activeSheet: ActiveSheet?
	@State private var name = "Ryan Bosher"
	@State private var emailAddress = "https://bosh.codes/"
	
	init() {
	}
	
	var body: some View {
		NavigationView {
			VStack {
				Image("memojiCircle")
					.resizable()
					.scaledToFit()
					.padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
				HStack{
					Spacer()
					VStack{
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
				self.activeSheet = .info
			}) {
				Text("Info")
				Image(systemName: "info.circle")
			})
					
					.sheet(item: $activeSheet) { item in
						switch item {
						case .info:
							InfoSheetView()
							case .transaction:
							AddTransactionView()
						}
					}
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
					MeView()
				}
			}
		}

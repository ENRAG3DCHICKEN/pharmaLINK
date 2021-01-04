//
//  RefillPrescriptionSelection.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-05.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct RefillPrescriptionSelection: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var selection: Int?
    
    @State private var chosenPharmacy: Pharmacy?
    
    @State private var rx1: String = ""
    @State private var rx2: String = ""
    @State private var rx3: String = ""
    @State private var rx4: String = ""
    @State private var rx5: String = ""
    @State private var rx6: String = ""
        
    init(chosenPharmacy: Pharmacy?) {
        _chosenPharmacy = State(wrappedValue: chosenPharmacy)
    }
    
    var body: some View {
        

        
        VStack(spacing: 0) {
            
            Text("")
                .navigationBarBackButtonHidden(true)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Refill Prescription")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            self.selection = 0
                        } ) {
                            HStack {
                                Image(systemName: "chevron.backward").font(.headline)
                                Text("Back").font(.headline)
                            }
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
        
                            UserDefaults.standard.set( (rx1 + rx2 + rx3 + rx4 + rx5 + rx6), forKey: "refill_prescription")
                            self.selection = 1
                            
                        })  {
                            HStack {
                                Text("Next").font(.headline)
                                Image(systemName: "chevron.forward").font(.headline)
                            }
                        }
                            .disabled(rx1.isEmpty)
                    }
                }

            

            Form {
                Section(header: Text("Pharmacy Details: ")) {
                    Text("Pharmacy Name: \(chosenPharmacy!.pharmacyName)")
                    Text("Pharmacy Address: \(chosenPharmacy!.address)")
                    Text("Pharmacy Phone: \(chosenPharmacy!.phoneNumber)")
                }
                
                Section() {
                    TextField("Refill Rx #1: ", text: $rx1).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Refill Rx #2: ", text: $rx2).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Refill Rx #3: ", text: $rx3).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Refill Rx #4: ", text: $rx4).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Refill Rx #5: ", text: $rx5).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Refill Rx #6: ", text: $rx6).autocapitalization(.none).disableAutocorrection(true)
                }
                
            }
            
            
            
            
//            Button(action: {
//                self.selection = 0
//            } ) { Text("< Back").font(.body).bold() }
//                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                .foregroundColor(Color(.white))
//                .background(Color(UIColor.gradiant1))
//                .padding(.horizontal)
            
//            Button(action: {
//                UserDefaults.standard.set( (rx1 + rx2 + rx3 + rx4 + rx5 + rx6), forKey: "refill_prescription")
//                self.selection = 1
//            } ) { Text("Next >").font(.body).bold() }
//                .disabled(rx1.isEmpty)
//                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                .foregroundColor(Color(.white))
//                .background( (rx1.isEmpty) ? .gray : Color(UIColor.mainColor))
//                .padding()
            
            NavigationLink(destination: HomeView(), tag: 0, selection: $selection) { EmptyView() }
            NavigationLink(destination: CheckoutView(chosenPharmacy: chosenPharmacy!, prescriptionSource: "Refill RX - N/A", indicator: 3), tag: 1, selection: $selection) { EmptyView() }
            
        }
    }
}

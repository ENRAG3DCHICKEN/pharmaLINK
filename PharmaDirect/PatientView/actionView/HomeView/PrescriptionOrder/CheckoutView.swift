//
//  ShippingView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-12.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    
        @Environment(\.colorScheme) var colorScheme
    
        @State private var selection: Int?
        
        @State private var chosenPharmacy: Pharmacy
        @State private var indicator: Int
        @State private var prescriptionSource: String?
    
        //Patient Selection
        @State private var optionLocalPickup: Bool = true
        @State private var optionDelivery_Regular: Bool = false
        @State private var optionDelivery_Sameday: Bool = false
    
        @State private var shipFullName: String = ""
        @State private var shipAddress: String = ""
        @State private var shipCity: String = ""
        @State private var shipProvince: String = ""
        @State private var shipPostalCode: String = ""
        @State private var shipPhoneNumber: String = ""
    
        init(chosenPharmacy: Pharmacy, prescriptionSource: String?, indicator: Int) {
            _chosenPharmacy = State(wrappedValue: chosenPharmacy)
            _prescriptionSource = State(wrappedValue: prescriptionSource)
            _indicator = State(wrappedValue: indicator)
        }
        
        var body: some View {
            
        let od1 = Binding<Bool>(get: { self.optionLocalPickup }, set: { self.optionLocalPickup = $0; self.optionDelivery_Regular = false; self.optionDelivery_Sameday = false })
        let od2 = Binding<Bool>(get: { self.optionDelivery_Regular }, set: { self.optionDelivery_Regular = $0; self.optionLocalPickup = false; self.optionDelivery_Sameday = false })
        let od3 = Binding<Bool>(get: { self.optionDelivery_Sameday }, set: { self.optionDelivery_Sameday = $0; self.optionLocalPickup = false; self.optionDelivery_Regular = false })

            VStack() {

                Text("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Checkout View")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {
                                
                                //Back to New Prescriptions
                                if indicator == 2 {
                                    self.selection = 2
                                //Back to Refill Prescriptions
                                } else if indicator == 3 {
                                    self.selection = 3
                                //Back to Transfer Prescriptions
                                } else if indicator == 4 {
                                    self.selection = 4
                                }
                                
                            } ) {
                                HStack {
                                    Image(systemName: "chevron.backward").font(.headline)
                                    Text("Back").font(.headline)
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
            
                                if optionLocalPickup {
                                    UserDefaults.standard.set("Local Pickup", forKey: "shipOption")
                                } else if optionDelivery_Regular {
                                    UserDefaults.standard.set("Regular Delivery", forKey: "shipOption")
                                } else if optionDelivery_Sameday {
                                    UserDefaults.standard.set("Sameday Delivery", forKey: "shipOption")
                                }
                
                                UserDefaults.standard.set(shipFullName, forKey: "shipFullName")
                                UserDefaults.standard.set(shipAddress, forKey: "shipAddress")
                                UserDefaults.standard.set(shipCity, forKey: "shipCity")
                                UserDefaults.standard.set(shipProvince, forKey: "shipProvince")
                                UserDefaults.standard.set(shipPostalCode, forKey: "shipPostalCode")
                                UserDefaults.standard.set(shipPhoneNumber, forKey: "shipPhoneNumber")
                
                                self.selection = 1
                                
                            })  {
                                HStack {
                                    Text("Next").font(.headline)
                                    Image(systemName: "chevron.forward").font(.headline)
                                }
                            }
                                .disabled( !optionLocalPickup && shipFullName.isEmpty || !optionLocalPickup && shipAddress.isEmpty || !optionLocalPickup && shipProvince.isEmpty || !optionLocalPickup && shipPostalCode.isEmpty || !optionLocalPickup && shipPhoneNumber.isEmpty)
                        }
                    }
               
                Form {
                    Section(header: Text("Shipping Options: "))  {
                        
                        if chosenPharmacy.shipping_LocalPickup {
                            Toggle(isOn: od1) { Text("In-Store Pick Up - FREE").font(.body) }
                        }
                        if chosenPharmacy.shipping_FreeDelivery {
                            Toggle(isOn: od2) { Text("Regular Delivery - FREE").font(.body) }
                        }
                        if chosenPharmacy.shipping_SamedayDelivery {
                            Toggle(isOn: od3) { Text("Same-Day Delivery - ($5)").font(.body) }
                        }
                        
                    }
                    

                    if optionDelivery_Regular == true || optionDelivery_Sameday == true {
                        Section(header: Text("Shipping Details: ")) {
                               TextField("Full Name", text: $shipFullName).autocapitalization(.none).disableAutocorrection(true)
                                TextField("Address", text: $shipAddress).autocapitalization(.none).disableAutocorrection(true)
                                TextField("City", text: $shipCity).autocapitalization(.none).disableAutocorrection(true)
                                Picker(selection: $shipProvince, label: Text("Province")) {
                                    ForEach(0..<provinces.count) { index in
                                        Text(provinces[index]).tag(provinces[index])
                                    }
                                }
                                TextField("Postal Code", text: $shipPostalCode).autocapitalization(.none).disableAutocorrection(true)
                                TextField("Phone", text: $shipPhoneNumber).autocapitalization(.none).disableAutocorrection(true)
                        }
//                                .padding()
                    }
                }
            
            Spacer()
            
//            Button(action: {
//                //Back to New Prescriptions
//                if indicator == 2 {
//                    self.selection = 2
//                //Back to Refill Prescriptions
//                } else if indicator == 3 {
//                    self.selection = 3
//                //Back to Transfer Prescriptions
//                } else if indicator == 4 {
//                    self.selection = 4
//                }
//            }) { Text("< Back").font(.body).bold() }
//                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                .foregroundColor(Color(.white))
//                .background(Color(UIColor.gradiant1))
//                .padding(.horizontal)
//
//            Button(action: {
//
//                if optionLocalPickup {
//                    UserDefaults.standard.set("Local Pickup", forKey: "shipOption")
//                } else if optionDelivery_Regular {
//                    UserDefaults.standard.set("Regular Delivery", forKey: "shipOption")
//                } else if optionDelivery_Sameday {
//                    UserDefaults.standard.set("Sameday Delivery", forKey: "shipOption")
//                }
//
//                UserDefaults.standard.set(shipFullName, forKey: "shipFullName")
//                UserDefaults.standard.set(shipAddress, forKey: "shipAddress")
//                UserDefaults.standard.set(shipCity, forKey: "shipCity")
//                UserDefaults.standard.set(shipProvince, forKey: "shipProvince")
//                UserDefaults.standard.set(shipPostalCode, forKey: "shipPostalCode")
//                UserDefaults.standard.set(shipPhoneNumber, forKey: "shipPhoneNumber")
//
//                self.selection = 1
//
//            } ) { Text("Next >").font(.body).bold() }
//                .disabled( !optionLocalPickup && shipFullName.isEmpty || !optionLocalPickup && shipAddress.isEmpty || !optionLocalPickup && shipProvince.isEmpty || !optionLocalPickup && shipPostalCode.isEmpty || !optionLocalPickup && shipPhoneNumber.isEmpty)
//                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                .foregroundColor(Color(.white))
//                .background( !optionLocalPickup && shipFullName.isEmpty || !optionLocalPickup && shipAddress.isEmpty || !optionLocalPickup && shipProvince.isEmpty || !optionLocalPickup && shipPostalCode.isEmpty || !optionLocalPickup && shipPhoneNumber.isEmpty ? .gray : Color(UIColor.mainColor))
//                .padding()
            
                //Go BACK Views
                NavigationLink(destination: NewPrescriptionSelection(chosenPharmacy: chosenPharmacy), tag: 2, selection: $selection) { EmptyView() }
                NavigationLink(destination: RefillPrescriptionSelection(chosenPharmacy: chosenPharmacy), tag: 3, selection: $selection) { EmptyView() }
                NavigationLink(destination: TransferPrescriptionSelection(chosenPharmacy: chosenPharmacy), tag: 4, selection: $selection) { EmptyView() }
                
                
                //Go FORWARD Views
                NavigationLink(destination: SummaryCompletionView(chosenPharmacy: chosenPharmacy, prescriptionSource: prescriptionSource, indicator: indicator), tag: 1, selection: $selection) { EmptyView() }
            
        }
    }
}



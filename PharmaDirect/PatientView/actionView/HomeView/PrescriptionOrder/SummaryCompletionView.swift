//
//  SummaryCompletionView.swift
//  InstantCredit
//
//  Created by ENRAG3DMINX on 11/11/20.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct SummaryCompletionView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State private var selection: Int?
    
    @State private var prescriptionSource: String?
    @State private var chosenPharmacy: Pharmacy
    @State private var indicator: Int
    
    init(chosenPharmacy: Pharmacy, prescriptionSource: String?, indicator: Int) {
        _chosenPharmacy = State(wrappedValue: chosenPharmacy)
        _prescriptionSource = State(wrappedValue: prescriptionSource)
        _indicator = State(wrappedValue: indicator)
    }
    
    
    var body: some View {
        VStack {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            Text("Order Confirmation").font(.headline)
//            ScrollView {
                Form {
                    Section(header: Text("Your prescription will be fulfilled by: ")) {
                        Text("Pharmacy Name: \(chosenPharmacy.pharmacyName)")
                        Text("Pharmacy Phone: \(chosenPharmacy.phoneNumber)")
                        Text("Pharmacy Fax: \(chosenPharmacy.faxNumber)")
                    }
                    
                    
                    if UserDefaults.standard.string(forKey: "shipOption") != "optionLocalPickup" {
                        Section(header: Text("Your prescription will be shipped to: ")) {
                        // Delivery Details
                            
                            Text("Shipping Name: \(UserDefaults.standard.string(forKey: "shipFullName")!)")
                            Text("Shipping Address: \(UserDefaults.standard.string(forKey: "shipAddress")!)")
                            Text("Shipping City: \(UserDefaults.standard.string(forKey: "shipCity")!)")
                            Text("Shipping Province: \(UserDefaults.standard.string(forKey: "shipProvince")!)")
                            Text("Shipping Postal Code: \(UserDefaults.standard.string(forKey: "shipPostalCode")!)")
                            Text("Shipping Phone Number: \(UserDefaults.standard.string(forKey: "shipPhoneNumber")!)")
                            
                            Text("Expected Delivery: (5) Business Days")
                            
                        }
                    } else {
                        //Local Pickup Details
                        Section(header: Text("Your prescription will be available for pickup at: ")) {
                            Text("Pharmacy Name: \(chosenPharmacy.pharmacyName)")
                            Text("Pharmacy Address: \(chosenPharmacy.address)")
                            Text("Pharmacy Postal Code: \(chosenPharmacy.postalCode)")
                            Text("Pharmacy Phone: \(chosenPharmacy.phoneNumber)")
                        }
                    }
                    
                    Section(header: Text("Your prescription will be billed to: ")) {
                        Text("Billing Name: \(UserDefaults.standard.string(forKey: "fullName")!)")
                        Text("Billing Address: \(UserDefaults.standard.string(forKey: "address")!)")
                        Text("Billing City: \(UserDefaults.standard.string(forKey: "city")!)")
                        Text("Billing Province: \(UserDefaults.standard.string(forKey: "province")!)")
                        Text("Billing Postal Code: \(UserDefaults.standard.string(forKey: "postalCode")!)")
                        Text("Billing Phone Number: \(UserDefaults.standard.string(forKey: "phoneNumber")!)")
                    }
                    
                    Section(header: Text("Credit Card Information: ")) {
                        Text("Billing Credit Card: \(UserDefaults.standard.string(forKey: "paymentType")!)")
                        Text("Billing Cardholder Name: \(UserDefaults.standard.string(forKey: "cardholderName")!)")
                        Text("Billing Card Number: \(UserDefaults.standard.string(forKey: "paymentCardNumber")!)")
                        Text("Billing Expiry: \(UserDefaults.standard.integer(forKey: "expirationMM")) /  \(UserDefaults.standard.integer(forKey: "expirationYY"))")
                    }
            }
            Button(action: { self.selection = 0 } ) { Text("< Back").font(.body).bold() }
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .background(Color(UIColor.gradiant1))
                .padding(.horizontal)
                .foregroundColor(Color(.white))
            
            Button(action: {
                OrderSubmissionToCoreDataAndFB(context: context, chosenPharmacy: chosenPharmacy, prescriptionSource: prescriptionSource, indicator: indicator)
                self.selection = 1
            } ) { Text("Confirm Order >").font(.body).bold() }
                .environment(\.managedObjectContext, self.context)
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .background(Color(UIColor.mainColor))
                .padding()
                .foregroundColor(Color(.white))
            
            NavigationLink(destination: CheckoutView(chosenPharmacy: chosenPharmacy, prescriptionSource: prescriptionSource, indicator: indicator), tag: 0, selection: $selection) { EmptyView() }
            
            NavigationLink(destination: HomeView(), tag: 1, selection: $selection) { EmptyView() }
                    
        
        //
        }
        
    }
}

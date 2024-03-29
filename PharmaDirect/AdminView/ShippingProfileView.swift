//
//  ShippingProfileView.swift
//  PharmaDirect
//
//  Created by ENRAG3DCHICKEN on 2020-12-19.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData
import FirebaseFirestore
import Firebase

struct ShippingProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    
    @State private var pharmacy: Pharmacy?
    @State private var selection: Int?
    
    @State private var localPickupOption: Bool
    @State private var freeDeliveryOption: Bool
    @State private var samedayDeliveryOption: Bool
    

    init(pharmacy: Pharmacy?) {
        // Pharmacy is Initialized - Review and Save Pharmacy to Core Data before Returning to Admin View
        // Pharmacy is NOT Initialized - Return to Admin View
        _pharmacy = State(wrappedValue: pharmacy)
        _selection = State(wrappedValue: (pharmacy != nil ? 0 : 1))
        
        _localPickupOption = State(wrappedValue: pharmacy?.shipping_LocalPickup ?? false)
        _freeDeliveryOption = State(wrappedValue: pharmacy?.shipping_FreeDelivery ?? false)
        _samedayDeliveryOption = State(wrappedValue: pharmacy?.shipping_SamedayDelivery ?? false)
    }

    
    var body: some View {

        VStack {
            Form {
                Section(header: Text("Customer Delivery Options:")) {
                    Toggle("Local Pickup Option", isOn: $localPickupOption)
                    Toggle("Free Delivery Option", isOn: $freeDeliveryOption)
                    Toggle("Sameday Deliver Option", isOn: $samedayDeliveryOption)
                }
            }
            
            Button(action: {
                
                pharmacy!.shipping_LocalPickup = localPickupOption
                pharmacy!.shipping_FreeDelivery = freeDeliveryOption
                pharmacy!.shipping_SamedayDelivery = samedayDeliveryOption
                
                //One to Many Relationships
                pharmacy!.orderHistory.forEach { $0.objectWillChange.send() }
                pharmacy!.patientCustomer.forEach { $0.objectWillChange.send() }
                
                do {
                    try context.save()
                } catch(let error) {
                    print("couldn't save pharmacy update to CoreData: \(error.localizedDescription)")
                }
                
                //Send Pharmacy Shipping Profile Update to Firebase Firestore
                
                let db = Firestore.firestore()
                db.collection("pharmacies").getDocuments() { (querySnapshot, err) in
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        for document in querySnapshot!.documents {
                            
                            //this below line is for debugging
                            print("\(document.documentID) => \(document.data())")
                            
                            // Applies when user is logged in and identified as an admin account
                            if UserDefaults.standard.string(forKey: "email")! == (document.data()["EmailAddress"] as! String) {
                                db.collection("pharmacies").document(document.documentID).updateData([
                                    "Shipping_LocalPickupOption": self.localPickupOption,
                                    "Shipping_FreeDeliveryOption": self.freeDeliveryOption,
                                    "Shipping_SamedayDeliveryOption": self.samedayDeliveryOption,
                                ]) { err in
                                    if let err = err {
                                        print("Error updating document: \(err)")
                                    } else {
                                        print("Document successfully updated")
                                    }
                                }
                                self.selection = 1
                            }
                        }
                    }
                }

                self.selection = 1
     
            })  { Text("Submit").font(.body).bold() }
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.mainColor))
                .padding()
            
            NavigationLink(destination: AdminHomeView(), tag: 1, selection: $selection) { EmptyView() }
        }
    }
}

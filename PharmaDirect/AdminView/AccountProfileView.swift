//
//  AccountProfileView.swift
//  PharmaDirect
//
//  Created by ENRAG3DCHICKEN on 2020-12-19.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct AccountProfileView: View {
    
    @Environment(\.managedObjectContext) var context
    @State private var pharmacy: Pharmacy?
    
    @State private var address: String
    @State private var province: String
    @State private var city: String
    @State private var postalCode: String
    @State private var phoneNumber: String
    @State private var faxNumber: String

    @State private var selection: Int?
    
    init(pharmacy: Pharmacy?) {
        
        // Pharmacy is Initialized - Review and Save Pharmacy to Core Data before Returning to Admin View
        // Pharmacy is NOT Initialized - Return to Admin View
        _pharmacy = State(wrappedValue: pharmacy ?? nil)
        _selection = State(wrappedValue: nil ?? 1)
        _address = State(wrappedValue: pharmacy?.address ?? "")
        _province = State(wrappedValue: pharmacy?.province ?? "")
        _city = State(wrappedValue: pharmacy?.city ?? "")
        _postalCode = State(wrappedValue: pharmacy?.postalCode ?? "")
        _phoneNumber = State(wrappedValue: pharmacy?.phoneNumber ?? "")
        _faxNumber = State(wrappedValue: pharmacy?.faxNumber ?? "")
        
    }
    
    var body: some View {

        VStack {
            Form {
                Section(header: Text("Account Profile:")) {
                    TextField("Address: ", text: $address).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Province: ", text: $province).autocapitalization(.none).disableAutocorrection(true)
                    TextField("City: ", text: $city).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Postal Code: ", text: $postalCode).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Phone Number: ", text: $phoneNumber).autocapitalization(.none).disableAutocorrection(true)
                    TextField("Fax Number: ", text: $faxNumber).autocapitalization(.none).disableAutocorrection(true)
                }
            }
            
            Button(action: {
                
                pharmacy!.address = address
                pharmacy!.province = province
                pharmacy!.city = city
                pharmacy!.postalCode = postalCode
                pharmacy!.phoneNumber = phoneNumber
                pharmacy!.faxNumber = faxNumber
                              
                //One to Many Relationships
                pharmacy!.orderHistory.forEach { $0.objectWillChange.send() }
                pharmacy!.patientCustomer.forEach { $0.objectWillChange.send() }
                
                do {
                    try context.save()
                } catch(let error) {
                    print("couldn't save pharmacy update to CoreData: \(error.localizedDescription)")
                }

                self.selection = 1
     
            })  { Text("Submit").font(.body).bold() }
                .disabled(address.isEmpty || province.isEmpty || city.isEmpty || postalCode.isEmpty || phoneNumber.isEmpty || faxNumber.isEmpty)
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .foregroundColor(Color(.white))
                .background(address.isEmpty || province.isEmpty || city.isEmpty || postalCode.isEmpty || phoneNumber.isEmpty || faxNumber.isEmpty ? .gray : Color(UIColor.mainColor))
                .padding()
            
            NavigationLink(destination: AdminHomeView(), tag: 1, selection: $selection) { EmptyView() }
            
            
        }
    }
}

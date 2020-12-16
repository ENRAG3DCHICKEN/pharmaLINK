//
//  TransferPrescriptionMessage.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-11-29.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct TransferPrescriptionMessage: View {
    
    @State private var selection: Int?

    @State private var chosenPharmacy: Pharmacy?
    
    init(chosenPharmacy: Pharmacy?) {
        _chosenPharmacy = State(wrappedValue: chosenPharmacy)
    }
    
    var body: some View {
        VStack(spacing: 0) {

            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            Text("Transfer Prescription Request").font(.headline)
            
            
            Spacer()
            
            Form {
                Section {
                    Text("Only place transfer requests now for prescriptions you wish to have filled at this time")
                        .font(.body)
                        .multilineTextAlignment(.center)
                    
                    Text("Please place your orders for future prescriptions near the time you wish to have them shipped")
                        .font(.body)
                        .multilineTextAlignment(.center)
                }
            }
            
            Spacer()
            
            Button(action: {
                self.selection = 0
            } ) { Text("< Back").font(.body).bold() }
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.gradiant1))
                .padding(.horizontal)
            
            Button(action: {
                self.selection = 1
            } ) { Text("Next >").font(.body).bold() }
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.mainColor))
                .padding()   
            
            NavigationLink(destination: HomeView(), tag: 0, selection: $selection) { EmptyView() }
            NavigationLink(destination: TransferPrescriptionSelection(chosenPharmacy: chosenPharmacy!), tag: 1, selection: $selection) { EmptyView() }
            
        }
    }
}



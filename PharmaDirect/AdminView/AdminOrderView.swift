//
//  AdminOrderView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-08.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct AdminOrderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var chosenOrder: Orders
    
    init(chosenOrder: Orders) {
        _chosenOrder = State(wrappedValue: chosenOrder)
    }
    
    
    
    var body: some View {
        
        VStack {
            
            Text("")
                .navigationBarTitle("Order View")
                .navigationBarItems(trailing: action)
//                .navigationBarHidden(true)
                                     
            Form {
                
                //Order Details
                Section(header: Text("Order Details: ")) {
                    Text("Order Type: \(chosenOrder.orderType)")
                    if chosenOrder.orderType == "New Prescription" || chosenOrder.orderType == "Transfer Prescription" {
                        Text("Prescription Source: \(chosenOrder.prescriptionSource)")
                    }
                    if chosenOrder.orderType == "Refill Prescription" {
                        Text("Refill Prescription: \(chosenOrder.refill_prescription!)")
                    }
                    if chosenOrder.orderType == "Transfer Prescription" {
                        Text("Transfer from Pharmacy (Name): \(chosenOrder.trans_priorPharmacyName!)")
                        Text("Transfer from Pharmacy (Phone): \(chosenOrder.trans_priorPharmacyPhone!)")
                        Text("Transfer All Medication: \(chosenOrder.trans_transferAll ? "Yes" : "No")")
                        
                        if chosenOrder.trans_transferAll == false {
                            Text("Transfer the Following Medications: \(chosenOrder.trans_prescription!)")
                        }
                    }
                }
                
                //Patient Details
                Section(header: Text("Patient Details: ")) {
                    Text("Full Name: \(chosenOrder.patient.fullName)")
                    Text("Home Address: \(chosenOrder.patient.address)")
                    Text("City: \(chosenOrder.patient.city)")
                    Text("Email Address: \(chosenOrder.patient.emailAddress)")
                    Text("Postal Code: \(chosenOrder.patient.postalCode)")
                    Text("Phone Number: \(chosenOrder.patient.phoneNumber)")
                    Text("Province: \(chosenOrder.patient.province)")
                }
                
                //Patient Health Details
                Section(header: Text("Patient Health Details: ")) {
                    Text("Birth Date: \(chosenOrder.patient.healthInfo.birthDate)")
                    Text("Gender: \(chosenOrder.patient.healthInfo.gender)")
                    Text("Generic Substitution: \(String(chosenOrder.patient.healthInfo.genericSubstitution))")
                    Text("Allergies: \(chosenOrder.patient.healthInfo.specificAllergies)")
                    Text("Medical Conditions: \(chosenOrder.patient.healthInfo.specificMedicalConditions)")
                }
                
                //Patient Payment Details
                Section(header: Text("Patient Payment Details: ")) {
                    Text("Cardholder Name: \(chosenOrder.patient.paymentInfo.cardholderName)")
                    Text("Payment Type: \(chosenOrder.patient.paymentInfo.paymentType)")
                    Text("Payment Card Number: \(chosenOrder.patient.paymentInfo.paymentCardNumber)")
                    Text("Expiration MM: \(chosenOrder.patient.paymentInfo.expirationMM)")
                    Text("Expiration YY: \(String(chosenOrder.patient.paymentInfo.expirationYY))")
                    Text("CVV: \(chosenOrder.patient.paymentInfo.cvv)")
                }
                                
                //Patient Insurance Details
                Section(header: Text("Patient Insurance Details: ")) {
                    Text("OHIP Number: \(chosenOrder.patient.insuranceInfo.ohip)")
                    
                    if chosenOrder.patient.insuranceInfo.billToInsuranceFlag1 == true {
                        Group{
                            Text("Plan Name: \(chosenOrder.patient.insuranceInfo.planName1!)")
                            Text("Member ID: \(chosenOrder.patient.insuranceInfo.memberIDNumber1)")
                            Text("Group Number: \(chosenOrder.patient.insuranceInfo.groupNumber1)")
                            Text("Policyholder Name: \(chosenOrder.patient.insuranceInfo.policyholderName1!)")
                            Text("Carrier Code: \(chosenOrder.patient.insuranceInfo.carrierCode1!)")
                            Text("Policyholder DOB: \(chosenOrder.patient.insuranceInfo.policyholderDOB1)")
                            Text("Insurance Phone Number: \(chosenOrder.patient.insuranceInfo.insurancePhoneNumber1)")
                            Text("Relationship to Cardholder: \(chosenOrder.patient.insuranceInfo.relationshipToCardholder1!)")
                        }
                    }
                    
                    if chosenOrder.patient.insuranceInfo.billToInsuranceFlag2 == true {
                        Group{
                            Text("Plan Name: \(chosenOrder.patient.insuranceInfo.planName2!)")
                            Text("Member ID: \(chosenOrder.patient.insuranceInfo.memberIDNumber2)")
                            Text("Group Number: \(chosenOrder.patient.insuranceInfo.groupNumber2)")
                            Text("Policyholder Name: \(chosenOrder.patient.insuranceInfo.policyholderName2!)")
                            Text("Carrier Code: \(chosenOrder.patient.insuranceInfo.carrierCode2!)")
                            Text("Policyholder DOB: \(chosenOrder.patient.insuranceInfo.policyholderDOB2)")
                            Text("Insurance Phone Number: \(chosenOrder.patient.insuranceInfo.insurancePhoneNumber2)")
                            Text("Relationship to Cardholder: \(chosenOrder.patient.insuranceInfo.relationshipToCardholder2!)")
                        }
                    }
                    
                    if chosenOrder.patient.insuranceInfo.billToInsuranceFlag3 == true {
                        Group{
                            Text("Plan Name: \(chosenOrder.patient.insuranceInfo.planName3!)")
                            Text("Member ID: \(chosenOrder.patient.insuranceInfo.memberIDNumber3)")
                            Text("Group Number: \(chosenOrder.patient.insuranceInfo.groupNumber3)")
                            Text("Policyholder Name: \(chosenOrder.patient.insuranceInfo.policyholderName3!)")
                            Text("Carrier Code: \(chosenOrder.patient.insuranceInfo.carrierCode3!)")
                            Text("Policyholder DOB: \(chosenOrder.patient.insuranceInfo.policyholderDOB3)")
                            Text("Insurance Phone Number: \(chosenOrder.patient.insuranceInfo.insurancePhoneNumber3)")
                            Text("Relationship to Cardholder: \(chosenOrder.patient.insuranceInfo.relationshipToCardholder3!)")
                        }
                    }
                    
                }
              
                
            }
        }
        EmptyView()
    }

    @State private var showAction = false

    var action: some View {
        Button("Action") {
            self.showAction = true
        }
            .sheet(isPresented: $showAction) {
                PharmacistAction(chosenOrder: chosenOrder, showAction: $showAction)
            }
    }
    
}
    
    
struct PharmacistAction: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var showAction: Bool
    
    @State private var chosenOrder: Orders
    
    @State private var patientEntryCompleted: Bool
    @State private var rxEntryCompleted: Bool
    @State private var rxPreparationCompleted: Bool
    @State private var rxCompleted: Bool

    
    
    init(chosenOrder: Orders, showAction: Binding<Bool>) {
        _chosenOrder = State(wrappedValue: chosenOrder)
        _showAction = showAction
        
        _patientEntryCompleted = State(wrappedValue: chosenOrder.statusPatientEntry)
        _rxEntryCompleted = State(wrappedValue: chosenOrder.statusRXEntry)
        _rxPreparationCompleted = State(wrappedValue: chosenOrder.statusRXPrep)
        _rxCompleted = State(wrappedValue: chosenOrder.statusRXCompleted)
    }
    
    var body: some View {
        NavigationView {
            Form {
                
                Section {
                    Text("Patient Fulfillment Method: \(chosenOrder.fulfillmentOption)")
                        .navigationBarTitle("Admin Order Management:")
                        .navigationBarItems(leading: cancel, trailing: done)
                }
                
                Section(header: Text("Pharmacy Completion Status:")) {
                    Toggle("Patient Entry Completed:", isOn: $patientEntryCompleted)
                    Toggle("Prescription Entry Completed:", isOn: $rxEntryCompleted)
                    Toggle("Prescription Preparation Completed:", isOn: $rxPreparationCompleted)
                    Toggle("Prescription Completed:", isOn: $rxCompleted)
                }
                
                if chosenOrder.fulfillmentOption_ != "Local Pickup" {
                    //Patient Fulfillment Details
                    Section(header: Text("Patient Shipping Details: ")) {
                        Text("Shipping Name: \(chosenOrder.patient.shippingInfo.fullName)")
                        Text("Shipping Address: \(chosenOrder.patient.shippingInfo.address)")
                        Text("Shipping Province: \(chosenOrder.patient.shippingInfo.province)")
                        Text("Shipping City: \(chosenOrder.patient.shippingInfo.city)")
                        Text("Shipping Postal Code: \(String(chosenOrder.patient.shippingInfo.postalCode))")
                        Text("Shipping Phone Number: \(chosenOrder.patient.shippingInfo.phoneNumber)")
                    }
                }
            }
        }
    }
    
    var cancel: some View {
        Button("Cancel") {
            self.showAction = false
        }
    }
    
    var done: some View {
        Button("Done") {
            
            if patientEntryCompleted == true {
                chosenOrder.statusPatientEntry = true
            }
            if rxEntryCompleted == true {
                chosenOrder.statusRXEntry = true
            }
            if rxPreparationCompleted == true {
                chosenOrder.statusRXPrep = true
            }
            if rxCompleted == true {
                chosenOrder.statusRXCompleted = true
            }
            
            if (patientEntryCompleted && rxEntryCompleted && rxPreparationCompleted && rxCompleted) {
                chosenOrder.orderCompleted = true
            }
            
            self.showAction = false
        }
    }
    
}
    
    
    
    
    


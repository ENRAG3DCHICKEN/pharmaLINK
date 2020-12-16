//
//  PatientOrderView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-13.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct PatientOrderView: View {
    
    @State private var chosenOrder: Orders
    
    init(chosenOrder: Orders) {
        _chosenOrder = State(wrappedValue: chosenOrder)
    }
    
    
    var body: some View {
        VStack {
            
            EmptyView()
                .navigationBarTitle("Order View")
//                .navigationBarItems(trailing: action)
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
                
                //Pharmacy Details
                Section(header: Text("Pharmacy Details: ")) {
                    Text("Pharmacy Name: \(chosenOrder.fulfillmentPharmacy.pharmacyName)")
                    Text("Accreditation Number: \(chosenOrder.fulfillmentPharmacy.accreditationNumber)")
                    Text("Address: \(chosenOrder.fulfillmentPharmacy.address)")
                    Text("Province: \(chosenOrder.fulfillmentPharmacy.province)")
                    Text("City: \(chosenOrder.fulfillmentPharmacy.city)")
                    Text("Postal Code: \(chosenOrder.fulfillmentPharmacy.postalCode)")
                    Text("Fax Number: \(chosenOrder.fulfillmentPharmacy.faxNumber)")
                    Text("Phone Number: \(chosenOrder.fulfillmentPharmacy.phoneNumber)")
                }
                
                                
                //Patient Health Details
                Section(header: Text("Patient Health Details: ")) {
                    Text("Birth Date: \(chosenOrder.patient.healthInfo.birthDate)")
                    Text("Gender: \(chosenOrder.patient.healthInfo.gender)")
                    Text("Generic Substitution: \(String(chosenOrder.patient.healthInfo.genericSubstitution))")
                    Text("Allergies: \(chosenOrder.patient.healthInfo.specificAllergies)")
                    Text("Medical Conditions: \(chosenOrder.patient.healthInfo.specificMedicalConditions)")
                }
                
                //Patient Fulfillment Details
                Section(header: Text("Patient Fulfillment Details: ")) {
                    Text("Shipping Name: \(chosenOrder.patient.shippingInfo.fullName)")
                    Text("Shipping Address: \(chosenOrder.patient.shippingInfo.address)")
                    Text("Shipping Province: \(chosenOrder.patient.shippingInfo.province)")
                    Text("Shipping City: \(chosenOrder.patient.shippingInfo.city)")
                    Text("Shipping Postal Code: \(String(chosenOrder.patient.shippingInfo.postalCode))")
                    Text("Shipping Phone Number: \(chosenOrder.patient.shippingInfo.phoneNumber)")
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
}

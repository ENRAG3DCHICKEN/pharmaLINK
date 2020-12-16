//
//  Ext+Patient.swift
//  InstantCredit
//
//  Created by ENRAG3DMINX on 11/18/20.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData
import Combine
import UIKit
import FirebaseAuth


//Make Patient both identifiable and comporable


//Patient Core Data, Optional Value Check
extension Patient {
    
    //Attributes
    var address: String {
        get { address_! }
        set { address_ = newValue }
    }
    var city: String {
        get { city_! }
        set { city_ = newValue }
    }
    var emailAddress: String {
        get { emailAddress_! }
        set { emailAddress_ = newValue }
    }
    var fullName: String {
        get { fullName_! }
        set { fullName_ = newValue }
    }
    var patientUUID: String {
        get { patientUUID_! }
        set { patientUUID_ = newValue }
    }
    var phoneNumber: String {
        get { phoneNumber_! }
        set { phoneNumber_ = newValue }
    }
    var postalCode: String {
        get { postalCode_! }
        set { postalCode_ = newValue }
    }
    var privacyCompletionFlag: Bool {
        get { privacyCompletionFlag_ }
        set { privacyCompletionFlag_ = newValue }
    }
    var province: String {
        get { province_! }
        set { province_ = newValue }
    }
    var signupCompletionFlag: Bool {
        get { signupCompletionFlag_ }
        set { signupCompletionFlag_ = newValue }
    }
        
    //One to One Relationships
    var healthInfo: PatientHealthDetails {
        get { healthInfo_! }
        set { healthInfo_ = newValue }
    }
    var insuranceInfo: PatientInsuranceDetails {
        get { insuranceInfo_!}
        set { insuranceInfo_ = newValue }
    }
    var paymentInfo: PatientPaymentDetails {
        get { paymentInfo_! }
        set { paymentInfo_ = newValue }
    }
    var shippingInfo: PatientFulfillmentDetails {
        get { shippingInfo_! }
        set { shippingInfo_ = newValue }
    }

    //One to Many Relationships
    var orderHistory: Set<Orders> {
        get { (orderHistory_ as? Set<Orders>) ?? [] }
        set { orderHistory_ = newValue as NSSet }
    }
    var orderPharmacy: Set<Pharmacy> {
        get { (orderPharmacy_ as? Set<Pharmacy>) ?? [] }
        set { orderPharmacy_ = newValue as NSSet }
    }
    
}


extension Patient {
    
    //Standard query request to Core Data
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Patient> {
        let request = NSFetchRequest<Patient>(entityName: "Patient")
        // need to sort by distance
        request.sortDescriptors = [NSSortDescriptor(key: "emailAddress_", ascending: true)]
        request.predicate = predicate
        return request
    }
}


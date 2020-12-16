//
//  Ext+PatientPaymentDetails.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-11-28.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//


import SwiftUI
import CoreData
import Combine
import UIKit

//PatientPaymentDetails Core Data, Optional Value Check
extension PatientPaymentDetails {
    
    //Attributes
    var cardholderName: String {
        get { cardholderName_! }
        set { cardholderName_ = newValue }
    }
    var cvv: Int64 {
        get { cvv_ }
        set { cvv_ = newValue }
    }
    var expirationMM: Int64 {
        get { expirationMM_ }
        set { expirationMM_ = newValue }
    }
    var expirationYY: Int64 {
        get { expirationYY_ }
        set { expirationYY_ = newValue }
    }
    var paymentCardNumber: Int64 {
        get { paymentCardNumber_ }
        set { paymentCardNumber_ = newValue }
    }
    var paymentType: String {
        get { paymentType_! }
        set { paymentType_ = newValue }
    }
    
    //One to One Relationships
    var patient: Patient {
        get { patient_! }
        set { patient_ = newValue }
    }
    
    //One to Many Relationships

}

extension PatientPaymentDetails {
    //Standard query request to Core Data
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<PatientPaymentDetails> {
        let request = NSFetchRequest<PatientPaymentDetails>(entityName: "PatientPaymentDetails")
        // need to sort by distance
        request.sortDescriptors = [NSSortDescriptor(key: "cardholderName_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

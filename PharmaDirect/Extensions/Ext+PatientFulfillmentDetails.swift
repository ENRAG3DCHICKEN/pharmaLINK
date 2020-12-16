//
//  Ext+PatientShippingDetails.swift
//  InstantCredit
//
//  Created by ENRAG3DMINX on 11/20/20.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData
import Combine
import UIKit

//PatientFulfillmentDetails Core Data, Optional Value Check
extension PatientFulfillmentDetails {
    
    //Attributes
    var address: String {
        get { address_! }
        set { address_ = newValue }
    }
    var city: String {
        get { city_! }
        set { city_ = newValue }
    }
    var fullName: String {
        get { fullName_! }
        set { fullName_ = newValue }
    }
    var phoneNumber: String {
        get { phoneNumber_! }
        set { phoneNumber_ = newValue }
    }
    var postalCode: String {
        get { postalCode_! }
        set { postalCode_ = newValue }
    }
    var province: String {
        get { province_! }
        set { province_ = newValue }
    }

    //One to One Relationships
    var patient: Patient {
        get { patient_! }
        set { patient_ = newValue }
    }
    
    //One to Many Relationships

}

extension PatientFulfillmentDetails {
    //Standard query request to Core Data
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<PatientFulfillmentDetails> {
        let request = NSFetchRequest<PatientFulfillmentDetails>(entityName: "PatientFulfillmentDetails")
        // need to sort by distance
        request.sortDescriptors = [NSSortDescriptor(key: "fullName_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

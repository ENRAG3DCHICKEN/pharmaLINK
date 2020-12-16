//
//  Ext+PatientInsuranceDetails.swift
//  PharmaDirect
//
//  Created by ENRAG3DCHICKEN on 2020-12-15.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//


import SwiftUI
import CoreData
import Combine
import UIKit

//PatientInsuranceDetails Core Data, Optional Value Check

extension PatientInsuranceDetails {
    //Standard query request to Core Data
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<PatientPaymentDetails> {
        let request = NSFetchRequest<PatientPaymentDetails>(entityName: "PatientPaymentDetails")
        // need to sort by distance
        request.sortDescriptors = [NSSortDescriptor(key: "cardholderName_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

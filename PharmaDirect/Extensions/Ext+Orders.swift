//
//  Ext+Orders.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-06.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

extension Orders {
    
    //Standard query request to Core Data
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Orders> {
        let request = NSFetchRequest<Orders>(entityName: "Orders")
        request.sortDescriptors = [NSSortDescriptor(key: "orderSubmissionTime_", ascending: false)]
        request.predicate = predicate
        return request
    }

}

//Orders Core Data, Optional Value Check
extension Orders {
    
    //Attributes
    var orderCompleted: Bool {
        get { orderCompleted_ }
        set { orderCompleted_ = newValue }
    }
    var orderSubmissionTime: Date {
        get { orderSubmissionTime_! }
        set { orderSubmissionTime_ = newValue }
    }
    var orderType: String {
        get { orderType_! }
        set { orderType_ = newValue }
    }
    var orderUUID: UUID {
        get { orderUUID_! }
        set { orderUUID_ = newValue }
    }
    var patientEmailAddress: String {
        get { patientEmailAddress_! }
        set { patientEmailAddress_ = newValue }
    }
    var pharmacyAccreditationNumber: Int64 {
        get { pharmacyAccreditationNumber_ }
        set { pharmacyAccreditationNumber_ = newValue }
    }
    var pharmacyEmailAddress: String {
        get { pharmacyEmailAddress_! }
        set { pharmacyEmailAddress_ = newValue }
    }
    var pharmacyName: String {
        get { pharmacyName_! }
        set { pharmacyName_ = newValue }
    }
    var prescriptionSource: String {
        get { prescriptionSource_! }
        set { prescriptionSource_ = newValue }
    }
//    var refill_prescription: String {
//        get { refill_prescription_! }
//        set { refill_prescription_ = newValue }
//    }
//    var trans_prescription: String {
//        get { trans_prescription_! }
//        set { trans_prescription_ = newValue }
//    }
//    var trans_priorPharmacyName: String {
//        get { trans_priorPharmacyName_! }
//        set { trans_priorPharmacyName_ = newValue }
//    }
//    var trans_priorPharmacyPhone: String {
//        get { trans_priorPharmacyPhone_! }
//        set { trans_priorPharmacyPhone_ = newValue }
//    }
//    var trans_transferAll: Bool {
//        get { trans_transferAll_ }
//        set { trans_transferAll_ = newValue }
//    }
    
    //One to One Relationships
    var fulfillmentPharmacy: Pharmacy {
        get { fulfillmentPharmacy_! }
        set { fulfillmentPharmacy_ = newValue }
    }
    var patient: Patient {
        get { patient_! }
        set { patient_ = newValue }
    }
    
    
    //One to Many Relationships

}


//
//  OrderSubmissionView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-04.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//



import SwiftUI
import CoreData
import Firebase
import FirebaseFirestore


func OrderSubmissionToCoreDataAndFB(context: NSManagedObjectContext, chosenPharmacy: Pharmacy, prescriptionSource: String?, indicator: Int) {
    
    //Standard query request to Core Data (Patient Details)
    let request = NSFetchRequest<Patient>(entityName: "Patient")
    request.sortDescriptors = [NSSortDescriptor(key: "emailAddress_", ascending: true)]
    request.predicate = NSPredicate(format: "emailAddress_ = %@", UserDefaults.standard.string(forKey: "email")!)
    let results = (try? context.fetch(request)) ?? []
    let patient = results.first
    
    let patientFulfillmentDetails: PatientFulfillmentDetails = PatientFulfillmentDetailsObjectUpdate(context: context, patient: patient!)
    let orders: Orders = OrdersObjectUpdate(context: context, patient: patient!, chosenPharmacy: chosenPharmacy, prescriptionSource: prescriptionSource, indicator: indicator)
    groupedObjectsWillChange_Orders(context: context, patientFulfillmentDetails: patientFulfillmentDetails, orders: orders)
    print("Core Data Order Submission Completed!")

    SendOrdersToFirestore(orders: orders)
    UpdatePatientFulfillmentDetailsOnFirestore(context: context)
    
    ClearOrderRelatedUserDefaults()

}

func PatientFulfillmentDetailsObjectUpdate(context: NSManagedObjectContext, patient: Patient) -> PatientFulfillmentDetails {
    

    
    //Standard query request to Core Data (Patient Fulfillment Details)
    let request = NSFetchRequest<PatientFulfillmentDetails>(entityName: "PatientFulfillmentDetails")
    request.sortDescriptors = [NSSortDescriptor(key: "fullName_", ascending: true)]
    request.predicate = NSPredicate(format: "patient_ = %@", patient)

    let results = (try? context.fetch(request)) ?? []
    let patientFulfillmentDetails = results.first ?? PatientFulfillmentDetails(context: context)
    
    patientFulfillmentDetails.address = UserDefaults.standard.string(forKey: "shipAddress")!
    patientFulfillmentDetails.city = UserDefaults.standard.string(forKey: "shipCity")!
    patientFulfillmentDetails.fullName = UserDefaults.standard.string(forKey: "shipFullName")!
    patientFulfillmentDetails.postalCode = UserDefaults.standard.string(forKey: "shipPostalCode")!
    patientFulfillmentDetails.province = UserDefaults.standard.string(forKey: "shipProvince")!
    patientFulfillmentDetails.phoneNumber = UserDefaults.standard.string(forKey: "shipPhoneNumber")!
    patientFulfillmentDetails.patient = patient
    
    do {
        try context.save()
    } catch(let error) {
        print("couldn't save patient fulfillment details update to CoreData: \(error.localizedDescription)")
    }
    
    return patientFulfillmentDetails
}

func OrdersObjectUpdate(context: NSManagedObjectContext, patient: Patient, chosenPharmacy: Pharmacy, prescriptionSource: String?, indicator: Int) -> Orders {
    
    let orders = Orders(context: context)
    
    orders.orderCompleted = false
    orders.orderUUID = UUID()
    orders.patientEmailAddress = UserDefaults.standard.string(forKey: "email")!
    orders.pharmacyName = chosenPharmacy.pharmacyName
    orders.pharmacyAccreditationNumber = chosenPharmacy.accreditationNumber
    orders.pharmacyEmailAddress = chosenPharmacy.emailAddress
    orders.orderSubmissionTime = Date()
    
    orders.fulfillmentPharmacy = chosenPharmacy
    orders.patient = patient
    
    //Back to New Prescriptions
    if indicator == 2 {
        orders.orderType = "New Prescription"
        orders.prescriptionSource = prescriptionSource!
    //Back to Refill Prescriptions
    } else if indicator == 3 {
        orders.orderType = "Refill Prescription"
        orders.prescriptionSource = prescriptionSource!
        orders.refill_prescription = UserDefaults.standard.string(forKey: "refill_prescription")!
    //Back to Transfer Prescriptions
    } else if indicator == 4 {
        orders.orderType = "Tramsfer Prescription"
        orders.prescriptionSource = prescriptionSource!
        orders.trans_priorPharmacyName = UserDefaults.standard.string(forKey: "transPriorPharmacyName")!
        orders.trans_priorPharmacyPhone = UserDefaults.standard.string(forKey: "transPriorPharmacyPhone")!
        orders.trans_transferAll = UserDefaults.standard.bool(forKey: "transAllFlag")
        orders.trans_prescription = UserDefaults.standard.string(forKey: "transMedication1")! + UserDefaults.standard.string(forKey: "transMedication2")! + UserDefaults.standard.string(forKey: "transMedication3")! + UserDefaults.standard.string(forKey: "transMedication4")! + UserDefaults.standard.string(forKey: "transMedication5")! + UserDefaults.standard.string(forKey: "transMedication6")!
    }

    do {
        try context.save()
    } catch(let error) {
        print("couldn't save orders update to CoreData: \(error.localizedDescription)")
    }

    return orders
}

func groupedObjectsWillChange_Orders(context: NSManagedObjectContext, patientFulfillmentDetails: PatientFulfillmentDetails, orders: Orders) {

    //PatientFulfillmentDetails
    patientFulfillmentDetails.objectWillChange.send()
    
    //Orders
    orders.objectWillChange.send()

    do {
        try context.save()
    } catch(let error) {
        print("couldn't save patient fulfillment details update to CoreData: \(error.localizedDescription)")
    }
}

func SendOrdersToFirestore(orders: Orders) {
    
    //Populate Core Data asynchronously on secondary queue
    DispatchQueue.global(qos: .userInitiated).async {
        
        //Search firebase for documents = pharmacies
        let db = Firestore.firestore()
        
        // Add a new document in collection "orders"
        db.collection("orders").document((orders.orderUUID).uuidString).setData([
            "orderCompleted": orders.orderCompleted,
            "orderSubmissionTime": orders.orderSubmissionTime as Any,
            "orderType": orders.orderType,
            "orderUUID": ((orders.orderUUID).uuidString),
            "patientEmailAddress": orders.patientEmailAddress,
            "pharmacyAccreditationNumber": orders.pharmacyAccreditationNumber,
            "pharmacyName": orders.pharmacyName,
            "pharmacyEmailAddress": orders.pharmacyEmailAddress,
            "prescriptionSource": orders.prescriptionSource,
            "refill_prescription": orders.refill_prescription ?? "",
            "trans_prescription": orders.trans_prescription ?? "",
            "trans_priorPharmacyName": orders.trans_priorPharmacyName ?? "",
            "trans_priorPharmacyPhone": orders.trans_priorPharmacyPhone ?? "",
            "trans_transferAll": orders.trans_transferAll,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
            }
        }
    }
}

func UpdatePatientFulfillmentDetailsOnFirestore(context: NSManagedObjectContext) {
    
    //Standard query request to Core Data
    let request = NSFetchRequest<Patient>(entityName: "Patient")
    request.sortDescriptors = [NSSortDescriptor(key: "emailAddress_", ascending: true)]
    request.predicate = NSPredicate(format: "emailAddress_ == %@", String(UserDefaults.standard.string(forKey: "email")!))

    let results = (try? context.fetch(request)) ?? []
    let patient = results.first

    
    //Check if the Patient Fulfillment Details doc already exists for a Patient
    // If the doc exists then update it
    // If the doc does not exist, then create it
    
    //Populate Core Data asynchronously on secondary queue
    DispatchQueue.global(qos: .userInitiated).async {
        
        //Search firebase for documents
        let db = Firestore.firestore()
    
        db.collection("users").document((patient?.patientUUID)!).collection("ShippingAddress").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
                
                
           

func ClearOrderRelatedUserDefaults() {
    
    UserDefaults.standard.removeObject(forKey: "refill_prescription")

    UserDefaults.standard.removeObject(forKey: "transPriorPharmacyName")
    UserDefaults.standard.removeObject(forKey: "transPriorPharmacyPhone")
    UserDefaults.standard.removeObject(forKey: "transAllFlag")
    
    UserDefaults.standard.removeObject(forKey: "transMedication1")
    UserDefaults.standard.removeObject(forKey: "transMedication2")
    UserDefaults.standard.removeObject(forKey: "transMedication3")
    UserDefaults.standard.removeObject(forKey: "transMedication4")
    UserDefaults.standard.removeObject(forKey: "transMedication5")
    UserDefaults.standard.removeObject(forKey: "transMedication6")
    
    UserDefaults.standard.removeObject(forKey: "shipFullName")
    UserDefaults.standard.removeObject(forKey: "shipAddress")
    UserDefaults.standard.removeObject(forKey: "shipCity")
    UserDefaults.standard.removeObject(forKey: "shipProvince")
    UserDefaults.standard.removeObject(forKey: "shipPostalCode")
    UserDefaults.standard.removeObject(forKey: "shipPhoneNumber")
    
}

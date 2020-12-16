//
//  Pharmacy.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-19.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import CoreData
import Combine
import UIKit
import MapKit

extension Pharmacy: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    public var title: String? { pharmacyName }
    public var subtitle: String? { address }
}

extension Pharmacy: Comparable {
    public static func < (lhs: Pharmacy, rhs: Pharmacy) -> Bool {
        //replace with calcualted distance
        lhs.latitude < rhs.latitude
    }
    
    // should probably be Identifiable & Comparable
   
    static func update(fbPharmacyData: Dictionary<String,Any>, in context: NSManagedObjectContext) {
        
        //Look for a pharmacy with a specific item:
            
            //Retrieve all PharmacyUUID records from Firebase
            print(fbPharmacyData["AccreditationNumber"] as! CVarArg)
            
            //Setup NSFetchRequest variable using the same Pharmacy UUID as Firebase
            let request = fetchRequest(NSPredicate(format: "accreditationNumber_ = %@", fbPharmacyData["AccreditationNumber"] as! CVarArg))
                                       
        print("A")
        print(request)
            //Retrieve all Core Data records with the same PharmacyUUID (same as Firebase - using the NSFetchRequest variable setup in the line directly above)
            let results = (try? context.fetch(request)) ?? []
        print("B")
        print(results)
        
        let pharmacy = results.first ?? Pharmacy(context: context)
        print("C")
        print(pharmacy)
        
        //If pharmacy exists, update existing pharmacy in core data - else if pharmacy doesn't exist, create & populate!
        pharmacy.accreditationNumber = fbPharmacyData["AccreditationNumber"] as! Int64
        pharmacy.address = (fbPharmacyData["Address"] as? String)!
        pharmacy.city = (fbPharmacyData["City"] as? String)!
        pharmacy.emailAddress = (fbPharmacyData["EmailAddress"] as? String)!
        pharmacy.longitude = Double(truncating: fbPharmacyData["Longitude"] as! NSNumber)
        pharmacy.latitude = Double(truncating: fbPharmacyData["Latitude"] as! NSNumber)
        pharmacy.pharmacyName = (fbPharmacyData["PharmacyName"] as? String)!
        pharmacy.phoneNumber = (fbPharmacyData["PhoneNumber"] as? String)!
        pharmacy.faxNumber = (fbPharmacyData["FaxNumber"] as? String)!
        pharmacy.postalCode = (fbPharmacyData["PostalCode"] as? String)!
        pharmacy.province = (fbPharmacyData["Province"] as? String)!
        pharmacy.pharmacyUUID = (fbPharmacyData["PharmacyUUID"] as? String)!
            
        pharmacy.objectWillChange.send()
        
        pharmacy.orderHistory.forEach { $0.objectWillChange.send() }
        
        //Add relationships will change!
        
        print(pharmacy)
    
        do {
            
//            Code for debugging - allows you to delete all the individual records and fields from an entity - everything in Pharmacy while leaving pharmacy intact
//            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Pharmacy.fetchRequest()
//            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//            let persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
//            try persistentContainer.viewContext.execute(deleteRequest)
            try context.save()
            
            //New code after bug on ipad vs iphone
            pharmacy.objectWillChange.send()
            
        } catch(let error) {
            print("couldn't save pharmacy update to CoreData: \(error.localizedDescription)")
        }
    }
        
    //Standard query request to Core Data
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Pharmacy> {
        let request = NSFetchRequest<Pharmacy>(entityName: "Pharmacy")
        // need to sort by distance
        request.sortDescriptors = [NSSortDescriptor(key: "latitude_", ascending: true)]
        request.predicate = predicate
        return request
    }
}


//Pharmacy Core Data, Optional Value Check
extension Pharmacy {
    
    //Attributes
    var accreditationNumber: Int64 {
        get { accreditationNumber_ }
        set { accreditationNumber_ = newValue }
    }
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
    var faxNumber: String {
        get { faxNumber_! }
        set { faxNumber_ = newValue }
    }
    var latitude: Double {
        get { latitude_ }
        set { latitude_ = newValue }
    }
    var longitude: Double {
        get { longitude_ }
        set { longitude_ = newValue }
    }
    var pharmacyName: String {
        get { pharmacyName_! }
        set { pharmacyName_ = newValue }
    }
    var pharmacyUUID: String {
        get { pharmacyUUID_! }
        set { pharmacyUUID_ = newValue }
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
 
    
    //One to Many Relationships
        // Downcast from NSSet to Set<Orders> and checks if nil, and returns empty array if nil
    var orderHistory: Set<Orders> {
        get { (orderHistory_ as? Set<Orders>) ?? [] }
        set { orderHistory_ = newValue as NSSet }
    }
    
    var patientCustomer: Set<Patient> {
        get { (patientCustomer_ as? Set<Patient>) ?? [] }
        set { patientCustomer_ = newValue as NSSet }
    }
}



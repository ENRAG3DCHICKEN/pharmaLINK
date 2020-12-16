//
//  LoginViewHelper.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-09.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData
import Firebase
import FirebaseAuth



func CallTransferCoreDataToUserDefaults_Patient(context: NSManagedObjectContext) {
    //Standard query request to Core Data
    let request = NSFetchRequest<Patient>(entityName: "Patient")
    request.sortDescriptors = [NSSortDescriptor(key: "emailAddress_", ascending: true)]
    request.predicate = NSPredicate(format: "emailAddress_ = %@", UserDefaults.standard.string(forKey: "email")!)

    let results = (try? context.fetch(request)) ?? []
    let patient = results.first
    
    UserDefaults.standard.set(patient?.fullName, forKey: "fullName")
    UserDefaults.standard.set(patient?.address, forKey: "address")
    UserDefaults.standard.set(patient?.city, forKey: "city")
    UserDefaults.standard.set(patient?.province, forKey: "province")
    UserDefaults.standard.set(patient?.postalCode, forKey: "postalCode")
    UserDefaults.standard.set(patient?.phoneNumber, forKey: "phoneNumber")
    UserDefaults.standard.set(patient?.privacyCompletionFlag, forKey: "privacyCompletionFlag")
    UserDefaults.standard.set(patient?.signupCompletionFlag,forKey: "signupCompletionFlag")
}

func CallTransferCoreDataToUserDefaults_PatientHealthDetails(context: NSManagedObjectContext, patient: Patient) {
    //Standard query request to Core Data
    let request = NSFetchRequest<PatientHealthDetails>(entityName: "PatientHealthDetails")
    request.sortDescriptors = [NSSortDescriptor(key: "gender_", ascending: true)]
    request.predicate = NSPredicate(format: "patient_ = %@", patient)

    let results = (try? context.fetch(request)) ?? []
    let patientHealthDetails = results.first

        let dateAsString = patientHealthDetails?.birthDate
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        let coreDataDate = df.date(from: dateAsString!)
    
    UserDefaults.standard.set(coreDataDate, forKey: "birthDate")
    UserDefaults.standard.set(patientHealthDetails?.genericSubstitution, forKey: "substituteGeneric")
    UserDefaults.standard.set(patientHealthDetails?.gender, forKey: "selectedGender")
    
    //PatientHealthDetails - Allergies
    UserDefaults.standard.set(patientHealthDetails?.allergiesFlag, forKey: "allergiesFlag")
    
            //Allergies List Flag
            let allergiesString: String = patientHealthDetails!.specificAllergies
            let delimitedAllergies: [String] = allergiesString.components(separatedBy: ",")
    
            var allergiesListFlag: [Bool] = []
            for allergies in allergiesListExOther {
                if delimitedAllergies.contains(allergies) {
                    allergiesListFlag.append(true)
                } else {
                    allergiesListFlag.append(false)
                }
            }
//            allergiesListFlag.removeLast(1)
            UserDefaults.standard.set(allergiesListFlag, forKey: "allergiesListFlag")
                    
            //Other Allergies
            let lastDelimitedAllergies: String = delimitedAllergies.last!
            UserDefaults.standard.set(lastDelimitedAllergies, forKey: "otherAllergies")

            print(allergiesListFlag)
            print(lastDelimitedAllergies)

    

    
    //PatientHealthDetails - Medical Conditions
    UserDefaults.standard.set(patientHealthDetails?.medicalConditionsFlag, forKey: "medicalConditionsFlag")
    
            //Medical Conditions List Flag
            let conditionsString: String = patientHealthDetails!.specificMedicalConditions
            let delimitedConditions: [String] = conditionsString.components(separatedBy: ",")

            var conditionsListFlag: [Bool] = []
            for conditions in conditionsListExOther {
                if delimitedConditions.contains(conditions) {
                    conditionsListFlag.append(true)
                } else {
                    conditionsListFlag.append(false)
                }
            }
//            conditionsListFlag.removeLast(1)
            UserDefaults.standard.set(conditionsListFlag, forKey: "conditionsListFlag")
                    
            //Other Medical Conditions
            let lastDelimitedConditions: String = delimitedConditions.last!
            UserDefaults.standard.set(lastDelimitedConditions, forKey: "otherMedicalConditions")

            print(conditionsListFlag)
            print(lastDelimitedConditions)

}

func CallTransferCoreDataToUserDefaults_PatientInsuranceDetails(context: NSManagedObjectContext, patient: Patient) {
    
    //Standard query request to Core Data
    let request = NSFetchRequest<PatientInsuranceDetails>(entityName: "PatientInsuranceDetails")
    request.sortDescriptors = [NSSortDescriptor(key: "ohip", ascending: true)]
    request.predicate = NSPredicate(format: "patient_ = %@", patient)

    let results = (try? context.fetch(request)) ?? []
    let patientInsuranceDetails = results.first

    UserDefaults.standard.set(patientInsuranceDetails?.ohip, forKey: "OHIP")
    UserDefaults.standard.set(patientInsuranceDetails?.billToInsuranceFlag1, forKey: "billToInsuranceFlag1")
    UserDefaults.standard.set(patientInsuranceDetails?.billToInsuranceFlag2, forKey: "billToInsuranceFlag2")
    UserDefaults.standard.set(patientInsuranceDetails?.billToInsuranceFlag3, forKey: "billToInsuranceFlag3")
    UserDefaults.standard.set(patientInsuranceDetails?.planName1, forKey: "selectedPlanName1")
    UserDefaults.standard.set(patientInsuranceDetails?.planName2, forKey: "selectedPlanName2")
    UserDefaults.standard.set(patientInsuranceDetails?.planName3, forKey: "selectedPlanName3")

    UserDefaults.standard.set(patientInsuranceDetails?.memberIDNumber1 ?? nil, forKey: "memberID1")
    UserDefaults.standard.set(patientInsuranceDetails?.groupNumber1 ?? nil, forKey: "groupNumber1")
    UserDefaults.standard.set(patientInsuranceDetails?.policyholderName1 ?? nil, forKey: "policyholderName1")
    UserDefaults.standard.set(patientInsuranceDetails?.carrierCode1 ?? nil, forKey: "carrierCode1")
    UserDefaults.standard.set(patientInsuranceDetails?.policyholderDOB1 ?? nil, forKey: "selectedDate1")
    UserDefaults.standard.set(patientInsuranceDetails?.insurancePhoneNumber1 ?? nil, forKey: "insurancePhone1")
    UserDefaults.standard.set(patientInsuranceDetails?.relationshipToCardholder1 ?? nil, forKey: "relationshipToCardholder1")

    UserDefaults.standard.set(patientInsuranceDetails?.memberIDNumber2 ?? nil, forKey: "memberID2")
    UserDefaults.standard.set(patientInsuranceDetails?.groupNumber2 ?? nil, forKey: "groupNumber2")
    UserDefaults.standard.set(patientInsuranceDetails?.policyholderName2 ?? nil, forKey: "policyholderName2")
    UserDefaults.standard.set(patientInsuranceDetails?.carrierCode2 ?? nil, forKey: "carrierCode2")
    UserDefaults.standard.set(patientInsuranceDetails?.policyholderDOB2 ?? nil, forKey: "selectedDate2")
    UserDefaults.standard.set(patientInsuranceDetails?.insurancePhoneNumber2 ?? nil, forKey: "insurancePhone2")
    UserDefaults.standard.set(patientInsuranceDetails?.relationshipToCardholder2 ?? nil, forKey: "relationshipToCardholder2")

    UserDefaults.standard.set(patientInsuranceDetails?.memberIDNumber3 ?? nil, forKey: "memberID3")
    UserDefaults.standard.set(patientInsuranceDetails?.groupNumber3 ?? nil, forKey: "groupNumber3")
    UserDefaults.standard.set(patientInsuranceDetails?.policyholderName3 ?? nil, forKey: "policyholderName3")
    UserDefaults.standard.set(patientInsuranceDetails?.carrierCode3 ?? nil, forKey: "carrierCode3")
    UserDefaults.standard.set(patientInsuranceDetails?.policyholderDOB3 ?? nil, forKey: "selectedDate3")
    UserDefaults.standard.set(patientInsuranceDetails?.insurancePhoneNumber3 ?? nil, forKey: "insurancePhone3")
    UserDefaults.standard.set(patientInsuranceDetails?.relationshipToCardholder3 ?? nil, forKey: "relationshipToCardholder3")
}

func CallTransferCoreDataToUserDefaults_PatientPaymentDetails(context: NSManagedObjectContext, patient: Patient) {
    
    //Standard query request to Core Data
    let request = NSFetchRequest<PatientPaymentDetails>(entityName: "PatientPaymentDetails")
    request.sortDescriptors = [NSSortDescriptor(key: "cardholderName_", ascending: true)]
    request.predicate = NSPredicate(format: "patient_ = %@", patient)

    let results = (try? context.fetch(request)) ?? []
    let patientPaymentDetails = results.first
    
    UserDefaults.standard.set(patientPaymentDetails?.paymentType, forKey: "paymentType")
    UserDefaults.standard.set(patientPaymentDetails?.cardholderName, forKey: "cardholderName")
    UserDefaults.standard.set(patientPaymentDetails?.paymentCardNumber, forKey: "paymentCardNumber")
    UserDefaults.standard.set(patientPaymentDetails?.expirationMM, forKey: "expirationMonth")
    UserDefaults.standard.set(patientPaymentDetails?.expirationYY, forKey: "expirationYear")
    UserDefaults.standard.set(patientPaymentDetails?.cvv, forKey: "cvv")

}








//func CallTransferFirebaseToCoreData_PatientHealthDetails(context: NSManagedObjectContext, uid: String) -> PatientHealthDetails {
//
//    let db = Firestore.firestore()
//    db.collection("users").document(uid).collection("HealthProfile").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//
//            for document in querySnapshot!.documents {
//
//                //this below line is for debugging
//                print("\(document.documentID) => \(document.data())")
//
//            }
//        }
//    }
//
////    var patientHealthDetails: PatientHealthDetails
////
////    return patientHealthDetails
//}

//func CallTransferFirebaseToCoreData_PatientInsuranceDetails(context: NSManagedObjectContext, uid: String) -> PatientInsuranceDetails {
//
//    let db = Firestore.firestore()
//
//    db.collection("users").document(uid).collection("InsuranceDetails").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//
//            for document in querySnapshot!.documents {
//
//                //this below line is for debugging
//                print("\(document.documentID) => \(document.data())")
//
//            }
//        }
//    }
//}

//func CallTransferFirebaseToCoreData_PatientPaymentDetails(context: NSManagedObjectContext, uid: String) -> PatientPaymentDetails {
//
//    let db = Firestore.firestore()
//
//    db.collection("users").document(uid).collection("PaymentDetails").getDocuments() { (querySnapshot, err) in
//        if let err = err {
//            print("Error getting documents: \(err)")
//        } else {
//
//            for document in querySnapshot!.documents {
//
//                //this below line is for debugging
//                print("\(document.documentID) => \(document.data())")
//
//            }
//        }
//    }
//
////    var patientPaymentDetails: PatientPaymentDetails
////
////    return patientPaymentDetails
//}
//



            








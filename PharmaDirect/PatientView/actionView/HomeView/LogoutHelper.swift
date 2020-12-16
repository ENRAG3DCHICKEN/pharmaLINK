//
//  LogoutHelper.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-09.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

func ClearPatientUserDefaults_Logout() {

    //Main Items
    UserDefaults.standard.removeObject(forKey: "email")
    UserDefaults.standard.removeObject(forKey: "password")
    UserDefaults.standard.removeObject(forKey: "privacyCompletionFlag")
    UserDefaults.standard.removeObject(forKey: "signupCompletionFlag")
    
    //Patient Items
    UserDefaults.standard.removeObject(forKey: "fullName")
    UserDefaults.standard.removeObject(forKey: "address")
    UserDefaults.standard.removeObject(forKey: "city")
    UserDefaults.standard.removeObject(forKey: "province")
    UserDefaults.standard.removeObject(forKey: "postalCode")
    UserDefaults.standard.removeObject(forKey: "phoneNumber")
    
    //Patient Health Items
    UserDefaults.standard.removeObject(forKey: "birthDate")
    UserDefaults.standard.removeObject(forKey: "substituteGender")
    UserDefaults.standard.removeObject(forKey: "selectedGender")
    UserDefaults.standard.removeObject(forKey: "allergiesFlag")
    UserDefaults.standard.removeObject(forKey: "allergiesListFlag")
    UserDefaults.standard.removeObject(forKey: "otherAllergies")
    UserDefaults.standard.removeObject(forKey: "medicalConditionsFlag")
    UserDefaults.standard.removeObject(forKey: "conditionsListFlag")
    UserDefaults.standard.removeObject(forKey: "otherMedicalConditions")
    
    //PatientInsuranceDetails
    UserDefaults.standard.removeObject(forKey: "OHIP")
    UserDefaults.standard.removeObject(forKey: "billToInsuranceFlag1")
    UserDefaults.standard.removeObject(forKey: "billToInsuranceFlag2")
    UserDefaults.standard.removeObject(forKey: "billToInsuranceFlag3")
    UserDefaults.standard.removeObject(forKey: "selectedPlanName1")
    UserDefaults.standard.removeObject(forKey: "selectedPlanName2")
    UserDefaults.standard.removeObject(forKey: "selectedPlanName3")
    
    UserDefaults.standard.removeObject(forKey: "memberID1")
    UserDefaults.standard.removeObject(forKey: "groupNumber1")
    UserDefaults.standard.removeObject(forKey: "policyholderName1")
    UserDefaults.standard.removeObject(forKey: "carrierCode1")
    UserDefaults.standard.removeObject(forKey: "selectedDate1")
    UserDefaults.standard.removeObject(forKey: "insurancePhone1")
    UserDefaults.standard.removeObject(forKey: "relationshipToCardholder1")
    
    UserDefaults.standard.removeObject(forKey: "memberID2")
    UserDefaults.standard.removeObject(forKey: "groupNumber2")
    UserDefaults.standard.removeObject(forKey: "policyholderName2")
    UserDefaults.standard.removeObject(forKey: "carrierCode2")
    UserDefaults.standard.removeObject(forKey: "selectedDate2")
    UserDefaults.standard.removeObject(forKey: "insurancePhone2")
    UserDefaults.standard.removeObject(forKey: "relationshipToCardholder2")
    
    UserDefaults.standard.removeObject(forKey: "memberID3")
    UserDefaults.standard.removeObject(forKey: "groupNumber3")
    UserDefaults.standard.removeObject(forKey: "policyholderName3")
    UserDefaults.standard.removeObject(forKey: "carrierCode3")
    UserDefaults.standard.removeObject(forKey: "selectedDate3")
    UserDefaults.standard.removeObject(forKey: "insurancePhone3")
    UserDefaults.standard.removeObject(forKey: "relationshipToCardholder3")
    
    //PatientPaymentDetails
    UserDefaults.standard.removeObject(forKey: "paymentType")
    UserDefaults.standard.removeObject(forKey: "cardholderName")
    UserDefaults.standard.removeObject(forKey: "paymentCardNumber")
    UserDefaults.standard.removeObject(forKey: "expirationMonth")
    UserDefaults.standard.removeObject(forKey: "expirationYear")
    UserDefaults.standard.removeObject(forKey: "cvv")
    
}


//
//  InsuranceViewModel.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-13.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import Foundation

struct InsurancePlan: Identifiable {
    var planName: String
    var memberIDNumber: String
    var groupNumber: String
    var policyholderName: String
    var carrierCode: String
    var policyholderDOBDD: Int
    var policyholderDOBMM: Int
    var policyholderDOBYY: Int
    var relationshipToCardholder: String
    var insurancePhoneNumber: String
    
    var id = UUID()

}

    var planNameSelections: [String] = ["Alberta Red Cross","Assure (Great West Life)", "Assure (Sunlife)", "Assure Health", "Atlantic Blue Cross",
                                        "Atlantic Blue Cross (Workers' Compensation)", "Canadian Armed Forces (National Defense", "Canadian Benefit Provider Inc.",
                                        "Claim Secure", "ClaimSecure Patient Assistance", "eSorse", "Express Scripts (Desjardin)", "Express Scripts (Empire Life)",
                                        "Express Scripts (Industrial Alliance)", "Express Scripts (RWAM)", "Express Scripts Canada", "Great West Life", "Green Shield Canada",
                                        "Indian Affairs (NIHB)", "Johnson's Insurance", "Managed Health Care Services", "MDM", "Medavie Blue Cross",
                                        "Nexgen Rx", "NIHB", "ODB (Ontario Drug Benefits)", "ODB (Trillium)", "ODB (ODSP)", "Ontario Blue Cross", "Public Services Health Plan",
                                        "RCMP", "SSQ", "Veterans Affairs Canada", "Workers Compensation"]


var relationshipToCardholder: [String] = ["Cardholder", "Spouse", "Child Underage", "Child Overage", "Disabled Dependent", "Dependent Student"]

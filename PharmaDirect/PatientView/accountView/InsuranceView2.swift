//
//  InsuranceView2.swift
//  InstantCredit
//
//  Created by Jackie Yiu on 11/6/20.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct InsuranceView2: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State var selection: Int?

    @Binding var billToInsuranceFlag1: Bool
    @Binding var billToInsuranceFlag2: Bool
    @Binding var billToInsuranceFlag3: Bool

    @Binding var selectedPlanName1: String
    @Binding var selectedPlanName2: String
    @Binding var selectedPlanName3: String

    @State private var memberID2: String
    @State private var groupNumber2: String
    @State private var policyholderName2: String
    @State private var carrierCode2: String
    @State private var selectedDate2: Date
    @State private var insurancePhone2: String
    @State private var relationshipToCardholder2: String 
    
    init(billToInsuranceFlag1: Binding<Bool>, billToInsuranceFlag2: Binding<Bool>, billToInsuranceFlag3: Binding<Bool>, selectedPlanName1: Binding<String>, selectedPlanName2: Binding<String>, selectedPlanName3: Binding<String>) {
        _billToInsuranceFlag1 = billToInsuranceFlag1
        _billToInsuranceFlag2 = billToInsuranceFlag2
        _billToInsuranceFlag3 = billToInsuranceFlag3
        _selectedPlanName1 = selectedPlanName1
        _selectedPlanName2 = selectedPlanName2
        _selectedPlanName3 = selectedPlanName3
        
        if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
            _memberID2 = State(wrappedValue: UserDefaults.standard.string(forKey: "memberID2") ?? "")
            _groupNumber2 = State(wrappedValue: UserDefaults.standard.string(forKey: "groupNumber2") ?? "")
            _policyholderName2 = State(wrappedValue: UserDefaults.standard.string(forKey: "policyholderName2") ?? "")
            _carrierCode2 = State(wrappedValue: UserDefaults.standard.string(forKey: "carrierCode2") ?? "")
            _selectedDate2 = State(wrappedValue: UserDefaults.standard.object(forKey: "selectedDate2") as? Date ?? Date())
            _insurancePhone2 = State(wrappedValue: UserDefaults.standard.string(forKey: "insurancePhone2") ?? "")
            _relationshipToCardholder2 = State(wrappedValue: UserDefaults.standard.string(forKey: "relationshipToCardholder2") ?? "")
        } else {
            _memberID2 = State(wrappedValue: "")
            _groupNumber2 = State(wrappedValue: "")
            _policyholderName2 = State(wrappedValue: "")
            _carrierCode2 = State(wrappedValue: "")
            _selectedDate2 = State(wrappedValue: Date())
            _insurancePhone2 = State(wrappedValue: "")
            _relationshipToCardholder2 = State(wrappedValue: "")
        }
    }


    var body: some View {
        VStack {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            Image("cropped-img7")
                .resizable()
                .frame(height: UIScreen.main.bounds.height * 0.2)
                .overlay(
                    Text("Help us match you to the right counselor.")
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
                        .foregroundColor(.white)
                        .background(Color.black)
                        .opacity(0.7)
                )
                  
            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") != true {
                HStack {
                    ForEach(0..<8) { index in
                        Rectangle()
                            .foregroundColor(Color(index <= 5 ? UIColor.lightGreen : .lightGray))
                            .frame(height: 5)
                    }
                }
                    .padding()
            }
            
            Form {
             
                if selectedPlanName2 != "" {

                    Section(header: Text("Insurance Details")) {
                        Text(selectedPlanName2)
                        TextField("Member ID", text: $memberID2)
                        TextField("Group #", text: $groupNumber2)
                        TextField("Policyholder Name", text: $policyholderName2)
                        TextField("Carrier Code", text: $carrierCode2)
                        DatePicker("Date of Birth", selection: $selectedDate2, displayedComponents: .date)
                        TextField("Insurance Phone Number", text: $insurancePhone2)
                        Picker(selection: $relationshipToCardholder2, label: Text("Relationship To Cardholder")) {
                            ForEach(0..<relationshipToCardholder.count) { index in
                                Text(relationshipToCardholder[index]).tag(relationshipToCardholder[index])
                            }
                        }
                    }
                }
            }
                .padding()
            
            Spacer()
            
            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                Button(action: {
                    if selectedPlanName3 != "" {
                        self.selection = 1
                    } else if selectedPlanName3 == "" {
                        self.selection = 9
                    }
                    UserDefaults.standard.set(self.memberID2, forKey: "memberID2")
                    UserDefaults.standard.set(self.groupNumber2, forKey: "groupNumber2")
                    UserDefaults.standard.set(self.policyholderName2, forKey: "policyholderName2")
                    UserDefaults.standard.set(self.carrierCode2, forKey: "carrierCode2")
                    UserDefaults.standard.set(self.selectedDate2, forKey: "selectedDate2")
                    UserDefaults.standard.set(self.insurancePhone2, forKey: "insurancePhone2")
                    UserDefaults.standard.set(self.relationshipToCardholder2, forKey: "relationshipToCardholder2")
                    FormSubmissionToCoreData(context: context)
                } ) { Text("Submit").font(.body).bold() }
                .disabled(memberID2.isEmpty || groupNumber2.isEmpty || policyholderName2.isEmpty || carrierCode2.isEmpty || insurancePhone2.isEmpty || relationshipToCardholder2.isEmpty)
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .foregroundColor(Color(.white))
                .background(memberID2.isEmpty || groupNumber2.isEmpty || policyholderName2.isEmpty || carrierCode2.isEmpty || insurancePhone2.isEmpty || relationshipToCardholder2.isEmpty ? .gray : Color(UIColor.mainColor))
                .padding()
            } else {
                
                Button(action: {
                    self.selection = 0
                } ) { Text("< Back").font(.body).bold() }
                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                    .foregroundColor(Color(.white))
                    .background(Color(UIColor.gradiant1))
                    .padding(.horizontal)
                
                Button(action: {
                    if selectedPlanName3 != "" {
                        self.selection = 1
                    } else if selectedPlanName3 == "" {
                        self.selection = 2
                    }
                    UserDefaults.standard.set(self.memberID2, forKey: "memberID2")
                    UserDefaults.standard.set(self.groupNumber2, forKey: "groupNumber2")
                    UserDefaults.standard.set(self.policyholderName2, forKey: "policyholderName2")
                    UserDefaults.standard.set(self.carrierCode2, forKey: "carrierCode2")
                    UserDefaults.standard.set(self.selectedDate2, forKey: "selectedDate2")
                    UserDefaults.standard.set(self.insurancePhone2, forKey: "insurancePhone2")
                    UserDefaults.standard.set(self.relationshipToCardholder2, forKey: "relationshipToCardholder2")
                } ) { Text("Next >").font(.body).bold() }
                .disabled(memberID2.isEmpty || groupNumber2.isEmpty || policyholderName2.isEmpty || carrierCode2.isEmpty || insurancePhone2.isEmpty || relationshipToCardholder2.isEmpty)
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                .foregroundColor(Color(.white))
                .background(memberID2.isEmpty || groupNumber2.isEmpty || policyholderName2.isEmpty || carrierCode2.isEmpty || insurancePhone2.isEmpty || relationshipToCardholder2.isEmpty ? .gray : Color(UIColor.mainColor))
                .padding()
        }
            NavigationLink(destination: InsuranceView1(billToInsuranceFlag1: $billToInsuranceFlag1, billToInsuranceFlag2: $billToInsuranceFlag2, billToInsuranceFlag3: $billToInsuranceFlag3, selectedPlanName1: $selectedPlanName1, selectedPlanName2: $selectedPlanName2, selectedPlanName3: $selectedPlanName3), tag: 0, selection: $selection) { EmptyView() }
            NavigationLink(destination: InsuranceView3(billToInsuranceFlag1: $billToInsuranceFlag1, billToInsuranceFlag2: $billToInsuranceFlag2, billToInsuranceFlag3: $billToInsuranceFlag3, selectedPlanName1: $selectedPlanName1, selectedPlanName2: $selectedPlanName2, selectedPlanName3: $selectedPlanName3), tag: 1, selection: $selection) { EmptyView() }
            NavigationLink(destination: PaymentView(), tag: 2, selection: $selection) { EmptyView() }
            
            NavigationLink(destination: HomeView(selectionValue: 1), tag: 9, selection: $selection) { EmptyView() }
            
        }
    }
        
}

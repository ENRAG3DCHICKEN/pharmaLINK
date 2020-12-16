//
//  InsuranceView2.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-13.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct InsuranceView1: View {

        @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
        @State var selection: Int?
    
        @Binding var billToInsuranceFlag1: Bool
        @Binding var billToInsuranceFlag2: Bool
        @Binding var billToInsuranceFlag3: Bool

        @Binding var selectedPlanName1: String
        @Binding var selectedPlanName2: String
        @Binding var selectedPlanName3: String
    
        @State private var memberID1: String
        @State private var groupNumber1: String
        @State private var policyholderName1: String
        @State private var carrierCode1: String
        @State private var selectedDate1: Date
        @State private var insurancePhone1: String
        @State private var relationshipToCardholder1: String 


        init(billToInsuranceFlag1: Binding<Bool>, billToInsuranceFlag2: Binding<Bool>, billToInsuranceFlag3: Binding<Bool>, selectedPlanName1: Binding<String>, selectedPlanName2: Binding<String>, selectedPlanName3: Binding<String>) {
            _billToInsuranceFlag1 = billToInsuranceFlag1
            _billToInsuranceFlag2 = billToInsuranceFlag2
            _billToInsuranceFlag3 = billToInsuranceFlag3
            _selectedPlanName1 = selectedPlanName1
            _selectedPlanName2 = selectedPlanName2
            _selectedPlanName3 = selectedPlanName3
            
            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                _memberID1 = State(wrappedValue: UserDefaults.standard.string(forKey: "memberID1") ?? "")
                _groupNumber1 = State(wrappedValue: UserDefaults.standard.string(forKey: "groupNumber1") ?? "")
                _policyholderName1 = State(wrappedValue: UserDefaults.standard.string(forKey: "policyholderName1") ?? "")
                _carrierCode1 = State(wrappedValue: UserDefaults.standard.string(forKey: "carrierCode1") ?? "")
                _selectedDate1 = State(wrappedValue: UserDefaults.standard.object(forKey: "selectedDate1") as? Date ?? Date())
                _insurancePhone1 = State(wrappedValue: UserDefaults.standard.string(forKey: "insurancePhone1") ?? "")
                _relationshipToCardholder1 = State(wrappedValue: UserDefaults.standard.string(forKey: "relationshipToCardholder1") ?? "")
            } else {
                _memberID1 = State(wrappedValue: "")
                _groupNumber1 = State(wrappedValue: "")
                _policyholderName1 = State(wrappedValue: "")
                _carrierCode1 = State(wrappedValue: "")
                _selectedDate1 = State(wrappedValue: Date())
                _insurancePhone1 = State(wrappedValue: "")
                _relationshipToCardholder1 = State(wrappedValue: "")
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
                    
                        if selectedPlanName1 != "" {

                                Section(header: Text("Insurance Details")) {
                                    Text(selectedPlanName1)
                                    TextField("Member ID", text: $memberID1)
                                    TextField("Group #", text: $groupNumber1)
                                    TextField("Policyholder Name", text: $policyholderName1)
                                    TextField("Carrier Code", text: $carrierCode1)
                                    DatePicker("Date of Birth", selection: $selectedDate1, displayedComponents: .date)
                                    TextField("Insurance Phone Number", text: $insurancePhone1)
                                    Picker(selection: $relationshipToCardholder1, label: Text("Relationship To Cardholder")) {
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
                            if selectedPlanName2 != "" {
                                self.selection = 1
                            } else if selectedPlanName2 == "" {
                                self.selection = 9
                            }
                            UserDefaults.standard.set(self.memberID1, forKey: "memberID1")
                            UserDefaults.standard.set(self.groupNumber1, forKey: "groupNumber1")
                            UserDefaults.standard.set(self.policyholderName1, forKey: "policyholderName1")
                            UserDefaults.standard.set(self.carrierCode1, forKey: "carrierCode1")
                            UserDefaults.standard.set(self.selectedDate1, forKey: "selectedDate1")
                            UserDefaults.standard.set(self.insurancePhone1, forKey: "insurancePhone1")
                            UserDefaults.standard.set(self.relationshipToCardholder1, forKey: "relationshipToCardholder1")
                            FormSubmissionToCoreData(context: context)
                        } ) { Text("Submit").font(.body).bold() }
                            .disabled(memberID1.isEmpty || groupNumber1.isEmpty || policyholderName1.isEmpty || carrierCode1.isEmpty || insurancePhone1.isEmpty || relationshipToCardholder1.isEmpty)
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                            .foregroundColor(Color(.white))
                            .background(memberID1.isEmpty || groupNumber1.isEmpty || policyholderName1.isEmpty || carrierCode1.isEmpty || insurancePhone1.isEmpty || relationshipToCardholder1.isEmpty ? .gray : Color(UIColor.mainColor))
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
                            if selectedPlanName2 != "" {
                                self.selection = 1
                            } else if selectedPlanName2 == "" {
                                self.selection = 2
                            }
                            UserDefaults.standard.set(self.memberID1, forKey: "memberID1")
                            UserDefaults.standard.set(self.groupNumber1, forKey: "groupNumber1")
                            UserDefaults.standard.set(self.policyholderName1, forKey: "policyholderName1")
                            UserDefaults.standard.set(self.carrierCode1, forKey: "carrierCode1")
                            UserDefaults.standard.set(self.selectedDate1, forKey: "selectedDate1")
                            UserDefaults.standard.set(self.insurancePhone1, forKey: "insurancePhone1")
                            UserDefaults.standard.set(self.relationshipToCardholder1, forKey: "relationshipToCardholder1")
                        } ) { Text("Next >").font(.body).bold() }
                            .disabled(memberID1.isEmpty || groupNumber1.isEmpty || policyholderName1.isEmpty || carrierCode1.isEmpty || insurancePhone1.isEmpty || relationshipToCardholder1.isEmpty)
                            .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                            .foregroundColor(Color(.white))
                            .background(memberID1.isEmpty || groupNumber1.isEmpty || policyholderName1.isEmpty || carrierCode1.isEmpty || insurancePhone1.isEmpty || relationshipToCardholder1.isEmpty ? .gray : Color(UIColor.mainColor))
                            .padding()
                    }
                    NavigationLink(destination: InsuranceView(), tag: 0, selection: $selection) { EmptyView() }
                    NavigationLink(destination: InsuranceView2(billToInsuranceFlag1: $billToInsuranceFlag1, billToInsuranceFlag2: $billToInsuranceFlag2, billToInsuranceFlag3: $billToInsuranceFlag3, selectedPlanName1: $selectedPlanName1, selectedPlanName2: $selectedPlanName2, selectedPlanName3: $selectedPlanName3), tag: 1, selection: $selection) { EmptyView() }
                    NavigationLink(destination: PaymentView(), tag: 2, selection: $selection) { EmptyView() }
                    
                    NavigationLink(destination: HomeView(selectionValue: 1), tag: 9, selection: $selection) { EmptyView() }

                    
                }
            }
        }

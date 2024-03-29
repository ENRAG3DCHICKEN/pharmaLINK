//
//  HealthProfileView3.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-13.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct HealthProfileView3: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State var selection: Int?
    
    @State var medicalConditionsFlag: Bool
    @State var conditionsListFlag: [Bool]
    @State var otherMedicalConditions: String

    init() {
        if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
            _medicalConditionsFlag = State(wrappedValue: UserDefaults.standard.bool(forKey: "medicalConditionsFlag"))
            _conditionsListFlag = State(wrappedValue: UserDefaults.standard.object(forKey: "conditionsListFlag") as! [Bool])
            _otherMedicalConditions = State(wrappedValue: UserDefaults.standard.string(forKey: "otherMedicalConditions")!)
        } else {
            _medicalConditionsFlag = State(wrappedValue: true)
            _conditionsListFlag = State(wrappedValue: Array(repeating: false, count: conditionsListExOther.count))
            _otherMedicalConditions = State(wrappedValue: "")
        }
    }

    
    var body: some View {
            VStack {
                
                Text("")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Health Profile")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                                Button(action: {
                                    self.selection = 0
                                } ) {
                                    HStack {
                                        Image(systemName: "chevron.backward").font(.headline)
                                        Text("Back").font(.headline)
                                    }
                                }
                            } else {
                                Button(action: {
                                    self.selection = 0
                                } ) {
                                    HStack {
                                        Image(systemName: "chevron.backward").font(.headline)
                                        Text("Back").font(.headline)
                                    }
                                }
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                                Button(action: {
                                    
                                    self.selection = 9
                                    UserDefaults.standard.set(self.medicalConditionsFlag, forKey: "medicalConditionsFlag")
                                    UserDefaults.standard.set(self.conditionsListFlag, forKey: "conditionsListFlag")
                                    UserDefaults.standard.set(self.otherMedicalConditions, forKey: "otherMedicalConditions")
                                    FormSubmissionToCoreData(context: context)
                                    
                                })  {
                                    HStack {
                                        Text("Submit").font(.headline)
                                        Image(systemName: "chevron.forward").font(.headline)
                                    }
                                }
                                    .disabled(medicalConditionsFlag && (conditionsListFlag.allSatisfy({ $0 == false }) && otherMedicalConditions == ""))
                            } else {
                                Button(action: {
                                    
                                    self.selection = 1
                                    UserDefaults.standard.set(self.medicalConditionsFlag, forKey: "medicalConditionsFlag")
                                    UserDefaults.standard.set(self.conditionsListFlag, forKey: "conditionsListFlag")
                                    UserDefaults.standard.set(self.otherMedicalConditions, forKey: "otherMedicalConditions")
                                    
                                })  {
                                    HStack {
                                        Text("Next").font(.headline)
                                        Image(systemName: "chevron.forward").font(.headline)
                                    }
                                }
                                    .disabled(medicalConditionsFlag && (conditionsListFlag.allSatisfy({ $0 == false }) && otherMedicalConditions == ""))
                            }
                        }
                    }
                
                if UIScreen.main.bounds.size.height > 800 {
                    Image("cropped-img7")
                        .resizable()
                        .frame(height: UIScreen.main.bounds.height * 0.18)
                        .overlay(
                            Text("Provide all necessary info to your pharmacist")
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.18)
                                .foregroundColor(.white)
                                .background(Color.black)
                                .opacity(0.7)
                        )
                }
                if UserDefaults.standard.bool(forKey: "signupCompletionFlag") != true {
                    HStack {
                        ForEach(0..<8) { index in
                            Rectangle()
                                .foregroundColor(Color(index <= 3 ? UIColor.lightGreen : .lightGray))
                                .frame(height: 5)
                        }
                    }
                        .padding()
                }
                
                
                Form {
                    Section(header: Text("Health Profile")) {
                        HStack {
                            Toggle(isOn: $medicalConditionsFlag) { Text("Do you have any medical conditions?") }
                            Text(medicalConditionsFlag ? "Yes" : "No")
                        }
                        if medicalConditionsFlag == true {
                            List {
                                Section {
                                    ForEach(0..<conditionsListExOther.count) { index in
                                        HStack {
                                            Toggle(isOn: self.$conditionsListFlag[index]) { Text(conditionsListExOther[index]) }
                                            Text(self.conditionsListFlag[index] ? "Yes" : "No")
                                        }
                                    }
                                }
                                TextField("List Other Medical Conditions", text: self.$otherMedicalConditions)
                            }
                                
                        }
                    }
                }
                .padding()
                
                Spacer()
                                
//                Button(action: {
//                    self.selection = 0
//                } ) { Text("< Back").font(.body).bold() }
//                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                    .foregroundColor(Color(.white))
//                    .background(Color(UIColor.gradiant1))
//                    .padding(.horizontal)
//
//                if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
//                    Button(action: {
//                        self.selection = 9
//                        UserDefaults.standard.set(self.medicalConditionsFlag, forKey: "medicalConditionsFlag")
//                        UserDefaults.standard.set(self.conditionsListFlag, forKey: "conditionsListFlag")
//                        UserDefaults.standard.set(self.otherMedicalConditions, forKey: "otherMedicalConditions")
//                        FormSubmissionToCoreData(context: context)
//                    } ) { Text("Submit").font(.body).bold() }
//                        .disabled(medicalConditionsFlag && (conditionsListFlag.allSatisfy({ $0 == false }) && otherMedicalConditions == ""))
//                        .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                        .foregroundColor(Color(.white))
//                        .background(medicalConditionsFlag && (conditionsListFlag.allSatisfy({ $0 == false }) && otherMedicalConditions == "") ? Color(.gray) : Color(UIColor.mainColor))
//                        .padding()
//                } else {
//
//                    Button(action: {
//                        self.selection = 1
//                        UserDefaults.standard.set(self.medicalConditionsFlag, forKey: "medicalConditionsFlag")
//                        UserDefaults.standard.set(self.conditionsListFlag, forKey: "conditionsListFlag")
//                        UserDefaults.standard.set(self.otherMedicalConditions, forKey: "otherMedicalConditions")
//                } ) { Text("Next >").font(.body).bold() }
//                    .disabled(medicalConditionsFlag && (conditionsListFlag.allSatisfy({ $0 == false }) && otherMedicalConditions == ""))
//                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                    .foregroundColor(Color(.white))
//                    .background(medicalConditionsFlag && (conditionsListFlag.allSatisfy({ $0 == false }) && otherMedicalConditions == "") ? Color(.gray) : Color(UIColor.mainColor))
//                    .padding()
//                }
                
                NavigationLink(destination: HealthProfileView2(), tag: 0, selection: $selection) { EmptyView() }
                NavigationLink(destination: InsuranceView(), tag: 1, selection: $selection) { EmptyView() }
                
                NavigationLink(destination: HomeView(selectionValue: 1), tag: 9, selection: $selection) { EmptyView() }
            }
        }
    

  
    
    
}

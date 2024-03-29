//
//  HealthProfileView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-12.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct HealthProfileView2: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State var selection: Int?
    
    @State var allergiesFlag: Bool
    @State var allergiesListFlag: [Bool]
    @State var otherAllergies: String
  
    init() {
        if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
            _allergiesFlag = State(wrappedValue: UserDefaults.standard.bool(forKey: "allergiesFlag"))
            _allergiesListFlag = State(wrappedValue: UserDefaults.standard.object(forKey: "allergiesListFlag") as! [Bool])
            _otherAllergies = State(wrappedValue: UserDefaults.standard.string(forKey: "otherAllergies")!)
        } else {
            _allergiesFlag = State(wrappedValue: true)
            _allergiesListFlag = State(wrappedValue: Array(repeating: false, count: allergiesListExOther.count))
            _otherAllergies = State(wrappedValue: "")
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
                                    .disabled(false)
                            } else {
                                Button(action: {
                                    self.selection = 0
                                } ) {
                                    HStack {
                                        Image(systemName: "chevron.backward").font(.headline)
                                        Text("Back").font(.headline)
                                    }
                                }
                                    .disabled(false)
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                                Button(action: {
                                    
                                    self.selection = 1
                
                                    UserDefaults.standard.set(self.allergiesFlag, forKey: "allergiesFlag")
                                    UserDefaults.standard.set(self.allergiesListFlag, forKey: "allergiesListFlag")
                                    UserDefaults.standard.set(otherAllergies, forKey: "otherAllergies")
                                    
                                })  {
                                    HStack {
                                        Text("Submit").font(.headline)
                                        Image(systemName: "chevron.forward").font(.headline)
                                    }
                                }
                                    .disabled(allergiesFlag && (allergiesListFlag.allSatisfy({ $0 == false }) && otherAllergies == ""))
                            } else {
                                Button(action: {
                                    
                                    self.selection = 1
                
                                    UserDefaults.standard.set(self.allergiesFlag, forKey: "allergiesFlag")
                                    UserDefaults.standard.set(self.allergiesListFlag, forKey: "allergiesListFlag")
                                    UserDefaults.standard.set(otherAllergies, forKey: "otherAllergies")
                                    
                                })  {
                                    HStack {
                                        Text("Next").font(.headline)
                                        Image(systemName: "chevron.forward").font(.headline)
                                    }
                                }
                                    .disabled(allergiesFlag && (allergiesListFlag.allSatisfy({ $0 == false }) && otherAllergies == ""))
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
                                .foregroundColor(Color(index <= 2 ? UIColor.lightGreen : .lightGray))
                                .frame(height: 5)
                        }
                    }
                        .padding()
                }
                
                Form {
                    Section(header: Text("Health Profile")) {
                        HStack {
                            Toggle(isOn: $allergiesFlag) { Text("Do you have any drug allergies?") }
                            Text(allergiesFlag ? "Yes" : "No")
                        }
            
                        if allergiesFlag == true {
                            List {
                                Section {
                                    ForEach(0..<allergiesListExOther.count) { index in
                                        HStack {
                                            Toggle(isOn: self.$allergiesListFlag[index]) { Text(allergiesListExOther[index]) }
                                            Text(self.allergiesListFlag[index] ? "Yes" : "No")
                                        }
                                    }
                                }
                                TextField("List Other Allergies", text: self.$otherAllergies)
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
//                Button(action: {
//                    self.selection = 1
//                    
//                    UserDefaults.standard.set(self.allergiesFlag, forKey: "allergiesFlag")
//                    UserDefaults.standard.set(self.allergiesListFlag, forKey: "allergiesListFlag")
//                    UserDefaults.standard.set(otherAllergies, forKey: "otherAllergies")
//                    
//                } ) { Text("Next >").font(.body).bold() }
//                    .disabled(allergiesFlag && (allergiesListFlag.allSatisfy({ $0 == false }) && otherAllergies == ""))
//                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                    .foregroundColor(Color(.white))
//                    .background(allergiesFlag && (allergiesListFlag.allSatisfy({ $0 == false }) && otherAllergies == "") ? Color(.gray) : Color(UIColor.mainColor))
//                    .padding()
                
                NavigationLink(destination: HealthProfileView1(), tag: 0, selection: $selection) { EmptyView() }
                
                NavigationLink(destination: HealthProfileView3(), tag: 1, selection: $selection) { EmptyView() }
            }
        }
    
    
    

    
    }

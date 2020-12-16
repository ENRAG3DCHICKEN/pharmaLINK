//
//  PatientInfoView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-12.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import Firebase
import CoreData

struct PatientInfoView: View {

    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State var chosenPharmacy: Pharmacy?
    @State var selection: Int?
    
    @State var fullName: String
    @State var address: String
    @State var city: String
    @State var province: String
    @State var postalCode: String
    @State var phoneNumber: String
    
    init() {
        if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
            _fullName = State(wrappedValue: UserDefaults.standard.string(forKey: "fullName")!)
            _address = State(wrappedValue: UserDefaults.standard.string(forKey: "address")!)
            _city = State(wrappedValue: UserDefaults.standard.string(forKey: "city")!)
            _province = State(wrappedValue: UserDefaults.standard.string(forKey: "province")!)
            _postalCode = State(wrappedValue: UserDefaults.standard.string(forKey: "postalCode")!)
            _phoneNumber = State(wrappedValue: UserDefaults.standard.string(forKey: "phoneNumber")!)
        } else {
            _fullName = State(wrappedValue: "")
            _address = State(wrappedValue: "")
            _city = State(wrappedValue: "")
            _province = State(wrappedValue: "")
            _postalCode = State(wrappedValue: "")
            _phoneNumber = State(wrappedValue: "")
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
                Section {
                    HStack {
                        ForEach(0..<8) { index in
                            Rectangle()
                                .foregroundColor(Color(index <= 0 ? UIColor.lightGreen : .lightGray))
                                .frame(height: 5)
                        }
                    }
                        .padding()
                }
            }
            
            Form {
                Section(header: Text("Patient Info")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Address", text: $address)
                    TextField("City", text: $city)
                    Picker(selection: $province, label: Text("Province")) {
                        ForEach(0..<provinces.count) { index in
                            Text(provinces[index]).tag(provinces[index])
                        }
                    }
                    TextField("Postal Code", text: $postalCode)
                    TextField("Phone", text: $phoneNumber)

                }
            }
                .padding()
            
            Spacer()
        
            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                Button(action: {
                    self.selection = 9
                    
                    UserDefaults.standard.set(self.fullName, forKey: "fullName")
                    UserDefaults.standard.set(self.address, forKey: "address")
                    UserDefaults.standard.set(self.city, forKey: "city")
                    UserDefaults.standard.set(self.province, forKey: "province")
                    UserDefaults.standard.set(self.postalCode, forKey: "postalCode")
                    UserDefaults.standard.set(self.phoneNumber, forKey: "phoneNumber")
                    
                    FormSubmissionToCoreData(context: context)
                })  { Text("Submit").font(.body).bold() }
                .disabled(fullName.isEmpty || address.isEmpty || city.isEmpty || province.isEmpty || postalCode.isEmpty || phoneNumber.isEmpty)
                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                    .foregroundColor(Color(.white))
                .background(fullName.isEmpty || address.isEmpty || city.isEmpty || province.isEmpty || postalCode.isEmpty || phoneNumber.isEmpty ? .gray : Color(UIColor.mainColor))
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
                    self.selection = 1
                    
                    UserDefaults.standard.set(self.fullName, forKey: "fullName")
                    UserDefaults.standard.set(self.address, forKey: "address")
                    UserDefaults.standard.set(self.city, forKey: "city")
                    UserDefaults.standard.set(self.province, forKey: "province")
                    UserDefaults.standard.set(self.postalCode, forKey: "postalCode")
                    UserDefaults.standard.set(self.phoneNumber, forKey: "phoneNumber")
                    
                })  { Text("Next >").font(.body).bold() }
                .disabled(fullName.isEmpty || address.isEmpty || city.isEmpty || province.isEmpty || postalCode.isEmpty || phoneNumber.isEmpty)
                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                    .foregroundColor(Color(.white))
                .background(fullName.isEmpty || address.isEmpty || city.isEmpty || province.isEmpty || postalCode.isEmpty || phoneNumber.isEmpty ? .gray : Color(UIColor.mainColor))
                    .padding()
            
            }
                NavigationLink(destination: PharmacySearchView(chosenPharmacy: chosenPharmacy), tag: 0, selection: $selection) { EmptyView() }
                NavigationLink(destination: HealthProfileView1(), tag: 1, selection: $selection) { EmptyView() }
            
                NavigationLink(destination: HomeView(selectionValue: 1), tag: 9, selection: $selection) { EmptyView() }
            
        }
        .onAppear {
            DispatchQueue.global(qos: .userInitiated).async {
                //Standard query request to Core Data
                let request = NSFetchRequest<Pharmacy>(entityName: "Pharmacy")
                request.sortDescriptors = [NSSortDescriptor(key: "accreditationNumber_", ascending: true)]
                request.predicate = NSPredicate(format: "accreditationNumber_ == %@", String(UserDefaults.standard.integer(forKey: "chosenPharmacy")))

                let results = (try? context.fetch(request)) ?? []
                self.chosenPharmacy = results.first
                print(UserDefaults.standard.integer(forKey: "chosenPharmacy"))
            }
        }
    }
}

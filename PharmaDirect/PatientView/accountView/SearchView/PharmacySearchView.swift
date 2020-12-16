//
//  PharmacySearchView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData
import MapKit

struct PharmacySearchView: View {
    
    
//
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
//    //
//    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "longitude",ascending: true)]) var pharmacies: FetchedResults<Pharmacy>
//
    
    @FetchRequest(fetchRequest: Pharmacy.fetchRequest(.all)) var pharmacies: FetchedResults<Pharmacy>
    
    @State private var selection: Int? = nil
    
    @State private var chosenPharmacy : Pharmacy?
    
    init(chosenPharmacy: Pharmacy?) {
        _chosenPharmacy = State(wrappedValue: chosenPharmacy)
    }
    
    init() {
        _chosenPharmacy = State(wrappedValue: nil)
    }


    
    var selectedPharmacyMarker: Binding<MKAnnotation?> {
        return Binding<MKAnnotation?>(
            get: { return chosenPharmacy },
            set: { annotation in
                if let pharmacy = annotation as? Pharmacy {
                    chosenPharmacy = pharmacy
                }
            }
        )
    }
    
    var body: some View {
        VStack {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
                          
            Form {
                Section {
                    Picker("Pharmacy", selection: $chosenPharmacy) {
                        ForEach(pharmacies.sorted(), id: \.self) { pharmacy in
                            Text("\(pharmacy.pharmacyName)").tag(pharmacy as Pharmacy?)
                        }
                    }
            
            MapView(annotations: pharmacies.sorted(), selection: selectedPharmacyMarker)
                .frame(minHeight: 400)
                }
            }
            
            if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                Button(action: {
                    UserDefaults.standard.set(chosenPharmacy!.accreditationNumber, forKey: "chosenPharmacy")
                    self.selection = 9
                    FormSubmissionToCoreData(context: context)
                } ) { Text("Submit").font(.body).bold() }
                    .disabled(chosenPharmacy == nil)
                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                    .foregroundColor(Color(.white))
                    .background( chosenPharmacy == nil ? .gray : Color(UIColor.mainColor))
                    .padding()
            } else {
                Button(action: {
                    UserDefaults.standard.set(chosenPharmacy!.accreditationNumber, forKey: "chosenPharmacy")
                    print("checkHERE")
                    print(UserDefaults.standard.double(forKey: "chosenPharmacy"))
                    self.selection = 1
                } ) { Text("Next >").font(.body).bold() }
                    .disabled(chosenPharmacy == nil)
                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
                    .foregroundColor(Color(.white))
                    .background( chosenPharmacy == nil ? .gray : Color(UIColor.mainColor))
                    .padding()
            }
                NavigationLink(destination: PatientInfoView(), tag: 1, selection: $selection) { EmptyView() }
                NavigationLink(destination: HomeView(selectionValue: 1), tag: 9, selection: $selection) { EmptyView() }
        }
            .onAppear(perform: {
                print("start")
                populateCoreData_Pharmacy(context: context)
                print("done")
                
            })
        }
    }






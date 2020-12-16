//
//  UserDetailsView.swift
//  InstantCredit
//
//  Created by ENRAG3DMINX on 11/9/20.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct UserDetailsView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State var selection: Int?
    
    
    @State var chosenPharmacy: Pharmacy?
    var body: some View {
        
        VStack(spacing: 0) {
            
        Text("")
            .navigationBarTitle("")
            .navigationBarHidden(true)
                      

        Image("cropped-img7")
            .resizable()
            .frame(height: UIScreen.main.bounds.height * 0.2)
            .overlay(
                Text("Account Profile").font(.title)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.2)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .opacity(0.7)
            )
            
            NavigationLink(destination: PharmacySearchView(chosenPharmacy: chosenPharmacy), tag: 0, selection: $selection) {
                Button(action: {
                    print("tryhere")
                    print(chosenPharmacy?.pharmacyName ?? "no pharmacy detected")
                    self.selection = 0
            }, label: {
                HStack {
                Image(systemName: "map").font(.body)
                Text("Pharmacy Selection").font(.body).bold()
                Spacer()
                Text(">").font(.body).bold()
                }.padding()
                
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
        NavigationLink(destination: PatientInfoView(), tag: 1, selection: $selection) {
            Button(action: {
                self.selection = 1
            }, label: {
                HStack {
                Image(systemName: "person.crop.circle").font(.body)
                Text("Patient Info").font(.body).bold()
                Spacer()
                Text(">").font(.body).bold()
                }.padding()
                
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
        NavigationLink(destination: HealthProfileView1(), tag: 2, selection: $selection) {
            Button(action: {
                self.selection = 2
            }, label: {
                HStack {
                Image(systemName: "cross.case").font(.body)
                Text("Health Profile").font(.body).bold()
                Spacer()
                Text(">").font(.body).bold()
                }.padding()
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
        NavigationLink(destination: InsuranceView(), tag: 3, selection: $selection) {
            Button(action: {
                self.selection = 3
            }, label: {
                HStack {
                    Image(systemName: "scroll").font(.body)
                    Text("Insurance Details").font(.body).bold()
                    Spacer()
                    Text(">").font(.body).bold()
                }.padding()
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
        NavigationLink(destination: PaymentView(), tag: 4, selection: $selection) {
            Button(action: {
                self.selection = 4
            }, label: {
                HStack {
                    Image(systemName: "creditcard").font(.body)
                    Text("Payment Info").font(.body).bold()
                    Spacer()
                    Text(">").font(.body).bold()
                }.padding()
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
        NavigationLink(destination: PrivacyView(), tag: 5, selection: $selection) {
            Button(action: {
                self.selection = 5
            }, label: {
                HStack {
                    Image(systemName: "lock.rotation").font(.body)
                    Text("Privacy Policy").font(.body).bold()
                    Spacer()
                    Text(">").font(.body).bold()
                }.padding()
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
            
        NavigationLink(destination: LandingView(), tag: 6, selection: $selection) {
            Button(action: {
                ClearPatientUserDefaults_Logout()
                self.selection = 6
            }, label: {
                HStack {
                    Image(systemName: "key").font(.body)
                    Text("Logout").font(.body).bold()
                    Spacer()
                    Text(">").font(.body).bold()
                }.padding()
            })
                .frame(width: UIScreen.main.bounds.width * 0.92, height: 30)
                .foregroundColor(Color(.white))
                .background(Color(UIColor.buttonBar))
                .padding().shadow(radius: 5, y: 5)
        }
        
            
     
            

        Spacer()
    
        

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

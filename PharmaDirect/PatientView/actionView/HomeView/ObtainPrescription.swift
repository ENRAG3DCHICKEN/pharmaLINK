//
//  ObtainPrescription.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-12-02.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData



struct ObtainPrescriptions: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @State private var chosenPharmacy: Pharmacy?
    @State private var selection: Int?
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
                          
        
            NavigationLink(destination: NewPrescriptionSelection(chosenPharmacy: chosenPharmacy), tag: 1, selection: $selection) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(UIColor.tile1b),Color(UIColor.tile1a)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack {
                        Button(action: {
                            self.selection = 1
                        }, label: {

                                VStack {
                                    HStack {
                                        Text("New")
                                            .font(.headline).bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Prescription")
                                            .font(.headline).bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    Spacer()
                                    
                                }
                                    .padding()
                            
                        })
                        Spacer()
                        Image(systemName: "plus")
                            .font(.title)
                            .padding()
                    }
                }
                    .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.17)
                    .foregroundColor(Color(.white))
                    .padding().shadow(radius: 5, y: 5)
                

                
            }
            
            NavigationLink(destination: RefillPrescriptionSelection(chosenPharmacy: chosenPharmacy), tag: 2, selection: $selection) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(UIColor.tile2b),Color(UIColor.tile2a)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack {
                        Button(action: {
                            self.selection = 2
                        }, label: {
                            VStack {
                                HStack {
                                    Text("Refill")
                                        .font(.headline).bold()
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                HStack {
                                    Text("Prescription")
                                        .font(.headline).bold()
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                                Spacer()
                                
                            }
                                .padding()
                            })
                            Spacer()
                            Image(systemName: "repeat")
                                .font(.title)
                                .padding()
                        }
                }
                            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.17)
                            .foregroundColor(Color(.white))
                            .padding().shadow(radius: 5, y: 5)
            }
            
            
            NavigationLink(destination: TransferPrescriptionSelection(chosenPharmacy: chosenPharmacy), tag: 3, selection: $selection) {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color(UIColor.tile3b),Color(UIColor.tile3a)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack {
                        Button(action: {
                            self.selection = 3
                        }, label: {
                            VStack {
                                VStack {
                                    HStack {
                                        Text("Transfer")
                                            .font(.headline).bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Prescription")
                                            .font(.headline).bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    Spacer()
                                    
                                }
                                    .padding()
                            }
                            Spacer()
                            Image(systemName: "link")
                                .font(.title)
                                .padding()
                        })
                    }
                }
                            .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.17)
                            .foregroundColor(Color(.white))
                            .padding().shadow(radius: 5, y: 5)
                    
            }
            
            NavigationLink(destination: PharmacySearchView(), tag: 4, selection: $selection) { EmptyView() }
            
            
            
            
            
        }
            .onAppear {
                DispatchQueue.global(qos: .userInitiated).async {
                    
                    //If no pharmacy saved on phone - send to PharmacySearchView
                    if UserDefaults.standard.integer(forKey: "chosenPharmacy") == 0 {
                        self.selection = 4
                    }
                    
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

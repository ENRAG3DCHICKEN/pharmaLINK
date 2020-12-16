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
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @State private var chosenPharmacy: Pharmacy?
    @State private var selection: Int?
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
                          
        
            NavigationLink(destination: NewPrescriptionMessage(chosenPharmacy: chosenPharmacy), tag: 1, selection: $selection) {
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
                    .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.20)
                    .foregroundColor(Color(.white))
                    .padding().shadow(radius: 5, y: 5)
                

                
            }
            
            NavigationLink(destination: RefillPrescriptionMessage(chosenPharmacy: chosenPharmacy), tag: 2, selection: $selection) {
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
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.2)
                            .foregroundColor(Color(.white))
                            .padding().shadow(radius: 5, y: 5)
            }
            
            
            NavigationLink(destination: TransferPrescriptionMessage(chosenPharmacy: chosenPharmacy), tag: 3, selection: $selection) {
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
                            .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.2)
                            .foregroundColor(Color(.white))
                            .padding().shadow(radius: 5, y: 5)
                    
            }
            
            
            
            
            
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

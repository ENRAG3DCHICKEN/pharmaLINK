//
//  homeView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-10.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    
    @State private var selection: Int
    @State private var patient: Patient?

    init(selectionValue: Int) {
        _selection = State(wrappedValue: selectionValue)
    }
    
    init() {
        _selection = State(wrappedValue: 2)
    }
    
    var body: some View {
        VStack {
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
                          

            TabView(selection: $selection) {
                    UserDetailsView()
                        .tabItem {
                            Image(systemName: "person")
                        }
                            .tag(1)
                    
                    ObtainPrescriptions()
                        .tabItem {
                            Image(systemName: "plus.circle")
                        }
                            .tag(2)
                    
                    PastPrescriptions()
                        .tabItem {
                            Image(systemName: "book")
                        }
                            .tag(3)
            }
        }

    }
}



struct PastPrescriptions: View {
    

    @FetchRequest(fetchRequest: Orders.fetchRequest(
        NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "patientEmailAddress_ == %@", UserDefaults.standard.string(forKey: "email")!), NSPredicate(format: "orderCompleted_ = %d", false)
        ])
    )) var orders_InProcess: FetchedResults<Orders>

    @FetchRequest(fetchRequest: Orders.fetchRequest(
        NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "patientEmailAddress_ == %@", UserDefaults.standard.string(forKey: "email")!), NSPredicate(format: "orderCompleted_ = %d", true)
        ])
    )) var orders_Completed: FetchedResults<Orders>

    
    
    var body: some View {
        VStack {
            Section {
                VStack{
                    
                    Text("")
                        .navigationBarTitle("")
                        .navigationBarHidden(true)
                                  
                    
                    
                    Text("In Process Prescriptions for: \(UserDefaults.standard.string(forKey: "fullName")!)").font(.headline).padding(.horizontal)
                    //Pull Current Order History
                    
                    //If BLANK
                    if orders_InProcess.count == 0 {
                        Text("You have no orders to be processed").font(.body).padding()
                    } else {
                        List {
                            ForEach(orders_InProcess, id: \.self) { (order: Orders) in
                                NavigationLink(destination: PatientOrderView(chosenOrder: order))
                                { Text((order.orderUUID).uuidString) }
                            }
                        }
                            .padding()
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                    }
                    
                    
                    Text("Prescription History for: \(UserDefaults.standard.string(forKey: "fullName")!)").font(.headline).padding(.horizontal)
                    //Pull Past Order History
                    
                    // If BLANK
                    if orders_Completed.count == 0 {
                        Text("There are no past completed orders in your order history").font(.body).padding()
                    } else {
                        List {
                            ForEach(orders_Completed, id: \.self) { (order: Orders) in
                                NavigationLink(destination: PatientOrderView(chosenOrder: order))
                                { Text((order.orderUUID).uuidString) }
                            }
                        }
                            .padding()
                            .frame(height: UIScreen.main.bounds.height * 0.4)
                    }
                    
                    Spacer()
                    
                }
            }
        }
        
    }
}

//
//  AdminView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-15.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import CoreData

struct AdminHomeView: View {
    
    @State private var selection: Int

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
                    AdminDetailsView()
                        .tabItem {
                            Image(systemName: "gearshape")
                        }
                            .tag(1)
                    
                    PendingPrescriptions()
                        .tabItem {
                            Image(systemName: "highlighter")
                        }
                            .tag(2)
                    
                    CompletedPrescriptions()
                        .tabItem {
                            Image(systemName: "folder")
                        }
                            .tag(3)
            }
        }
    }
}


struct AdminDetailsView: View {
    
    @Environment(\.managedObjectContext) var context: NSManagedObjectContext
    @State var pharmacy: Pharmacy?
    
    @State private var selection: Int?
    
    
    
    var body: some View {
        
        VStack {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            //1. Pharmacy Store Profile
            //2. Shipping Details
            //3. Logout
            
            
            
                NavigationLink(destination: AccountProfileView(pharmacy: pharmacy), tag: 1, selection: $selection) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(UIColor.tile1b),Color(UIColor.tile1a)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        HStack {
                            Button(action: {
                                self.selection = 1
                            }, label: {
                                    VStack {
                                        HStack {
                                            Text("Account")
                                                .font(.headline).bold()
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        HStack {
                                            Text("Details")
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
                
                NavigationLink(destination: ShippingProfileView(pharmacy: pharmacy), tag: 2, selection: $selection) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(UIColor.tile2b),Color(UIColor.tile2a)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        HStack {
                            Button(action: {
                                self.selection = 2
                            }, label: {
                                VStack {
                                    HStack {
                                        Text("Shipping")
                                            .font(.headline).bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Details")
                                            .font(.headline).bold()
                                            .multilineTextAlignment(.leading)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                                    .padding()
                                })
                                Spacer()
                                Image(systemName: "paperplane")
                                    .font(.title)
                                    .padding()
                            }
                    }
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.17)
                                .foregroundColor(Color(.white))
                                .padding().shadow(radius: 5, y: 5)
                }
                
                
                NavigationLink(destination: LandingView(), tag: 3, selection: $selection) {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(UIColor.tile3b),Color(UIColor.tile3a)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        HStack {
                            Button(action: {
                                UserDefaults.standard.removeObject(forKey: "email")
                                UserDefaults.standard.removeObject(forKey: "password")
                                UserDefaults.standard.removeObject(forKey: "signupCompletionFlag")
                                self.selection = 3
                            }, label: {
                                VStack {
                                    VStack {
                                        HStack {
                                            Text("Logout")
                                                .font(.headline).bold()
                                                .multilineTextAlignment(.leading)
                                            Spacer()
                                        }
                                        Spacer()
                                    }
                                        .padding()
                                }
                                Spacer()
                                Image(systemName: "key")
                                    .font(.title)
                                    .padding()
                            })
                        }
                    }
                                .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height * 0.17)
                                .foregroundColor(Color(.white))
                                .padding().shadow(radius: 5, y: 5)
                        
                }
        }
            .onAppear {
                populateCoreData_Pharmacy(context: context)
//                DispatchQueue.global(qos: .userInitiated).async {
                    //Standard query request to Core Data
                    let request = NSFetchRequest<Pharmacy>(entityName: "Pharmacy")
                    request.sortDescriptors = [NSSortDescriptor(key: "accreditationNumber_", ascending: true)]
                    request.predicate = NSPredicate(format: "emailAddress_ = %@", UserDefaults.standard.string(forKey: "email")!)
                    let results = (try? context.fetch(request)) ?? []
                    self.pharmacy = results.first
                    print(pharmacy)
//                }
            }
    }
}

struct PendingPrescriptions: View {

    @FetchRequest(fetchRequest: Orders.fetchRequest(
        NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "pharmacyEmailAddress_ == %@", UserDefaults.standard.string(forKey: "email")!), NSPredicate(format: "orderCompleted_ = %d", false)
        ])
    )) var orders: FetchedResults<Orders>
    
    @State private var selection: Int?

    var body: some View {

        VStack {
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
                Text("Pending Orders").font(.headline)
                
                // If BLANK
                if orders.count == 0 {
                    Text("There are no pending orders in your order history").font(.body).padding()
                }

                List {
                    ForEach(orders, id: \.self) { (order: Orders) in
                        NavigationLink(destination: AdminOrderView(chosenOrder: order))
                        { Text((order.orderUUID).uuidString) }
                    }
                }
                    .padding()
        }
    }
}



struct CompletedPrescriptions: View {
    
    @FetchRequest(fetchRequest: Orders.fetchRequest(
        NSCompoundPredicate(andPredicateWithSubpredicates: [
            NSPredicate(format: "pharmacyEmailAddress_ == %@", UserDefaults.standard.string(forKey: "email")!), NSPredicate(format: "orderCompleted_ = %d", true)
        ])
    )) var orders: FetchedResults<Orders>
    
    @State private var selection: Int?

    var body: some View {

        VStack {
            Text("").font(.headline)
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            
            Text("Completed Orders").font(.headline)
            
            // If BLANK
            if orders.count == 0 {
                Text("There are no completed orders in your order history").font(.body).padding()
            }

                List {
                    ForEach(orders, id: \.self) { (order: Orders) in
                        NavigationLink(destination: AdminOrderView(chosenOrder: order))
                        { Text((order.orderUUID).uuidString) }
                    }
                }
                    .padding()
        }
    }
}

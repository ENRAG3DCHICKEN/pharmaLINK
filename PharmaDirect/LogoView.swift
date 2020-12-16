//
//  LogoView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LogoView: View {
    
    @State var selection: Int?
    @State var email: String?
    @State var password: String?
    

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                
                Text("")
                    .navigationBarTitle("")
                    .navigationBarHidden(true)

                LinearGradient(gradient: Gradient(colors: [Color(UIColor.gradiant4), Color(UIColor.gradiant3)]), startPoint: .top, endPoint: .bottom)
                Image("yoga").resizable()
                        .frame(width: 200, height: 120)
                    

        
                NavigationLink(destination: LandingView(), tag: 1, selection: $selection) { EmptyView() }
                NavigationLink(destination: HomeView(), tag: 2, selection: $selection) { EmptyView() }
                NavigationLink(destination: AdminHomeView(), tag: 3, selection: $selection) { EmptyView() }
                NavigationLink(destination: PharmacySearchView(), tag: 4, selection: $selection) { EmptyView() }
                }
        }
            
        .onAppear(perform: {
            if UserDefaults.standard.string(forKey: "email") != nil, UserDefaults.standard.string(forKey: "password") != nil {
                
                print("signing in")

                Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "email")!.trimmingCharacters(in: .whitespacesAndNewlines), password: UserDefaults.standard.string(forKey: "password")!.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, err) in
                    
                    if err != nil {
                        //
                        print("Saved Credentials via UserDefaults were not able to allow the user to sign-in")
                        print("check1")
                        self.selection = 1
                    } else {
                        let db = Firestore.firestore()
                        db.collection("admin").getDocuments() { (querySnapshot, err) in
                            if let err = err {
                                print("Error getting documents: \(err)")
                            } else {
                                
                                for document in querySnapshot!.documents {
                                    
                                    //this below line is for debugging
                                    print("\(document.documentID) => \(document.data())")
                                    
                                    // Applies when user is logged in and identified as an admin account
                                    if UserDefaults.standard.string(forKey: "email")! == (document.data()["email"] as! String) {
                                        print("check3")
                                        self.selection = 3

                                    }
                                }
                                // Applies when user is logged in and not identified as an admin account
                                if self.selection == nil {
                                    
                                    //Sign-up Process Completed - UserHomeView
                                    print(UserDefaults.standard.bool(forKey: "signupCompletionFlag"))
                                    if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                                        print("check2")
                                        self.selection = 2
                                    } else {
                                        //Sign-up Process Incomplete - PatientInfoView
                                        print("leaving")
                                        print("check4")
                                        self.selection = 4
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                }
            } else {
                // No Credentials
                print("credentials")
                self.selection = 1
                  
                }
            }
        )
            .background(Color(UIColor.mainColor))
        }
    }
}

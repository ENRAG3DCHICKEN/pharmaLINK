//
//  signUpView1.swift
//  TemplateApp
//
//  Created by ENRAG3DCHICKEN on 2020-09-29.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct SignUpView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var selection: Int? = nil
    
    @State var fieldSelection: Int? = nil
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var displayErrorMessage: String = ""
    @State var displayEmailErrorMessage: String = ""
    @State var displayPasswordErrorMessage: String = ""
    
    
    @State var emailErrorCondition: Bool = false
    @State var passwordErrorCondition: Bool = false

    
    var body: some View {
            VStack(spacing: 0) {
                
//                Text("")
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
                
                Text("PHARMACIE")
                    .bold()
                    .foregroundColor(colorScheme == .dark ? Color(.green) : (Color(UIColor.mainColor)))
                    .font(.largeTitle)
                    .padding()

                Text("""
                        Create an account to
                    fullfill your prescriptions.
                    """)
                    .font(.headline)
                    .padding()
                    .lineLimit(nil)
                
                TextField("Email", text: $email).simultaneousGesture(TapGesture().onEnded {
                    self.fieldSelection = 1
                })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(5)
                    .border(self.emailErrorCondition == true ? Color.red : self.fieldSelection == 1 ? (Color(UIColor.mainColor)) : Color.gray, width: 1.5)
                    .padding()
                HStack {
                    Text(displayEmailErrorMessage).font(.caption)
                        .foregroundColor(Color.red)
                        .padding(.leading)
                    Spacer()
                }
                SecureField("Password", text: $password).simultaneousGesture(TapGesture().onEnded {
                    self.fieldSelection = 2
                })
                    .padding(5)
                    .border(self.passwordErrorCondition == true ? Color.red : self.fieldSelection == 2 ? (Color(UIColor.mainColor)) : Color.gray, width: 1.5)
                    .padding()
                HStack {
                    Text(displayPasswordErrorMessage).font(.caption)
                        .foregroundColor(Color.red)
                        .padding(.leading)
                    Spacer()
                }
                Button(action: {
                    self.displayErrorMessage = ""
                    let validationResult = validateFields(email: self.email, password: self.password)
                    
                    if validationResult == "Both Empty" {
                        self.emailErrorCondition = true
                        self.passwordErrorCondition = true
                        self.displayEmailErrorMessage = "Email is required"
                        self.displayPasswordErrorMessage = "Password is required"
                    } else if validationResult == "Email Empty" {
                        self.emailErrorCondition = true
                        self.passwordErrorCondition = false
                        self.displayEmailErrorMessage = "Email is required"
                    } else if validationResult == "Password Empty" {
                        self.emailErrorCondition = false
                        self.passwordErrorCondition = true
                        self.displayPasswordErrorMessage = "Password is required"
                    } else {
                        
                        if validationResult == "Email Bad" {
                            self.emailErrorCondition = true
                            self.displayEmailErrorMessage = "Please enter a valid email address"
                        }
                        if validationResult == "Password Bad" {
                            self.passwordErrorCondition = true
                            self.displayPasswordErrorMessage = "Password must be at least 6 characters and consists of characters and numbers"
                        }
                    }
                
                    
                    if validationResult == "OK" {
                        
                        // Create the User - via FirebaseAuth
                        Auth.auth().createUser(withEmail: self.email.trimmingCharacters(in: .whitespacesAndNewlines), password: self.password.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, err) in
                                                        
                            // Check for errors
                            if err != nil {
                                // There was an error creating the user
                                self.displayErrorMessage = err!.localizedDescription
                                print(self.displayErrorMessage)
                            } else if err == nil && result != nil {
                                
                                //Check if Admin Account
                                //User authenticated - checking if user is admin account
                                let db = Firestore.firestore()
                                db.collection("pharmacies").getDocuments() { (querySnapshot, err) in
                                    if let err = err {
                                        print("Error getting documents: \(err)")
                                    } else {
                                        
                                        for document in querySnapshot!.documents {
                                            
                                            //this below line is for debugging
                                            print("\(document.documentID) => \(document.data())")
                                            
                                            // Applies when user is logged in and identified as an admin account
                                            if self.email == (document.data()["EmailAddress"]! as! String) {
                                                print("leaving for admin")
                                                UserDefaults.standard.set(self.email, forKey: "email")
                                                self.selection = 4

                                            }
                                            
                                        }
                                        
                                        // Applies when user is logged in and not identified as an admin account
                                        if self.selection == nil {
                                            //Pass to Patient Account
                                            UserDefaults.standard.set(self.email, forKey: "email")
                                            UserDefaults.standard.set(self.password, forKey: "password")
                                            self.selection = 3
                                        }

                                    }
                                }
                            }
                        }
                    } else {
                        self.displayErrorMessage = validationResult
                        print(self.displayErrorMessage)
                    }
                        
                }, label: { Text("Sign Up").font(.body) })

                    .frame(width: UIScreen.main.bounds.width * 0.92, height: 35)
//                    .background(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                    .foregroundColor(Color(.white))
                    .background(Color(UIColor.mainColor))
                    .padding()
                    
                VStack {
                    Text("By creating an account you are accepting our ")
                        .font(.footnote)
                        HStack(spacing: 1) {
                            Text("Terms of Service")
                                .font(.footnote)
                                .underline()
                                .foregroundColor(colorScheme == .light ? Color(UIColor.mainColor) : Color(.green))
                                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                    self.selection = 1
                                })
                            Text(" and ")
                                .font(.footnote)
                            Text("Privacy Policy")
                                .font(.footnote)
                                .underline()
                                .foregroundColor(colorScheme == .light ? Color(UIColor.mainColor) : Color(.green))
                                .onTapGesture(count: 1, perform: {
                                    self.selection = 2
                                })
                            Text(".")
                                .font(.footnote)
                        }
                    
                    Text(displayErrorMessage).font(.caption)
                        .padding()
                    //
                    NavigationLink(destination: PrivacyPolicyView(), tag: 1, selection: $selection) { EmptyView() }
                    NavigationLink(destination: TermsView(), tag: 2, selection: $selection) { EmptyView() }
                    //
                    NavigationLink(destination: PharmacySearchView(), tag: 3, selection: $selection) { EmptyView() }
                    //
                    NavigationLink(destination: AdminHomeView(), tag: 4, selection: $selection) { EmptyView() }
                    Spacer()
                }

                
                }
            
    }
    
    
    
    
}


                                    //User was created successfully, now store the first name and last name in Firestore
//                                    let db = Firestore.firestore()
//                                    db.collection("users").addDocument(data: ["firstName": "CleanFirstName", "lastName": "CleanLastName", "uid": result!.user.uid]) { (error) in
//                                        if error != nil // Show Error Message }

//
//  loginView1.swift
//  TemplateApp
//
//  Created by ENRAG3DCHICKEN on 2020-09-29.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//



import SwiftUI
import FirebaseAuth
import Firebase
import CoreData

struct LoginView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    
    @State var email: String = ""
    @State var password: String = ""
    
    @State var errorMessage: String = ""
    @State var selection: Int?
    
    var body: some View {
            VStack {
                
//                Text("")
//                    .navigationBarTitle("")
//                    .navigationBarHidden(true)
                
                Group {
                    Text("pharmacie")
                        .bold()
                        .foregroundColor(colorScheme == .dark ? Color(UIColor.neonGreen) : (Color(UIColor.mainColor)))
                        .font(.largeTitle)
                    + Text("+")
                        .bold()
                        .foregroundColor(colorScheme == .dark ? Color(UIColor.neonGreen) : (Color(UIColor.mainColor)))
                        .font(.largeTitle)
                        .baselineOffset(10)
                }
                    .padding()
                
                Text("""
                        Welcome back.
                    """)
                    .font(.headline)
                    .padding()
                    .lineLimit(nil)
                
                TextField("Email", text: $email).simultaneousGesture(TapGesture().onEnded {
                })
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Password", text: $password).simultaneousGesture(TapGesture().onEnded {
                })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Text("Forgot your password?").font(.caption)
                    .padding()
                    .onTapGesture(count: 1, perform: {
                        self.selection = 3
                    })
                
                Button(action: {
                    
                    UserDefaults.standard.set(self.email, forKey: "email")
                    
                    Auth.auth().signIn(withEmail: self.email.trimmingCharacters(in: .whitespacesAndNewlines), password: self.password.trimmingCharacters(in: .whitespacesAndNewlines)) { (result, err) in
                        if err != nil {
                            //
                            self.errorMessage = err!.localizedDescription
                        } else {
                                                        
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
                                            self.selection = 2
                                        }
                                    }
                                
                            
                                    // Applies when user is logged in and not identified as an admin account
                                    if self.selection == nil {


                                        //Standard query request to Core Data (Patient Object)
                                        let request = NSFetchRequest<Patient>(entityName: "Patient")
                                        request.sortDescriptors = [NSSortDescriptor(key: "emailAddress_", ascending: true)]
                                        request.predicate = NSPredicate(format: "emailAddress_ = %@", UserDefaults.standard.string(forKey: "email")!)

                                        let results = (try? context.fetch(request)) ?? []
                                        let patient = results.first

                                            
                                        //Core Data to User Defaults
                                        if patient != nil {
                                            CallTransferCoreDataToUserDefaults_Patient(context: context)
                                            CallTransferCoreDataToUserDefaults_PatientHealthDetails(context: context, patient: patient!)
                                            CallTransferCoreDataToUserDefaults_PatientInsuranceDetails(context: context, patient: patient!)
                                            CallTransferCoreDataToUserDefaults_PatientPaymentDetails(context: context, patient: patient!)
                                        }
                                        
                                        //Sign-up Process Completed - UserHomeView
                                        print(UserDefaults.standard.string(forKey: "signupCompletionFlag") as Any)
                                        if UserDefaults.standard.bool(forKey: "signupCompletionFlag") == true {
                                            self.selection = 1
                                        } else {
                                            //Sign-up Process Incomplete - PatientInfoView
                                            self.selection = 4
                                        }
                                    }
                                }
                            }
                        }
                    }
                }) { Text("Log In").font(.body)  }
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                    .foregroundColor(Color(.white))
                    .background(Color(UIColor.mainColor))
                    .padding()
                
                VStack {
                    NavigationLink(destination: HomeView(), tag: 1, selection: $selection) { EmptyView() }
                    NavigationLink(destination: AdminHomeView(), tag: 2, selection: $selection) { EmptyView() }
                    NavigationLink(destination: PasswordResetView(), tag: 3, selection: $selection) { EmptyView() }
                    NavigationLink(destination: PharmacySearchView(), tag: 4, selection: $selection) { EmptyView() }
                    Text(errorMessage)
                    Spacer()
                }
            }
        }
    }

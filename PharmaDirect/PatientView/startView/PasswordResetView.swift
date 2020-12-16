//
//  PasswordResetView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-11-02.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI
import Firebase

struct PasswordResetView: View {
    
    @State var email: String = ""
    @State var displayErrorMessage = ""
    
    @State var selection: Int?
    
    var body: some View {
        
        VStack {
            
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            Text("Forgot your password?").font(.headline)
            
            Text("Enter your email to get help logging in.").font(.subheadline)
            
            TextField("Email", text: $email).simultaneousGesture(TapGesture().onEnded {
            })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Send Email", action: {
                Auth.auth().sendPasswordReset(withEmail: email) { err in
                    if err != nil {
                        // There was an error creating the user
                        self.displayErrorMessage = err!.localizedDescription
                        print(self.displayErrorMessage)
                    } else {
                        UserDefaults.standard.removeObject(forKey: "email")
                        UserDefaults.standard.removeObject(forKey: "password")
                        self.selection = 1
                    }
                }
                
            })
                    .frame(width: UIScreen.main.bounds.width * 0.9, height: 30)
                    .foregroundColor(Color(.white))
                    .background(Color(UIColor.mainColor))
                    .padding()
            Text(displayErrorMessage)
            
            NavigationLink(destination: PasswordResetCompletedView(), tag: 1, selection: $selection) { EmptyView() }
            
            Spacer()
        
        }
    }
}

struct PasswordResetView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetView()
    }
}

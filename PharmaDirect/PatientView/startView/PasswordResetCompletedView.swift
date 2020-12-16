//
//  PasswordResetCompletedView.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-11-02.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct PasswordResetCompletedView: View {
    
    @State var selection: Int? = nil
    
    var body: some View {
        
        VStack {
        
            Text("")
                .navigationBarTitle("")
                .navigationBarHidden(true)
            
            Text("Check your email").font(.headline)

            Spacer()
            Text("""
                    We sent an email to your inbox.
                Follow the email prompt to continue.
                """).font(.subheadline)
            Spacer()
            Text("Try logging in again").onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                self.selection = 1
            })
                .foregroundColor(Color(UIColor.mainColor))
            
            NavigationLink(destination: LoginView(), tag: 1, selection: $selection) { EmptyView() }
            
        }
    }
}

struct PasswordResetCompletedView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetCompletedView()
    }
}

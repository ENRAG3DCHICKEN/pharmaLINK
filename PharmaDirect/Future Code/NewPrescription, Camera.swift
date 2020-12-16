//
//  NewPrescription.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-14.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import SwiftUI

struct NewPrescriptionView: View {
    
    @State var selection: Int?
    
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            pickImage
            
            NavigationLink(destination: HealthProfileView2(), tag: 1, selection: $selection) { Text("") }
                
            Button(action: { self.selection = 1 }) { Text("Submit").font(.caption) }
        }
        
    }


    @State private var showImagePicker = false
    @State private var imagePickerSourceType = UIImagePickerController.SourceType.photoLibrary

    var pickImage: some View {
        HStack {
            Image(systemName: "photo").imageScale(.large).foregroundColor(.accentColor).onTapGesture {
                self.imagePickerSourceType = .photoLibrary
                self.showImagePicker = true
            }
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Image(systemName: "camera").imageScale(.large).foregroundColor(.accentColor).onTapGesture {
                    self.imagePickerSourceType = .camera
                    self.showImagePicker = true
                }
            } 
        }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: self.imagePickerSourceType) { image in
                    if image != nil {
                        DispatchQueue.main.async {
                            // Do something with the selected image
                        }
                    }
                        self.showImagePicker = false
                }
        }
    }

}

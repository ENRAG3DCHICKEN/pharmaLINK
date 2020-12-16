//
//  StartViewHelpers.swift
//  InstantCredit
//
//  Created by ENRAG3DCHICKEN on 2020-10-11.
//  Copyright © 2020 ENRAG3DCHICKEN. All rights reserved.
//

import Foundation
import SwiftUI


func validateFields(email: String, password: String) -> String {
    
    //Check if fields are empty
    if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" && password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return "Both Empty"
    } else if email.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return "Email Empty"
    } else if password.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
        return "Password Empty"
    }
    
    //Check if password is valid (Length = 10, at least 1 character, at least 1 special character)
    if isPasswordValid(password) != true {
        return "Password Bad"
    }
     
    return "OK"
}

func isPasswordValid(_ password: String) -> Bool {
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,}")
    return passwordTest.evaluate(with: password)
}


func findCredentials() {
    return 
}

extension CGPoint {
    static func -(lhs: Self, rhs: Self) -> CGSize {
        CGSize(width: lhs.x - rhs.x, height: lhs.y - rhs.y)
    }
    static func +(lhs: Self, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x + rhs.width, y: lhs.y + rhs.height)
    }
    static func -(lhs: Self, rhs: CGSize) -> CGPoint {
        CGPoint(x: lhs.x - rhs.width, y: lhs.y - rhs.height)
    }
    static func *(lhs: Self, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    static func /(lhs: Self, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
}

extension CGSize {
    static func +(lhs: Self, rhs: Self) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    static func -(lhs: Self, rhs: Self) -> CGSize {
        CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }
    static func *(lhs: Self, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }
    static func /(lhs: Self, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width/rhs, height: lhs.height/rhs)
    }
}

extension Image {
    func centerCropped() -> some View {
        GeometryReader { geo in
            self
            .resizable()
            .scaledToFill()
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }
}

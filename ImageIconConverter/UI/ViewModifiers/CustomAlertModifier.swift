//
//  CustomAlertModifier.swift
//  ImageIconConverter
//
//  Created by Yujin Cha on 2023/01/04.
//

import SwiftUI


extension CustomAlertModifier {
    static let alertTitle = "Something went wrong!"
    static let alertButtonText = "Ok"
}

struct CustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    var message: String
    
    func body(content: Content) -> some View {
        content
            .alert(CustomAlertModifier.alertTitle, isPresented: $isPresented) {
                Button(CustomAlertModifier.alertButtonText) {}
            } message: {
                Text(message)
            }
    }
}


extension View {
    func customAlert(isPresented: Binding<Bool>, message: String) -> some View {
        modifier(CustomAlertModifier(isPresented: isPresented, message: message))
    }
}

//
//  TWRoundedSecureTextfield.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2021-12-27.
//

import SwiftUI

struct CCRoundedSecureTextfield: View {
    
    var titleKey: String
    @Binding var text: String
    
    var body: some View {
        SecureField(titleKey, text: $text)
            .padding()
            .background(Color.TextFieldBackgroundColor)
    }
}

struct TWRoundedSecureTextfield_Previews: PreviewProvider {
    static var previews: some View {
        CCRoundedSecureTextfield(titleKey: "Password", text: .constant(""))
    }
}

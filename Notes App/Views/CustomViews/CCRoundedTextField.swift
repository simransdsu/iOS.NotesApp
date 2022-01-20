//
//  TWRoundedTextView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2021-12-27.
//

import SwiftUI

struct CCRoundedTextField: View {
    
    var titleKey: String
    @Binding var text: String
    
    
    var body: some View {
        TextField(titleKey, text: $text)
            .padding()
            .background(Color.TextFieldBackgroundColor)
    }
}

struct TWRoundedTextView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CCRoundedTextField(titleKey: "Username", text: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }
}

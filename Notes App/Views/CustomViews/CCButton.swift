//
//  TWButton.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2021-12-27.
//

import SwiftUI

struct CCButton: View {
    
    var action: () -> Void
    var text: String
    var backgroundColor: Color = .AccentColor
    var foregroundColor: Color = .White
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(text)
                    .foregroundColor(foregroundColor)
                Spacer()
            }.padding()
                
        }
            .background(backgroundColor)
    }
}

struct TWButton_Previews: PreviewProvider {
    static var previews: some View {
        CCButton(action:{
            
        }, text: "Button title.").previewLayout(.sizeThatFits)
    }
}

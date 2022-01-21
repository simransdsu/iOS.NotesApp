//
//  CCRoundedButton.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-19.
//

import SwiftUI

struct CCRoundedButton: View {
    
    let text: String
    let radius: CGFloat = 65
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Circle()
                .frame(width: radius, height: radius)
                .overlay(
                    Text(text)
                        .font(.largeTitle)
                        .foregroundColor(Color.White)
                )
        }
    }
}

struct CCRoundedButton_Previews: PreviewProvider {
    static var previews: some View {
        CCRoundedButton(text: "+", action: {})
    }
}

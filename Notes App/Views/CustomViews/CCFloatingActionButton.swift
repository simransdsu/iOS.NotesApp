//
//  TWFloatingActionButton.swift
//  Notes App (iOS)
//
//  Created by Simran Preet Singh Narang on 2022-01-04.
//

import SwiftUI

struct CCFloatingActionButton: View {
    
    var action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    action()
                } label: {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color.AccentColor)
                        .foregroundColor(.White)
                }
            }
        }
    }
}

struct TWFloatingActionButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CCFloatingActionButton(action: {})
                .previewLayout(.sizeThatFits)
        }
    }
}

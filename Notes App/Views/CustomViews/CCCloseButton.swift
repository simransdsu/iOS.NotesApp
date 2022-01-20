//
//  CCCloseButton.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-06.
//

import SwiftUI

struct CCCloseButton: View {
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

struct CCCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CCCloseButton(action: {})
    }
}

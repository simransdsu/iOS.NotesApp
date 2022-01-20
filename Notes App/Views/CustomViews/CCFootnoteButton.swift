//
//  CCCloseToolbarItem.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-06.
//

import SwiftUI

struct CCFootnoteButton: View {
    
    var action: () -> Void
    var plainText:String
    var highlightText: String
    
    var body: some View {
        HStack {
            Button("\(Text(plainText).foregroundColor(.LabelColor)) \(highlightText)") {
                withAnimation {
                    action()
                }
            }
        }.font(.footnote)
    }
}

struct CCCloseToolbarItem_Previews: PreviewProvider {
    static var previews: some View {
        CCFootnoteButton(action: {},
                         plainText: "New to Twitter?",
                         highlightText:"Sign up")
    }
}

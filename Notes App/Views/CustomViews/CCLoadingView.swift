//
//  CCLoadingView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI

struct CCLoadingView: View {
    
    var message: String
    
    init(message: String = "Wait for a bit...") {
        self.message = message
    }
    
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
            Text(message)
            Spacer()
        }.frame(width: 250, height: 250)
            .background(Color.AccentColor.opacity(0.5))
            .cornerRadius(10)
    }
}

struct CCLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        CCLoadingView()
    }
}

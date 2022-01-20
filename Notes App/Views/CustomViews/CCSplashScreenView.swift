//
//  CCSplashScreenView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-11.
//

import SwiftUI

struct CCSplashScreenView: View {
    var body: some View {
        VStack {
            Spacer()
            CCResizableSquareImage("clap-512", size: 250)
                .cornerRadius(20)
            Spacer()
        }
    }
}

struct CCSplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        CCSplashScreenView()
    }
}

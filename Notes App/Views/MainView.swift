//
//  ContentView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-06.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        AuthView()
            .onAppear {
                print("ENVIRONMENT: ", BuildConfiguration.shared.environment)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  HomeView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-06.
//

import SwiftUI
import Resolver

struct MainHomeView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @EnvironmentObject var authSession: AuthSession
    
    var body: some View {
        TabView {
            NavigationView {
                NotesView()
                    .navigationTitle("Home")
            }.tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("Home")
                }
            }.tag(0)
            
            
            NavigationView {
                SettingsView()
            }.tabItem {
                VStack {
                    Image(systemName: "gear")
                    Text("Settings")
                }
            }.tag(1)
        }
    }
}

struct MainHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainHomeView()
    }
}
